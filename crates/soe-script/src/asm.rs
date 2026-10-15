// crates/soe-script/src/asm.rs
use crate::ast::*;
use soe_core::Rom;

pub struct Assembler;

impl Assembler {
    pub fn assemble_script(script: &Script) -> Vec<u8> {
        let mut out = Vec::new();
        for stmt in &script.statements {
            Self::assemble_instruction(&stmt.instruction, &mut out);
        }
        out
    }

    pub fn assemble_instruction(instr: &Instruction, out: &mut Vec<u8>) {
        match instr {
            Instruction::End | Instruction::Return => out.push(0x00),
            Instruction::Skip(jmp) => {
                out.push(0x04);
                out.extend_from_slice(&jmp.to_le_bytes());
            }
            Instruction::SkipNeg(jmp) => {
                out.push(0x05);
                out.push(*jmp as u8);
            }
            Instruction::Fork(rom_addr) => {
                out.push(0x07);
                let script_addr = Rom::rom_to_script_addr(*rom_addr);
                let b0 = (script_addr & 0xFF) as u8;
                let b1 = ((script_addr >> 8) & 0xFF) as u8;
                let b2 = ((script_addr >> 16) & 0xFF) as u8;
                out.extend_from_slice(&[b0, b1, b2]);
            }
            Instruction::Call(rom_addr) => {
                out.push(0x29);
                let script_addr = Rom::rom_to_script_addr(*rom_addr);
                let b0 = (script_addr & 0xFF) as u8;
                let b1 = ((script_addr >> 8) & 0xFF) as u8;
                let b2 = ((script_addr >> 16) & 0xFF) as u8;
                out.extend_from_slice(&[b0, b1, b2]);
            }
            Instruction::CallRelative(jmp) => {
                out.push(0xA6);
                out.extend_from_slice(&jmp.to_le_bytes());
            }
            Instruction::CallRelativeByte(jmp) => {
                out.push(0xA5);
                out.push(*jmp as u8);
            }
            Instruction::If { cond, target_offset } => {
                out.push(0x08);
                Self::assemble_expr(cond, out);
                out.extend_from_slice(&target_offset.to_le_bytes());
            }
            Instruction::IfNot { cond, target_offset } => {
                out.push(0x09);
                Self::assemble_expr(cond, out);
                out.extend_from_slice(&target_offset.to_le_bytes());
            }
            Instruction::IfMoneyGe { currency, amount, target_offset } => {
                out.push(0x0A);
                Self::assemble_expr(currency, out);
                let b0 = (amount & 0xFF) as u8;
                let b1 = ((amount >> 8) & 0xFF) as u8;
                let b2 = ((amount >> 16) & 0xFF) as u8;
                out.extend_from_slice(&[b0, b1, b2]);
                out.extend_from_slice(&target_offset.to_le_bytes());
            }
            Instruction::IfMoneyLt { currency, amount, target_offset } => {
                out.push(0x0B);
                Self::assemble_expr(currency, out);
                let b0 = (amount & 0xFF) as u8;
                let b1 = ((amount >> 8) & 0xFF) as u8;
                let b2 = ((amount >> 16) & 0xFF) as u8;
                out.extend_from_slice(&[b0, b1, b2]);
                out.extend_from_slice(&target_offset.to_le_bytes());
            }
            Instruction::SetFlag { base, bit_index, val } => {
                let op = match base {
                    FlagBase::Ram => 0x0C,
                    FlagBase::Temp => 0x0D,
                };
                out.push(op);
                out.extend_from_slice(&bit_index.to_le_bytes());
                Self::assemble_expr(val, out);
            }
            Instruction::SetScriptArgBit { bit_index, val } => {
                out.push(0x0E);
                out.push(*bit_index);
                Self::assemble_expr(val, out);
            }
            Instruction::WriteVarFast { addr, val } => {
                out.push(0x17);
                out.extend_from_slice(&addr.to_le_bytes());
                out.extend_from_slice(&val.to_le_bytes());
            }
            Instruction::WriteRam { addr, expr } => {
                out.push(0x18);
                out.extend_from_slice(&addr.to_le_bytes());
                Self::assemble_expr(expr, out);
            }
            Instruction::WriteTemp { addr, expr } => {
                out.push(0x1D);
                out.extend_from_slice(&addr.to_le_bytes());
                Self::assemble_expr(expr, out);
            }
            Instruction::WriteScriptArg { arg, expr } => {
                out.push(0x1E);
                out.push(*arg);
                Self::assemble_expr(expr, out);
            }
            Instruction::ShowText(text_id) => {
                out.push(0x51);
                out.extend_from_slice(&text_id.to_le_bytes());
            }
            Instruction::ShowTextEnd(text_id) => {
                out.push(0x52);
                out.extend_from_slice(&text_id.to_le_bytes());
            }
            Instruction::HideText => out.push(0x55),
            Instruction::GiveMoney { currency, amount } => {
                out.push(0x7C);
                Self::assemble_expr(currency, out);
                let b0 = (*amount & 0xFF) as u8;
                let b1 = ((*amount >> 8) & 0xFF) as u8;
                let b2 = ((*amount >> 16) & 0xFF) as u8;
                out.extend_from_slice(&[b0, b1, b2]);
            }
            Instruction::TakeMoney { currency, amount } => {
                out.push(0x7D);
                Self::assemble_expr(currency, out);
                let b0 = (*amount & 0xFF) as u8;
                let b1 = ((*amount >> 8) & 0xFF) as u8;
                let b2 = ((*amount >> 16) & 0xFF) as u8;
                out.extend_from_slice(&[b0, b1, b2]);
            }
            Instruction::GiveJewels(amount) => {
                out.push(0x7C);
                Self::assemble_expr(&Expr::Const(3), out);
                let b0 = (*amount & 0xFF) as u8;
                let b1 = ((*amount >> 8) & 0xFF) as u8;
                let b2 = ((*amount >> 16) & 0xFF) as u8;
                out.extend_from_slice(&[b0, b1, b2]);
            }
            Instruction::Sleep(frames) => {
                out.push(0xA7);
                out.push(*frames);
            }
            Instruction::SleepWord(frames) => {
                out.push(0xA8);
                out.extend_from_slice(&frames.to_le_bytes());
            }
            Instruction::Raw { opcode, payload } => {
                out.push(*opcode);
                out.extend_from_slice(payload);
            }
        }
    }

