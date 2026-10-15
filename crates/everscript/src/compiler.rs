// crates/everscript/src/compiler.rs
use crate::ast::*;
use soe_script::asm::Assembler;
use soe_script::ast as sigil;
use std::collections::HashMap;

#[derive(Debug, Clone)]
pub struct CompiledBlock {
    pub name: String,
    pub address: Option<u32>,
    pub bytecode: Vec<u8>,
}

pub struct Compiler {
    symbols: HashMap<String, i64>,
}

impl Default for Compiler {
    fn default() -> Self {
        Self::new()
    }
}

impl Compiler {
    pub fn new() -> Self {
        let mut symbols = HashMap::new();
        // Standard-Symbole & Konstanten
        symbols.insert("True".to_string(), 1);
        symbols.insert("False".to_string(), 0);
        symbols.insert("BOY".to_string(), 0xD0);
        symbols.insert("Boy".to_string(), 0xD0);
        symbols.insert("DOG".to_string(), 0xD1);
        symbols.insert("Dog".to_string(), 0xD1);
        Self { symbols }
    }

    pub fn compile_file(&mut self, file: &EvsScriptFile) -> Result<Vec<CompiledBlock>, String> {
        // Pass 1: Sammle alle Enums und Symbole
        for item in &file.items {
            self.collect_symbols(item);
        }

        // Pass 2: Kompiliere Funktionen und Patches
        let mut blocks = Vec::new();
        for item in &file.items {
            self.compile_item(item, &mut blocks)?;
        }

        Ok(blocks)
    }

    fn collect_symbols(&mut self, item: &EvsTopLevel) {
        match item {
            EvsTopLevel::Enum { name, members } => {
                for (mem_name, val) in members {
                    self.symbols.insert(format!("{}.{}", name, mem_name), *val);
                    self.symbols.insert(mem_name.clone(), *val);
                }
            }
            EvsTopLevel::Group { items, .. } => {
                for sub in items {
                    self.collect_symbols(sub);
                }
            }
            _ => {}
        }
    }

    fn compile_item(&mut self, item: &EvsTopLevel, out: &mut Vec<CompiledBlock>) -> Result<(), String> {
        match item {
            EvsTopLevel::Function(fun) => {
                let bytecode = self.compile_statements(&fun.body)?;
                out.push(CompiledBlock {
                    name: fun.name.clone(),
                    address: fun.address,
                    bytecode,
                });
            }
            EvsTopLevel::Patch { address, statements } => {
                let bytecode = self.compile_statements(statements)?;
                out.push(CompiledBlock {
                    name: format!("patch_${:06X}", address),
                    address: Some(*address),
                    bytecode,
                });
            }
            EvsTopLevel::Group { items, .. } => {
                for sub in items {
                    self.compile_item(sub, out)?;
                }
            }
            EvsTopLevel::Enum { .. } => {}
        }
        Ok(())
    }

