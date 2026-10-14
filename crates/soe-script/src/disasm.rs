// crates/soe-script/src/disasm.rs
use crate::ast::*;
use soe_core::Rom;

pub struct Disassembler<'a> {
    rom: &'a Rom,
}

impl<'a> Disassembler<'a> {
    pub fn new(rom: &'a Rom) -> Self {
        Self { rom }
    }

    /// Disassembliert ein Skript ab einer SNES-Adresse.
    pub fn disassemble_script(&self, start_snes_addr: u32, max_len: usize) -> Script {
        let mut script = Script {
            start_addr: start_snes_addr,
            statements: Vec::new(),
        };

        let start_file_off = Rom::snes_to_file_offset(start_snes_addr);
        let mut cur_file_off = start_file_off;
        let end_file_off = (start_file_off + max_len).min(self.rom.len());

        let mut max_jump_target: usize = 0;

        while cur_file_off < end_file_off {
            let stmt_start = cur_file_off;
            let snes_addr = Rom::file_offset_to_snes(stmt_start);
            let opcode = match self.rom.read_u8_at(cur_file_off) {
                Ok(b) => b,
                Err(_) => break,
            };
            cur_file_off += 1;

            let (instruction, ok) = self.decode_instruction(opcode, &mut cur_file_off, stmt_start);
            let raw_len = cur_file_off - stmt_start;
            let mut raw_bytes = Vec::with_capacity(raw_len);
            for i in 0..raw_len {
                if let Ok(b) = self.rom.read_u8_at(stmt_start + i) {
                    raw_bytes.push(b);
                }
            }

            // Track target jumps
            match &instruction {
                Instruction::Skip(off) => {
                    let target = (cur_file_off as isize + *off as isize) as usize;
                    if target > max_jump_target {
                        max_jump_target = target;
                    }
                }
                Instruction::If { target_offset, .. } | Instruction::IfNot { target_offset, .. } => {
                    let target = (cur_file_off as isize + *target_offset as isize) as usize;
                    if target > max_jump_target {
                        max_jump_target = target;
                    }
                }
                _ => {}
            }

            let stmt = ScriptStatement {
                offset: stmt_start - start_file_off,
                snes_addr,
                raw_bytes,
                instruction: instruction.clone(),
            };
            script.statements.push(stmt);

            if !ok {
                break;
            }

            // Wenn End oder Return erreicht und kein weiterer Sprung darüber hinaus zeigt: Abbruch
            if (matches!(instruction, Instruction::End | Instruction::Return))
                && cur_file_off >= max_jump_target
            {
                break;
            }
        }

        script
    }