    /// Serialisiert einen Ausdruck in eine Sub-Instruktionskette und setzt das Bit 7 auf dem letzten Byte.
    pub fn assemble_expr(expr: &Expr, out: &mut Vec<u8>) {
        let mut sub_bytes = Vec::new();
        Self::emit_sub_expr(expr, &mut sub_bytes);
        if let Some(last) = sub_bytes.last_mut() {
            *last |= 0x80;
        }
        out.extend(sub_bytes);
    }

    fn emit_sub_expr(expr: &Expr, bytes: &mut Vec<u8>) {
        match expr {
            Expr::Const(val) => {
                if (0..=15).contains(val) {
                    bytes.push(0x30 + (*val as u8));
                } else if (16..=31).contains(val) {
                    bytes.push(0x60 + ((*val - 16) as u8));
                } else if (*val >= 0) && (*val <= 255) {
                    bytes.push(0x02);
                    bytes.push(*val as u8);
                } else {
                    bytes.push(0x04);
                    bytes.extend_from_slice(&val.to_le_bytes());
                }
            }
            Expr::Flag { base, bit_index } => {
                let op = match base {
                    FlagBase::Ram => 0x05,
                    FlagBase::Temp => 0x0A,
                };
                bytes.push(op);
                bytes.extend_from_slice(&bit_index.to_le_bytes());
            }
            Expr::RamByte(addr) => {
                bytes.push(0x07);
                bytes.extend_from_slice(&addr.to_le_bytes());
            }
            Expr::RamWord(addr) => {
                bytes.push(0x09);
                bytes.extend_from_slice(&addr.to_le_bytes());
            }
            Expr::TempByte(addr) => {
                bytes.push(0x0C);
                bytes.extend_from_slice(&addr.to_le_bytes());
            }
            Expr::TempWord(addr) => {
                bytes.push(0x0E);
                bytes.extend_from_slice(&addr.to_le_bytes());
            }
            Expr::ArgByte(arg) => {
                bytes.push(0x11);
                bytes.push(*arg);
            }
            Expr::ArgWord(arg) => {
                bytes.push(0x13);
                bytes.push(*arg);
            }
            Expr::Entity(ent) => {
                bytes.push(ent.to_u8());
            }
            Expr::Rng => {
                bytes.push(0x2A);
            }
            Expr::RngRange(right) => {
                Self::emit_sub_expr(right, bytes);
                bytes.push(0x2B);
            }
            Expr::DialogResponse => {
                bytes.push(0x2C);
            }
            Expr::Unary { op, expr } => {
                Self::emit_sub_expr(expr, bytes);
                let b = match op {
                    UnaryOp::Not => 0x14,
                    UnaryOp::BitNot => 0x15,
                    UnaryOp::Neg => 0x16,
                };
                bytes.push(b);
            }
            Expr::Binary { op, left, right } => {
                Self::emit_sub_expr(left, bytes);
                bytes.push(0x29); // Push left
                Self::emit_sub_expr(right, bytes);
                let b = match op {
                    BinaryOp::Mul => 0x17,
                    BinaryOp::Div => 0x18,
                    BinaryOp::Add => 0x1A,
                    BinaryOp::Sub => 0x1B,
                    BinaryOp::Shl => 0x1C,
                    BinaryOp::Shr => 0x1D,
                    BinaryOp::Lt => 0x1E,
                    BinaryOp::Gt => 0x1F,
                    BinaryOp::Le => 0x20,
                    BinaryOp::Ge => 0x21,
                    BinaryOp::Eq => 0x22,
                    BinaryOp::Ne => 0x23,
                    BinaryOp::BitAnd => 0x24,
                    BinaryOp::BitOr => 0x25,
                    BinaryOp::BitXor => 0x26,
                    BinaryOp::Or => 0x27,
                    BinaryOp::And => 0x28,
                };
                bytes.push(b);
            }
            Expr::Raw(raw) => {
                bytes.extend_from_slice(raw);
            }
        }
    }
}