    pub fn compile_statements(&self, statements: &[EvsStmt]) -> Result<Vec<u8>, String> {
        let mut out = Vec::new();

        for stmt in statements {
            match stmt {
                EvsStmt::End => {
                    out.push(0x00);
                }
                EvsStmt::Return => {
                    out.push(0x00);
                }
                EvsStmt::Call(expr) => {
                    let addr = self.eval_expr_const(expr)? as u32;
                    let instr = sigil::Instruction::Call(addr);
                    Assembler::assemble_instruction(&instr, &mut out);
                }
                EvsStmt::Text(expr) => {
                    let id = self.eval_expr_const(expr)? as u16;
                    let instr = sigil::Instruction::ShowText(id);
                    Assembler::assemble_instruction(&instr, &mut out);
                }
                EvsStmt::TextEnd(expr) => {
                    let id = self.eval_expr_const(expr)? as u16;
                    let instr = sigil::Instruction::ShowTextEnd(id);
                    Assembler::assemble_instruction(&instr, &mut out);
                }
                EvsStmt::TextHide => {
                    out.push(0x55);
                }
                EvsStmt::GiveJewels(expr) => {
                    let amount = self.eval_expr_const(expr)? as u32;
                    let instr = sigil::Instruction::GiveJewels(amount);
                    Assembler::assemble_instruction(&instr, &mut out);
                }
                EvsStmt::Sleep(expr) => {
                    let frames = self.eval_expr_const(expr)? as u32;
                    if frames <= 255 {
                        let instr = sigil::Instruction::Sleep(frames as u8);
                        Assembler::assemble_instruction(&instr, &mut out);
                    } else if frames <= 65535 {
                        let instr = sigil::Instruction::SleepWord(frames as u16);
                        Assembler::assemble_instruction(&instr, &mut out);
                    } else {
                        return Err(format!("Sleep-Dauer {} übersteigt 65535 Frames", frames));
                    }
                }
                EvsStmt::LockPlayer(expr) => {
                    let arg = self.eval_expr_const(expr)? as u8;
                    let instr = sigil::Instruction::LockPlayer(arg);
                    Assembler::assemble_instruction(&instr, &mut out);
                }
                EvsStmt::UnlockPlayer(expr) => {
                    let arg = self.eval_expr_const(expr)? as u8;
                    let instr = sigil::Instruction::UnlockPlayer(arg);
                    Assembler::assemble_instruction(&instr, &mut out);
                }
                EvsStmt::Skip(expr) => {
                    let off = self.eval_expr_const(expr)? as i16;
                    let instr = sigil::Instruction::Skip(off);
                    Assembler::assemble_instruction(&instr, &mut out);
                }
                EvsStmt::SwitchCharacter(expr) => {
                    let sigil_expr = self.compile_expr(expr)?;
                    let instr = sigil::Instruction::SwitchCharacter(sigil_expr);
                    Assembler::assemble_instruction(&instr, &mut out);
                }
                EvsStmt::AttachCamera(expr) => {
                    let sigil_expr = self.compile_expr(expr)?;
                    let instr = sigil::Instruction::AttachCamera(sigil_expr);
                    Assembler::assemble_instruction(&instr, &mut out);
                }
                EvsStmt::Raw { opcode, payload } => {
                    let instr = sigil::Instruction::Raw { opcode: *opcode, payload: payload.clone() };
                    Assembler::assemble_instruction(&instr, &mut out);
                }
                EvsStmt::Assign { target, value } => {
                    self.compile_assignment(target, value, &mut out)?;
                }
                EvsStmt::If { cond, then_branch, else_branch } => {
                    let mut then_bytes = self.compile_statements(then_branch)?;

                    if let Some(else_branch) = else_branch {
                        let else_bytes = self.compile_statements(else_branch)?;
                        // Skip instruction am Ende des then-Blocks
                        let skip_offset = else_bytes.len() as i16;
                        let mut skip_instr_bytes = Vec::new();
                        Assembler::assemble_instruction(&sigil::Instruction::Skip(skip_offset), &mut skip_instr_bytes);
                        then_bytes.extend(skip_instr_bytes);

                        let if_offset = (then_bytes.len()) as i16;
                        let sigil_cond = self.compile_expr(cond)?;
                        Assembler::assemble_instruction(&sigil::Instruction::IfNot { cond: sigil_cond, target_offset: if_offset }, &mut out);
                        out.extend(then_bytes);
                        out.extend(else_bytes);
                    } else {
                        let if_offset = then_bytes.len() as i16;
                        let sigil_cond = self.compile_expr(cond)?;
                        Assembler::assemble_instruction(&sigil::Instruction::IfNot { cond: sigil_cond, target_offset: if_offset }, &mut out);
                        out.extend(then_bytes);
                    }
                }
                EvsStmt::While { cond, body } => {
                    let body_bytes = self.compile_statements(body)?;
                    let loop_start_offset = out.len();

                    let sigil_cond = self.compile_expr(cond)?;
                    // Platzhalter für IfNot
                    let mut cond_bytes = Vec::new();
                    // Body + Skip(Rücksprung)
                    let skip_len = 3usize; // 0x04 + 2 bytes
                    let if_offset = (body_bytes.len() + skip_len) as i16;
                    Assembler::assemble_instruction(&sigil::Instruction::IfNot { cond: sigil_cond, target_offset: if_offset }, &mut cond_bytes);

                    out.extend(cond_bytes);
                    out.extend(body_bytes);

                    // Rücksprung zum Anfang
                    let total_loop_len = out.len() - loop_start_offset;
                    let back_jmp = -(total_loop_len as i16) - 3;
                    Assembler::assemble_instruction(&sigil::Instruction::Skip(back_jmp), &mut out);
                }
            }
        }

        Ok(out)
    }

    fn compile_assignment(&self, target: &EvsExpr, value: &EvsExpr, out: &mut Vec<u8>) -> Result<(), String> {
        match target {
            EvsExpr::Memory { base, offset } => {
                let off_val = self.eval_expr_const(offset)? as u16;
                let sigil_val = self.compile_expr(value)?;
                if *base == 0x2258 || *base == 0x7E2258 {
                    let instr = sigil::Instruction::WriteRam { opcode: 0x18, addr: off_val, expr: sigil_val };
                    Assembler::assemble_instruction(&instr, out);
                } else if *base == 0x2834 || *base == 0x7E2834 {
                    let instr = sigil::Instruction::WriteTemp { opcode: 0x19, addr: off_val, expr: sigil_val };
                    Assembler::assemble_instruction(&instr, out);
                } else {
                    return Err(format!("Nicht unterstützte Basisadresse: 0x{:06X}", base));
                }
            }
            EvsExpr::Flag { base, bit } => {
                let bit_index = self.eval_expr_const(bit)? as u16;
                let sigil_val = self.compile_expr(value)?;
                let instr = sigil::Instruction::SetFlag { base: *base, bit_index, val: sigil_val };
                Assembler::assemble_instruction(&instr, out);
            }
            EvsExpr::ArgBit(bit_index) => {
                let sigil_val = self.compile_expr(value)?;
                let instr = sigil::Instruction::SetScriptArgBit { bit_index: *bit_index, val: sigil_val };
                Assembler::assemble_instruction(&instr, out);
            }
            EvsExpr::Arg(arg) => {
                let sigil_val = self.compile_expr(value)?;
                let instr = sigil::Instruction::WriteScriptArg { opcode: 0x1E, arg: *arg, expr: sigil_val };
                Assembler::assemble_instruction(&instr, out);
            }
            _ => return Err(format!("Ungültiges Zuweisungsziel: {:?}", target)),
        }
        Ok(())
    }

