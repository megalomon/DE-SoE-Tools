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
                Instruction::IfMoneyGe { target_offset, .. }
                | Instruction::IfMoneyLt { target_offset, .. } => {
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

            // Wenn Terminal-Befehl erreicht und kein weiterer Sprung darüber hinaus zeigt: Abbruch
            if instruction.is_terminal() && cur_file_off >= max_jump_target {
                break;
            }
        }

        script
    }

    fn raw_instruction(&self, opcode: u8, stmt_start: usize, cur_file_off: usize) -> Instruction {
        let payload = if cur_file_off > stmt_start + 1 {
            let mut p = Vec::with_capacity(cur_file_off - stmt_start - 1);
            for i in (stmt_start + 1)..cur_file_off {
                p.push(self.rom.read_u8_at(i).unwrap_or(0));
            }
            p
        } else {
            Vec::new()
        };
        Instruction::Raw { opcode, payload }
    }

    fn decode_instruction(
        &self,
        opcode: u8,
        cur_file_off: &mut usize,
        stmt_start: usize,
    ) -> (Instruction, bool) {
        match opcode {
            0x00 => (Instruction::End, true),
            // 27 STP / Trap-Opcodes
            0x01..=0x03 | 0x06 | 0x0F | 0x13 | 0x1F | 0x24 | 0x25 | 0x28 | 0x2F
            | 0x34..=0x37 | 0x3E | 0x40 | 0x41 | 0x4F | 0x53 | 0x56 | 0x57 | 0x67 | 0x6B
            | 0x72 | 0x8B | 0xB8 => (Instruction::Raw { opcode, payload: Vec::new() }, false),

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
                (Instruction::Fork(rom_addr), true)
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
                let currency = self.parse_sub(cur_file_off);
                let amount_low = self.read_u16(cur_file_off);
                let amount_high = self.read_u8(cur_file_off);
                let amount = (amount_low as u32) | ((amount_high as u32) << 16);
                let target_offset = self.read_i16(cur_file_off);
                (Instruction::IfMoneyGe { currency, amount, target_offset }, true)
            }
            0x0B => {
                let currency = self.parse_sub(cur_file_off);
                let amount_low = self.read_u16(cur_file_off);
                let amount_high = self.read_u8(cur_file_off);
                let amount = (amount_low as u32) | ((amount_high as u32) << 16);
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
            0x10 | 0x14 | 0x18 | 0x1C => {
                let addr = self.read_u16(cur_file_off);
                let expr = self.parse_sub(cur_file_off);
                (Instruction::WriteRam { opcode, addr, expr }, true)
            }
            0x11 | 0x15 | 0x19 | 0x1D => {
                let addr = self.read_u16(cur_file_off);
                let expr = self.parse_sub(cur_file_off);
                (Instruction::WriteTemp { opcode, addr, expr }, true)
            }
            0x12 | 0x16 | 0x1A | 0x1E => {
                let arg = self.read_u8(cur_file_off);
                let expr = self.parse_sub(cur_file_off);
                (Instruction::WriteScriptArg { opcode, arg, expr }, true)
            }
            0x17 => {
                let addr = self.read_u16(cur_file_off);
                let val = self.read_u16(cur_file_off);
                (Instruction::WriteVarFast { addr, val }, true)
            }
            0x1B => {
                let _w1 = self.read_u16(cur_file_off);
                let _w2 = self.read_u16(cur_file_off);
                let _b1 = self.read_u8(cur_file_off);
                let _b2 = self.read_u8(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x20 => {
                let _x = self.read_u8(cur_file_off);
                let _y = self.read_u8(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x21 => {
                let x = self.read_u8(cur_file_off);
                let y = self.read_u8(cur_file_off);
                (Instruction::CameraFollow { x, y }, true)
            }
            0x22 => {
                let x = self.read_u8(cur_file_off);
                let y = self.read_u8(cur_file_off);
                let map = self.read_u16(cur_file_off);
                (Instruction::ChangeMap { x, y, map }, true)
            }
            0x23 => {
                let _scroll = self.read_u16(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x26 | 0x27 => (self.raw_instruction(opcode, stmt_start, *cur_file_off), true),
            0x29 => {
                let script_addr = self.read_u24(cur_file_off);
                let rom_addr = Rom::script_to_rom_addr(script_addr);
                (Instruction::Call(rom_addr), true)
            }
            0x2C => {
                let arg = self.read_u8(cur_file_off);
                (Instruction::LockPlayer(arg), true)
            }
            0x2D => {
                let arg = self.read_u8(cur_file_off);
                (Instruction::UnlockPlayer(arg), true)
            }
            0x30..=0x33 => {
                let _b = self.read_u8(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x38 | 0x3A => (self.raw_instruction(opcode, stmt_start, *cur_file_off), true),
            0x3C => {
                for _ in 0..6 { self.read_u8(cur_file_off); }
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x3D => {
                let _ent = self.parse_sub(cur_file_off);
                let _w = self.read_u16(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x3F => {
                let _e = self.parse_sub(cur_file_off);
                let _w1 = self.read_u16(cur_file_off);
                let _w2 = self.read_u16(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x42 => {
                let _ent = self.parse_sub(cur_file_off);
                let _w = self.read_u16(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x43 => {
                let _ent = self.parse_sub(cur_file_off);
                let _x = self.parse_sub(cur_file_off);
                let _y = self.parse_sub(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x44..=0x47 => {
                for _ in 0..5 { self.read_u8(cur_file_off); }
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x48..=0x4B => (self.raw_instruction(opcode, stmt_start, *cur_file_off), true),
            0x4C => {
                let _b = self.read_u8(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x4D => (self.raw_instruction(opcode, stmt_start, *cur_file_off), true),
            0x50 => {
                let _win = self.read_u8(cur_file_off);
                let _txt = self.read_u16(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x51 => {
                let text_id = self.read_u16(cur_file_off);
                (Instruction::ShowText(text_id), true)
            }
            0x52 => {
                let text_id = self.read_u16(cur_file_off);
                (Instruction::ShowTextEnd(text_id), true)
            }
            0x54 => {
                let _win = self.read_u8(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x55 => (Instruction::HideText, true),
            0x58 | 0x59 => (self.raw_instruction(opcode, stmt_start, *cur_file_off), true),
            0x5A | 0x5B => (self.raw_instruction(opcode, stmt_start, *cur_file_off), true),
            0x5C => {
                let _e1 = self.parse_sub(cur_file_off);
                let _e2 = self.parse_sub(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x5D | 0x5E => {
                let _e = self.parse_sub(cur_file_off);
                let _w = self.read_u16(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x62 => {
                let _b = self.read_u8(cur_file_off);
                let _w1 = self.read_u16(cur_file_off);
                let _w2 = self.read_u16(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x63 => (self.raw_instruction(opcode, stmt_start, *cur_file_off), true),
            0x65 | 0x66 => (self.raw_instruction(opcode, stmt_start, *cur_file_off), true),
            0x69 | 0x6A => (self.raw_instruction(opcode, stmt_start, *cur_file_off), true),
            0x6C | 0x6E => {
                let _ent = self.parse_sub(cur_file_off);
                let _cx = self.read_u8(cur_file_off);
                let _cy = self.read_u8(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x6D | 0x6F => {
                let _ent = self.parse_sub(cur_file_off);
                let _dx = self.parse_sub(cur_file_off);
                let _dy = self.parse_sub(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x70 | 0x71 => {
                let _e1 = self.parse_sub(cur_file_off);
                let _e2 = self.parse_sub(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x73 => {
                let _ent = self.parse_sub(cur_file_off);
                let _x = self.parse_sub(cur_file_off);
                let _y = self.parse_sub(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x78 | 0x79 => {
                let _ent = self.parse_sub(cur_file_off);
                let _anim = self.read_u16(cur_file_off);
                let _e = self.parse_sub(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x7A | 0x7B => {
                let _ent = self.parse_sub(cur_file_off);
                let _e = self.parse_sub(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x7C => {
                let currency = self.parse_sub(cur_file_off);
                let amount_low = self.read_u16(cur_file_off);
                let amount_high = self.read_u8(cur_file_off);
                let amount = (amount_low as u32) | ((amount_high as u32) << 16);
                (Instruction::GiveMoney { currency, amount }, true)
            }
            0x7D => {
                let currency = self.parse_sub(cur_file_off);
                let amount_low = self.read_u16(cur_file_off);
                let amount_high = self.read_u8(cur_file_off);
                let amount = (amount_low as u32) | ((amount_high as u32) << 16);
                (Instruction::TakeMoney { currency, amount }, true)
            }
            0x7E => {
                for _ in 0..3 { self.parse_sub(cur_file_off); }
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x7F => {
                let _w = self.read_u16(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x80..=0x83 => (self.raw_instruction(opcode, stmt_start, *cur_file_off), true),
            0x88 => (self.raw_instruction(opcode, stmt_start, *cur_file_off), true),
            0x8C => {
                let _txt = self.read_u16(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x8D => {
                let _b = self.read_u8(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x8E | 0x8F => {
                let _e1 = self.parse_sub(cur_file_off);
                let _e2 = self.parse_sub(cur_file_off);
                let _off = self.read_i16(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x96 => {
                let _x = self.parse_sub(cur_file_off);
                let _y = self.parse_sub(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x97 => {
                for _ in 0..7 { self.parse_sub(cur_file_off); }
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x99 => {
                for _ in 0..6 { self.parse_sub(cur_file_off); }
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x9D => {
                let _ent = self.parse_sub(cur_file_off);
                let _x = self.parse_sub(cur_file_off);
                let _y = self.parse_sub(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0x9E | 0xAC => {
                let target = self.parse_sub(cur_file_off);
                let spell = self.parse_sub(cur_file_off);
                let level = self.parse_sub(cur_file_off);
                let mut extra = Vec::new();
                loop {
                    let expr = self.parse_sub(cur_file_off);
                    let is_zero = matches!(expr, Expr::Const { val: 0, .. });
                    extra.push(expr);
                    if is_zero {
                        break;
                    }
                }
                (Instruction::CastAlchemy { opcode, target, spell, level, extra }, true)
            }
            0x9F..=0xA1 => (self.raw_instruction(opcode, stmt_start, *cur_file_off), true),
            0xA2 => {
                let _type = self.read_u16(cur_file_off);
                let _param = self.read_u16(cur_file_off);
                let _x = self.parse_sub(cur_file_off);
                let _y = self.parse_sub(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0xA3 => {
                let _idx = self.read_u8(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0xA4 => {
                let _idx = self.read_u16(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0xA5 => {
                let off = self.read_i8(cur_file_off);
                (Instruction::CallRelativeByte(off), true)
            }
            0xA6 => {
                let off = self.read_i16(cur_file_off);
                (Instruction::CallRelative(off), true)
            }
            0xA7 => {
                let frames = self.read_u8(cur_file_off);
                (Instruction::Sleep(frames), true)
            }
            0xA8 => {
                let frames = self.read_u16(cur_file_off);
                (Instruction::SleepWord(frames), true)
            }
            0xAA => (self.raw_instruction(opcode, stmt_start, *cur_file_off), true),
            0xAB => (Instruction::ResetGame, true),
            0xAD => {
                for _ in 0..6 { self.read_u8(cur_file_off); }
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0xAE => {
                for _ in 0..4 { self.read_u8(cur_file_off); }
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0xAF => {
                let count = self.read_u8(cur_file_off);
                for _ in 0..count { self.parse_sub(cur_file_off); }
                let _addr = self.read_u24(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0xB0 => {
                let count = self.read_u8(cur_file_off);
                for _ in 0..count { self.parse_sub(cur_file_off); }
                let _idx = self.read_u8(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0xB1 => {
                let count = self.read_u8(cur_file_off);
                for _ in 0..count { self.parse_sub(cur_file_off); }
                let _idx = self.read_u16(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0xB2 => {
                let count = self.read_u8(cur_file_off);
                for _ in 0..count { self.parse_sub(cur_file_off); }
                let _off = self.read_i8(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0xB3 => {
                let count = self.read_u8(cur_file_off);
                for _ in 0..count { self.parse_sub(cur_file_off); }
                let _off = self.read_i16(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0xB4 => {
                let count = self.read_u8(cur_file_off);
                for _ in 0..count { self.parse_sub(cur_file_off); }
                let _addr = self.read_u24(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0xB5 => {
                for _ in 0..8 { self.parse_sub(cur_file_off); }
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0xB6 => {
                for _ in 0..4 { self.parse_sub(cur_file_off); }
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0xBA | 0xC2 => {
                for _ in 0..3 { self.read_u8(cur_file_off); }
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            0xBC..=0xC1 => (self.raw_instruction(opcode, stmt_start, *cur_file_off), true),
            // Strukturierte Expression-Opcodes
            0x2E => {
                let cond = self.parse_sub(cur_file_off);
                (Instruction::WaitUntil(cond), true)
            }
            0x39 => {
                let frames = self.parse_sub(cur_file_off);
                (Instruction::WaitFrame(frames), true)
            }
            0x3B => {
                let anim = self.parse_sub(cur_file_off);
                (Instruction::WaitAnim(anim), true)
            }
            0x5F => {
                let expr = self.parse_sub(cur_file_off);
                let word = self.read_u16(cur_file_off);
                (Instruction::TileState { expr, word }, true)
            }
            0x60 => {
                let val = self.parse_sub(cur_file_off);
                (Instruction::BgScrollX(val), true)
            }
            0x61 => {
                let val = self.parse_sub(cur_file_off);
                (Instruction::BgScrollY(val), true)
            }
            0x64 => {
                let speed = self.parse_sub(cur_file_off);
                (Instruction::BgScrollSpeed(speed), true)
            }
            0x68 => {
                let speed = self.parse_sub(cur_file_off);
                (Instruction::Bg2ScrollSpeed(speed), true)
            }
            0x84 => {
                let currency = self.parse_sub(cur_file_off);
                let amount = self.parse_sub(cur_file_off);
                (Instruction::GiveMoneyExpr { currency, amount }, true)
            }
            0x85 => {
                let currency = self.parse_sub(cur_file_off);
                let amount = self.parse_sub(cur_file_off);
                (Instruction::TakeMoneyExpr { currency, amount }, true)
            }
            0x86 => {
                let val = self.parse_sub(cur_file_off);
                (Instruction::SoundCmd28(val), true)
            }
            0x87 => {
                let val = self.parse_sub(cur_file_off);
                (Instruction::SoundCmd2A(val), true)
            }
            0x89 => {
                let item = self.parse_sub(cur_file_off);
                let count = self.parse_sub(cur_file_off);
                (Instruction::AddShopItem { item, count }, true)
            }
            0x8A => {
                let shop_id = self.parse_sub(cur_file_off);
                (Instruction::OpenShopMenu(shop_id), true)
            }
            0x90 => {
                let level = self.parse_sub(cur_file_off);
                (Instruction::SetBrightness(level), true)
            }
            0x92 => {
                let target = self.parse_sub(cur_file_off);
                let palette = self.parse_sub(cur_file_off);
                (Instruction::SetEntityPalette { target, palette }, true)
            }
            0x93 => {
                let target = self.parse_sub(cur_file_off);
                let amount = self.parse_sub(cur_file_off);
                (Instruction::DamageEntity { target, amount }, true)
            }
            0x94 => {
                let target = self.parse_sub(cur_file_off);
                let amount = self.parse_sub(cur_file_off);
                (Instruction::HealEntity { target, amount }, true)
            }
            0x95 => {
                let target = self.parse_sub(cur_file_off);
                let hp = self.parse_sub(cur_file_off);
                (Instruction::SetEntityHp { target, hp }, true)
            }
            0x98 => {
                let weather = self.parse_sub(cur_file_off);
                (Instruction::SetWeather(weather), true)
            }
            0x9A => {
                let target = self.parse_sub(cur_file_off);
                (Instruction::AttachCamera(target), true)
            }
            0xA9 => {
                let target = self.parse_sub(cur_file_off);
                let action = self.parse_sub(cur_file_off);
                (Instruction::TriggerEntityAction { target, action }, true)
            }
            0xB7 => {
                let color = self.parse_sub(cur_file_off);
                (Instruction::FlashScreen(color), true)
            }
            0xB9 => {
                let target = self.parse_sub(cur_file_off);
                let dx = self.parse_sub(cur_file_off);
                let dy = self.parse_sub(cur_file_off);
                (Instruction::SetEntityPosRel { target, dx, dy }, true)
            }
            0xBB => {
                let target = self.parse_sub(cur_file_off);
                let val = self.parse_sub(cur_file_off);
                (Instruction::DamageEntity2 { target, val }, true)
            }
            // Weitere Opcodes mit 1 Ausdrucks-Operanden (Raw)
            0x2A | 0x2B | 0x4E | 0x74..=0x77 | 0x91 | 0x9B | 0x9C => {
                let _expr = self.parse_sub(cur_file_off);
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
            _ => {
                let payload_len = Self::get_known_payload_len(opcode);
                for _ in 0..payload_len {
                    self.read_u8(cur_file_off);
                }
                (self.raw_instruction(opcode, stmt_start, *cur_file_off), true)
            }
        }
    }

    fn get_known_payload_len(opcode: u8) -> usize {
        match opcode {
            // 0 operand bytes
            0x00..=0x03 | 0x06 | 0x0F | 0x13 | 0x1F | 0x24 | 0x25 | 0x26 | 0x27 | 0x28 | 0x2F
            | 0x34..=0x38 | 0x3A | 0x3E | 0x40 | 0x41 | 0x48..=0x4B | 0x4D | 0x4F | 0x53
            | 0x55 | 0x56 | 0x57 | 0x58 | 0x59 | 0x5A | 0x5B | 0x63 | 0x65 | 0x66 | 0x67 | 0x69 | 0x6A | 0x6B
            | 0x72 | 0x80..=0x83 | 0x88 | 0x8B | 0x9F..=0xA1 | 0xAA | 0xAB | 0xB8 | 0xBC..=0xC1 => 0,

            // 1 byte
            0x05 | 0x2C | 0x2D | 0x30..=0x33 | 0x4C | 0x54
            | 0x8D | 0xA3 | 0xA5 | 0xA7 => 1,

            // 2 bytes
            0x04 | 0x20 | 0x21 | 0x23 | 0x51 | 0x52 | 0x7F | 0x8C | 0xA4 | 0xA6 | 0xA8 => 2,

            // 3 bytes
            0x07 | 0x29 | 0x50 | 0xBA | 0xC2 => 3,

            // 4 bytes
            0x17 | 0x22 | 0xAE => 4,

            // 5 bytes
            0x44..=0x47 | 0x62 => 5,

            // 6 bytes
            0x1B | 0x3C | 0xAD => 6,

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
                    let val = (sub - 0x30) as i32;
                    current_expr = Some(Expr::Const { opcode: Some(sub), val });
                }
                0x40..=0x4F => {
                    let val = (sub as i8 - 0x50) as i32;
                    current_expr = Some(Expr::Const { opcode: Some(sub), val });
                }
                0x60..=0x6F => {
                    let val = (sub - 0x60 + 16) as i32;
                    current_expr = Some(Expr::Const { opcode: Some(sub), val });
                }
                0x01 => {
                    let b = self.read_u8(cur_file_off);
                    let val = -256 + (b as i32);
                    current_expr = Some(Expr::Const { opcode: Some(0x01), val });
                }
                0x02 => {
                    let b = self.read_u8(cur_file_off);
                    let val = b as i32;
                    current_expr = Some(Expr::Const { opcode: Some(0x02), val });
                }
                0x03 => {
                    let w = self.read_u16(cur_file_off);
                    // Token 03 sets high-word unconditionally to 0xFFFF (not sign-extended)
                    let val = (w as u32 | 0xFFFF0000) as i32;
                    current_expr = Some(Expr::Const { opcode: Some(0x03), val });
                }
                0x04 => {
                    let w = self.read_u16(cur_file_off);
                    current_expr = Some(Expr::Const { opcode: Some(0x04), val: w as i32 });
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
                    current_expr = Some(Expr::RamByte { opcode: sub, addr });
                }
                0x08 | 0x09 => {
                    let addr = self.read_u16(cur_file_off);
                    current_expr = Some(Expr::RamWord { opcode: sub, addr });
                }
                0x0B | 0x0C => {
                    let addr = self.read_u16(cur_file_off);
                    current_expr = Some(Expr::TempByte { opcode: sub, addr });
                }
                0x0D | 0x0E => {
                    let addr = self.read_u16(cur_file_off);
                    current_expr = Some(Expr::TempWord { opcode: sub, addr });
                }
                0x0F => {
                    let bit = self.read_u8(cur_file_off);
                    current_expr = Some(Expr::ArgBit(bit));
                }
                0x10 | 0x11 => {
                    let arg = self.read_u8(cur_file_off);
                    current_expr = Some(Expr::ArgByte { opcode: sub, arg });
                }
                0x12 | 0x13 => {
                    let arg = self.read_u8(cur_file_off);
                    current_expr = Some(Expr::ArgWord { opcode: sub, arg });
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
                    let left = stack.pop().unwrap_or_else(|| Expr::const_val(0));
                    let right = current_expr.take().unwrap_or_else(|| Expr::const_val(0));
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
                    let right = current_expr.take().unwrap_or_else(|| Expr::const_val(0));
                    current_expr = Some(Expr::RngRange(Box::new(right)));
                }
                0x2C => {
                    let param = current_expr.take();
                    current_expr = Some(Expr::DialogResponse(param.map(Box::new)));
                }
                0x55 | 0x56 | 0x5A | 0x5B | 0x5C => {
                    if let Some(e) = current_expr.take() {
                        current_expr = Some(Expr::RawUnary { op: sub, expr: Box::new(e) });
                    } else {
                        current_expr = Some(Expr::RawToken(sub));
                    }
                }
                0x2D | 0x2E | 0x54 | 0x57..=0x59 => {
                    current_expr = Some(Expr::RawToken(sub));
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

        current_expr.unwrap_or_else(|| Expr::const_val(0))
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
