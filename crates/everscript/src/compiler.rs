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
            EvsTopLevel::Function(fun) => {
                if let Some(addr) = fun.address {
                    self.symbols.insert(fun.name.clone(), addr as i64);
                }
            }
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
        let mut label_offsets = HashMap::new();
        let mut gotos = Vec::new();

        self.compile_statements_inner(statements, &mut out, &mut label_offsets, &mut gotos)?;

        // Phase 2: Auflösen aller gotos zu Labels
        for (goto_pos, label_name) in gotos {
            let target_pos = label_offsets.get(&label_name).ok_or_else(|| {
                format!("Unbekanntes Sprungziel / Label: '{}'", label_name)
            })?;
            let rel_offset = (*target_pos as i32) - (goto_pos as i32 + 3);
            if rel_offset < i16::MIN as i32 || rel_offset > i16::MAX as i32 {
                return Err(format!("Sprungversatz zu Label '{}' ({}) übersteigt 16-Bit Bereich", label_name, rel_offset));
            }
            let bytes = (rel_offset as i16).to_le_bytes();
            out[goto_pos + 1] = bytes[0];
            out[goto_pos + 2] = bytes[1];
        }

        Ok(out)
    }

    fn compile_statements_inner(
        &self,
        statements: &[EvsStmt],
        out: &mut Vec<u8>,
        label_offsets: &mut HashMap<String, usize>,
        gotos: &mut Vec<(usize, String)>,
    ) -> Result<(), String> {
        for stmt in statements {
            match stmt {
                EvsStmt::Label(name) => {
                    if label_offsets.contains_key(name) {
                        return Err(format!("Doppelt definiertes Label: '{}'", name));
                    }
                    label_offsets.insert(name.clone(), out.len());
                }
                EvsStmt::Goto(name) => {
                    gotos.push((out.len(), name.clone()));
                    Assembler::assemble_instruction(&sigil::Instruction::Skip(0), out);
                }
                EvsStmt::End => {
                    out.push(0x00);
                }
                EvsStmt::Return => {
                    out.push(0x00);
                }
                EvsStmt::Call(expr) => {
                    let addr = self.eval_expr_const(expr)? as u32;
                    let instr = sigil::Instruction::Call(addr);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::Text(expr) => {
                    let id = self.eval_expr_const(expr)? as u16;
                    let instr = sigil::Instruction::ShowText(id);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::TextEnd(expr) => {
                    let id = self.eval_expr_const(expr)? as u16;
                    let instr = sigil::Instruction::ShowTextEnd(id);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::TextHide => {
                    out.push(0x55);
                }
                EvsStmt::GiveJewels(expr) => {
                    let amount = self.eval_expr_const(expr)? as u32;
                    let instr = sigil::Instruction::GiveJewels(amount);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::GiveMoney { currency, amount } => {
                    let cur = self.compile_expr(currency)?;
                    if let Ok(amt) = self.eval_expr_const(amount) {
                        let instr = sigil::Instruction::GiveMoney { currency: cur, amount: amt as u32 };
                        Assembler::assemble_instruction(&instr, out);
                    } else {
                        let amt_expr = self.compile_expr(amount)?;
                        let instr = sigil::Instruction::GiveMoneyExpr { currency: cur, amount: amt_expr };
                        Assembler::assemble_instruction(&instr, out);
                    }
                }
                EvsStmt::TakeMoney { currency, amount } => {
                    let cur = self.compile_expr(currency)?;
                    if let Ok(amt) = self.eval_expr_const(amount) {
                        let instr = sigil::Instruction::TakeMoney { currency: cur, amount: amt as u32 };
                        Assembler::assemble_instruction(&instr, out);
                    } else {
                        let amt_expr = self.compile_expr(amount)?;
                        let instr = sigil::Instruction::TakeMoneyExpr { currency: cur, amount: amt_expr };
                        Assembler::assemble_instruction(&instr, out);
                    }
                }
                EvsStmt::Sleep(expr) => {
                    let frames = self.eval_expr_const(expr)? as u32;
                    if frames <= 255 {
                        let instr = sigil::Instruction::Sleep(frames as u8);
                        Assembler::assemble_instruction(&instr, out);
                    } else if frames <= 65535 {
                        let instr = sigil::Instruction::SleepWord(frames as u16);
                        Assembler::assemble_instruction(&instr, out);
                    } else {
                        return Err(format!("Sleep-Dauer {} übersteigt 65535 Frames", frames));
                    }
                }
                EvsStmt::LockPlayer(expr) => {
                    let arg = self.eval_expr_const(expr)? as u8;
                    let instr = sigil::Instruction::LockPlayer(arg);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::UnlockPlayer(expr) => {
                    let arg = self.eval_expr_const(expr)? as u8;
                    let instr = sigil::Instruction::UnlockPlayer(arg);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::Skip(expr) => {
                    let off = self.eval_expr_const(expr)? as i16;
                    let instr = sigil::Instruction::Skip(off);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::FadeIn => {
                    Assembler::assemble_instruction(&sigil::Instruction::FadeIn, out);
                }
                EvsStmt::FadeOut => {
                    Assembler::assemble_instruction(&sigil::Instruction::FadeOut, out);
                }
                EvsStmt::ChangeMap { x, y, map } => {
                    let x_val = self.eval_expr_const(x)? as u8;
                    let y_val = self.eval_expr_const(y)? as u8;
                    let map_val = self.eval_expr_const(map)? as u16;
                    let instr = sigil::Instruction::ChangeMap { x: x_val, y: y_val, map: map_val };
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::CameraFollow { x, y } => {
                    let x_val = self.eval_expr_const(x)? as u8;
                    let y_val = self.eval_expr_const(y)? as u8;
                    let instr = sigil::Instruction::CameraFollow { x: x_val, y: y_val };
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::SetCameraPos { x, y } => {
                    let x_val = self.eval_expr_const(x)? as u8;
                    let y_val = self.eval_expr_const(y)? as u8;
                    let instr = sigil::Instruction::SetCameraPos { x: x_val, y: y_val };
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::WaitFrame(expr) => {
                    let sigil_expr = self.compile_expr(expr)?;
                    let instr = sigil::Instruction::WaitFrame(sigil_expr);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::WaitAnim(expr) => {
                    let sigil_expr = self.compile_expr(expr)?;
                    let instr = sigil::Instruction::WaitAnim(sigil_expr);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::WaitUntil(expr) => {
                    let sigil_expr = self.compile_expr(expr)?;
                    let instr = sigil::Instruction::WaitUntil(sigil_expr);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::DamageEntity { target, amount } => {
                    let target_expr = self.compile_expr(target)?;
                    let amount_expr = self.compile_expr(amount)?;
                    let instr = sigil::Instruction::DamageEntity { target: target_expr, amount: amount_expr };
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::HealEntity { target, amount } => {
                    let target_expr = self.compile_expr(target)?;
                    let amount_expr = self.compile_expr(amount)?;
                    let instr = sigil::Instruction::HealEntity { target: target_expr, amount: amount_expr };
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::SetEntityHp { target, hp } => {
                    let target_expr = self.compile_expr(target)?;
                    let hp_expr = self.compile_expr(hp)?;
                    let instr = sigil::Instruction::SetEntityHp { target: target_expr, hp: hp_expr };
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::PlaySound { channel, id } => {
                    let ch = match channel {
                        Some(c) => self.eval_expr_const(c)? as u8,
                        None => 0,
                    };
                    let sound_id = self.eval_expr_const(id)? as u8;
                    let instr = sigil::Instruction::PlaySound { channel: ch, id: sound_id };
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::PlayMusic(expr) => {
                    let music_id = self.eval_expr_const(expr)? as u8;
                    let instr = sigil::Instruction::PlayMusic(music_id);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::SwitchCharacter(expr) => {
                    let sigil_expr = self.compile_expr(expr)?;
                    let instr = sigil::Instruction::SwitchCharacter(sigil_expr);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::AttachCamera(expr) => {
                    let sigil_expr = self.compile_expr(expr)?;
                    let instr = sigil::Instruction::AttachCamera(sigil_expr);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::Raw { opcode, payload } => {
                    let instr = sigil::Instruction::Raw { opcode: *opcode, payload: payload.clone() };
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::Assign { target, value } => {
                    self.compile_assignment(target, value, out)?;
                }
                EvsStmt::If { cond, then_branch, else_branch } => {
                    // Check for single skip optimization: if (...) skip(+n);
                    if then_branch.len() == 1 && else_branch.is_none() {
                        if let EvsStmt::Skip(off_expr) = &then_branch[0] {
                            let target_offset = self.eval_expr_const(off_expr)? as i16;
                            // Check for if (money(cur) >= amt) skip(...)
                            if let EvsExpr::Binary { op: sigil::BinaryOp::Ge, left, right } = cond {
                                if let EvsExpr::Money(cur) = **left {
                                    if let Ok(amt) = self.eval_expr_const(right) {
                                        let instr = sigil::Instruction::IfMoneyGe {
                                            currency: sigil::Expr::const_val(cur as i32),
                                            amount: amt as u32,
                                            target_offset,
                                        };
                                        Assembler::assemble_instruction(&instr, out);
                                        continue;
                                    }
                                }
                            }
                            // Check for if (money(cur) < amt) skip(...)
                            if let EvsExpr::Binary { op: sigil::BinaryOp::Lt, left, right } = cond {
                                if let EvsExpr::Money(cur) = **left {
                                    if let Ok(amt) = self.eval_expr_const(right) {
                                        let instr = sigil::Instruction::IfMoneyLt {
                                            currency: sigil::Expr::const_val(cur as i32),
                                            amount: amt as u32,
                                            target_offset,
                                        };
                                        Assembler::assemble_instruction(&instr, out);
                                        continue;
                                    }
                                }
                            }
                            if let EvsExpr::Unary { op: sigil::UnaryOp::Not, expr: inner } = cond {
                                let sigil_cond = self.compile_expr(inner)?;
                                Assembler::assemble_instruction(&sigil::Instruction::IfNot { cond: sigil_cond, target_offset }, out);
                                continue;
                            } else {
                                let sigil_cond = self.compile_expr(cond)?;
                                Assembler::assemble_instruction(&sigil::Instruction::If { cond: sigil_cond, target_offset }, out);
                                continue;
                            }
                        }
                    }

                    let sigil_cond = self.compile_expr(cond)?;
                    Assembler::assemble_instruction(&sigil::Instruction::IfNot { cond: sigil_cond, target_offset: 0 }, out);
                    let then_start = out.len();

                    self.compile_statements_inner(then_branch, out, label_offsets, gotos)?;

                    if let Some(else_branch) = else_branch {
                        let skip_pos = out.len();
                        Assembler::assemble_instruction(&sigil::Instruction::Skip(0), out);
                        let then_end = out.len();

                        let if_offset = (then_end - then_start) as i16;
                        let if_bytes = if_offset.to_le_bytes();
                        out[then_start - 2] = if_bytes[0];
                        out[then_start - 1] = if_bytes[1];

                        let else_start = out.len();
                        self.compile_statements_inner(else_branch, out, label_offsets, gotos)?;
                        let else_end = out.len();

                        let skip_offset = (else_end - else_start) as i16;
                        let skip_bytes = skip_offset.to_le_bytes();
                        out[skip_pos + 1] = skip_bytes[0];
                        out[skip_pos + 2] = skip_bytes[1];
                    } else {
                        let then_end = out.len();
                        let if_offset = (then_end - then_start) as i16;
                        let if_bytes = if_offset.to_le_bytes();
                        out[then_start - 2] = if_bytes[0];
                        out[then_start - 1] = if_bytes[1];
                    }
                }
                EvsStmt::While { cond, body } => {
                    let loop_start = out.len();
                    let sigil_cond = self.compile_expr(cond)?;
                    Assembler::assemble_instruction(&sigil::Instruction::IfNot { cond: sigil_cond, target_offset: 0 }, out);
                    let body_start = out.len();

                    self.compile_statements_inner(body, out, label_offsets, gotos)?;

                    let skip_pos = out.len();
                    Assembler::assemble_instruction(&sigil::Instruction::Skip(0), out);
                    let loop_end = out.len();

                    let if_offset = (loop_end - body_start) as i16;
                    let if_bytes = if_offset.to_le_bytes();
                    out[body_start - 2] = if_bytes[0];
                    out[body_start - 1] = if_bytes[1];

                    let back_offset = (loop_start as i32) - (skip_pos as i32 + 3);
                    let skip_bytes = (back_offset as i16).to_le_bytes();
                    out[skip_pos + 1] = skip_bytes[0];
                    out[skip_pos + 2] = skip_bytes[1];
                }
            }
        }

        Ok(())
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
            EvsExpr::Money(m) => Ok(sigil::Expr::const_val(*m as i32)),
            EvsExpr::Rng => Ok(sigil::Expr::Rng),
            EvsExpr::RngRange(r) => {
                let sub = self.compile_expr(r)?;
                Ok(sigil::Expr::RngRange(Box::new(sub)))
            }
            EvsExpr::DialogResponse(param) => {
                let sigil_param = match param {
                    Some(p) => Some(Box::new(self.compile_expr(p)?)),
                    None => None,
                };
                Ok(sigil::Expr::DialogResponse(sigil_param))
            }
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
            EvsExpr::Call { name, args } if args.is_empty() => {
                if let Some(val) = self.symbols.get(name) {
                    Ok(*val)
                } else {
                    Err(format!("Unbekanntes Funktionssymbol: '{}'", name))
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