    pub fn compile_expr(&self, expr: &EvsExpr) -> Result<sigil::Expr, String> {
        match expr {
            EvsExpr::Number(n) => {
                if *n < -65536 || *n > 65535 {
                    return Err(format!("Konstante {} liegt außerhalb des gültigen Bereichs (-65536..65535)", n));
                }
                Ok(sigil::Expr::const_val(*n as i32))
            }
            EvsExpr::Ident(id) => {
                if let Some(val) = self.symbols.get(id) {
                    if *val < -65536 || *val > 65535 {
                        return Err(format!("Symbol '{}' mit Wert {} liegt außerhalb des gültigen Bereichs (-65536..65535)", id, val));
                    }
                    Ok(sigil::Expr::const_val(*val as i32))
                } else {
                    Err(format!("Unbekanntes Symbol: '{}'", id))
                }
            }
            EvsExpr::Flag { base, bit } => {
                let bit_index = self.eval_expr_const(bit)? as u16;
                Ok(sigil::Expr::Flag { base: *base, bit_index })
            }
            EvsExpr::Memory { base, offset } => {
                let off_val = self.eval_expr_const(offset)? as u16;
                if *base == 0x2258 || *base == 0x7E2258 {
                    Ok(sigil::Expr::ram_word(off_val))
                } else {
                    Ok(sigil::Expr::temp_word(off_val))
                }
            }
            EvsExpr::Arg(a) => Ok(sigil::Expr::arg_word(*a)),
            EvsExpr::ArgBit(b) => Ok(sigil::Expr::ArgBit(*b)),
            EvsExpr::Rng => Ok(sigil::Expr::Rng),
            EvsExpr::RngRange(r) => {
                let sub = self.compile_expr(r)?;
                Ok(sigil::Expr::RngRange(Box::new(sub)))
            }
            EvsExpr::DialogResponse => Ok(sigil::Expr::DialogResponse(None)),
            EvsExpr::Unary { op, expr } => {
                if *op == soe_script::ast::UnaryOp::Neg {
                    if let Ok(val) = self.eval_expr_const(expr) {
                        let folded = -val;
                        if folded < -65536 || folded > 65535 {
                            return Err(format!("Konstante {} liegt außerhalb des gültigen Bereichs (-65536..65535)", folded));
                        }
                        return Ok(sigil::Expr::const_val(folded as i32));
                    }
                }
                let sub = self.compile_expr(expr)?;
                Ok(sigil::Expr::Unary { op: *op, expr: Box::new(sub) })
            }
            EvsExpr::Binary { op, left, right } => {
                let l = self.compile_expr(left)?;
                let r = self.compile_expr(right)?;
                Ok(sigil::Expr::Binary { op: *op, left: Box::new(l), right: Box::new(r) })
            }
            _ => Err(format!("Nicht unterstützter Ausdruck in Skript-Evaluierung: {:?}", expr)),
        }
    }

    fn eval_expr_const(&self, expr: &EvsExpr) -> Result<i64, String> {
        match expr {
            EvsExpr::Number(n) => Ok(*n),
            EvsExpr::Ident(id) => {
                if let Some(val) = self.symbols.get(id) {
                    Ok(*val)
                } else {
                    Err(format!("Unbekanntes konstantes Symbol: '{}'", id))
                }
            }
            EvsExpr::Unary { op: soe_script::ast::UnaryOp::Neg, expr } => {
                let v = self.eval_expr_const(expr)?;
                Ok(-v)
            }
            EvsExpr::Binary { op, left, right } => {
                let l = self.eval_expr_const(left)?;
                let r = self.eval_expr_const(right)?;
                match op {
                    soe_script::ast::BinaryOp::Add => Ok(l + r),
                    soe_script::ast::BinaryOp::Sub => Ok(l - r),
                    soe_script::ast::BinaryOp::Mul => Ok(l * r),
                    soe_script::ast::BinaryOp::Div => Ok(l / r),
                    soe_script::ast::BinaryOp::BitAnd => Ok(l & r),
                    soe_script::ast::BinaryOp::BitOr => Ok(l | r),
                    soe_script::ast::BinaryOp::BitXor => Ok(l ^ r),
                    soe_script::ast::BinaryOp::Shl => Ok(l << r),
                    soe_script::ast::BinaryOp::Shr => Ok(l >> r),
                    _ => Err("Nicht-arithmetischer Operator in konstanter Berechnung".to_string()),
                }
            }
            _ => Err(format!("Ausdruck ist nicht zur Compilezeit konstant: {:?}", expr)),
        }
    }
}