    fn decode_instruction(
        &self,
        opcode: u8,
        cur_file_off: &mut usize,
        _stmt_start: usize,
    ) -> (Instruction, bool) {
        match opcode {
            0x00 => (Instruction::End, true),
            0x01 => (Instruction::Return, true),
            0x04 => {
                let jmp = self.read_i16(cur_file_off);
                (Instruction::Skip(jmp), true)
            }
            0x05 => {
                let jmp = self.read_i8(cur_file_off);
                (Instruction::SkipNeg(jmp), true)
            }
            0x07 => {
                let script_addr = self.read_u24(cur_file_off);
                let rom_addr = Rom::script_to_rom_addr(script_addr);
                (Instruction::Call(rom_addr), true)
            }
            0x08 => {
                let cond = self.parse_sub(cur_file_off);
                let target_offset = self.read_i16(cur_file_off);
                (Instruction::If { cond, target_offset }, true)
            }
            0x09 => {
                let cond = self.parse_sub(cur_file_off);
                let target_offset = self.read_i16(cur_file_off);
                (Instruction::IfNot { cond, target_offset }, true)
            }
            0x0A => {
                let currency = self.read_u8(cur_file_off);
                let amount = self.read_u24(cur_file_off);
                let target_offset = self.read_i16(cur_file_off);
                (Instruction::IfMoneyGe { currency, amount, target_offset }, true)
            }
            0x0B => {
                let currency = self.read_u8(cur_file_off);
                let amount = self.read_u24(cur_file_off);
                let target_offset = self.read_i16(cur_file_off);
                (Instruction::IfMoneyLt { currency, amount, target_offset }, true)
            }
            0x0C => {
                let bit_index = self.read_u16(cur_file_off);
                let val = self.parse_sub(cur_file_off);
                (Instruction::SetFlag { base: FlagBase::Ram, bit_index, val }, true)
            }
            0x0D => {
                let bit_index = self.read_u16(cur_file_off);
                let val = self.parse_sub(cur_file_off);
                (Instruction::SetFlag { base: FlagBase::Temp, bit_index, val }, true)
            }
            0x0E => {
                let bit_index = self.read_u8(cur_file_off);
                let val = self.parse_sub(cur_file_off);
                (Instruction::SetScriptArgBit { bit_index, val }, true)
            }
            0x17 => {
                let addr = self.read_u16(cur_file_off);
                let val = self.read_u16(cur_file_off);
                (Instruction::WriteVarFast { addr, val }, true)
            }
            0x10 | 0x14 => {
                let addr = self.read_u16(cur_file_off);
                let expr = self.parse_sub(cur_file_off);
                (Instruction::WriteRam { addr, expr }, true)
            }
            0x11 | 0x15 => {
                let addr = self.read_u16(cur_file_off);
                let expr = self.parse_sub(cur_file_off);
                (Instruction::WriteTemp { addr, expr }, true)
            }
            0x18 | 0x1C => {
                let addr = self.read_u16(cur_file_off);
                let expr = self.parse_sub(cur_file_off);
                (Instruction::WriteRam { addr, expr }, true)
            }
            0x19 | 0x1D => {
                let addr = self.read_u16(cur_file_off);
                let expr = self.parse_sub(cur_file_off);
                (Instruction::WriteTemp { addr, expr }, true)
            }
            0x1E => {
                let arg = self.read_u8(cur_file_off);
                let expr = self.parse_sub(cur_file_off);
                (Instruction::WriteScriptArg { arg, expr }, true)
            }
            0x27 => (Instruction::Raw { opcode: 0x27, payload: Vec::new() }, true),
            0x29 => {
                let script_addr = self.read_u24(cur_file_off);
                let rom_addr = Rom::script_to_rom_addr(script_addr);
                (Instruction::Call(rom_addr), true)
            }
            0x2C | 0x2D => {
                let arg = self.read_u8(cur_file_off);
                (Instruction::Raw { opcode, payload: vec![arg] }, true)
            }
            0x51 => {
                let text_id = self.read_u16(cur_file_off);
                (Instruction::ShowText(text_id), true)
            }
            0x52 => {
                let text_id = self.read_u16(cur_file_off);
                (Instruction::ShowTextEnd(text_id), true)
            }
            0x55 => (Instruction::HideText, true),
            0x7C => {
                let amount = self.read_u16(cur_file_off);
                (Instruction::GiveJewels(amount), true)
            }
            0xA7 => {
                let frames = self.read_u16(cur_file_off);
                (Instruction::Sleep(frames), true)
            }
            _ => {
                // Fallback für sonstige Opcodes
                let payload_len = Self::get_known_payload_len(opcode);
                let mut payload = Vec::with_capacity(payload_len);
                for _ in 0..payload_len {
                    payload.push(self.read_u8(cur_file_off));
                }
                (Instruction::Raw { opcode, payload }, true)
            }
        }
    }

    fn get_known_payload_len(opcode: u8) -> usize {
        match opcode {
            0x02 | 0x03 => 0,
            0x06 => 1,
            0x10 | 0x11 | 0x12 | 0x13 | 0x14 | 0x15 | 0x16 => 2,
            0x19 | 0x1A | 0x1B | 0x1C => 2,
            0x20..=0x2E => 2,
            0x30..=0x4F => 2,
            0x50 => 1,
            0x53 | 0x54 => 0,
            _ => 0,
        }
    }

