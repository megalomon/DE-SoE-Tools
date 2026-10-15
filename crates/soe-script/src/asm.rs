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
            Instruction::FadeIn => out.push(0x26),
            Instruction::FadeOut => out.push(0x27),
            Instruction::SetCameraPos { x, y } => {
                out.push(0x20);
                out.push(*x);
                out.push(*y);
            }
            Instruction::PlaySound { channel, id } => {
                out.push(0x30 + (*channel & 3));
                out.push(*id);
            }
            Instruction::PlayMusic(id) => {
                out.push(0x33);
                out.push(*id);
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
                let ends_with_zero = extra.last().map(|e| matches!(e, Expr::Const { val: 0, .. })).unwrap_or(false);
                if !ends_with_zero {
                    Self::assemble_expr(&Expr::const_val(0), out);
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
            Instruction::IfEqual { left, right, target_offset } => {
                out.push(0x8E);
                Self::assemble_expr(left, out);
                Self::assemble_expr(right, out);
                out.extend_from_slice(&target_offset.to_le_bytes());
            }
            Instruction::IfNotEqual { left, right, target_offset } => {
                out.push(0x8F);
                Self::assemble_expr(left, out);
                Self::assemble_expr(right, out);
                out.extend_from_slice(&target_offset.to_le_bytes());
            }
            Instruction::PlayEntityAnim { target, anim, speed } => {
                out.push(0x78);
                Self::assemble_expr(target, out);
                out.extend_from_slice(&anim.to_le_bytes());
                Self::assemble_expr(speed, out);
            }
            Instruction::PlayEntityAnimWait { target, anim, speed } => {
                out.push(0x79);
                Self::assemble_expr(target, out);
                out.extend_from_slice(&anim.to_le_bytes());
                Self::assemble_expr(speed, out);
            }
            Instruction::SetEntityPos { target, x, y } => {
                out.push(0x43);
                Self::assemble_expr(target, out);
                Self::assemble_expr(x, out);
                Self::assemble_expr(y, out);
            }
            Instruction::MoveEntityTo { target, x, y } => {
                out.push(0x73);
                Self::assemble_expr(target, out);
                Self::assemble_expr(x, out);
                Self::assemble_expr(y, out);
            }
            Instruction::SetEntityPosExpr { target, x, y } => {
                out.push(0x9D);
                Self::assemble_expr(target, out);
                Self::assemble_expr(x, out);
                Self::assemble_expr(y, out);
            }
            Instruction::SetEntityPosFast { opcode, target, cx, cy } => {
                out.push(*opcode);
                Self::assemble_expr(target, out);
                out.push(*cx);
                out.push(*cy);
            }
            Instruction::SetEntityPosRelFast { opcode, target, dx, dy } => {
                out.push(*opcode);
                Self::assemble_expr(target, out);
                Self::assemble_expr(dx, out);
                Self::assemble_expr(dy, out);
            }
            Instruction::SetEntitySpeed { target, speed } => {
                out.push(0x42);
                Self::assemble_expr(target, out);
                out.extend_from_slice(&speed.to_le_bytes());
            }
            Instruction::AttachScript { target, script_id } => {
                out.push(0x3D);
                Self::assemble_expr(target, out);
                out.extend_from_slice(&script_id.to_le_bytes());
            }
            Instruction::EntityAction { opcode, target } => {
                out.push(*opcode);
                Self::assemble_expr(target, out);
            }
            Instruction::CameraAction9C(expr) => {
                out.push(0x9C);
                Self::assemble_expr(expr, out);
            }
            Instruction::SpawnEntity { b1, b2, b3 } => {
                out.push(0xBA);
                out.push(*b1);
                out.push(*b2);
                out.push(*b3);
            }
            Instruction::SpawnEntityExtra { b1, b2, b3 } => {
                out.push(0xC2);
                out.push(*b1);
                out.push(*b2);
                out.push(*b3);
            }
            Instruction::SpawnNpc { npc_type, param, x, y } => {
                out.push(0xA2);
                out.extend_from_slice(&npc_type.to_le_bytes());
                out.extend_from_slice(&param.to_le_bytes());
                Self::assemble_expr(x, out);
                Self::assemble_expr(y, out);
            }
            Instruction::MapEffect5C { arg1, arg2 } => {
                out.push(0x5C);
                Self::assemble_expr(arg1, out);
                Self::assemble_expr(arg2, out);
            }
            Instruction::SetTileAttr { opcode, target, attr } => {
                out.push(*opcode);
                Self::assemble_expr(target, out);
                out.extend_from_slice(&attr.to_le_bytes());
            }
            Instruction::SetBgScroll(val) => {
                out.push(0x23);
                out.extend_from_slice(&val.to_le_bytes());
            }
            Instruction::ShowWindowText { window, text_id } => {
                out.push(0x50);
                out.push(*window);
                out.extend_from_slice(&text_id.to_le_bytes());
            }
            Instruction::HideWindowText(window) => {
                out.push(0x54);
                out.push(*window);
            }
            Instruction::SetWindowSize { opcode, window, x, y, w, h } => {
                out.push(*opcode);
                out.push(*window);
                out.push(*x);
                out.push(*y);
                out.push(*w);
                out.push(*h);
            }
            Instruction::ShowNamingScreen(target) => {
                out.push(0x7F);
                out.extend_from_slice(&target.to_le_bytes());
            }
            Instruction::ShowMessage(msg_id) => {
                out.push(0x8C);
                out.extend_from_slice(&msg_id.to_le_bytes());
            }
            Instruction::SetBrightnessFast(expr) => {
                out.push(0x91);
                Self::assemble_expr(expr, out);
            }
            Instruction::SetPitch(expr) => {
                out.push(0x9A);
                Self::assemble_expr(expr, out);
            }
            Instruction::SetMusicVolume(vol) => {
                out.push(0x8D);
                out.push(*vol);
            }
            Instruction::SoundCmd2AExpr(expr) => {
                out.push(0x2A);
                Self::assemble_expr(expr, out);
            }
            Instruction::SoundCmd2BExpr(expr) => {
                out.push(0x2B);
                Self::assemble_expr(expr, out);
            }
            Instruction::ScriptCmd4E(expr) => {
                out.push(0x4E);
                Self::assemble_expr(expr, out);
            }
            Instruction::ScriptCmd7E { arg1, arg2, arg3, arg4 } => {
                out.push(0x7E);
                Self::assemble_expr(arg1, out);
                Self::assemble_expr(arg2, out);
                Self::assemble_expr(arg3, out);
                Self::assemble_expr(arg4, out);
            }
            Instruction::WriteWramByte { target, val } => {
                out.push(0x7A);
                Self::assemble_expr(target, out);
                Self::assemble_expr(val, out);
            }
            Instruction::WriteWramWord { target, val } => {
                out.push(0x7B);
                Self::assemble_expr(target, out);
                Self::assemble_expr(val, out);
            }
            Instruction::CallTableByte(idx) => {
                out.push(0xA3);
                out.push(*idx);
            }
            Instruction::CallTableWord(idx) => {
                out.push(0xA4);
                out.extend_from_slice(&idx.to_le_bytes());
            }
            Instruction::SpawnNpcParam { npc_type, param, x, y } => {
                out.push(0x3C);
                out.extend_from_slice(&npc_type.to_le_bytes());
                out.extend_from_slice(&param.to_le_bytes());
                out.push(*x);
                out.push(*y);
            }
            Instruction::ResetWindowDefaults(win) => {
                out.push(0x48 + (*win & 3));
            }
            Instruction::LockPlayerFast { opcode } => {
                out.push(*opcode);
            }
            Instruction::UnlockPlayerFast { opcode } => {
                out.push(*opcode);
            }
            Instruction::CallParams { args, addr } => {
                out.push(0xAF);
                out.push(args.len() as u8);
                for a in args {
                    Self::assemble_expr(a, out);
                }
                let s_addr = Rom::rom_to_script_addr(*addr);
                out.extend_from_slice(&s_addr.to_le_bytes()[..3]);
            }
            Instruction::CallTableByteParams { args, idx } => {
                out.push(0xB0);
                out.push(args.len() as u8);
                for a in args {
                    Self::assemble_expr(a, out);
                }
                out.push(*idx);
            }
            Instruction::CallTableWordParams { args, idx } => {
                out.push(0xB1);
                out.push(args.len() as u8);
                for a in args {
                    Self::assemble_expr(a, out);
                }
                out.extend_from_slice(&idx.to_le_bytes());
            }
            Instruction::CallRelativeByteParams { args, offset } => {
                out.push(0xB2);
                out.push(args.len() as u8);
                for a in args {
                    Self::assemble_expr(a, out);
                }
                out.push(*offset as u8);
            }
            Instruction::CallRelativeWordParams { args, offset } => {
                out.push(0xB3);
                out.push(args.len() as u8);
                for a in args {
                    Self::assemble_expr(a, out);
                }
                out.extend_from_slice(&offset.to_le_bytes());
            }
            Instruction::ForkParams { args, addr } => {
                out.push(0xB4);
                out.push(args.len() as u8);
                for a in args {
                    Self::assemble_expr(a, out);
                }
                let s_addr = Rom::rom_to_script_addr(*addr);
                out.extend_from_slice(&s_addr.to_le_bytes()[..3]);
            }
            Instruction::Yield { opcode } => {
                out.push(*opcode);
            }
            Instruction::NopSkipByte(b) => {
                out.push(0x4C);
                out.push(*b);
            }
            Instruction::Nop => {
                out.push(0x4D);
            }
            Instruction::FadeInMusic => {
                out.push(0x58);
            }
            Instruction::FadeOutMusic => {
                out.push(0x59);
            }
            Instruction::DisableInterrupts => {
                out.push(0x5A);
            }
            Instruction::EnableInterrupts => {
                out.push(0x5B);
            }
            Instruction::WaitPathEnd => {
                out.push(0x63);
            }
            Instruction::EnableBg1 => {
                out.push(0x65);
            }
            Instruction::DisableBg1 => {
                out.push(0x66);
            }
            Instruction::EnableBg2 => {
                out.push(0x69);
            }
            Instruction::DisableBg2 => {
                out.push(0x6A);
            }
            Instruction::EntityFaceEntity { a, b } => {
                out.push(0x70);
                Self::assemble_expr(a, out);
                Self::assemble_expr(b, out);
            }
            Instruction::FaceEachOther { a, b } => {
                out.push(0x71);
                Self::assemble_expr(a, out);
                Self::assemble_expr(b, out);
            }
            Instruction::ShowHudAll => {
                out.push(0x80);
            }
            Instruction::HideHudAll => {
                out.push(0x81);
            }
            Instruction::RestoreMainScreenLayers => {
                out.push(0x82);
            }
            Instruction::SetSubScreenLayers => {
                out.push(0x83);
            }
            Instruction::ClearShopMenu => {
                out.push(0x88);
            }
            Instruction::SetCameraBase { x, y } => {
                out.push(0x96);
                Self::assemble_expr(x, out);
                Self::assemble_expr(y, out);
            }
            Instruction::ShakeScreenComplex(args) => {
                out.push(0x97);
                for a in args {
                    Self::assemble_expr(a, out);
                }
            }
            Instruction::EnterMode7Map(args) => {
                out.push(0x99);
                for a in args {
                    Self::assemble_expr(a, out);
                }
            }
            Instruction::ShowCurrencyHud => {
                out.push(0x9F);
            }
            Instruction::UpdateCurrencyHud => {
                out.push(0xA0);
            }
            Instruction::HideCurrencyHud => {
                out.push(0xA1);
            }
            Instruction::SetCanineAiTargeting => {
                out.push(0xAA);
            }
            Instruction::SetRamPairsX8 { w1, w2, b1, b2 } => {
                out.push(0x1B);
                out.extend_from_slice(&w1.to_le_bytes());
                out.extend_from_slice(&w2.to_le_bytes());
                out.push(*b1);
                out.push(*b2);
            }
            Instruction::SetTempPairsX8 { w1, w2, b1, b2 } => {
                out.push(0xAD);
                out.extend_from_slice(&w1.to_le_bytes());
                out.extend_from_slice(&w2.to_le_bytes());
                out.push(*b1);
                out.push(*b2);
            }
            Instruction::SetArgPairsX8 { arg1, arg2, b1, b2 } => {
                out.push(0xAE);
                out.push(*arg1);
                out.push(*arg2);
                out.push(*b1);
                out.push(*b2);
            }
            Instruction::SetNpcScript { target, w1, w2 } => {
                out.push(0x3F);
                Self::assemble_expr(target, out);
                out.extend_from_slice(&w1.to_le_bytes());
                out.extend_from_slice(&w2.to_le_bytes());
            }
            Instruction::SetAmbientActorPos { id, x, y } => {
                out.push(0x62);
                out.push(*id);
                out.extend_from_slice(&x.to_le_bytes());
                out.extend_from_slice(&y.to_le_bytes());
            }
            Instruction::PaletteFadeCustom(args) => {
                out.push(0xB5);
                for a in args {
                    Self::assemble_expr(a, out);
                }
            }
            Instruction::StartPaletteCycle(args) => {
                out.push(0xB6);
                for a in args {
                    Self::assemble_expr(a, out);
                }
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
