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
            Instruction::WriteRam { opcode, addr, expr } => {
                out.push(*opcode);
                out.extend_from_slice(&addr.to_le_bytes());
                Self::assemble_expr(expr, out);
            }
            Instruction::WriteTemp { opcode, addr, expr } => {
                out.push(*opcode);
                out.extend_from_slice(&addr.to_le_bytes());
                Self::assemble_expr(expr, out);
            }
            Instruction::WriteScriptArg { opcode, arg, expr } => {
                out.push(*opcode);
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
                Self::assemble_expr(&Expr::const_val(3), out);
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
            Instruction::LockPlayer(arg) => {
                out.push(0x2C);
                out.push(*arg);
            }
            Instruction::UnlockPlayer(arg) => {
                out.push(0x2D);
                out.push(*arg);
            }
            Instruction::CameraFollow { x, y } => {
                out.push(0x21);
                out.push(*x);
                out.push(*y);
            }
            Instruction::ChangeMap { x, y, map } => {
                out.push(0x22);
                out.push(*x);
                out.push(*y);
                out.extend_from_slice(&map.to_le_bytes());
            }
            Instruction::ResetGame => {
                out.push(0xAB);
            }
            Instruction::WaitUntil(expr) => {
                out.push(0x2E);
                Self::assemble_expr(expr, out);
            }
            Instruction::WaitFrame(expr) => {
                out.push(0x39);
                Self::assemble_expr(expr, out);
            }
            Instruction::WaitAnim(expr) => {
                out.push(0x3B);
                Self::assemble_expr(expr, out);
            }
            Instruction::TileState { expr, word } => {
                out.push(0x5F);
                Self::assemble_expr(expr, out);
                out.extend_from_slice(&word.to_le_bytes());
            }
            Instruction::BgScrollX(expr) => {
                out.push(0x60);
                Self::assemble_expr(expr, out);
            }
            Instruction::BgScrollY(expr) => {
                out.push(0x61);
                Self::assemble_expr(expr, out);
            }
            Instruction::BgScrollSpeed(expr) => {
                out.push(0x64);
                Self::assemble_expr(expr, out);
            }
            Instruction::Bg2ScrollSpeed(expr) => {
                out.push(0x68);
                Self::assemble_expr(expr, out);
            }
            Instruction::GiveMoneyExpr { currency, amount } => {
                out.push(0x84);
                Self::assemble_expr(currency, out);
                Self::assemble_expr(amount, out);
            }
            Instruction::TakeMoneyExpr { currency, amount } => {
                out.push(0x85);
                Self::assemble_expr(currency, out);
                Self::assemble_expr(amount, out);
            }
            Instruction::SoundCmd28(expr) => {
                out.push(0x86);
                Self::assemble_expr(expr, out);
            }
            Instruction::SoundCmd2A(expr) => {
                out.push(0x87);
                Self::assemble_expr(expr, out);
            }
            Instruction::AddShopItem { item, count } => {
                out.push(0x89);
                Self::assemble_expr(item, out);
                Self::assemble_expr(count, out);
            }
            Instruction::OpenShopMenu(expr) => {
                out.push(0x8A);
                Self::assemble_expr(expr, out);
            }
            Instruction::SetBrightness(expr) => {
                out.push(0x90);
                Self::assemble_expr(expr, out);
            }
            Instruction::SetEntityPalette { target, palette } => {
                out.push(0x92);
                Self::assemble_expr(target, out);
                Self::assemble_expr(palette, out);
            }
            Instruction::DamageEntity { target, amount } => {
                out.push(0x93);
                Self::assemble_expr(target, out);
                Self::assemble_expr(amount, out);
            }
            Instruction::HealEntity { target, amount } => {
                out.push(0x94);
                Self::assemble_expr(target, out);
                Self::assemble_expr(amount, out);
            }
            Instruction::SetEntityHp { target, hp } => {
                out.push(0x95);
                Self::assemble_expr(target, out);
                Self::assemble_expr(hp, out);
            }
            Instruction::SwitchCharacter(expr) => {
                out.push(0x98);
                Self::assemble_expr(expr, out);
            }
            Instruction::AttachCamera(expr) => {
                out.push(0x9B);
                Self::assemble_expr(expr, out);
            }
            Instruction::CastAlchemy { opcode, target, spell, level, extra } => {
                out.push(*opcode);
                Self::assemble_expr(target, out);
                Self::assemble_expr(spell, out);
                Self::assemble_expr(level, out);
                for e in extra {
                    Self::assemble_expr(e, out);
                }
            }
            Instruction::TriggerEntityAction { target, action } => {
                out.push(0xA9);
                Self::assemble_expr(target, out);
                Self::assemble_expr(action, out);
            }
            Instruction::FlashScreen(expr) => {
                out.push(0xB7);
                Self::assemble_expr(expr, out);
            }
            Instruction::SetEntityPosRel { target, dx, dy } => {
                out.push(0xB9);
                Self::assemble_expr(target, out);
                Self::assemble_expr(dx, out);
                Self::assemble_expr(dy, out);
            }
            Instruction::DamageEntity2 { target, val } => {
                out.push(0xBB);
                Self::assemble_expr(target, out);
                Self::assemble_expr(val, out);
            }
            Instruction::Raw { opcode, payload } => {
                out.push(*opcode);
                out.extend_from_slice(payload);
            }
        }
    }

    /// Serialisiert einen Ausdruck in eine Sub-Instruktionskette und setzt das Bit 7 auf dem Opcode-Byte des letzten Tokens.
    pub fn assemble_expr(expr: &Expr, out: &mut Vec<u8>) {
        let mut sub_bytes = Vec::new();
        let last_token_pos = Self::emit_sub_expr(expr, &mut sub_bytes);
        if let Some(pos) = last_token_pos {
            sub_bytes[pos] |= 0x80;
        }
        out.extend(sub_bytes);
    }

    /// Gibt die Byte-Position des Opcode-Bytes des letzten Tokens zurück.
    fn emit_sub_expr(expr: &Expr, bytes: &mut Vec<u8>) -> Option<usize> {
        match expr {
            Expr::Const { opcode, val } => {
                let pos = bytes.len();
                match opcode {
                    Some(0x01) => {
                        bytes.push(0x01);
                        bytes.push((*val + 256) as u8);
                    }
                    Some(0x02) => {
                        bytes.push(0x02);
                        bytes.push(*val as u8);
                    }
                    Some(0x03) => {
                        bytes.push(0x03);
                        let w = (*val as u32 & 0xFFFF) as u16;
                        bytes.extend_from_slice(&w.to_le_bytes());
                    }
                    Some(0x04) => {
                        bytes.push(0x04);
                        let w = (*val as u32 & 0xFFFF) as u16;
                        bytes.extend_from_slice(&w.to_le_bytes());
                    }
                    Some(tok @ 0x30..=0x3F) | Some(tok @ 0x40..=0x4F) | Some(tok @ 0x60..=0x6F) => {
                        bytes.push(*tok);
                    }
                    _ => {
                        if (-256..=-1).contains(val) {
                            bytes.push(0x01);
                            bytes.push((*val + 256) as u8);
                        } else if *val < 0 {
                            bytes.push(0x03);
                            let w = (*val as u32 & 0xFFFF) as u16;
                            bytes.extend_from_slice(&w.to_le_bytes());
                        } else if (0..=15).contains(val) {
                            bytes.push(0x30 + (*val as u8));
                        } else if (16..=31).contains(val) {
                            bytes.push(0x60 + ((*val - 16) as u8));
                        } else if (0..=255).contains(val) {
                            bytes.push(0x02);
                            bytes.push(*val as u8);
                        } else {
                            bytes.push(0x04);
                            let w = (*val as u32 & 0xFFFF) as u16;
                            bytes.extend_from_slice(&w.to_le_bytes());
                        }
                    }
                }
                Some(pos)
            }
            Expr::Flag { base, bit_index } => {
                let pos = bytes.len();
                let op = match base {
                    FlagBase::Ram => 0x05,
                    FlagBase::Temp => 0x0A,
                };
                bytes.push(op);
                bytes.extend_from_slice(&bit_index.to_le_bytes());
                Some(pos)
            }
            Expr::RamByte { opcode, addr } => {
                let pos = bytes.len();
                bytes.push(*opcode);
                bytes.extend_from_slice(&addr.to_le_bytes());
                Some(pos)
            }
            Expr::RamWord { opcode, addr } => {
                let pos = bytes.len();
                bytes.push(*opcode);
                bytes.extend_from_slice(&addr.to_le_bytes());
                Some(pos)
            }
            Expr::TempByte { opcode, addr } => {
                let pos = bytes.len();
                bytes.push(*opcode);
                bytes.extend_from_slice(&addr.to_le_bytes());
                Some(pos)
            }
            Expr::TempWord { opcode, addr } => {
                let pos = bytes.len();
                bytes.push(*opcode);
                bytes.extend_from_slice(&addr.to_le_bytes());
                Some(pos)
            }
            Expr::ArgBit(bit) => {
                let pos = bytes.len();
                bytes.push(0x0F);
                bytes.push(*bit);
                Some(pos)
            }
            Expr::ArgByte { opcode, arg } => {
                let pos = bytes.len();
                bytes.push(*opcode);
                bytes.push(*arg);
                Some(pos)
            }
            Expr::ArgWord { opcode, arg } => {
                let pos = bytes.len();
                bytes.push(*opcode);
                bytes.push(*arg);
                Some(pos)
            }
            Expr::Entity(ent) => {
                let pos = bytes.len();
                bytes.push(ent.to_u8() & 0x7F);
                Some(pos)
            }
            Expr::Rng => {
                let pos = bytes.len();
                bytes.push(0x2A);
                Some(pos)
            }
            Expr::RngRange(right) => {
                Self::emit_sub_expr(right, bytes);
                let pos = bytes.len();
                bytes.push(0x2B);
                Some(pos)
            }
            Expr::DialogResponse(param) => {
                if let Some(p) = param {
                    Self::emit_sub_expr(p, bytes);
                }
                let pos = bytes.len();
                bytes.push(0x2C);
                Some(pos)
            }
            Expr::RawToken(tok) => {
                let pos = bytes.len();
                bytes.push(*tok);
                Some(pos)
            }
            Expr::Unary { op, expr } => {
                Self::emit_sub_expr(expr, bytes);
                let pos = bytes.len();
                let b = match op {
                    UnaryOp::Not => 0x14,
                    UnaryOp::BitNot => 0x15,
                    UnaryOp::Neg => 0x16,
                };
                bytes.push(b);
                Some(pos)
            }
            Expr::RawUnary { op, expr } => {
                Self::emit_sub_expr(expr, bytes);
                let pos = bytes.len();
                bytes.push(*op);
                Some(pos)
            }
            Expr::Binary { op, left, right } => {
                Self::emit_sub_expr(left, bytes);
                bytes.push(0x29); // Push left
                Self::emit_sub_expr(right, bytes);
                let pos = bytes.len();
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
                Some(pos)
            }
            Expr::Raw(raw) => {
                if raw.is_empty() {
                    return None;
                }
                let start = bytes.len();
                bytes.extend_from_slice(raw);
                if raw.iter().any(|b| (b & 0x80) != 0) {
                    None
                } else {
                    Some(start)
                }
            }
        }
    }
}