    /// Parst eine Sub-Instruktionskette (Ausdruck) unter Verwendung des Auswertungs-Stacks.
    pub fn parse_sub(&self, cur_file_off: &mut usize) -> Expr {
        let mut stack: Vec<Expr> = Vec::new();
        let mut current_expr: Option<Expr> = None;

        loop {
            let raw_byte = self.read_u8(cur_file_off);
            let done = (raw_byte & 0x80) != 0;
            let sub = raw_byte & 0x7F;

            match sub {
                // Konstante Werte direkt im Byte kodiert
                0x30..=0x3F => {
                    let val = (sub - 0x30) as i16;
                    current_expr = Some(Expr::Const(val));
                }
                0x60..=0x6F => {
                    let val = (sub - 0x60 + 16) as i16;
                    current_expr = Some(Expr::Const(val));
                }
                0x01 | 0x02 => {
                    let b = self.read_u8(cur_file_off);
                    let val = if sub == 0x01 { b as i8 as i16 } else { b as i16 };
                    current_expr = Some(Expr::Const(val));
                }
                0x03 | 0x04 => {
                    let w = self.read_u16(cur_file_off);
                    let val = if sub == 0x03 { w as i16 } else { w as i16 };
                    current_expr = Some(Expr::Const(val));
                }
                0x05 => {
                    let bit_index = self.read_u16(cur_file_off);
                    current_expr = Some(Expr::Flag { base: FlagBase::Ram, bit_index });
                }
                0x0A => {
                    let bit_index = self.read_u16(cur_file_off);
                    current_expr = Some(Expr::Flag { base: FlagBase::Temp, bit_index });
                }
                0x06 | 0x07 => {
                    let addr = self.read_u16(cur_file_off);
                    current_expr = Some(Expr::RamByte(addr));
                }
                0x08 | 0x09 => {
                    let addr = self.read_u16(cur_file_off);
                    current_expr = Some(Expr::RamWord(addr));
                }
                0x0B | 0x0C => {
                    let addr = self.read_u16(cur_file_off);
                    current_expr = Some(Expr::TempByte(addr));
                }
                0x0D | 0x0E => {
                    let addr = self.read_u16(cur_file_off);
                    current_expr = Some(Expr::TempWord(addr));
                }
                0x10 | 0x11 => {
                    let arg = self.read_u8(cur_file_off);
                    current_expr = Some(Expr::ArgByte(arg));
                }
                0x12 | 0x13 => {
                    let arg = self.read_u8(cur_file_off);
                    current_expr = Some(Expr::ArgWord(arg));
                }
                // Unäre Operatoren
                0x14 => {
                    if let Some(e) = current_expr.take() {
                        current_expr = Some(Expr::Unary { op: UnaryOp::Not, expr: Box::new(e) });
                    }
                }
                0x15 => {
                    if let Some(e) = current_expr.take() {
                        current_expr = Some(Expr::Unary { op: UnaryOp::BitNot, expr: Box::new(e) });
                    }
                }
                0x16 => {
                    if let Some(e) = current_expr.take() {
                        current_expr = Some(Expr::Unary { op: UnaryOp::Neg, expr: Box::new(e) });
                    }
                }
                // Binäre Operatoren
                0x17 | 0x18 | 0x1A | 0x1B | 0x1C | 0x1D | 0x1E | 0x1F | 0x20 | 0x21 | 0x22 | 0x23 | 0x24 | 0x25 | 0x26 | 0x27 | 0x28 => {
                    let op = match sub {
                        0x17 => BinaryOp::Mul,
                        0x18 => BinaryOp::Div,
                        0x1A => BinaryOp::Add,
                        0x1B => BinaryOp::Sub,
                        0x1C => BinaryOp::Shl,
                        0x1D => BinaryOp::Shr,
                        0x1E => BinaryOp::Lt,
                        0x1F => BinaryOp::Gt,
                        0x20 => BinaryOp::Le,
                        0x21 => BinaryOp::Ge,
                        0x22 => BinaryOp::Eq,
                        0x23 => BinaryOp::Ne,
                        0x24 => BinaryOp::BitAnd,
                        0x25 => BinaryOp::BitOr,
                        0x26 => BinaryOp::BitXor,
                        0x27 => BinaryOp::Or,
                        0x28 => BinaryOp::And,
                        _ => unreachable!(),
                    };
                    let left = stack.pop().unwrap_or(Expr::Const(0));
                    let right = current_expr.take().unwrap_or(Expr::Const(0));
                    current_expr = Some(Expr::Binary {
                        op,
                        left: Box::new(left),
                        right: Box::new(right),
                    });
                }
                0x29 => {
                    // Push auf Stack
                    if let Some(e) = current_expr.take() {
                        stack.push(e);
                    }
                }
                0x2A => {
                    current_expr = Some(Expr::Rng);
                }
                0x2B => {
                    let right = current_expr.take().unwrap_or(Expr::Const(0));
                    current_expr = Some(Expr::RngRange(Box::new(right)));
                }
                0x2C => {
                    current_expr = Some(Expr::DialogResponse);
                }
                0x50..=0x53 => {
                    let ent = Entity::from_u8(sub | 0x80);
                    current_expr = Some(Expr::Entity(ent));
                }
                _ => {
                    current_expr = Some(Expr::Raw(vec![raw_byte]));
                }
            }

            if done {
                break;
            }
        }

        current_expr.unwrap_or(Expr::Const(0))
    }

    fn read_u8(&self, off: &mut usize) -> u8 {
        let b = self.rom.read_u8_at(*off).unwrap_or(0);
        *off += 1;
        b
    }

    fn read_i8(&self, off: &mut usize) -> i8 {
        self.read_u8(off) as i8
    }

    fn read_u16(&self, off: &mut usize) -> u16 {
        let b0 = self.read_u8(off) as u16;
        let b1 = self.read_u8(off) as u16;
        b0 | (b1 << 8)
    }

    fn read_i16(&self, off: &mut usize) -> i16 {
        self.read_u16(off) as i16
    }

    fn read_u24(&self, off: &mut usize) -> u32 {
        let b0 = self.read_u8(off) as u32;
        let b1 = self.read_u8(off) as u32;
        let b2 = self.read_u8(off) as u32;
        b0 | (b1 << 8) | (b2 << 16)
    }
}
