// crates/soe-script/src/format.rs
use crate::ast::*;

impl Script {
    pub fn to_disassembly_string(&self) -> String {
        let mut out = String::new();
        out.push_str(&format!("// Script at SNES ${:06X}\n", self.start_addr));
        for stmt in &self.statements {
            let bytes_hex = stmt
                .raw_bytes
                .iter()
                .map(|b| format!("{:02X}", b))
                .collect::<Vec<_>>()
                .join(" ");

            let instr_str = format_instruction(&stmt.instruction, stmt.offset, stmt.snes_addr);
            out.push_str(&format!(
                "[{:04X}] ${:06X}  {:<16}  {}\n",
                stmt.offset, stmt.snes_addr, bytes_hex, instr_str
            ));
        }
        out
    }

    pub fn to_everscript_string(&self) -> String {
        let mut out = String::new();
        out.push_str(&format!("// Everscript representation for ${:06X}\n", self.start_addr));
        out.push_str("fun script() {\n");
        for stmt in &self.statements {
            let instr_str = format_everscript_instruction(&stmt.instruction);
            out.push_str(&format!("    {}\n", instr_str));
        }
        out.push_str("}\n");
        out
    }
}

pub fn format_instruction(instr: &Instruction, offset: usize, _snes_addr: u32) -> String {
    match instr {
        Instruction::End => "END".to_string(),
        Instruction::Return => "RETURN".to_string(),
        Instruction::Skip(jmp) => {
            let target = (offset as isize + *jmp as isize + 3) as usize;
            format!("SKIP {:+} -> [{:04X}]", jmp, target)
        }
        Instruction::SkipNeg(jmp) => {
            let target = (offset as isize + *jmp as isize + 2) as usize;
            format!("SKIP {:+} -> [{:04X}]", jmp, target)
        }
        Instruction::Call(rom_addr) => format!("CALL ${:06X}", rom_addr),
        Instruction::If { cond, target_offset } => {
            let target = (offset as isize + *target_offset as isize) as usize;
            format!("IF {} SKIP {:+} -> [{:04X}]", format_expr(cond), target_offset, target)
        }
        Instruction::IfNot { cond, target_offset } => {
            let target = (offset as isize + *target_offset as isize) as usize;
            format!("IF NOT ({}) SKIP {:+} -> [{:04X}]", format_expr(cond), target_offset, target)
        }
        Instruction::IfMoneyGe { currency, amount, target_offset } => {
            format!("IF MONEY[{}] >= {} SKIP {:+}", currency, amount, target_offset)
        }
        Instruction::IfMoneyLt { currency, amount, target_offset } => {
            format!("IF MONEY[{}] < {} SKIP {:+}", currency, amount, target_offset)
        }
        Instruction::SetFlag { base, bit_index, val } => {
            let base_str = match base {
                FlagBase::Ram => "RAM",
                FlagBase::Temp => "TEMP",
            };
            format!("{}_FLAG[0x{:04X}] = {}", base_str, bit_index, format_expr(val))
        }
        Instruction::SetScriptArgBit { bit_index, val } => {
            format!("ARG_BIT[{}] = {}", bit_index, format_expr(val))
        }
        Instruction::WriteVarFast { addr, val } => {
            format!("RAM[$2258 + 0x{:04X}] = 0x{:04X}", addr, val)
        }
        Instruction::WriteRam { addr, expr } => {
            format!("RAM[$2258 + 0x{:04X}] = {}", addr, format_expr(expr))
        }
        Instruction::WriteTemp { addr, expr } => {
            format!("TEMP[$2834 + 0x{:04X}] = {}", addr, format_expr(expr))
        }
        Instruction::WriteScriptArg { arg, expr } => {
            format!("ARG[{}] = {}", arg, format_expr(expr))
        }
        Instruction::ShowText(id) => format!("SHOW_TEXT 0x{:04X}", id),
        Instruction::ShowTextEnd(id) => format!("SHOW_TEXT_END 0x{:04X}", id),
        Instruction::HideText => "HIDE_TEXT".to_string(),
        Instruction::GiveJewels(amount) => format!("GIVE_JEWELS {}", amount),
        Instruction::Sleep(frames) => format!("SLEEP {} frames", frames),
        Instruction::Raw { opcode, payload } => {
            let p_hex = payload.iter().map(|b| format!("{:02X}", b)).collect::<Vec<_>>().join(" ");
            format!("RAW 0x{:02X} [{}]", opcode, p_hex)
        }
    }
}

