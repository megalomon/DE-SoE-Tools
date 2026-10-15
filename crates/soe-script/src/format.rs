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

            let instr_str = format_instruction_with_len(&stmt.instruction, stmt.offset, stmt.snes_addr, stmt.raw_bytes.len());
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

pub fn format_instruction(instr: &Instruction, offset: usize, snes_addr: u32) -> String {
    let mut buf = Vec::new();
    crate::asm::Assembler::assemble_instruction(instr, &mut buf);
    format_instruction_with_len(instr, offset, snes_addr, buf.len())
}

pub fn format_instruction_with_len(instr: &Instruction, offset: usize, _snes_addr: u32, instr_len: usize) -> String {
    match instr {
        Instruction::End => "END".to_string(),
        Instruction::Return => "RETURN".to_string(),
        Instruction::Skip(jmp) => {
            let target = ((offset as isize + instr_len as isize + *jmp as isize) as i64 & 0xFFFF) as usize;
            format!("SKIP {:+} -> [{:04X}]", jmp, target)
        }
        Instruction::SkipNeg(jmp) => {
            let b = *jmp as u8;
            let delta = (b as isize) - 256;
            let target = ((offset as isize + delta) as i64 & 0xFFFF) as usize;
            format!("SKIP_BACK {} (delta {}) -> [{:04X}]", b, delta, target)
        }
        Instruction::Call(rom_addr) => format!("CALL ${:06X}", rom_addr),
        Instruction::Fork(rom_addr) => format!("FORK ${:06X}", rom_addr),
        Instruction::CallRelative(jmp) => {
            let target = ((offset as isize + *jmp as isize) as i64 & 0xFFFF) as usize;
            format!("CALL_REL {:+} -> [{:04X}]", jmp, target)
        }
        Instruction::CallRelativeByte(jmp) => {
            let target = ((offset as isize + *jmp as isize) as i64 & 0xFFFF) as usize;
            format!("CALL_REL {:+} -> [{:04X}]", jmp, target)
        }
        Instruction::If { cond, target_offset } => {
            let target = ((offset as isize + instr_len as isize + *target_offset as isize) as i64 & 0xFFFF) as usize;
            format!("IF {} SKIP {:+} -> [{:04X}]", format_expr(cond), target_offset, target)
        }
        Instruction::IfNot { cond, target_offset } => {
            let target = ((offset as isize + instr_len as isize + *target_offset as isize) as i64 & 0xFFFF) as usize;
            format!("IF NOT ({}) SKIP {:+} -> [{:04X}]", format_expr(cond), target_offset, target)
        }
        Instruction::IfMoneyGe { currency, amount, target_offset } => {
            let target = ((offset as isize + instr_len as isize + *target_offset as isize) as i64 & 0xFFFF) as usize;
            format!("IF MONEY[{}] >= {} SKIP {:+} -> [{:04X}]", format_expr(currency), amount, target_offset, target)
        }
        Instruction::IfMoneyLt { currency, amount, target_offset } => {
            let target = ((offset as isize + instr_len as isize + *target_offset as isize) as i64 & 0xFFFF) as usize;
            format!("IF MONEY[{}] < {} SKIP {:+} -> [{:04X}]", format_expr(currency), amount, target_offset, target)
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
        Instruction::WriteRam { addr, expr, .. } => {
            format!("RAM[$2258 + 0x{:04X}] = {}", addr, format_expr(expr))
        }
        Instruction::WriteTemp { addr, expr, .. } => {
            format!("TEMP[$2834 + 0x{:04X}] = {}", addr, format_expr(expr))
        }
        Instruction::WriteScriptArg { arg, expr, .. } => {
            format!("ARG[{}] = {}", arg, format_expr(expr))
        }
        Instruction::ShowText(id) => format!("SHOW_TEXT 0x{:04X}", id),
        Instruction::ShowTextEnd(id) => format!("SHOW_TEXT_END 0x{:04X}", id),
        Instruction::HideText => "HIDE_TEXT".to_string(),
        Instruction::GiveMoney { currency, amount } => {
            format!("GIVE_MONEY ({}) amt: {}", format_expr(currency), amount)
        }
        Instruction::TakeMoney { currency, amount } => {
            format!("TAKE_MONEY ({}) amt: {}", format_expr(currency), amount)
        }
        Instruction::GiveJewels(amount) => format!("GIVE_JEWELS {}", amount),
        Instruction::Sleep(frames) => format!("SLEEP {} frames", frames),
        Instruction::SleepWord(frames) => format!("SLEEP_ALIGNED {} frames", frames),
        Instruction::LockPlayer(arg) => format!("LOCK_PLAYER 0x{:02X}", arg),
        Instruction::UnlockPlayer(arg) => format!("UNLOCK_PLAYER 0x{:02X}", arg),
        Instruction::FadeIn => "FADE_IN".to_string(),
        Instruction::FadeOut => "FADE_OUT".to_string(),
        Instruction::SetCameraPos { x, y } => format!("SET_CAMERA_POS {}, {}", x, y),
        Instruction::PlaySound { channel, id } => format!("PLAY_SOUND ch: {}, id: 0x{:02X}", channel, id),
        Instruction::PlayMusic(id) => format!("PLAY_MUSIC id: 0x{:02X}", id),
        Instruction::CameraFollow { x, y } => format!("CAMERA_FOLLOW {}, {}", x, y),
        Instruction::ChangeMap { x, y, map } => format!("CHANGE_MAP map: 0x{:04X}, pos: ({}, {})", map, x, y),
        Instruction::ResetGame => "RESET_GAME".to_string(),
        Instruction::WaitUntil(expr) => format!("WAIT_UNTIL ({})", format_expr(expr)),
        Instruction::WaitFrame(expr) => format!("WAIT_FRAME ({})", format_expr(expr)),
        Instruction::WaitAnim(expr) => format!("WAIT_ANIM ({})", format_expr(expr)),
        Instruction::TileState { expr, word } => format!("TILE_STATE ({}) 0x{:04X}", format_expr(expr), word),
        Instruction::BgScrollX(expr) => format!("BG_SCROLL_X ({})", format_expr(expr)),
        Instruction::BgScrollY(expr) => format!("BG_SCROLL_Y ({})", format_expr(expr)),
        Instruction::BgScrollSpeed(expr) => format!("BG_SCROLL_SPEED ({})", format_expr(expr)),
        Instruction::Bg2ScrollSpeed(expr) => format!("BG2_SCROLL_SPEED ({})", format_expr(expr)),
        Instruction::GiveMoneyExpr { currency, amount } => format!("GIVE_MONEY_EXPR cur: ({}) amt: ({})", format_expr(currency), format_expr(amount)),
        Instruction::TakeMoneyExpr { currency, amount } => format!("TAKE_MONEY_EXPR cur: ({}) amt: ({})", format_expr(currency), format_expr(amount)),
        Instruction::SoundCmd28(expr) => format!("SOUND_CMD_28 ({})", format_expr(expr)),
        Instruction::SoundCmd2A(expr) => format!("SOUND_CMD_2A ({})", format_expr(expr)),
        Instruction::AddShopItem { item, count } => format!("ADD_SHOP_ITEM item: ({}) count: ({})", format_expr(item), format_expr(count)),
        Instruction::OpenShopMenu(expr) => format!("OPEN_SHOP_MENU ({})", format_expr(expr)),
        Instruction::SetBrightness(expr) => format!("SET_BRIGHTNESS ({})", format_expr(expr)),
        Instruction::SetEntityPalette { target, palette } => format!("SET_ENTITY_PALETTE target: ({}) palette: ({})", format_expr(target), format_expr(palette)),
        Instruction::DamageEntity { target, amount } => format!("DAMAGE_ENTITY target: ({}) amt: ({})", format_expr(target), format_expr(amount)),
        Instruction::HealEntity { target, amount } => format!("HEAL_ENTITY target: ({}) amt: ({})", format_expr(target), format_expr(amount)),
        Instruction::SetEntityHp { target, hp } => format!("SET_ENTITY_HP target: ({}) hp: ({})", format_expr(target), format_expr(hp)),
        Instruction::SwitchCharacter(expr) => format!("SWITCH_CHARACTER ({})", format_expr(expr)),
        Instruction::AttachCamera(expr) => format!("ATTACH_CAMERA ({})", format_expr(expr)),
        Instruction::CastAlchemy { opcode, target, spell, level, extra } => {
            let extra_str = extra.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("CAST_ALCHEMY_0x{:02X} target: ({}) spell: ({}) lvl: ({}) extra: [{}]", opcode, format_expr(target), format_expr(spell), format_expr(level), extra_str)
        }
        Instruction::TriggerEntityAction { target, action } => format!("TRIGGER_ENTITY_ACTION target: ({}) act: ({})", format_expr(target), format_expr(action)),
        Instruction::FlashScreen(expr) => format!("FLASH_SCREEN ({})", format_expr(expr)),
        Instruction::SetEntityPosRel { target, dx, dy } => format!("SET_ENTITY_POS_REL target: ({}) dx: ({}) dy: ({})", format_expr(target), format_expr(dx), format_expr(dy)),
        Instruction::DamageEntity2 { target, val } => format!("DAMAGE_ENTITY_2 target: ({}) val: ({})", format_expr(target), format_expr(val)),
        Instruction::IfEqual { left, right, target_offset } => {
            let target = ((offset as isize + instr_len as isize + *target_offset as isize) as i64 & 0xFFFF) as usize;
            format!("IF {} == {} SKIP {:+} -> [{:04X}]", format_expr(left), format_expr(right), target_offset, target)
        }
        Instruction::IfNotEqual { left, right, target_offset } => {
            let target = ((offset as isize + instr_len as isize + *target_offset as isize) as i64 & 0xFFFF) as usize;
            format!("IF {} != {} SKIP {:+} -> [{:04X}]", format_expr(left), format_expr(right), target_offset, target)
        }
        Instruction::PlayEntityAnim { target, anim, speed } => {
            format!("PLAY_ENTITY_ANIM target: ({}) anim: 0x{:04X} speed: ({})", format_expr(target), anim, format_expr(speed))
        }
        Instruction::PlayEntityAnimWait { target, anim, speed } => {
            format!("PLAY_ENTITY_ANIM_WAIT target: ({}) anim: 0x{:04X} speed: ({})", format_expr(target), anim, format_expr(speed))
        }
        Instruction::SetEntityPos { target, x, y } => {
            format!("SET_ENTITY_POS target: ({}) x: ({}) y: ({})", format_expr(target), format_expr(x), format_expr(y))
        }
        Instruction::MoveEntityTo { target, x, y } => {
            format!("MOVE_ENTITY_TO target: ({}) x: ({}) y: ({})", format_expr(target), format_expr(x), format_expr(y))
        }
        Instruction::SetEntityPosExpr { target, x, y } => {
            format!("SET_ENTITY_POS_EXPR target: ({}) x: ({}) y: ({})", format_expr(target), format_expr(x), format_expr(y))
        }
        Instruction::SetEntityPosFast { opcode, target, cx, cy } => {
            format!("SET_ENTITY_POS_FAST_0x{:02X} target: ({}) cx: {} cy: {}", opcode, format_expr(target), cx, cy)
        }
        Instruction::SetEntityPosRelFast { opcode, target, dx, dy } => {
            format!("SET_ENTITY_POS_REL_FAST_0x{:02X} target: ({}) dx: ({}) dy: ({})", opcode, format_expr(target), format_expr(dx), format_expr(dy))
        }
        Instruction::SetEntitySpeed { target, speed } => {
            format!("SET_ENTITY_SPEED target: ({}) speed: 0x{:04X}", format_expr(target), speed)
        }
        Instruction::AttachScript { target, script_id } => {
            format!("ATTACH_SCRIPT target: ({}) script: 0x{:04X}", format_expr(target), script_id)
        }
        Instruction::EntityAction { opcode, target } => {
            format!("ENTITY_ACTION_0x{:02X} target: ({})", opcode, format_expr(target))
        }
        Instruction::CameraAction9C(expr) => format!("CAMERA_ACTION_9C ({})", format_expr(expr)),
        Instruction::SpawnEntity { b1, b2, b3 } => format!("SPAWN_ENTITY {} {} {}", b1, b2, b3),
        Instruction::SpawnEntityExtra { b1, b2, b3 } => format!("SPAWN_ENTITY_EXTRA {} {} {}", b1, b2, b3),
        Instruction::SpawnNpc { npc_type, param, x, y } => {
            format!("SPAWN_NPC type: 0x{:04X} param: 0x{:04X} x: ({}) y: ({})", npc_type, param, format_expr(x), format_expr(y))
        }
        Instruction::MapEffect5C { arg1, arg2 } => {
            format!("MAP_EFFECT_5C arg1: ({}) arg2: ({})", format_expr(arg1), format_expr(arg2))
        }
        Instruction::SetTileAttr { opcode, target, attr } => {
            format!("SET_TILE_ATTR_0x{:02X} target: ({}) attr: 0x{:04X}", opcode, format_expr(target), attr)
        }
        Instruction::SetBgScroll(val) => format!("SET_BG_SCROLL 0x{:04X}", val),
        Instruction::ShowWindowText { window, text_id } => {
            format!("SHOW_WINDOW_TEXT win: {} text: 0x{:04X}", window, text_id)
        }
        Instruction::HideWindowText(window) => format!("HIDE_WINDOW_TEXT win: {}", window),
        Instruction::SetWindowSize { opcode, window, x, y, w, h } => {
            format!("SET_WINDOW_SIZE_0x{:02X} win: {} x: {} y: {} w: {} h: {}", opcode, window, x, y, w, h)
        }
        Instruction::ShowNamingScreen(target) => format!("SHOW_NAMING_SCREEN 0x{:04X}", target),
        Instruction::ShowMessage(msg_id) => format!("SHOW_MESSAGE 0x{:04X}", msg_id),
        Instruction::SetBrightnessFast(expr) => format!("SET_BRIGHTNESS_FAST ({})", format_expr(expr)),
        Instruction::SetPitch(expr) => format!("SET_PITCH ({})", format_expr(expr)),
        Instruction::SetMusicVolume(vol) => format!("SET_MUSIC_VOLUME {}", vol),
        Instruction::SoundCmd2AExpr(expr) => format!("SOUND_CMD_2A_EXPR ({})", format_expr(expr)),
        Instruction::SoundCmd2BExpr(expr) => format!("SOUND_CMD_2B_EXPR ({})", format_expr(expr)),
        Instruction::ScriptCmd4E(expr) => format!("SCRIPT_CMD_4E ({})", format_expr(expr)),
        Instruction::ScriptCmd7E { arg1, arg2, arg3, arg4 } => {
            format!("SCRIPT_CMD_7E ({}) ({}) ({}) ({})", format_expr(arg1), format_expr(arg2), format_expr(arg3), format_expr(arg4))
        }
        Instruction::WriteWramByte { target, val } => {
            format!("WRITE_WRAM_BYTE target: ({}) val: ({})", format_expr(target), format_expr(val))
        }
        Instruction::WriteWramWord { target, val } => {
            format!("WRITE_WRAM_WORD target: ({}) val: ({})", format_expr(target), format_expr(val))
        }
        Instruction::CallTableByte(idx) => format!("CALL_TABLE_BYTE {}", idx),
        Instruction::CallTableWord(idx) => format!("CALL_TABLE_WORD 0x{:04X}", idx),
        Instruction::SpawnNpcParam { npc_type, param, x, y } => {
            format!("SPAWN_NPC_PARAM type: 0x{:04X} param: 0x{:04X} pos: ({}, {})", npc_type, param, x, y)
        }
        Instruction::ResetWindowDefaults(win) => format!("RESET_WINDOW_DEFAULTS win: {}", win),
        Instruction::LockPlayerFast { opcode } => format!("LOCK_PLAYER_FAST_0x{:02X}", opcode),
        Instruction::UnlockPlayerFast { opcode } => format!("UNLOCK_PLAYER_FAST_0x{:02X}", opcode),
        Instruction::CallParams { args, addr } => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("CALL_PARAMS 0x{:06X} [{}]", addr, a_str)
        }
        Instruction::CallTableByteParams { args, idx } => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("CALL_TABLE_BYTE_PARAMS {} [{}]", idx, a_str)
        }
        Instruction::CallTableWordParams { args, idx } => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("CALL_TABLE_WORD_PARAMS 0x{:04X} [{}]", idx, a_str)
        }
        Instruction::CallRelativeByteParams { args, offset } => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("CALL_REL_BYTE_PARAMS {:+} [{}]", offset, a_str)
        }
        Instruction::CallRelativeWordParams { args, offset } => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("CALL_REL_WORD_PARAMS {:+} [{}]", offset, a_str)
        }
        Instruction::ForkParams { args, addr } => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("FORK_PARAMS 0x{:06X} [{}]", addr, a_str)
        }
        Instruction::Yield { opcode } => format!("YIELD_0x{:02X}", opcode),
        Instruction::NopSkipByte(b) => format!("NOP_SKIP_BYTE {}", b),
        Instruction::Nop => "NOP".to_string(),
        Instruction::FadeInMusic => "FADE_IN_MUSIC".to_string(),
        Instruction::FadeOutMusic => "FADE_OUT_MUSIC".to_string(),
        Instruction::DisableInterrupts => "DISABLE_INTERRUPTS".to_string(),
        Instruction::EnableInterrupts => "ENABLE_INTERRUPTS".to_string(),
        Instruction::WaitPathEnd => "WAIT_PATH_END".to_string(),
        Instruction::EnableBg1 => "ENABLE_BG1".to_string(),
        Instruction::DisableBg1 => "DISABLE_BG1".to_string(),
        Instruction::EnableBg2 => "ENABLE_BG2".to_string(),
        Instruction::DisableBg2 => "DISABLE_BG2".to_string(),
        Instruction::EntityFaceEntity { a, b } => {
            format!("ENTITY_FACE_ENTITY ({}) ({})", format_expr(a), format_expr(b))
        }
        Instruction::FaceEachOther { a, b } => {
            format!("FACE_EACH_OTHER ({}) ({})", format_expr(a), format_expr(b))
        }
        Instruction::ShowHudAll => "SHOW_HUD_ALL".to_string(),
        Instruction::HideHudAll => "HIDE_HUD_ALL".to_string(),
        Instruction::RestoreMainScreenLayers => "RESTORE_MAIN_SCREEN_LAYERS".to_string(),
        Instruction::SetSubScreenLayers => "SET_SUB_SCREEN_LAYERS".to_string(),
        Instruction::ClearShopMenu => "CLEAR_SHOP_MENU".to_string(),
        Instruction::SetCameraBase { x, y } => {
            format!("SET_CAMERA_BASE ({}) ({})", format_expr(x), format_expr(y))
        }
        Instruction::ShakeScreenComplex(args) => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("SHAKE_SCREEN_COMPLEX [{}]", a_str)
        }
        Instruction::EnterMode7Map(args) => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("ENTER_MODE7_MAP [{}]", a_str)
        }
        Instruction::ShowCurrencyHud => "SHOW_CURRENCY_HUD".to_string(),
        Instruction::UpdateCurrencyHud => "UPDATE_CURRENCY_HUD".to_string(),
        Instruction::HideCurrencyHud => "HIDE_CURRENCY_HUD".to_string(),
        Instruction::SetCanineAiTargeting => "SET_CANINE_AI_TARGETING".to_string(),
        Instruction::SetRamPairsX8 { w1, w2, b1, b2 } => {
            format!("SET_RAM_PAIRS_X8 w1: 0x{:04X} w2: 0x{:04X} b1: {} b2: {}", w1, w2, b1, b2)
        }
        Instruction::SetTempPairsX8 { w1, w2, b1, b2 } => {
            format!("SET_TEMP_PAIRS_X8 w1: 0x{:04X} w2: 0x{:04X} b1: {} b2: {}", w1, w2, b1, b2)
        }
        Instruction::SetArgPairsX8 { arg1, arg2, b1, b2 } => {
            format!("SET_ARG_PAIRS_X8 arg1: {} arg2: {} b1: {} b2: {}", arg1, arg2, b1, b2)
        }
        Instruction::SetNpcScript { target, w1, w2 } => {
            format!("SET_NPC_SCRIPT target: ({}) w1: 0x{:04X} w2: 0x{:04X}", format_expr(target), w1, w2)
        }
        Instruction::SetAmbientActorPos { id, x, y } => {
            format!("SET_AMBIENT_ACTOR_POS id: {} pos: ({}, {})", id, x, y)
        }
        Instruction::PaletteFadeCustom(args) => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("PALETTE_FADE_CUSTOM [{}]", a_str)
        }
        Instruction::StartPaletteCycle(args) => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("START_PALETTE_CYCLE [{}]", a_str)
        }
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
        Instruction::Skip(jmp) => format!("skip({:+});", jmp),
        Instruction::SkipNeg(jmp) => {
            let b = *jmp as u8;
            let delta = (b as i16) - 256;
            format!("skip({});", delta)
        }
        Instruction::Call(rom_addr) => format!("call(0x{:06X});", rom_addr),
        Instruction::Fork(rom_addr) => format!("fork(0x{:06X});", rom_addr),
        Instruction::CallRelative(jmp) => format!("call_rel({:+});", jmp),
        Instruction::CallRelativeByte(jmp) => format!("call_rel({:+});", jmp),
        Instruction::If { cond, target_offset } => {
            format!("if ({}) skip({:+});", format_expr(cond), target_offset)
        }
        Instruction::IfNot { cond, target_offset } => {
            format!("if (!({})) skip({:+});", format_expr(cond), target_offset)
        }
        Instruction::IfMoneyGe { currency, amount, target_offset } => {
            format!("if (money({}) >= {}) skip({:+});", format_expr(currency), amount, target_offset)
        }
        Instruction::IfMoneyLt { currency, amount, target_offset } => {
            format!("if (money({}) < {}) skip({:+});", format_expr(currency), amount, target_offset)
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
            format!("RAM[0x{:04X}] = 0x{:04X};", addr, val)
        }
        Instruction::WriteRam { addr, expr, .. } => {
            format!("RAM[0x{:04X}] = {};", addr, format_expr(expr))
        }
        Instruction::WriteTemp { addr, expr, .. } => {
            format!("TEMP[0x{:04X}] = {};", addr, format_expr(expr))
        }
        Instruction::WriteScriptArg { arg, expr, .. } => {
            format!("arg({}) = {};", arg, format_expr(expr))
        }
        Instruction::ShowText(id) => format!("show_text(0x{:04X});", id),
        Instruction::ShowTextEnd(id) => format!("show_text_end(0x{:04X});", id),
        Instruction::HideText => "hide_text();".to_string(),
        Instruction::GiveMoney { currency, amount } => {
            format!("give_money({}, {});", format_expr(currency), amount)
        }
        Instruction::TakeMoney { currency, amount } => {
            format!("take_money({}, {});", format_expr(currency), amount)
        }
        Instruction::GiveJewels(amount) => format!("give_jewels({});", amount),
        Instruction::Sleep(frames) => format!("sleep({});", frames),
        Instruction::SleepWord(frames) => format!("sleep_aligned({});", frames),
        Instruction::LockPlayer(arg) => format!("lock_player(0x{:02X});", arg),
        Instruction::UnlockPlayer(arg) => format!("unlock_player(0x{:02X});", arg),
        Instruction::FadeIn => "fade_in();".to_string(),
        Instruction::FadeOut => "fade_out();".to_string(),
        Instruction::SetCameraPos { x, y } => format!("set_camera_pos({}, {});", x, y),
        Instruction::CameraFollow { x, y } => format!("camera_follow({}, {});", x, y),
        Instruction::ChangeMap { x, y, map } => format!("change_map({}, {}, 0x{:04X});", x, y, map),
        Instruction::ResetGame => "reset_game();".to_string(),
        Instruction::WaitUntil(expr) => format!("wait_until({});", format_expr(expr)),
        Instruction::WaitFrame(expr) => format!("wait_frame({});", format_expr(expr)),
        Instruction::WaitAnim(expr) => format!("wait_anim({});", format_expr(expr)),
        Instruction::TileState { expr, word } => format!("tile_state({}, 0x{:04X});", format_expr(expr), word),
        Instruction::BgScrollX(expr) => format!("bg_scroll_x({});", format_expr(expr)),
        Instruction::BgScrollY(expr) => format!("bg_scroll_y({});", format_expr(expr)),
        Instruction::BgScrollSpeed(expr) => format!("bg_scroll_speed({});", format_expr(expr)),
        Instruction::Bg2ScrollSpeed(expr) => format!("bg2_scroll_speed({});", format_expr(expr)),
        Instruction::GiveMoneyExpr { currency, amount } => format!("give_money_expr({}, {});", format_expr(currency), format_expr(amount)),
        Instruction::TakeMoneyExpr { currency, amount } => format!("take_money_expr({}, {});", format_expr(currency), format_expr(amount)),
        Instruction::SoundCmd28(expr) => format!("sound_cmd_28({});", format_expr(expr)),
        Instruction::SoundCmd2A(expr) => format!("sound_cmd_2a({});", format_expr(expr)),
        Instruction::AddShopItem { item, count } => format!("add_shop_item({}, {});", format_expr(item), format_expr(count)),
        Instruction::OpenShopMenu(expr) => format!("open_shop_menu({});", format_expr(expr)),
        Instruction::SetBrightness(expr) => format!("set_brightness({});", format_expr(expr)),
        Instruction::SetEntityPalette { target, palette } => format!("set_entity_palette({}, {});", format_expr(target), format_expr(palette)),
        Instruction::DamageEntity { target, amount } => format!("damage_entity({}, {});", format_expr(target), format_expr(amount)),
        Instruction::HealEntity { target, amount } => format!("heal_entity({}, {});", format_expr(target), format_expr(amount)),
        Instruction::SetEntityHp { target, hp } => format!("set_entity_hp({}, {});", format_expr(target), format_expr(hp)),
        Instruction::PlaySound { channel, id } => format!("play_sound({}, 0x{:02X});", channel, id),
        Instruction::PlayMusic(id) => format!("play_music(0x{:02X});", id),
        Instruction::SwitchCharacter(expr) => format!("switch_character({});", format_expr(expr)),
        Instruction::AttachCamera(expr) => format!("attach_camera({});", format_expr(expr)),
        Instruction::CastAlchemy { opcode, target, spell, level, extra } => {
            let extra_str = extra.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("cast_alchemy_0x{:02X}({}, {}, {}, [{}]);", opcode, format_expr(target), format_expr(spell), format_expr(level), extra_str)
        }
        Instruction::TriggerEntityAction { target, action } => format!("trigger_entity_action({}, {});", format_expr(target), format_expr(action)),
        Instruction::FlashScreen(expr) => format!("flash_screen({});", format_expr(expr)),
        Instruction::SetEntityPosRel { target, dx, dy } => format!("set_entity_pos_rel({}, {}, {});", format_expr(target), format_expr(dx), format_expr(dy)),
        Instruction::DamageEntity2 { target, val } => format!("damage_entity_2({}, {});", format_expr(target), format_expr(val)),
        Instruction::IfEqual { left, right, target_offset } => {
            format!("if ({} == {}) skip({:+});", format_expr(left), format_expr(right), target_offset)
        }
        Instruction::IfNotEqual { left, right, target_offset } => {
            format!("if ({} != {}) skip({:+});", format_expr(left), format_expr(right), target_offset)
        }
        Instruction::PlayEntityAnim { target, anim, speed } => {
            format!("play_entity_anim({}, 0x{:04X}, {});", format_expr(target), anim, format_expr(speed))
        }
        Instruction::PlayEntityAnimWait { target, anim, speed } => {
            format!("play_entity_anim_wait({}, 0x{:04X}, {});", format_expr(target), anim, format_expr(speed))
        }
        Instruction::SetEntityPos { target, x, y } => {
            format!("set_entity_pos({}, {}, {});", format_expr(target), format_expr(x), format_expr(y))
        }
        Instruction::MoveEntityTo { target, x, y } => {
            format!("move_entity_to({}, {}, {});", format_expr(target), format_expr(x), format_expr(y))
        }
        Instruction::SetEntityPosExpr { target, x, y } => {
            format!("set_entity_pos_expr({}, {}, {});", format_expr(target), format_expr(x), format_expr(y))
        }
        Instruction::SetEntityPosFast { opcode, target, cx, cy } => {
            format!("set_entity_pos_fast_0x{:02X}({}, {}, {});", opcode, format_expr(target), cx, cy)
        }
        Instruction::SetEntityPosRelFast { opcode, target, dx, dy } => {
            format!("set_entity_pos_rel_fast_0x{:02X}({}, {}, {});", opcode, format_expr(target), format_expr(dx), format_expr(dy))
        }
        Instruction::SetEntitySpeed { target, speed } => {
            format!("set_entity_speed({}, 0x{:04X});", format_expr(target), speed)
        }
        Instruction::AttachScript { target, script_id } => {
            format!("attach_script({}, 0x{:04X});", format_expr(target), script_id)
        }
        Instruction::EntityAction { opcode, target } => {
            format!("entity_action_0x{:02X}({});", opcode, format_expr(target))
        }
        Instruction::CameraAction9C(expr) => format!("camera_action_9c({});", format_expr(expr)),
        Instruction::SpawnEntity { b1, b2, b3 } => format!("spawn_entity({}, {}, {});", b1, b2, b3),
        Instruction::SpawnEntityExtra { b1, b2, b3 } => format!("spawn_entity_extra({}, {}, {});", b1, b2, b3),
        Instruction::SpawnNpc { npc_type, param, x, y } => {
            format!("spawn_npc(0x{:04X}, 0x{:04X}, {}, {});", npc_type, param, format_expr(x), format_expr(y))
        }
        Instruction::MapEffect5C { arg1, arg2 } => {
            format!("map_effect_5c({}, {});", format_expr(arg1), format_expr(arg2))
        }
        Instruction::SetTileAttr { opcode, target, attr } => {
            format!("set_tile_attr_0x{:02X}({}, 0x{:04X});", opcode, format_expr(target), attr)
        }
        Instruction::SetBgScroll(val) => format!("set_bg_scroll(0x{:04X});", val),
        Instruction::ShowWindowText { window, text_id } => {
            format!("show_window_text({}, 0x{:04X});", window, text_id)
        }
        Instruction::HideWindowText(window) => format!("hide_window_text({});", window),
        Instruction::SetWindowSize { opcode, window, x, y, w, h } => {
            format!("set_window_size_0x{:02X}({}, {}, {}, {}, {});", opcode, window, x, y, w, h)
        }
        Instruction::ShowNamingScreen(target) => format!("show_naming_screen(0x{:04X});", target),
        Instruction::ShowMessage(msg_id) => format!("show_message(0x{:04X});", msg_id),
        Instruction::SetBrightnessFast(expr) => format!("set_brightness_fast({});", format_expr(expr)),
        Instruction::SetPitch(expr) => format!("set_pitch({});", format_expr(expr)),
        Instruction::SetMusicVolume(vol) => format!("set_music_volume({});", vol),
        Instruction::SoundCmd2AExpr(expr) => format!("sound_cmd_2a_expr({});", format_expr(expr)),
        Instruction::SoundCmd2BExpr(expr) => format!("sound_cmd_2b_expr({});", format_expr(expr)),
        Instruction::ScriptCmd4E(expr) => format!("script_cmd_4e({});", format_expr(expr)),
        Instruction::ScriptCmd7E { arg1, arg2, arg3, arg4 } => {
            format!("script_cmd_7e({}, {}, {}, {});", format_expr(arg1), format_expr(arg2), format_expr(arg3), format_expr(arg4))
        }
        Instruction::WriteWramByte { target, val } => {
            format!("write_wram_byte({}, {});", format_expr(target), format_expr(val))
        }
        Instruction::WriteWramWord { target, val } => {
            format!("write_wram_word({}, {});", format_expr(target), format_expr(val))
        }
        Instruction::CallTableByte(idx) => format!("call_table_byte({});", idx),
        Instruction::CallTableWord(idx) => format!("call_table_word(0x{:04X});", idx),
        Instruction::SpawnNpcParam { npc_type, param, x, y } => {
            format!("spawn_npc_param(0x{:04X}, 0x{:04X}, {}, {});", npc_type, param, x, y)
        }
        Instruction::ResetWindowDefaults(win) => format!("reset_window_defaults({});", win),
        Instruction::LockPlayerFast { opcode } => format!("lock_player_fast_0x{:02X}();", opcode),
        Instruction::UnlockPlayerFast { opcode } => format!("unlock_player_fast_0x{:02X}();", opcode),
        Instruction::CallParams { args, addr } => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("call_params(0x{:06X}, [{}]);", addr, a_str)
        }
        Instruction::CallTableByteParams { args, idx } => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("call_table_byte_params({}, [{}]);", idx, a_str)
        }
        Instruction::CallTableWordParams { args, idx } => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("call_table_word_params(0x{:04X}, [{}]);", idx, a_str)
        }
        Instruction::CallRelativeByteParams { args, offset } => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("call_rel_byte_params({:+}, [{}]);", offset, a_str)
        }
        Instruction::CallRelativeWordParams { args, offset } => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("call_rel_word_params({:+}, [{}]);", offset, a_str)
        }
        Instruction::ForkParams { args, addr } => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("fork_params(0x{:06X}, [{}]);", addr, a_str)
        }
        Instruction::Yield { opcode } => format!("yield_0x{:02X}();", opcode),
        Instruction::NopSkipByte(b) => format!("nop_skip_byte({});", b),
        Instruction::Nop => "nop();".to_string(),
        Instruction::FadeInMusic => "fade_in_music();".to_string(),
        Instruction::FadeOutMusic => "fade_out_music();".to_string(),
        Instruction::DisableInterrupts => "disable_interrupts();".to_string(),
        Instruction::EnableInterrupts => "enable_interrupts();".to_string(),
        Instruction::WaitPathEnd => "wait_path_end();".to_string(),
        Instruction::EnableBg1 => "enable_bg1();".to_string(),
        Instruction::DisableBg1 => "disable_bg1();".to_string(),
        Instruction::EnableBg2 => "enable_bg2();".to_string(),
        Instruction::DisableBg2 => "disable_bg2();".to_string(),
        Instruction::EntityFaceEntity { a, b } => {
            format!("entity_face_entity({}, {});", format_expr(a), format_expr(b))
        }
        Instruction::FaceEachOther { a, b } => {
            format!("face_each_other({}, {});", format_expr(a), format_expr(b))
        }
        Instruction::ShowHudAll => "show_hud_all();".to_string(),
        Instruction::HideHudAll => "hide_hud_all();".to_string(),
        Instruction::RestoreMainScreenLayers => "restore_main_screen_layers();".to_string(),
        Instruction::SetSubScreenLayers => "set_sub_screen_layers();".to_string(),
        Instruction::ClearShopMenu => "clear_shop_menu();".to_string(),
        Instruction::SetCameraBase { x, y } => {
            format!("set_camera_base({}, {});", format_expr(x), format_expr(y))
        }
        Instruction::ShakeScreenComplex(args) => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("shake_screen_complex([{}]);", a_str)
        }
        Instruction::EnterMode7Map(args) => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("enter_mode7_map([{}]);", a_str)
        }
        Instruction::ShowCurrencyHud => "show_currency_hud();".to_string(),
        Instruction::UpdateCurrencyHud => "update_currency_hud();".to_string(),
        Instruction::HideCurrencyHud => "hide_currency_hud();".to_string(),
        Instruction::SetCanineAiTargeting => "set_canine_ai_targeting();".to_string(),
        Instruction::SetRamPairsX8 { w1, w2, b1, b2 } => {
            format!("set_ram_pairs_x8(0x{:04X}, 0x{:04X}, {}, {});", w1, w2, b1, b2)
        }
        Instruction::SetTempPairsX8 { w1, w2, b1, b2 } => {
            format!("set_temp_pairs_x8(0x{:04X}, 0x{:04X}, {}, {});", w1, w2, b1, b2)
        }
        Instruction::SetArgPairsX8 { arg1, arg2, b1, b2 } => {
            format!("set_arg_pairs_x8({}, {}, {}, {});", arg1, arg2, b1, b2)
        }
        Instruction::SetNpcScript { target, w1, w2 } => {
            format!("set_npc_script({}, 0x{:04X}, 0x{:04X});", format_expr(target), w1, w2)
        }
        Instruction::SetAmbientActorPos { id, x, y } => {
            format!("set_ambient_actor_pos({}, 0x{:04X}, 0x{:04X});", id, x, y)
        }
        Instruction::PaletteFadeCustom(args) => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("palette_fade_custom([{}]);", a_str)
        }
        Instruction::StartPaletteCycle(args) => {
            let a_str = args.iter().map(format_expr).collect::<Vec<_>>().join(", ");
            format!("start_palette_cycle([{}]);", a_str)
        }
        Instruction::Raw { opcode, payload } => {
            let p_hex = payload.iter().map(|b| format!("0x{:02X}", b)).collect::<Vec<_>>().join(", ");
            format!("raw(0x{:02X}, [{}]);", opcode, p_hex)
        }
    }
}

