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
                    let addr = self.eval_expr_const(expr)?;
                    if !(0..=0xFFFFFF).contains(&addr) {
                        return Err(format!("call: Adresse {} übersteigt 24-Bit-Bereich (0..0xFFFFFF)", addr));
                    }
                    let instr = sigil::Instruction::Call(addr as u32);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::Fork(expr) => {
                    let addr = self.eval_expr_const(expr)?;
                    if !(0..=0xFFFFFF).contains(&addr) {
                        return Err(format!("fork: Adresse {} übersteigt 24-Bit-Bereich (0..0xFFFFFF)", addr));
                    }
                    let instr = sigil::Instruction::Fork(addr as u32);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::CallRel(expr) => {
                    let off = self.eval_expr_const(expr)?;
                    if off < i16::MIN as i64 || off > i16::MAX as i64 {
                        return Err(format!("call_rel: Versatz {} übersteigt 16-Bit-Bereich (-32768..32767)", off));
                    }
                    let instr = sigil::Instruction::CallRelative(off as i16);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::Text(expr) => {
                    let id = self.eval_expr_const(expr)?;
                    if !(0..=65535).contains(&id) {
                        return Err(format!("text: Text-ID {} übersteigt 16-Bit-Bereich (0..65535)", id));
                    }
                    let instr = sigil::Instruction::ShowText(id as u16);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::TextEnd(expr) => {
                    let id = self.eval_expr_const(expr)?;
                    if !(0..=65535).contains(&id) {
                        return Err(format!("text_end: Text-ID {} übersteigt 16-Bit-Bereich (0..65535)", id));
                    }
                    let instr = sigil::Instruction::ShowTextEnd(id as u16);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::ShowMessage(expr) => {
                    let id = self.eval_expr_const(expr)?;
                    if !(0..=65535).contains(&id) {
                        return Err(format!("show_message: Text-ID {} übersteigt 16-Bit-Bereich (0..65535)", id));
                    }
                    let instr = sigil::Instruction::ShowMessage(id as u16);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::TextHide => {
                    out.push(0x55);
                }
                EvsStmt::GiveJewels(expr) => {
                    let amount = self.eval_expr_const(expr)?;
                    if !(0..=0xFFFFFF).contains(&amount) {
                        return Err(format!("give_jewels: Betrag {} übersteigt 24-Bit-Bereich (0..0xFFFFFF)", amount));
                    }
                    let instr = sigil::Instruction::GiveJewels(amount as u32);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::GiveMoney { currency, amount } => {
                    let cur = self.compile_expr(currency)?;
                    if let Ok(amt) = self.eval_expr_const(amount) {
                        if !(0..=0xFFFFFF).contains(&amt) {
                            return Err(format!("give_money: Betrag {} übersteigt 24-Bit-Bereich (0..0xFFFFFF)", amt));
                        }
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
                        if !(0..=0xFFFFFF).contains(&amt) {
                            return Err(format!("take_money: Betrag {} übersteigt 24-Bit-Bereich (0..0xFFFFFF)", amt));
                        }
                        let instr = sigil::Instruction::TakeMoney { currency: cur, amount: amt as u32 };
                        Assembler::assemble_instruction(&instr, out);
                    } else {
                        let amt_expr = self.compile_expr(amount)?;
                        let instr = sigil::Instruction::TakeMoneyExpr { currency: cur, amount: amt_expr };
                        Assembler::assemble_instruction(&instr, out);
                    }
                }
                EvsStmt::Sleep(expr) => {
                    let frames = self.eval_expr_const(expr)?;
                    if !(0..=65535).contains(&frames) {
                        return Err(format!("sleep: Dauer {} liegt außerhalb des Bereichs (0..65535)", frames));
                    }
                    if frames <= 255 {
                        let instr = sigil::Instruction::Sleep(frames as u8);
                        Assembler::assemble_instruction(&instr, out);
                    } else {
                        let instr = sigil::Instruction::SleepWord(frames as u16);
                        Assembler::assemble_instruction(&instr, out);
                    }
                }
                EvsStmt::LockPlayer(expr) => {
                    let arg = self.eval_expr_const(expr)?;
                    if !(0..=255).contains(&arg) {
                        return Err(format!("lock_player: Argument {} übersteigt 8-Bit-Bereich (0..255)", arg));
                    }
                    let instr = sigil::Instruction::LockPlayer(arg as u8);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::UnlockPlayer(expr) => {
                    let arg = self.eval_expr_const(expr)?;
                    if !(0..=255).contains(&arg) {
                        return Err(format!("unlock_player: Argument {} übersteigt 8-Bit-Bereich (0..255)", arg));
                    }
                    let instr = sigil::Instruction::UnlockPlayer(arg as u8);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::Skip(expr) => {
                    let off = self.eval_expr_const(expr)?;
                    if off < i16::MIN as i64 || off > i16::MAX as i64 {
                        return Err(format!("skip: Versatz {} übersteigt 16-Bit-Bereich (-32768..32767)", off));
                    }
                    let instr = sigil::Instruction::Skip(off as i16);
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::FadeIn => {
                    Assembler::assemble_instruction(&sigil::Instruction::FadeIn, out);
                }
                EvsStmt::FadeOut => {
                    Assembler::assemble_instruction(&sigil::Instruction::FadeOut, out);
                }
                EvsStmt::ChangeMap { x, y, map } => {
                    let x_val = self.eval_expr_const(x)?;
                    let y_val = self.eval_expr_const(y)?;
                    let map_val = self.eval_expr_const(map)?;
                    if !(0..=255).contains(&x_val) || !(0..=255).contains(&y_val) {
                        return Err(format!("change_map: Koordinaten ({}, {}) übersteigen 8-Bit-Bereich (0..255)", x_val, y_val));
                    }
                    if !(0..=65535).contains(&map_val) {
                        return Err(format!("change_map: Map-ID {} übersteigt 16-Bit-Bereich (0..65535)", map_val));
                    }
                    let instr = sigil::Instruction::ChangeMap { x: x_val as u8, y: y_val as u8, map: map_val as u16 };
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::CameraFollow { x, y } => {
                    let x_val = self.eval_expr_const(x)?;
                    let y_val = self.eval_expr_const(y)?;
                    if !(0..=255).contains(&x_val) || !(0..=255).contains(&y_val) {
                        return Err(format!("camera_follow: Koordinaten ({}, {}) übersteigen 8-Bit-Bereich (0..255)", x_val, y_val));
                    }
                    let instr = sigil::Instruction::CameraFollow { x: x_val as u8, y: y_val as u8 };
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::SetCameraPos { x, y } => {
                    let x_val = self.eval_expr_const(x)?;
                    let y_val = self.eval_expr_const(y)?;
                    if !(0..=255).contains(&x_val) || !(0..=255).contains(&y_val) {
                        return Err(format!("set_camera_pos: Koordinaten ({}, {}) übersteigen 8-Bit-Bereich (0..255)", x_val, y_val));
                    }
                    let instr = sigil::Instruction::SetCameraPos { x: x_val as u8, y: y_val as u8 };
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
                        Some(c) => {
                            let v = self.eval_expr_const(c)?;
                            if !(0..=255).contains(&v) {
                                return Err(format!("play_sound: Kanal {} übersteigt 8-Bit-Bereich (0..255)", v));
                            }
                            v as u8
                        }
                        None => 0,
                    };
                    let sound_id = self.eval_expr_const(id)?;
                    if !(0..=255).contains(&sound_id) {
                        return Err(format!("play_sound: Sound-ID {} übersteigt 8-Bit-Bereich (0..255)", sound_id));
                    }
                    let instr = sigil::Instruction::PlaySound { channel: ch, id: sound_id as u8 };
                    Assembler::assemble_instruction(&instr, out);
                }
                EvsStmt::PlayMusic(expr) => {
                    let music_id = self.eval_expr_const(expr)?;
                    if !(0..=255).contains(&music_id) {
                        return Err(format!("play_music: Musik-ID {} übersteigt 8-Bit-Bereich (0..255)", music_id));
                    }
                    let instr = sigil::Instruction::PlayMusic(music_id as u8);
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
                EvsStmt::Command { name, args } => {
                    self.compile_command(name, args, out)?;
                }
                EvsStmt::Instruction(instr) => {
                    Assembler::assemble_instruction(instr, out);
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
                            // Check for if (left == right) skip(...) -> IfEqual (0x8E)
                            if let EvsExpr::Binary { op: sigil::BinaryOp::Eq, left, right } = cond {
                                let sigil_l = self.compile_expr(left)?;
                                let sigil_r = self.compile_expr(right)?;
                                let instr = sigil::Instruction::IfEqual {
                                    left: sigil_l,
                                    right: sigil_r,
                                    target_offset,
                                };
                                Assembler::assemble_instruction(&instr, out);
                                continue;
                            }
                            // Check for if (left != right) skip(...) -> IfNotEqual (0x8F)
                            if let EvsExpr::Binary { op: sigil::BinaryOp::Ne, left, right } = cond {
                                let sigil_l = self.compile_expr(left)?;
                                let sigil_r = self.compile_expr(right)?;
                                let instr = sigil::Instruction::IfNotEqual {
                                    left: sigil_l,
                                    right: sigil_r,
                                    target_offset,
                                };
                                Assembler::assemble_instruction(&instr, out);
                                continue;
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
            EvsExpr::MemoryByte { base, offset } => {
                let off_val = self.eval_expr_const(offset)? as u16;
                let sigil_val = self.compile_expr(value)?;
                if *base == 0x2258 || *base == 0x7E2258 {
                    let instr = sigil::Instruction::WriteRam { opcode: 0x1C, addr: off_val, expr: sigil_val };
                    Assembler::assemble_instruction(&instr, out);
                } else {
                    let instr = sigil::Instruction::WriteTemp { opcode: 0x1D, addr: off_val, expr: sigil_val };
                    Assembler::assemble_instruction(&instr, out);
                }
            }
            EvsExpr::MemoryByteSigned { base, offset } => {
                let off_val = self.eval_expr_const(offset)? as u16;
                let sigil_val = self.compile_expr(value)?;
                if *base == 0x2258 || *base == 0x7E2258 {
                    let instr = sigil::Instruction::WriteRam { opcode: 0x1C, addr: off_val, expr: sigil_val };
                    Assembler::assemble_instruction(&instr, out);
                } else {
                    let instr = sigil::Instruction::WriteTemp { opcode: 0x1D, addr: off_val, expr: sigil_val };
                    Assembler::assemble_instruction(&instr, out);
                }
            }
            EvsExpr::MemorySigned { base, offset } => {
                let off_val = self.eval_expr_const(offset)? as u16;
                let sigil_val = self.compile_expr(value)?;
                if *base == 0x2258 || *base == 0x7E2258 {
                    let instr = sigil::Instruction::WriteRam { opcode: 0x18, addr: off_val, expr: sigil_val };
                    Assembler::assemble_instruction(&instr, out);
                } else {
                    let instr = sigil::Instruction::WriteTemp { opcode: 0x19, addr: off_val, expr: sigil_val };
                    Assembler::assemble_instruction(&instr, out);
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
            EvsExpr::Arg(arg) | EvsExpr::ArgWordSigned(arg) => {
                let sigil_val = self.compile_expr(value)?;
                let instr = sigil::Instruction::WriteScriptArg { opcode: 0x1A, arg: *arg, expr: sigil_val };
                Assembler::assemble_instruction(&instr, out);
            }
            EvsExpr::ArgByte(arg) | EvsExpr::ArgByteSigned(arg) => {
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
                match id.as_str() {
                    "boy" | "Boy" | "BOY" => return Ok(sigil::Expr::Entity(sigil::Entity::Boy)),
                    "dog" | "Dog" | "DOG" => return Ok(sigil::Expr::Entity(sigil::Entity::Dog)),
                    "controlled" | "Controlled" | "CONTROLLED" => return Ok(sigil::Expr::Entity(sigil::Entity::Controlled)),
                    "non_controlled" | "NonControlled" | "NON_CONTROLLED" => return Ok(sigil::Expr::Entity(sigil::Entity::NonControlled)),
                    "last_entity" | "LastEntity" => return Ok(sigil::Expr::Entity(sigil::Entity::LastEntity)),
                    "attached" | "Attached" => return Ok(sigil::Expr::Entity(sigil::Entity::Attached)),
                    _ => {}
                }
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
            EvsExpr::MemoryByte { base, offset } => {
                let off_val = self.eval_expr_const(offset)? as u16;
                if *base == 0x2258 || *base == 0x7E2258 {
                    Ok(sigil::Expr::ram_byte(off_val))
                } else {
                    Ok(sigil::Expr::temp_byte(off_val))
                }
            }
            EvsExpr::MemoryByteSigned { base, offset } => {
                let off_val = self.eval_expr_const(offset)? as u16;
                if *base == 0x2258 || *base == 0x7E2258 {
                    Ok(sigil::Expr::RamByteSigned(off_val))
                } else {
                    Ok(sigil::Expr::TempByteSigned(off_val))
                }
            }
            EvsExpr::MemorySigned { base, offset } => {
                let off_val = self.eval_expr_const(offset)? as u16;
                if *base == 0x2258 || *base == 0x7E2258 {
                    Ok(sigil::Expr::RamWordSigned(off_val))
                } else {
                    Ok(sigil::Expr::TempWordSigned(off_val))
                }
            }
            EvsExpr::Arg(a) => Ok(sigil::Expr::arg_word(*a)),
            EvsExpr::ArgByte(a) => Ok(sigil::Expr::arg_byte(*a)),
            EvsExpr::ArgByteSigned(a) => Ok(sigil::Expr::ArgByteSigned(*a)),
            EvsExpr::ArgWordSigned(a) => Ok(sigil::Expr::ArgWordSigned(*a)),
            EvsExpr::ArgBit(b) => Ok(sigil::Expr::ArgBit(*b)),
            EvsExpr::Money(m) => Ok(sigil::Expr::const_val(*m as i32)),
            EvsExpr::Entity(ent) => Ok(sigil::Expr::Entity(*ent)),
            EvsExpr::TriggerActor => Ok(sigil::Expr::TriggerActor),
            EvsExpr::TaskWord0D => Ok(sigil::Expr::TaskWord0D),
            EvsExpr::TaskWord09 => Ok(sigil::Expr::TaskWord09),
            EvsExpr::IsPartnerControlled => Ok(sigil::Expr::IsPartnerControlled),
            EvsExpr::FrameTimerLo => Ok(sigil::Expr::FrameTimerLo),
            EvsExpr::FrameTimerHi => Ok(sigil::Expr::FrameTimerHi),
            EvsExpr::DerefWord(e) => {
                let sub = self.compile_expr(e)?;
                Ok(sigil::Expr::DerefWord(Box::new(sub)))
            }
            EvsExpr::DerefByte(e) => {
                let sub = self.compile_expr(e)?;
                Ok(sigil::Expr::DerefByte(Box::new(sub)))
            }
            EvsExpr::QueryStatusA(e) => {
                let sub = self.compile_expr(e)?;
                Ok(sigil::Expr::QueryStatusA(Box::new(sub)))
            }
            EvsExpr::QueryStatusB(e) => {
                let sub = self.compile_expr(e)?;
                Ok(sigil::Expr::QueryStatusB(Box::new(sub)))
            }
            EvsExpr::EntityStatDiff(e) => {
                let sub = self.compile_expr(e)?;
                Ok(sigil::Expr::EntityStatDiff(Box::new(sub)))
            }
            EvsExpr::Token(t) => Ok(sigil::Expr::RawToken(*t)),
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
            EvsExpr::Call { name, args } => {
                match name.as_str() {
                    "is_partner_controlled" if args.is_empty() => Ok(sigil::Expr::IsPartnerControlled),
                    "trigger_actor" if args.is_empty() => Ok(sigil::Expr::TriggerActor),
                    "task_word_0d" if args.is_empty() => Ok(sigil::Expr::TaskWord0D),
                    "task_word_09" if args.is_empty() => Ok(sigil::Expr::TaskWord09),
                    "frame_timer_lo" if args.is_empty() => Ok(sigil::Expr::FrameTimerLo),
                    "frame_timer_hi" if args.is_empty() => Ok(sigil::Expr::FrameTimerHi),
                    "deref_word" if args.len() == 1 => {
                        let sub = self.compile_expr(&args[0])?;
                        Ok(sigil::Expr::DerefWord(Box::new(sub)))
                    }
                    "deref_byte" if args.len() == 1 => {
                        let sub = self.compile_expr(&args[0])?;
                        Ok(sigil::Expr::DerefByte(Box::new(sub)))
                    }
                    "query_status_a" if args.len() == 1 => {
                        let sub = self.compile_expr(&args[0])?;
                        Ok(sigil::Expr::QueryStatusA(Box::new(sub)))
                    }
                    "query_status_b" if args.len() == 1 => {
                        let sub = self.compile_expr(&args[0])?;
                        Ok(sigil::Expr::QueryStatusB(Box::new(sub)))
                    }
                    "entity_stat_diff" if args.len() == 1 => {
                        let sub = self.compile_expr(&args[0])?;
                        Ok(sigil::Expr::EntityStatDiff(Box::new(sub)))
                    }
                    "TOKEN" | "token" if args.len() == 1 => {
                        let tok = self.eval_expr_const(&args[0])? as u8;
                        Ok(sigil::Expr::RawToken(tok))
                    }
                    "Id" | "id" if args.len() == 1 => {
                        let id_val = self.eval_expr_const(&args[0])? as u8;
                        Ok(sigil::Expr::Entity(sigil::Entity::Id(id_val)))
                    }
                    "rnd" if args.is_empty() => Ok(sigil::Expr::Rng),
                    "rnd_range" if args.len() == 1 => {
                        let sub = self.compile_expr(&args[0])?;
                        Ok(sigil::Expr::RngRange(Box::new(sub)))
                    }
                    "dialog_response" => {
                        let p = if args.is_empty() {
                            None
                        } else {
                            Some(Box::new(self.compile_expr(&args[0])?))
                        };
                        Ok(sigil::Expr::DialogResponse(p))
                    }
                    "money" if args.len() == 1 => {
                        let v = self.eval_expr_const(&args[0])? as i32;
                        Ok(sigil::Expr::const_val(v))
                    }
                    _ => {
                        if let Some(val) = self.symbols.get(name) {
                            Ok(sigil::Expr::const_val(*val as i32))
                        } else {
                            Err(format!("Unbekannter Ausdruck/Funktion: '{}'", name))
                        }
                    }
                }
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

    fn compile_command(&self, name: &str, args: &[EvsExpr], out: &mut Vec<u8>) -> Result<(), String> {
        match name {
            // Flow & Script Control
            "end" if args.is_empty() => {
                out.push(0x00);
            }
            "return" if args.is_empty() => {
                out.push(0x00);
            }
            "skip" if args.len() == 1 => {
                let off = self.eval_expr_const(&args[0])?;
                let instr = sigil::Instruction::Skip(off as i16);
                Assembler::assemble_instruction(&instr, out);
            }
            "call" if args.len() == 1 => {
                let addr = self.eval_expr_const(&args[0])?;
                let instr = sigil::Instruction::Call(addr as u32);
                Assembler::assemble_instruction(&instr, out);
            }
            "fork" if args.len() == 1 => {
                let addr = self.eval_expr_const(&args[0])?;
                let instr = sigil::Instruction::Fork(addr as u32);
                Assembler::assemble_instruction(&instr, out);
            }
            "call_rel" if args.len() == 1 => {
                let off = self.eval_expr_const(&args[0])?;
                let instr = sigil::Instruction::CallRelative(off as i16);
                Assembler::assemble_instruction(&instr, out);
            }
            "call_table_byte" if args.len() == 1 => {
                let idx = self.eval_expr_const(&args[0])? as u8;
                let instr = sigil::Instruction::CallTableByte(idx);
                Assembler::assemble_instruction(&instr, out);
            }
            "call_table_word" if args.len() == 1 => {
                let idx = self.eval_expr_const(&args[0])? as u16;
                let instr = sigil::Instruction::CallTableWord(idx);
                Assembler::assemble_instruction(&instr, out);
            }
            "call_params" if args.len() == 2 => {
                let addr = self.eval_expr_const(&args[0])? as u32;
                let params = self.compile_expr_list(&args[1])?;
                let instr = sigil::Instruction::CallParams { args: params, addr };
                Assembler::assemble_instruction(&instr, out);
            }
            "call_table_byte_params" if args.len() == 2 => {
                let idx = self.eval_expr_const(&args[0])? as u8;
                let params = self.compile_expr_list(&args[1])?;
                let instr = sigil::Instruction::CallTableByteParams { args: params, idx };
                Assembler::assemble_instruction(&instr, out);
            }
            "call_table_word_params" if args.len() == 2 => {
                let idx = self.eval_expr_const(&args[0])? as u16;
                let params = self.compile_expr_list(&args[1])?;
                let instr = sigil::Instruction::CallTableWordParams { args: params, idx };
                Assembler::assemble_instruction(&instr, out);
            }
            "call_rel_byte_params" if args.len() == 2 => {
                let off = self.eval_expr_const(&args[0])? as i8;
                let params = self.compile_expr_list(&args[1])?;
                let instr = sigil::Instruction::CallRelativeByteParams { args: params, offset: off };
                Assembler::assemble_instruction(&instr, out);
            }
            "call_rel_word_params" if args.len() == 2 => {
                let off = self.eval_expr_const(&args[0])? as i16;
                let params = self.compile_expr_list(&args[1])?;
                let instr = sigil::Instruction::CallRelativeWordParams { args: params, offset: off };
                Assembler::assemble_instruction(&instr, out);
            }
            "fork_params" if args.len() == 2 => {
                let addr = self.eval_expr_const(&args[0])? as u32;
                let params = self.compile_expr_list(&args[1])?;
                let instr = sigil::Instruction::ForkParams { args: params, addr };
                Assembler::assemble_instruction(&instr, out);
            }
            "script_cmd_4e" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::ScriptCmd4E(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "script_cmd_7e" if args.len() == 4 => {
                let a1 = self.compile_expr(&args[0])?;
                let a2 = self.compile_expr(&args[1])?;
                let a3 = self.compile_expr(&args[2])?;
                let a4 = self.compile_expr(&args[3])?;
                let instr = sigil::Instruction::ScriptCmd7E { arg1: a1, arg2: a2, arg3: a3, arg4: a4 };
                Assembler::assemble_instruction(&instr, out);
            }
            "attach_script" if args.len() == 2 => {
                let target = self.compile_expr(&args[0])?;
                let script_id = self.eval_expr_const(&args[1])? as u16;
                let instr = sigil::Instruction::AttachScript { target, script_id };
                Assembler::assemble_instruction(&instr, out);
            }
            "reset_game" if args.is_empty() => {
                let instr = sigil::Instruction::ResetGame;
                Assembler::assemble_instruction(&instr, out);
            }
            "nop" if args.is_empty() => {
                let instr = sigil::Instruction::Nop;
                Assembler::assemble_instruction(&instr, out);
            }
            "nop_skip_byte" if args.len() == 1 => {
                let b = self.eval_expr_const(&args[0])? as u8;
                let instr = sigil::Instruction::NopSkipByte(b);
                Assembler::assemble_instruction(&instr, out);
            }
            "wait_path_end" if args.is_empty() => {
                let instr = sigil::Instruction::WaitPathEnd;
                Assembler::assemble_instruction(&instr, out);
            }
            "disable_interrupts" if args.is_empty() => {
                let instr = sigil::Instruction::DisableInterrupts;
                Assembler::assemble_instruction(&instr, out);
            }
            "enable_interrupts" if args.is_empty() => {
                let instr = sigil::Instruction::EnableInterrupts;
                Assembler::assemble_instruction(&instr, out);
            }

            // Player & Timing
            "sleep" | "sleep_aligned" if args.len() == 1 => {
                let frames = self.eval_expr_const(&args[0])?;
                if frames <= 255 && name == "sleep" {
                    let instr = sigil::Instruction::Sleep(frames as u8);
                    Assembler::assemble_instruction(&instr, out);
                } else {
                    let instr = sigil::Instruction::SleepWord(frames as u16);
                    Assembler::assemble_instruction(&instr, out);
                }
            }
            "lock_player" => {
                let arg = if args.is_empty() { 0 } else { self.eval_expr_const(&args[0])? as u8 };
                let instr = sigil::Instruction::LockPlayer(arg);
                Assembler::assemble_instruction(&instr, out);
            }
            "unlock_player" => {
                let arg = if args.is_empty() { 0 } else { self.eval_expr_const(&args[0])? as u8 };
                let instr = sigil::Instruction::UnlockPlayer(arg);
                Assembler::assemble_instruction(&instr, out);
            }
            "wait_frame" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::WaitFrame(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "wait_anim" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::WaitAnim(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "wait_until" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::WaitUntil(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "switch_character" | "select_entity" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::SwitchCharacter(e);
                Assembler::assemble_instruction(&instr, out);
            }

            // Text & Dialog & Windows
            "show_text" | "text" if args.len() == 1 => {
                let id = self.eval_expr_const(&args[0])? as u16;
                let instr = sigil::Instruction::ShowText(id);
                Assembler::assemble_instruction(&instr, out);
            }
            "show_text_end" | "text_end" if args.len() == 1 => {
                let id = self.eval_expr_const(&args[0])? as u16;
                let instr = sigil::Instruction::ShowTextEnd(id);
                Assembler::assemble_instruction(&instr, out);
            }
            "hide_text" | "text_hide" if args.is_empty() => {
                out.push(0x55);
            }
            "show_message" | "show_text_alt" if args.len() == 1 => {
                let id = self.eval_expr_const(&args[0])? as u16;
                let instr = sigil::Instruction::ShowMessage(id);
                Assembler::assemble_instruction(&instr, out);
            }
            "show_window_text" if args.len() == 2 => {
                let window = self.eval_expr_const(&args[0])? as u8;
                let text_id = self.eval_expr_const(&args[1])? as u16;
                let instr = sigil::Instruction::ShowWindowText { window, text_id };
                Assembler::assemble_instruction(&instr, out);
            }
            "hide_window_text" if args.len() == 1 => {
                let window = self.eval_expr_const(&args[0])? as u8;
                let instr = sigil::Instruction::HideWindowText(window);
                Assembler::assemble_instruction(&instr, out);
            }
            "reset_window_defaults" if args.len() == 1 => {
                let win = self.eval_expr_const(&args[0])? as u8;
                let instr = sigil::Instruction::ResetWindowDefaults(win);
                Assembler::assemble_instruction(&instr, out);
            }
            "show_naming_screen" if args.len() == 1 => {
                let target = self.eval_expr_const(&args[0])? as u16;
                let instr = sigil::Instruction::ShowNamingScreen(target);
                Assembler::assemble_instruction(&instr, out);
            }

            // Screen & Graphics & Palette
            "fade_in" if args.is_empty() => {
                let instr = sigil::Instruction::FadeIn;
                Assembler::assemble_instruction(&instr, out);
            }
            "fade_out" if args.is_empty() => {
                let instr = sigil::Instruction::FadeOut;
                Assembler::assemble_instruction(&instr, out);
            }
            "set_brightness" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::SetBrightness(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "set_brightness_fast" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::SetBrightnessFast(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "flash_screen" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::FlashScreen(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "shake_screen_complex" if args.len() == 1 => {
                let params = self.compile_expr_list(&args[0])?;
                let instr = sigil::Instruction::ShakeScreenComplex(params);
                Assembler::assemble_instruction(&instr, out);
            }
            "palette_fade_custom" if args.len() == 1 => {
                let params = self.compile_expr_list(&args[0])?;
                let instr = sigil::Instruction::PaletteFadeCustom(params);
                Assembler::assemble_instruction(&instr, out);
            }
            "start_palette_cycle" if args.len() == 1 => {
                let params = self.compile_expr_list(&args[0])?;
                let instr = sigil::Instruction::StartPaletteCycle(params);
                Assembler::assemble_instruction(&instr, out);
            }
            "show_hud_all" if args.is_empty() => {
                let instr = sigil::Instruction::ShowHudAll;
                Assembler::assemble_instruction(&instr, out);
            }
            "hide_hud_all" if args.is_empty() => {
                let instr = sigil::Instruction::HideHudAll;
                Assembler::assemble_instruction(&instr, out);
            }
            "show_currency_hud" if args.is_empty() => {
                let instr = sigil::Instruction::ShowCurrencyHud;
                Assembler::assemble_instruction(&instr, out);
            }
            "update_currency_hud" if args.is_empty() => {
                let instr = sigil::Instruction::UpdateCurrencyHud;
                Assembler::assemble_instruction(&instr, out);
            }
            "hide_currency_hud" if args.is_empty() => {
                let instr = sigil::Instruction::HideCurrencyHud;
                Assembler::assemble_instruction(&instr, out);
            }
            "restore_main_screen_layers" if args.is_empty() => {
                let instr = sigil::Instruction::RestoreMainScreenLayers;
                Assembler::assemble_instruction(&instr, out);
            }
            "set_sub_screen_layers" if args.is_empty() => {
                let instr = sigil::Instruction::SetSubScreenLayers;
                Assembler::assemble_instruction(&instr, out);
            }
            "enable_bg1" if args.is_empty() => {
                let instr = sigil::Instruction::EnableBg1;
                Assembler::assemble_instruction(&instr, out);
            }
            "disable_bg1" if args.is_empty() => {
                let instr = sigil::Instruction::DisableBg1;
                Assembler::assemble_instruction(&instr, out);
            }
            "enable_bg2" if args.is_empty() => {
                let instr = sigil::Instruction::EnableBg2;
                Assembler::assemble_instruction(&instr, out);
            }
            "disable_bg2" if args.is_empty() => {
                let instr = sigil::Instruction::DisableBg2;
                Assembler::assemble_instruction(&instr, out);
            }
            "bg_scroll_x" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::BgScrollX(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "bg_scroll_y" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::BgScrollY(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "bg_scroll_speed" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::BgScrollSpeed(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "bg2_scroll_speed" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::Bg2ScrollSpeed(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "set_bg_scroll" if args.len() == 1 => {
                let v = self.eval_expr_const(&args[0])? as u16;
                let instr = sigil::Instruction::SetBgScroll(v);
                Assembler::assemble_instruction(&instr, out);
            }
            "tile_state" if args.len() == 2 => {
                let e = self.compile_expr(&args[0])?;
                let w = self.eval_expr_const(&args[1])? as u16;
                let instr = sigil::Instruction::TileState { expr: e, word: w };
                Assembler::assemble_instruction(&instr, out);
            }

            // Map & Camera
            "change_map" if args.len() == 3 => {
                let x = self.eval_expr_const(&args[0])? as u8;
                let y = self.eval_expr_const(&args[1])? as u8;
                let map = self.eval_expr_const(&args[2])? as u16;
                let instr = sigil::Instruction::ChangeMap { x, y, map };
                Assembler::assemble_instruction(&instr, out);
            }
            "camera_follow" | "teleport_local" if args.len() == 2 => {
                let x = self.eval_expr_const(&args[0])? as u8;
                let y = self.eval_expr_const(&args[1])? as u8;
                let instr = sigil::Instruction::CameraFollow { x, y };
                Assembler::assemble_instruction(&instr, out);
            }
            "set_camera_pos" if args.len() == 2 => {
                let x = self.eval_expr_const(&args[0])? as u8;
                let y = self.eval_expr_const(&args[1])? as u8;
                let instr = sigil::Instruction::SetCameraPos { x, y };
                Assembler::assemble_instruction(&instr, out);
            }
            "attach_camera" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::AttachCamera(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "set_camera_base" if args.len() == 2 => {
                let x = self.compile_expr(&args[0])?;
                let y = self.compile_expr(&args[1])?;
                let instr = sigil::Instruction::SetCameraBase { x, y };
                Assembler::assemble_instruction(&instr, out);
            }
            "camera_action_9c" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::CameraAction9C(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "enter_mode7_map" if args.len() == 1 => {
                let params = self.compile_expr_list(&args[0])?;
                let instr = sigil::Instruction::EnterMode7Map(params);
                Assembler::assemble_instruction(&instr, out);
            }
            "map_effect_5c" if args.len() == 2 => {
                let a1 = self.compile_expr(&args[0])?;
                let a2 = self.compile_expr(&args[1])?;
                let instr = sigil::Instruction::MapEffect5C { arg1: a1, arg2: a2 };
                Assembler::assemble_instruction(&instr, out);
            }

            // Entities & NPCs
            "damage_entity" if args.len() == 2 => {
                let target = self.compile_expr(&args[0])?;
                let amount = self.compile_expr(&args[1])?;
                let instr = sigil::Instruction::DamageEntity { target, amount };
                Assembler::assemble_instruction(&instr, out);
            }
            "damage_entity_2" if args.len() == 2 => {
                let target = self.compile_expr(&args[0])?;
                let val = self.compile_expr(&args[1])?;
                let instr = sigil::Instruction::DamageEntity2 { target, val };
                Assembler::assemble_instruction(&instr, out);
            }
            "heal_entity" if args.len() == 2 => {
                let target = self.compile_expr(&args[0])?;
                let amount = self.compile_expr(&args[1])?;
                let instr = sigil::Instruction::HealEntity { target, amount };
                Assembler::assemble_instruction(&instr, out);
            }
            "set_entity_hp" if args.len() == 2 => {
                let target = self.compile_expr(&args[0])?;
                let hp = self.compile_expr(&args[1])?;
                let instr = sigil::Instruction::SetEntityHp { target, hp };
                Assembler::assemble_instruction(&instr, out);
            }
            "play_entity_anim" if args.len() == 3 => {
                let target = self.compile_expr(&args[0])?;
                let anim = self.eval_expr_const(&args[1])? as u16;
                let speed = self.compile_expr(&args[2])?;
                let instr = sigil::Instruction::PlayEntityAnim { target, anim, speed };
                Assembler::assemble_instruction(&instr, out);
            }
            "play_entity_anim_wait" if args.len() == 3 => {
                let target = self.compile_expr(&args[0])?;
                let anim = self.eval_expr_const(&args[1])? as u16;
                let speed = self.compile_expr(&args[2])?;
                let instr = sigil::Instruction::PlayEntityAnimWait { target, anim, speed };
                Assembler::assemble_instruction(&instr, out);
            }
            "set_entity_pos" if args.len() == 3 => {
                let target = self.compile_expr(&args[0])?;
                let x = self.compile_expr(&args[1])?;
                let y = self.compile_expr(&args[2])?;
                let instr = sigil::Instruction::SetEntityPos { target, x, y };
                Assembler::assemble_instruction(&instr, out);
            }
            "move_entity_to" if args.len() == 3 => {
                let target = self.compile_expr(&args[0])?;
                let x = self.compile_expr(&args[1])?;
                let y = self.compile_expr(&args[2])?;
                let instr = sigil::Instruction::MoveEntityTo { target, x, y };
                Assembler::assemble_instruction(&instr, out);
            }
            "set_entity_pos_expr" if args.len() == 3 => {
                let target = self.compile_expr(&args[0])?;
                let x = self.compile_expr(&args[1])?;
                let y = self.compile_expr(&args[2])?;
                let instr = sigil::Instruction::SetEntityPosExpr { target, x, y };
                Assembler::assemble_instruction(&instr, out);
            }
            "set_entity_pos_rel" if args.len() == 3 => {
                let target = self.compile_expr(&args[0])?;
                let dx = self.compile_expr(&args[1])?;
                let dy = self.compile_expr(&args[2])?;
                let instr = sigil::Instruction::SetEntityPosRel { target, dx, dy };
                Assembler::assemble_instruction(&instr, out);
            }
            "set_entity_speed" if args.len() == 2 => {
                let target = self.compile_expr(&args[0])?;
                let speed = self.eval_expr_const(&args[1])? as u16;
                let instr = sigil::Instruction::SetEntitySpeed { target, speed };
                Assembler::assemble_instruction(&instr, out);
            }
            "set_entity_palette" if args.len() == 2 => {
                let target = self.compile_expr(&args[0])?;
                let palette = self.compile_expr(&args[1])?;
                let instr = sigil::Instruction::SetEntityPalette { target, palette };
                Assembler::assemble_instruction(&instr, out);
            }
            "trigger_entity_action" if args.len() == 2 => {
                let target = self.compile_expr(&args[0])?;
                let action = self.compile_expr(&args[1])?;
                let instr = sigil::Instruction::TriggerEntityAction { target, action };
                Assembler::assemble_instruction(&instr, out);
            }
            "entity_face_entity" if args.len() == 2 => {
                let a = self.compile_expr(&args[0])?;
                let b = self.compile_expr(&args[1])?;
                let instr = sigil::Instruction::EntityFaceEntity { a, b };
                Assembler::assemble_instruction(&instr, out);
            }
            "face_each_other" if args.len() == 2 => {
                let a = self.compile_expr(&args[0])?;
                let b = self.compile_expr(&args[1])?;
                let instr = sigil::Instruction::FaceEachOther { a, b };
                Assembler::assemble_instruction(&instr, out);
            }
            "spawn_entity" if args.len() == 3 => {
                let b1 = self.eval_expr_const(&args[0])? as u8;
                let b2 = self.eval_expr_const(&args[1])? as u8;
                let b3 = self.eval_expr_const(&args[2])? as u8;
                let instr = sigil::Instruction::SpawnEntity { b1, b2, b3 };
                Assembler::assemble_instruction(&instr, out);
            }
            "spawn_entity_extra" if args.len() == 3 => {
                let b1 = self.eval_expr_const(&args[0])? as u8;
                let b2 = self.eval_expr_const(&args[1])? as u8;
                let b3 = self.eval_expr_const(&args[2])? as u8;
                let instr = sigil::Instruction::SpawnEntityExtra { b1, b2, b3 };
                Assembler::assemble_instruction(&instr, out);
            }
            "spawn_npc" if args.len() == 4 => {
                let npc_type = self.eval_expr_const(&args[0])? as u16;
                let param = self.eval_expr_const(&args[1])? as u16;
                let x = self.compile_expr(&args[2])?;
                let y = self.compile_expr(&args[3])?;
                let instr = sigil::Instruction::SpawnNpc { npc_type, param, x, y };
                Assembler::assemble_instruction(&instr, out);
            }
            "spawn_npc_param" if args.len() == 4 => {
                let npc_type = self.eval_expr_const(&args[0])? as u16;
                let param = self.eval_expr_const(&args[1])? as u16;
                let x = self.eval_expr_const(&args[2])? as u8;
                let y = self.eval_expr_const(&args[3])? as u8;
                let instr = sigil::Instruction::SpawnNpcParam { npc_type, param, x, y };
                Assembler::assemble_instruction(&instr, out);
            }
            "set_npc_script" if args.len() == 3 => {
                let target = self.compile_expr(&args[0])?;
                let w1 = self.eval_expr_const(&args[1])? as u16;
                let w2 = self.eval_expr_const(&args[2])? as u16;
                let instr = sigil::Instruction::SetNpcScript { target, w1, w2 };
                Assembler::assemble_instruction(&instr, out);
            }
            "set_ambient_actor_pos" if args.len() == 3 => {
                let id = self.eval_expr_const(&args[0])? as u8;
                let x = self.eval_expr_const(&args[1])? as u16;
                let y = self.eval_expr_const(&args[2])? as u16;
                let instr = sigil::Instruction::SetAmbientActorPos { id, x, y };
                Assembler::assemble_instruction(&instr, out);
            }
            "set_canine_ai_targeting" if args.is_empty() => {
                let instr = sigil::Instruction::SetCanineAiTargeting;
                Assembler::assemble_instruction(&instr, out);
            }

            // Sound & Music
            "play_sound" | "play_sfx" => {
                let (ch, id) = if args.len() == 1 {
                    (0, self.eval_expr_const(&args[0])? as u8)
                } else if args.len() == 2 {
                    (self.eval_expr_const(&args[0])? as u8, self.eval_expr_const(&args[1])? as u8)
                } else {
                    return Err(format!("play_sound erwartet 1 oder 2 Argumente, erhalten: {}", args.len()));
                };
                let instr = sigil::Instruction::PlaySound { channel: ch, id };
                Assembler::assemble_instruction(&instr, out);
            }
            "play_music" | "play_bgm" if args.len() == 1 => {
                let id = self.eval_expr_const(&args[0])? as u8;
                let instr = sigil::Instruction::PlayMusic(id);
                Assembler::assemble_instruction(&instr, out);
            }
            "set_pitch" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::SetPitch(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "set_music_volume" if args.len() == 1 => {
                let vol = self.eval_expr_const(&args[0])? as u8;
                let instr = sigil::Instruction::SetMusicVolume(vol);
                Assembler::assemble_instruction(&instr, out);
            }
            "sound_cmd_28" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::SoundCmd28(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "sound_cmd_2a" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::SoundCmd2A(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "sound_cmd_2a_expr" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::SoundCmd2AExpr(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "sound_cmd_2b_expr" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::SoundCmd2BExpr(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "fade_in_music" if args.is_empty() => {
                let instr = sigil::Instruction::FadeInMusic;
                Assembler::assemble_instruction(&instr, out);
            }
            "fade_out_music" if args.is_empty() => {
                let instr = sigil::Instruction::FadeOutMusic;
                Assembler::assemble_instruction(&instr, out);
            }

            // Money & Shop
            "give_money" | "give_money_expr" if args.len() == 2 => {
                let cur = self.compile_expr(&args[0])?;
                if let Ok(amt) = self.eval_expr_const(&args[1]) {
                    let instr = sigil::Instruction::GiveMoney { currency: cur, amount: amt as u32 };
                    Assembler::assemble_instruction(&instr, out);
                } else {
                    let amt_expr = self.compile_expr(&args[1])?;
                    let instr = sigil::Instruction::GiveMoneyExpr { currency: cur, amount: amt_expr };
                    Assembler::assemble_instruction(&instr, out);
                }
            }
            "take_money" | "take_money_expr" if args.len() == 2 => {
                let cur = self.compile_expr(&args[0])?;
                if let Ok(amt) = self.eval_expr_const(&args[1]) {
                    let instr = sigil::Instruction::TakeMoney { currency: cur, amount: amt as u32 };
                    Assembler::assemble_instruction(&instr, out);
                } else {
                    let amt_expr = self.compile_expr(&args[1])?;
                    let instr = sigil::Instruction::TakeMoneyExpr { currency: cur, amount: amt_expr };
                    Assembler::assemble_instruction(&instr, out);
                }
            }
            "give_jewels" if args.len() == 1 => {
                let amt = self.eval_expr_const(&args[0])? as u32;
                let instr = sigil::Instruction::GiveJewels(amt);
                Assembler::assemble_instruction(&instr, out);
            }
            "add_shop_item" if args.len() == 2 => {
                let item = self.compile_expr(&args[0])?;
                let count = self.compile_expr(&args[1])?;
                let instr = sigil::Instruction::AddShopItem { item, count };
                Assembler::assemble_instruction(&instr, out);
            }
            "open_shop_menu" if args.len() == 1 => {
                let e = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::OpenShopMenu(e);
                Assembler::assemble_instruction(&instr, out);
            }
            "clear_shop_menu" if args.is_empty() => {
                let instr = sigil::Instruction::ClearShopMenu;
                Assembler::assemble_instruction(&instr, out);
            }

            // Memory manipulation
            "write_wram_byte" if args.len() == 2 => {
                let target = self.compile_expr(&args[0])?;
                let val = self.compile_expr(&args[1])?;
                let instr = sigil::Instruction::WriteWramByte { target, val };
                Assembler::assemble_instruction(&instr, out);
            }
            "write_wram_word" if args.len() == 2 => {
                let target = self.compile_expr(&args[0])?;
                let val = self.compile_expr(&args[1])?;
                let instr = sigil::Instruction::WriteWramWord { target, val };
                Assembler::assemble_instruction(&instr, out);
            }
            "set_ram_pairs_x8" if args.len() == 4 => {
                let w1 = self.eval_expr_const(&args[0])? as u16;
                let w2 = self.eval_expr_const(&args[1])? as u16;
                let b1 = self.eval_expr_const(&args[2])? as u8;
                let b2 = self.eval_expr_const(&args[3])? as u8;
                let instr = sigil::Instruction::SetRamPairsX8 { w1, w2, b1, b2 };
                Assembler::assemble_instruction(&instr, out);
            }
            "set_temp_pairs_x8" if args.len() == 4 => {
                let w1 = self.eval_expr_const(&args[0])? as u16;
                let w2 = self.eval_expr_const(&args[1])? as u16;
                let b1 = self.eval_expr_const(&args[2])? as u8;
                let b2 = self.eval_expr_const(&args[3])? as u8;
                let instr = sigil::Instruction::SetTempPairsX8 { w1, w2, b1, b2 };
                Assembler::assemble_instruction(&instr, out);
            }
            "set_arg_pairs_x8" if args.len() == 4 => {
                let arg1 = self.eval_expr_const(&args[0])? as u8;
                let arg2 = self.eval_expr_const(&args[1])? as u8;
                let b1 = self.eval_expr_const(&args[2])? as u8;
                let b2 = self.eval_expr_const(&args[3])? as u8;
                let instr = sigil::Instruction::SetArgPairsX8 { arg1, arg2, b1, b2 };
                Assembler::assemble_instruction(&instr, out);
            }

            "write_var_fast" if args.len() == 2 => {
                let addr = self.eval_expr_const(&args[0])? as u16;
                let val = self.eval_expr_const(&args[1])? as u16;
                let instr = sigil::Instruction::WriteVarFast { addr, val };
                Assembler::assemble_instruction(&instr, out);
            }

            "skip_neg" | "skip_back" if args.len() == 1 => {
                let delta = self.eval_expr_const(&args[0])? as i8;
                let instr = sigil::Instruction::SkipNeg(delta);
                Assembler::assemble_instruction(&instr, out);
            }
            "call_rel_byte" if args.len() == 1 => {
                let off = self.eval_expr_const(&args[0])? as i8;
                let instr = sigil::Instruction::CallRelativeByte(off);
                Assembler::assemble_instruction(&instr, out);
            }

            // Raw
            "raw" if args.len() == 2 => {
                let opcode = self.eval_expr_const(&args[0])? as u8;
                let payload = self.eval_u8_list(&args[1])?;
                let instr = sigil::Instruction::Raw { opcode, payload };
                Assembler::assemble_instruction(&instr, out);
            }

            _ if name.starts_with("write_ram_0x") && args.len() == 2 => {
                let opcode = parse_hex_suffix(name)?;
                let addr = self.eval_expr_const(&args[0])? as u16;
                let expr = self.compile_expr(&args[1])?;
                let instr = sigil::Instruction::WriteRam { opcode, addr, expr };
                Assembler::assemble_instruction(&instr, out);
            }
            _ if name.starts_with("write_temp_0x") && args.len() == 2 => {
                let opcode = parse_hex_suffix(name)?;
                let addr = self.eval_expr_const(&args[0])? as u16;
                let expr = self.compile_expr(&args[1])?;
                let instr = sigil::Instruction::WriteTemp { opcode, addr, expr };
                Assembler::assemble_instruction(&instr, out);
            }
            _ if name.starts_with("write_script_arg_0x") && args.len() == 2 => {
                let opcode = parse_hex_suffix(name)?;
                let arg = self.eval_expr_const(&args[0])? as u8;
                let expr = self.compile_expr(&args[1])?;
                let instr = sigil::Instruction::WriteScriptArg { opcode, arg, expr };
                Assembler::assemble_instruction(&instr, out);
            }

            // Patterns with opcode in name: prefix_0x..
            _ if name.starts_with("set_entity_pos_fast_0x") && args.len() == 3 => {
                let opcode = parse_hex_suffix(name)?;
                let target = self.compile_expr(&args[0])?;
                let cx = self.eval_expr_const(&args[1])? as u8;
                let cy = self.eval_expr_const(&args[2])? as u8;
                let instr = sigil::Instruction::SetEntityPosFast { opcode, target, cx, cy };
                Assembler::assemble_instruction(&instr, out);
            }
            _ if name.starts_with("set_entity_pos_rel_fast_0x") && args.len() == 3 => {
                let opcode = parse_hex_suffix(name)?;
                let target = self.compile_expr(&args[0])?;
                let dx = self.compile_expr(&args[1])?;
                let dy = self.compile_expr(&args[2])?;
                let instr = sigil::Instruction::SetEntityPosRelFast { opcode, target, dx, dy };
                Assembler::assemble_instruction(&instr, out);
            }
            _ if name.starts_with("entity_action_0x") && args.len() == 1 => {
                let opcode = parse_hex_suffix(name)?;
                let target = self.compile_expr(&args[0])?;
                let instr = sigil::Instruction::EntityAction { opcode, target };
                Assembler::assemble_instruction(&instr, out);
            }
            _ if name.starts_with("set_tile_attr_0x") && args.len() == 2 => {
                let opcode = parse_hex_suffix(name)?;
                let target = self.compile_expr(&args[0])?;
                let attr = self.eval_expr_const(&args[1])? as u16;
                let instr = sigil::Instruction::SetTileAttr { opcode, target, attr };
                Assembler::assemble_instruction(&instr, out);
            }
            _ if name.starts_with("set_window_size_0x") && args.len() == 5 => {
                let opcode = parse_hex_suffix(name)?;
                let window = self.eval_expr_const(&args[0])? as u8;
                let x = self.eval_expr_const(&args[1])? as u8;
                let y = self.eval_expr_const(&args[2])? as u8;
                let w = self.eval_expr_const(&args[3])? as u8;
                let h = self.eval_expr_const(&args[4])? as u8;
                let instr = sigil::Instruction::SetWindowSize { opcode, window, x, y, w, h };
                Assembler::assemble_instruction(&instr, out);
            }
            _ if name.starts_with("lock_player_fast_0x") && args.is_empty() => {
                let opcode = parse_hex_suffix(name)?;
                let instr = sigil::Instruction::LockPlayerFast { opcode };
                Assembler::assemble_instruction(&instr, out);
            }
            _ if name.starts_with("unlock_player_fast_0x") && args.is_empty() => {
                let opcode = parse_hex_suffix(name)?;
                let instr = sigil::Instruction::UnlockPlayerFast { opcode };
                Assembler::assemble_instruction(&instr, out);
            }
            _ if name.starts_with("yield_0x") && args.is_empty() => {
                let opcode = parse_hex_suffix(name)?;
                let instr = sigil::Instruction::Yield { opcode };
                Assembler::assemble_instruction(&instr, out);
            }
            _ if name.starts_with("cast_alchemy_0x") && args.len() == 4 => {
                let opcode = parse_hex_suffix(name)?;
                let target = self.compile_expr(&args[0])?;
                let spell = self.compile_expr(&args[1])?;
                let level = self.compile_expr(&args[2])?;
                let extra = self.compile_expr_list(&args[3])?;
                let instr = sigil::Instruction::CastAlchemy { opcode, target, spell, level, extra };
                Assembler::assemble_instruction(&instr, out);
            }

            // User function call by name (symbols)
            _ => {
                if let Some(val) = self.symbols.get(name) {
                    let instr = sigil::Instruction::Call(*val as u32);
                    Assembler::assemble_instruction(&instr, out);
                } else {
                    return Err(format!("Unbekannter Befehl oder Funktion: '{}'", name));
                }
            }
        }
        Ok(())
    }

    fn compile_expr_list(&self, expr: &EvsExpr) -> Result<Vec<sigil::Expr>, String> {
        match expr {
            EvsExpr::Array(items) => {
                items.iter().map(|item| self.compile_expr(item)).collect()
            }
            _ => Ok(vec![self.compile_expr(expr)?]),
        }
    }

    fn eval_u8_list(&self, expr: &EvsExpr) -> Result<Vec<u8>, String> {
        match expr {
            EvsExpr::Array(items) => {
                items.iter().map(|item| self.eval_expr_const(item).map(|v| v as u8)).collect()
            }
            _ => Ok(vec![self.eval_expr_const(expr)? as u8]),
        }
    }

    fn eval_expr_const(&self, expr: &EvsExpr) -> Result<i64, String> {
        match expr {
            EvsExpr::Number(n) => Ok(*n),
            EvsExpr::Money(m) => Ok(*m as i64),
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

fn parse_hex_suffix(s: &str) -> Result<u8, String> {
    if let Some(idx) = s.rfind("0x").or_else(|| s.rfind("0X")) {
        u8::from_str_radix(&s[idx + 2..], 16)
            .map_err(|e| format!("Ungültiger Hex-Suffix in '{}': {}", s, e))
    } else {
        Err(format!("Kein Hex-Suffix in '{}'", s))
    }
}