pub fn format_everscript_instruction(instr: &Instruction) -> String {
    match instr {
        Instruction::End => "end();".to_string(),
        Instruction::Return => "return;".to_string(),
        Instruction::Skip(jmp) => format!("// branch {:+}", jmp),
        Instruction::SkipNeg(jmp) => format!("// branch neg {:+}", jmp),
        Instruction::Call(rom_addr) => format!("call(0x{:06X});", rom_addr),
        Instruction::If { cond, .. } => format!("if ({}) {{", format_expr(cond)),
        Instruction::IfNot { cond, .. } => format!("if (!({})) {{", format_expr(cond)),
        Instruction::IfMoneyGe { currency, amount, .. } => {
            format!("if (money({}) >= {}) {{", currency, amount)
        }
        Instruction::IfMoneyLt { currency, amount, .. } => {
            format!("if (money({}) < {}) {{", currency, amount)
        }
        Instruction::SetFlag { base, bit_index, val } => {
            let prefix = match base {
                FlagBase::Ram => "FLAG",
                FlagBase::Temp => "TEMP_FLAG",
            };
            format!("{}[0x{:04X}] = {};", prefix, bit_index, format_expr(val))
        }
        Instruction::SetScriptArgBit { bit_index, val } => {
            format!("arg_bit({}) = {};", bit_index, format_expr(val))
        }
        Instruction::WriteVarFast { addr, val } => {
            format!("$2258[0x{:04X}] = 0x{:04X};", addr, val)
        }
        Instruction::WriteRam { addr, expr } => {
            format!("$2258[0x{:04X}] = {};", addr, format_expr(expr))
        }
        Instruction::WriteTemp { addr, expr } => {
            format!("$2834[0x{:04X}] = {};", addr, format_expr(expr))
        }
        Instruction::WriteScriptArg { arg, expr } => {
            format!("arg({}) = {};", arg, format_expr(expr))
        }
        Instruction::ShowText(id) => format!("text(0x{:04X});", id),
        Instruction::ShowTextEnd(id) => format!("text_end(0x{:04X});", id),
        Instruction::HideText => "text_hide();".to_string(),
        Instruction::GiveJewels(amount) => format!("give_jewels({});", amount),
        Instruction::Sleep(frames) => format!("sleep({});", frames),
        Instruction::Raw { opcode, payload } => {
            let p_hex = payload.iter().map(|b| format!("0x{:02X}", b)).collect::<Vec<_>>().join(", ");
            format!("raw(0x{:02X}, [{}]);", opcode, p_hex)
        }
    }
}

pub fn format_expr(expr: &Expr) -> String {
    match expr {
        Expr::Const(v) => format!("{}", v),
        Expr::Flag { base, bit_index } => {
            let prefix = match base {
                FlagBase::Ram => "FLAG",
                FlagBase::Temp => "TEMP_FLAG",
            };
            format!("{}[0x{:04X}]", prefix, bit_index)
        }
        Expr::RamByte(addr) => format!("RAM_BYTE[0x{:04X}]", addr),
        Expr::RamWord(addr) => format!("RAM_WORD[0x{:04X}]", addr),
        Expr::TempByte(addr) => format!("TEMP_BYTE[0x{:04X}]", addr),
        Expr::TempWord(addr) => format!("TEMP_WORD[0x{:04X}]", addr),
        Expr::ArgByte(arg) => format!("ARG_BYTE[{}]", arg),
        Expr::ArgWord(arg) => format!("ARG_WORD[{}]", arg),
        Expr::Entity(ent) => format!("{:?}", ent),
        Expr::Rng => "rnd()".to_string(),
        Expr::RngRange(r) => format!("rnd_range({})", format_expr(r)),
        Expr::DialogResponse => "dialog_response()".to_string(),
        Expr::Unary { op, expr } => {
            let op_str = match op {
                UnaryOp::Not => "!",
                UnaryOp::BitNot => "~",
                UnaryOp::Neg => "-",
            };
            format!("{}{}", op_str, format_expr(expr))
        }
        Expr::Binary { op, left, right } => {
            let op_str = match op {
                BinaryOp::Add => "+",
                BinaryOp::Sub => "-",
                BinaryOp::Mul => "*",
                BinaryOp::Div => "/",
                BinaryOp::Shl => "<<",
                BinaryOp::Shr => ">>",
                BinaryOp::Lt => "<",
                BinaryOp::Gt => ">",
                BinaryOp::Le => "<=",
                BinaryOp::Ge => ">=",
                BinaryOp::Eq => "==",
                BinaryOp::Ne => "!=",
                BinaryOp::BitAnd => "&",
                BinaryOp::BitOr => "|",
                BinaryOp::BitXor => "^",
                BinaryOp::Or => "||",
                BinaryOp::And => "&&",
            };
            format!("({} {} {})", format_expr(left), op_str, format_expr(right))
        }
        Expr::Raw(r) => format!("RAW({:?})", r),
    }
}