pub fn format_expr(expr: &Expr) -> String {
    match expr {
        Expr::Const { val, .. } => format!("{}", val),
        Expr::Flag { base, bit_index } => {
            let prefix = match base {
                FlagBase::Ram => "FLAG",
                FlagBase::Temp => "TEMP_FLAG",
            };
            format!("{}[0x{:04X}]", prefix, bit_index)
        }
        Expr::RamByteSigned(addr) => format!("RAM_BYTE_S[0x{:04X}]", addr),
        Expr::RamByteUnsigned(addr) => format!("RAM_BYTE[0x{:04X}]", addr),
        Expr::RamWordSigned(addr) => format!("RAM_S[0x{:04X}]", addr),
        Expr::RamWordUnsigned(addr) => format!("RAM[0x{:04X}]", addr),
        Expr::TempByteSigned(addr) => format!("TEMP_BYTE_S[0x{:04X}]", addr),
        Expr::TempByteUnsigned(addr) => format!("TEMP_BYTE[0x{:04X}]", addr),
        Expr::TempWordSigned(addr) => format!("TEMP_S[0x{:04X}]", addr),
        Expr::TempWordUnsigned(addr) => format!("TEMP[0x{:04X}]", addr),
        Expr::ArgBit(bit) => format!("ARG_BIT[{}]", bit),
        Expr::ArgByteSigned(arg) => format!("ARG_BYTE_S[{}]", arg),
        Expr::ArgByteUnsigned(arg) => format!("ARG_BYTE[{}]", arg),
        Expr::ArgWordSigned(arg) => format!("ARG_WORD_S[{}]", arg),
        Expr::ArgWordUnsigned(arg) => format!("ARG_WORD[{}]", arg),
        Expr::TriggerActor => "trigger_actor()".to_string(),
        Expr::TaskWord0D => "task_word_0d()".to_string(),
        Expr::TaskWord09 => "task_word_09()".to_string(),
        Expr::DerefWord(e) => format!("deref_word({})", format_expr(e)),
        Expr::DerefByte(e) => format!("deref_byte({})", format_expr(e)),
        Expr::IsPartnerControlled => "is_partner_controlled()".to_string(),
        Expr::FrameTimerLo => "frame_timer_lo()".to_string(),
        Expr::FrameTimerHi => "frame_timer_hi()".to_string(),
        Expr::QueryStatusA(e) => format!("query_status_a({})", format_expr(e)),
        Expr::QueryStatusB(e) => format!("query_status_b({})", format_expr(e)),
        Expr::EntityStatDiff(e) => format!("entity_stat_diff({})", format_expr(e)),
        Expr::Entity(ent) => format!("{:?}", ent),
        Expr::Rng => "rnd()".to_string(),
        Expr::RngRange(r) => format!("rnd_range({})", format_expr(r)),
        Expr::DialogResponse(p) => match p {
            Some(param) => format!("dialog_response({})", format_expr(param)),
            None => "dialog_response()".to_string(),
        },
        Expr::Unary { op, expr } => {
            let op_str = match op {
                UnaryOp::Not => "!",
                UnaryOp::BitNot => "~",
                UnaryOp::Neg => "-",
            };
            format!("{}{}", op_str, format_expr(expr))
        }
        Expr::RawUnary { op, expr } => format!("UNARY_0x{:02X}({})", op, format_expr(expr)),
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
        Expr::RawToken(tok) => format!("TOKEN(0x{:02X})", tok),
        Expr::Raw(r) => format!("RAW({:?})", r),
    }
}
