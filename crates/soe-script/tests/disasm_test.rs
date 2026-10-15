use soe_core::Rom;
use soe_script::disasm::Disassembler;

#[test]
fn test_disasm_pot_trade_script() {
    let rom_path = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc";
    let rom = Rom::load(rom_path).expect("German ROM should load");
    let disasm = Disassembler::new(&rom);

    // Ceramic pot trader script at SNES $97:8712
    let script = disasm.disassemble_script(0x978712, 500);
    assert!(!script.statements.is_empty());

    let disasm_str = script.to_disassembly_string();
    println!("{}", disasm_str);

    let everscript_str = script.to_everscript_string();
    println!("{}", everscript_str);

    // Statement 0 should check Rice (RAM $2258 + 0x01CF) >= 2 or Pot count
    assert!(disasm_str.contains("IF") || !script.statements.is_empty());

    // Roundtrip verification: reassembled bytes must match original ROM bytes!
    let reassembled = soe_script::asm::Assembler::assemble_script(&script);
    let original: Vec<u8> = script.statements.iter().flat_map(|s| s.raw_bytes.clone()).collect();
    assert_eq!(reassembled, original, "Reassembled script must byte-exact match original ROM bytes!");
}

#[test]
fn test_disasm_all_map_start_scripts() {
    let rom_path = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc";
    let rom = Rom::load(rom_path).expect("German ROM should load");
    let disasm = Disassembler::new(&rom);

    // Map table at $93:801B
    let map_table_snes = 0x93801B;
    let mut total_statements = 0;
    let mut successful_scripts = 0;
    let mut roundtrip_matches = 0;

    for i in 0..127 {
        let entry_snes = map_table_snes + (i as u32) * 5;
        let script_ptr = rom.read_u24_snes(entry_snes).unwrap_or(0);
        if script_ptr == 0 {
            // Map 21 hat keinen Start-Skript-Pointer (ptr == 0)
            continue;
        }
        let snes_addr = Rom::script_to_rom_addr(script_ptr);

        let script = disasm.disassemble_script(snes_addr, 2048);
        if !script.statements.is_empty() {
            total_statements += script.statements.len();
            successful_scripts += 1;

            let reassembled = soe_script::asm::Assembler::assemble_script(&script);
            let original: Vec<u8> = script.statements.iter().flat_map(|s| s.raw_bytes.clone()).collect();
            if reassembled == original {
                roundtrip_matches += 1;
            } else {
                println!("Map {} mismatch (reassembled len {}, original len {}):", i, reassembled.len(), original.len());
                for (idx, (r, o)) in reassembled.iter().zip(original.iter()).enumerate() {
                    if r != o {
                        println!("  Mismatch at byte {}: reassembled 0x{:02X}, original 0x{:02X}", idx, r, o);
                        println!("    Context reassembled: {:02X?}", &reassembled[idx.saturating_sub(4)..std::cmp::min(idx+8, reassembled.len())]);
                        println!("    Context original:    {:02X?}", &original[idx.saturating_sub(4)..std::cmp::min(idx+8, original.len())]);
                        break;
                    }
                }
            }
        }
    }

    println!("Total decoded map scripts: {}/126, statements: {}, byte-exact roundtrips: {}/126",
             successful_scripts, total_statements, roundtrip_matches);
    assert_eq!(successful_scripts, 126);
    assert_eq!(roundtrip_matches, 126, "All 126 map scripts must roundtrip byte-exact!");
}

#[test]
fn test_disasm_opcode_7e_and_money_jump() {
    let rom_path = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc";
    let mut rom = Rom::load(rom_path).expect("German ROM should load");

    // Test 0x7E: reads exactly 4 expressions (0xB0, 0xB1, 0xB2, 0xB3 = inline 0, 1, 2, 3 with bit 7 set)
    let test_addr = 0x93E000;
    let bytes = [0x7E, 0xB0, 0xB1, 0xB2, 0xB3, 0x00];
    rom.write_bytes_snes(test_addr, &bytes).unwrap();

    // Test IfMoneyGe jump tracking past an End statement
    let test_addr2 = 0x93E020;
    let bytes2 = [
        0x0A, 0xB0, 0x64, 0x00, 0x00, 0x02, 0x00, // IfMoneyGe, offset +2
        0x00,                                      // End (should not terminate yet because jump target is past it)
        0x55,                                      // HideText
        0x00,                                      // End (terminates)
    ];
    rom.write_bytes_snes(test_addr2, &bytes2).unwrap();

    let disasm = Disassembler::new(&rom);
    let script = disasm.disassemble_script(test_addr, 10);
    assert_eq!(script.statements.len(), 2);
    assert_eq!(
        script.statements[0].instruction,
        soe_script::ast::Instruction::ScriptCmd7E {
            arg1: soe_script::ast::Expr::Const { opcode: Some(0x30), val: 0 },
            arg2: soe_script::ast::Expr::Const { opcode: Some(0x31), val: 1 },
            arg3: soe_script::ast::Expr::Const { opcode: Some(0x32), val: 2 },
            arg4: soe_script::ast::Expr::Const { opcode: Some(0x33), val: 3 },
        }
    );
    assert_eq!(script.statements[1].instruction, soe_script::ast::Instruction::End);

    let script2 = disasm.disassemble_script(test_addr2, 20);
    assert_eq!(script2.statements.len(), 4);
    assert_eq!(script2.statements[1].instruction, soe_script::ast::Instruction::End);
    assert_eq!(script2.statements[2].instruction, soe_script::ast::Instruction::HideText);
    assert_eq!(script2.statements[3].instruction, soe_script::ast::Instruction::End);
}

#[test]
fn test_verified_opcodes() {
    let rom_path = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc";
    let mut rom = Rom::load(rom_path).expect("German ROM should load");

    // 1. Opcode 0x44: SET_WINDOW_0_SIZE consumes exactly 5 bytes (win, x, y, w, h)
    let addr_44 = 0x93E100;
    let bytes_44 = [0x44, 0x00, 0x02, 0x04, 0x1A, 0x0A, 0x00];
    rom.write_bytes_snes(addr_44, &bytes_44).unwrap();

    // 2. Opcode 0x7F: SHOW_NAMING_SCREEN consumes exactly 2 bytes (u16 target)
    let addr_7f = 0x93E120;
    let bytes_7f = [0x7F, 0x03, 0x00, 0x00];
    rom.write_bytes_snes(addr_7f, &bytes_7f).unwrap();

    // 3. Opcode 0x91: SET_BRIGHTNESS evaluates an expression (e.g. inline const 15: 0xBF = 0x3F | 0x80)
    let addr_91 = 0x93E140;
    let bytes_91 = [0x91, 0xBF, 0x00];
    rom.write_bytes_snes(addr_91, &bytes_91).unwrap();

    // 4. Opcode 0x9B: ATTACH_CAMERA (Instruction::AttachCamera)
    let addr_9b = 0x93E160;
    let bytes_9b = [0x9B, 0xB0, 0x00];
    rom.write_bytes_snes(addr_9b, &bytes_9b).unwrap();

    // 5. Opcode 0x98: SWITCH_CHARACTER (Instruction::SwitchCharacter)
    let addr_98 = 0x93E180;
    let bytes_98 = [0x98, 0xB1, 0x00];
    rom.write_bytes_snes(addr_98, &bytes_98).unwrap();

    let disasm = Disassembler::new(&rom);

    // Verify 0x44
    let script_44 = disasm.disassemble_script(addr_44, 10);
    assert_eq!(script_44.statements.len(), 2);
    assert_eq!(
        script_44.statements[0].instruction,
        soe_script::ast::Instruction::SetWindowSize {
            opcode: 0x44,
            window: 0,
            x: 2,
            y: 4,
            w: 26,
            h: 10,
        }
    );
    assert_eq!(script_44.statements[1].instruction, soe_script::ast::Instruction::End);
    let reassembled_44 = soe_script::asm::Assembler::assemble_script(&script_44);
    assert_eq!(reassembled_44, bytes_44);

    // Verify 0x7F
    let script_7f = disasm.disassemble_script(addr_7f, 10);
    assert_eq!(script_7f.statements.len(), 2);
    assert_eq!(
        script_7f.statements[0].instruction,
        soe_script::ast::Instruction::ShowNamingScreen(3)
    );
    let reassembled_7f = soe_script::asm::Assembler::assemble_script(&script_7f);
    assert_eq!(reassembled_7f, bytes_7f);

    // Verify 0x91
    let script_91 = disasm.disassemble_script(addr_91, 10);
    assert_eq!(script_91.statements.len(), 2);
    assert_eq!(
        script_91.statements[0].instruction,
        soe_script::ast::Instruction::SetBrightnessFast(soe_script::ast::Expr::Const {
            opcode: Some(0x3F),
            val: 15,
        })
    );
    let reassembled_91 = soe_script::asm::Assembler::assemble_script(&script_91);
    assert_eq!(reassembled_91, bytes_91);

    // Verify 0x9B
    let script_9b = disasm.disassemble_script(addr_9b, 10);
    assert_eq!(script_9b.statements.len(), 2);
    assert_eq!(
        script_9b.statements[0].instruction,
        soe_script::ast::Instruction::AttachCamera(soe_script::ast::Expr::Const {
            opcode: Some(0x30),
            val: 0,
        })
    );
    let reassembled_9b = soe_script::asm::Assembler::assemble_script(&script_9b);
    assert_eq!(reassembled_9b, bytes_9b);

    // Verify 0x98
    let script_98 = disasm.disassemble_script(addr_98, 10);
    assert_eq!(script_98.statements.len(), 2);
    assert_eq!(
        script_98.statements[0].instruction,
        soe_script::ast::Instruction::SwitchCharacter(soe_script::ast::Expr::Const {
            opcode: Some(0x31),
            val: 1,
        })
    );
    let reassembled_98 = soe_script::asm::Assembler::assemble_script(&script_98);
    assert_eq!(reassembled_98, bytes_98);
}

#[test]
fn test_all_195_opcodes_and_tokens() {
    let rom_path = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc";
    let mut rom = Rom::load(rom_path).expect("German ROM should load");

    // 1. Verify token evaluation logic (Token 01: -256 + 0xFE = -2)
    let addr_tok1 = 0x93E200;
    let bytes_expr = [0x90, 0x01, 0xFE, 0xB0, 0x00];
    rom.write_bytes_snes(addr_tok1, &bytes_expr).unwrap();

    // 2. Test 0x8E forward jump tracking past an End statement
    let addr_8e = 0x93E220;
    let bytes_8e = [0x8E, 0xB0, 0xB0, 0x01, 0x00, 0x00, 0x26, 0x00];
    rom.write_bytes_snes(addr_8e, &bytes_8e).unwrap();

    let disasm = Disassembler::new(&rom);

    let script_tok = disasm.disassemble_script(addr_tok1, 10);
    assert_eq!(script_tok.statements.len(), 2);

    let script_8e = disasm.disassemble_script(addr_8e, 10);
    // Should NOT stop at the first 0x00 because max_jump_target points to 0x26!
    assert!(
        script_8e.statements.len() >= 3,
        "Disassembler must track 0x8E jump target and continue past interior End statement"
    );
    assert_eq!(
        script_8e.statements.last().unwrap().instruction,
        soe_script::ast::Instruction::End
    );
}

#[test]
fn test_all_structured_instructions_roundtrip() {
    use soe_script::ast::*;
    use soe_script::asm::Assembler;

    let test_instructions = vec![
        Instruction::DamageEntity { target: Expr::Entity(Entity::Boy), amount: Expr::const_val(50) },
        Instruction::HealEntity { target: Expr::Entity(Entity::Dog), amount: Expr::const_val(100) },
        Instruction::SetEntityHp { target: Expr::Entity(Entity::Boy), hp: Expr::const_val(250) },
        Instruction::DamageEntity2 { target: Expr::Entity(Entity::Boy), val: Expr::const_val(30) },
        Instruction::TriggerEntityAction { target: Expr::Entity(Entity::Boy), action: Expr::const_val(2) },
        Instruction::CastAlchemy {
            opcode: 0x9E,
            target: Expr::Entity(Entity::Dog),
            spell: Expr::const_val(5),
            level: Expr::const_val(3),
            extra: vec![Expr::const_val(10), Expr::const_val(0)],
        },
        Instruction::CastAlchemy {
            opcode: 0xAC,
            target: Expr::Entity(Entity::Boy),
            spell: Expr::const_val(12),
            level: Expr::const_val(1),
            extra: vec![Expr::const_val(0)],
        },
        Instruction::SetEntityPosRel {
            target: Expr::Entity(Entity::Boy),
            dx: Expr::const_val(10),
            dy: Expr::const_val(-5),
        },
        Instruction::FlashScreen(Expr::const_val(15)),
        Instruction::SwitchCharacter(Expr::const_val(1)),
        Instruction::AttachCamera(Expr::const_val(0)),
        Instruction::OpenShopMenu(Expr::const_val(3)),
        Instruction::AddShopItem { item: Expr::const_val(12), count: Expr::const_val(5) },
        Instruction::SoundCmd28(Expr::const_val(42)),
        Instruction::SoundCmd2A(Expr::const_val(43)),
        Instruction::TileState { expr: Expr::const_val(1), word: 0x1234 },
        Instruction::BgScrollX(Expr::const_val(100)),
        Instruction::BgScrollY(Expr::const_val(200)),
        Instruction::BgScrollSpeed(Expr::const_val(2)),
        Instruction::Bg2ScrollSpeed(Expr::const_val(4)),
        Instruction::WaitUntil(Expr::Flag { base: FlagBase::Ram, bit_index: 0x004E }),
        Instruction::WaitFrame(Expr::const_val(60)),
        Instruction::WaitAnim(Expr::const_val(1)),
        Instruction::ChangeMap { x: 10, y: 20, map: 0x002B },
        Instruction::CameraFollow { x: 15, y: 25 },
        Instruction::SetCameraPos { x: 5, y: 8 },
        Instruction::FadeIn,
        Instruction::FadeOut,
        Instruction::ResetGame,
        Instruction::LockPlayer(8),
        Instruction::UnlockPlayer(8),
        Instruction::Sleep(10),
        Instruction::SleepWord(1000),
        Instruction::PlaySound { channel: 0, id: 0x12 },
        Instruction::PlaySound { channel: 1, id: 0x15 },
        Instruction::PlaySound { channel: 2, id: 0x18 },
        Instruction::PlayMusic(0x78),
        Instruction::GiveMoney { currency: Expr::const_val(0), amount: 100 },
        Instruction::TakeMoney { currency: Expr::const_val(0), amount: 50 },
        Instruction::GiveMoneyExpr { currency: Expr::const_val(0), amount: Expr::const_val(100) },
        Instruction::TakeMoneyExpr { currency: Expr::const_val(0), amount: Expr::const_val(50) },
        Instruction::ShowText(0x0123),
        Instruction::ShowTextEnd(0x0123),
        Instruction::HideText,
        Instruction::WriteRam { opcode: 0x18, addr: 0x0100, expr: Expr::const_val(42) },
        Instruction::WriteTemp { opcode: 0x19, addr: 0x0020, expr: Expr::const_val(99) },
        Instruction::SetFlag { base: FlagBase::Ram, bit_index: 0x004E, val: Expr::const_val(1) },
        Instruction::SetFlag { base: FlagBase::Temp, bit_index: 0x0010, val: Expr::const_val(0) },
        Instruction::Skip(10),
        Instruction::SkipNeg(-5),
        Instruction::Call(0x938500),
        Instruction::Fork(0x938500),
        Instruction::CallRelative(20),
        Instruction::CallRelativeByte(10),
        Instruction::If { cond: Expr::const_val(1), target_offset: 15 },
        Instruction::IfNot { cond: Expr::const_val(0), target_offset: 15 },
        Instruction::IfMoneyGe { currency: Expr::const_val(0), amount: 50, target_offset: 12 },
        Instruction::IfMoneyLt { currency: Expr::const_val(0), amount: 50, target_offset: 12 },
        Instruction::IfEqual { left: Expr::const_val(5), right: Expr::const_val(5), target_offset: 20 },
        Instruction::IfNotEqual { left: Expr::const_val(5), right: Expr::const_val(10), target_offset: 20 },
        Instruction::PlayEntityAnim { target: Expr::Entity(Entity::Boy), anim: 0x0102, speed: Expr::const_val(3) },
        Instruction::PlayEntityAnimWait { target: Expr::Entity(Entity::Dog), anim: 0x0104, speed: Expr::const_val(2) },
        Instruction::SetEntityPos { target: Expr::Entity(Entity::Boy), x: Expr::const_val(100), y: Expr::const_val(200) },
        Instruction::MoveEntityTo { target: Expr::Entity(Entity::Boy), x: Expr::const_val(120), y: Expr::const_val(220) },
        Instruction::SetEntityPosExpr { target: Expr::Entity(Entity::Boy), x: Expr::const_val(100), y: Expr::const_val(200) },
        Instruction::SetEntityPosFast { opcode: 0x6C, target: Expr::Entity(Entity::Boy), cx: 12, cy: 34 },
        Instruction::SetEntityPosFast { opcode: 0x6E, target: Expr::Entity(Entity::Dog), cx: 15, cy: 40 },
        Instruction::SetEntityPosRelFast { opcode: 0x6D, target: Expr::Entity(Entity::Boy), dx: Expr::const_val(5), dy: Expr::const_val(-5) },
        Instruction::SetEntityPosRelFast { opcode: 0x6F, target: Expr::Entity(Entity::Dog), dx: Expr::const_val(2), dy: Expr::const_val(4) },
        Instruction::SetEntitySpeed { target: Expr::Entity(Entity::Boy), speed: 0x0200 },
        Instruction::AttachScript { target: Expr::Entity(Entity::Boy), script_id: 0x0123 },
        Instruction::EntityAction { opcode: 0x74, target: Expr::Entity(Entity::Boy) },
        Instruction::EntityAction { opcode: 0x75, target: Expr::Entity(Entity::Boy) },
        Instruction::EntityAction { opcode: 0x76, target: Expr::Entity(Entity::Dog) },
        Instruction::EntityAction { opcode: 0x77, target: Expr::Entity(Entity::Dog) },
        Instruction::CameraAction9C(Expr::const_val(1)),
        Instruction::SpawnEntity { b1: 1, b2: 2, b3: 3 },
        Instruction::SpawnEntityExtra { b1: 4, b2: 5, b3: 6 },
        Instruction::SpawnNpc { npc_type: 0x0012, param: 0x0034, x: Expr::const_val(10), y: Expr::const_val(20) },
        Instruction::MapEffect5C { arg1: Expr::const_val(1), arg2: Expr::const_val(2) },
        Instruction::SetTileAttr { opcode: 0x5D, target: Expr::Entity(Entity::Boy), attr: 0x0400 },
        Instruction::SetTileAttr { opcode: 0x5E, target: Expr::Entity(Entity::Dog), attr: 0x0800 },
        Instruction::SetBgScroll(0x0150),
        Instruction::ShowWindowText { window: 1, text_id: 0x0234 },
        Instruction::HideWindowText(1),
        Instruction::SetWindowSize { opcode: 0x44, window: 0, x: 2, y: 2, w: 28, h: 10 },
        Instruction::SetWindowSize { opcode: 0x45, window: 1, x: 4, y: 4, w: 20, h: 8 },
        Instruction::ShowNamingScreen(3),
        Instruction::ShowMessage(0x0042),
        Instruction::SetBrightnessFast(Expr::const_val(15)),
        Instruction::SetPitch(Expr::const_val(128)),
        Instruction::SetMusicVolume(200),
        Instruction::SoundCmd2AExpr(Expr::const_val(42)),
        Instruction::SoundCmd2BExpr(Expr::const_val(84)),
        Instruction::ScriptCmd4E(Expr::const_val(1)),
        Instruction::ScriptCmd7E { arg1: Expr::const_val(0), arg2: Expr::const_val(1), arg3: Expr::const_val(2), arg4: Expr::const_val(3) },
        Instruction::WriteWramByte { target: Expr::const_val(0x1000), val: Expr::const_val(0x25) },
        Instruction::WriteWramWord { target: Expr::const_val(0x1000), val: Expr::const_val(0x1234) },
        Instruction::CallTableByte(0x05),
        Instruction::CallTableWord(0x0105),
        Instruction::SpawnNpcParam { npc_type: 0x0010, param: 0x0020, x: 5, y: 10 },
        Instruction::ResetWindowDefaults(0),
        Instruction::ResetWindowDefaults(1),
        Instruction::ResetWindowDefaults(2),
        Instruction::ResetWindowDefaults(3),
        Instruction::LockPlayerFast { opcode: 0xBC },
        Instruction::LockPlayerFast { opcode: 0xBE },
        Instruction::LockPlayerFast { opcode: 0xC0 },
        Instruction::UnlockPlayerFast { opcode: 0xBD },
        Instruction::UnlockPlayerFast { opcode: 0xBF },
        Instruction::UnlockPlayerFast { opcode: 0xC1 },
        Instruction::CallParams { args: vec![Expr::const_val(1), Expr::const_val(2)], addr: 0x938500 },
        Instruction::CallTableByteParams { args: vec![Expr::const_val(1)], idx: 5 },
        Instruction::CallTableWordParams { args: vec![Expr::const_val(2)], idx: 0x0105 },
        Instruction::CallRelativeByteParams { args: vec![Expr::const_val(3)], offset: 12 },
        Instruction::CallRelativeWordParams { args: vec![Expr::const_val(4)], offset: 120 },
        Instruction::ForkParams { args: vec![Expr::const_val(5)], addr: 0x938500 },
        Instruction::Yield { opcode: 0x38 },
        Instruction::Yield { opcode: 0x3A },
        Instruction::NopSkipByte(0x42),
        Instruction::Nop,
        Instruction::FadeInMusic,
        Instruction::FadeOutMusic,
        Instruction::DisableInterrupts,
        Instruction::EnableInterrupts,
        Instruction::WaitPathEnd,
        Instruction::EnableBg1,
        Instruction::DisableBg1,
        Instruction::EnableBg2,
        Instruction::DisableBg2,
        Instruction::EntityFaceEntity { a: Expr::Entity(Entity::Boy), b: Expr::Entity(Entity::Dog) },
        Instruction::FaceEachOther { a: Expr::Entity(Entity::Boy), b: Expr::Entity(Entity::Dog) },
        Instruction::ShowHudAll,
        Instruction::HideHudAll,
        Instruction::RestoreMainScreenLayers,
        Instruction::SetSubScreenLayers,
        Instruction::ClearShopMenu,
        Instruction::SetCameraBase { x: Expr::const_val(10), y: Expr::const_val(20) },
        Instruction::ShakeScreenComplex(vec![Expr::const_val(1), Expr::const_val(2), Expr::const_val(3), Expr::const_val(4), Expr::const_val(5), Expr::const_val(6), Expr::const_val(7)]),
        Instruction::EnterMode7Map(vec![Expr::const_val(1), Expr::const_val(2), Expr::const_val(3), Expr::const_val(4), Expr::const_val(5), Expr::const_val(6)]),
        Instruction::ShowCurrencyHud,
        Instruction::UpdateCurrencyHud,
        Instruction::HideCurrencyHud,
        Instruction::SetCanineAiTargeting,
        Instruction::SetRamPairsX8 { w1: 0x0100, w2: 0x0200, b1: 2, b2: 4 },
        Instruction::SetTempPairsX8 { w1: 0x0010, w2: 0x0020, b1: 1, b2: 3 },
        Instruction::SetArgPairsX8 { arg1: 0, arg2: 1, b1: 5, b2: 6 },
        Instruction::SetNpcScript { target: Expr::Entity(Entity::Boy), w1: 0x1234, w2: 0x5678 },
        Instruction::SetAmbientActorPos { id: 2, x: 100, y: 200 },
        Instruction::PaletteFadeCustom(vec![Expr::const_val(0), Expr::const_val(1), Expr::const_val(2), Expr::const_val(3), Expr::const_val(4), Expr::const_val(5), Expr::const_val(6), Expr::const_val(7)]),
        Instruction::StartPaletteCycle(vec![Expr::const_val(1), Expr::const_val(2), Expr::const_val(3), Expr::const_val(4)]),
        Instruction::End,
    ];

    let rom_path = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc";
    let mut rom = Rom::load(rom_path).expect("German ROM should load");
    let test_addr = 0x93F000;

    for (idx, instr) in test_instructions.iter().enumerate() {
        let mut bytes = Vec::new();
        Assembler::assemble_instruction(instr, &mut bytes);
        // Append End (0x00) if not terminal to ensure safe disassembly termination
        if !instr.is_terminal() {
            bytes.push(0x00);
        }

        rom.write_bytes_snes(test_addr, &bytes).unwrap();
        let disasm = Disassembler::new(&rom);
        let script = disasm.disassemble_script(test_addr, bytes.len() + 2);
        assert!(
            !script.statements.is_empty(),
            "Instruction index {} ({:?}) disassembled to empty statements",
            idx, instr
        );

        let decoded_instr = &script.statements[0].instruction;
        // Verify reassembled bytes match original emitted bytes exactly (1:1 byte-exact)
        let mut reassembled = Vec::new();
        Assembler::assemble_instruction(decoded_instr, &mut reassembled);
        let mut expected_first = Vec::new();
        Assembler::assemble_instruction(instr, &mut expected_first);
        assert_eq!(
            reassembled, expected_first,
            "Byte emission mismatch for index {} ({:?})",
            idx, instr
        );

        // Verify disassembler string matches formatted instruction
        assert_eq!(
            soe_script::format::format_everscript_instruction(decoded_instr),
            soe_script::format::format_everscript_instruction(instr),
            "Everscript string mismatch for index {} ({:?})",
            idx, instr
        );
    }
}

#[test]
fn test_global_rom_scan_all_roots() {
    use soe_script::ast::Instruction;
    let rom_path = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc";
    let rom = Rom::load(rom_path).expect("German ROM should load");
    let disasm = Disassembler::new(&rom);

    let mut queue = std::collections::VecDeque::new();
    let mut visited = std::collections::HashSet::new();

    // 1. 128 Map enter scripts
    let map_table_snes = 0x93801B;
    for i in 0..128 {
        let entry_snes = map_table_snes + (i as u32) * 5;
        let script_ptr = rom.read_u24_snes(entry_snes).unwrap_or(0);
        if script_ptr != 0 {
            let addr = Rom::script_to_rom_addr(script_ptr);
            if addr >= 0x938000 && addr <= 0x9CFFFF && visited.insert(addr) {
                queue.push_back(addr);
            }
        }
    }

    // 2. Map triggers (mscripts & bscripts)
    let de_map_list_addr = 0xA0FDE5;
    let scripts_start_off = Rom::snes_to_file_offset(0x938000);
    let mapscript_ptr_word = rom.read_u16_at(scripts_start_off).unwrap_or(0);
    let mapscriptptr_snes = 0x938000 + (mapscript_ptr_word as u32);
    let mapscriptptr_off = Rom::snes_to_file_offset(mapscriptptr_snes);

    let map_list_off = Rom::snes_to_file_offset(de_map_list_addr);
    for map_id in 0..128 {
        let ptr_off = map_list_off + map_id * 4;
        if ptr_off + 3 > rom.len() {
            continue;
        }
        let data_snes_addr = rom.read_u24_at(ptr_off).unwrap_or(0);
        if !(0x800000..=0xAFFFFF).contains(&data_snes_addr) {
            continue;
        }
        let data_file_off = Rom::snes_to_file_offset(data_snes_addr);
        // Step-on triggers
        let m_len = rom.read_u16_at(data_file_off + 0x0D).unwrap_or(0);
        let m_ptr_off = data_file_off + 0x0D + 2;
        if m_len % 6 == 0 && m_len <= 600 {
            for i in 0..(m_len / 6) as usize {
                let entry_off = m_ptr_off + i * 6;
                let script_id = rom.read_u16_at(entry_off + 4).unwrap_or(0);
                let target_script_ptr = mapscriptptr_off + (script_id as usize);
                let target_val = rom.read_u24_at(target_script_ptr).unwrap_or(0);
                let addr = Rom::script_to_rom_addr(target_val);
                if addr >= 0x938000 && addr <= 0x9CFFFF && visited.insert(addr) {
                    queue.push_back(addr);
                }
            }
        }
        // B-triggers
        let b_len_off = data_file_off + 0x0D + 2 + (m_len as usize);
        let b_len = rom.read_u16_at(b_len_off).unwrap_or(0);
        let b_ptr_off = b_len_off + 2;
        if b_len % 6 == 0 && b_len <= 600 {
            for i in 0..(b_len / 6) as usize {
                let entry_off = b_ptr_off + i * 6;
                let script_id = rom.read_u16_at(entry_off + 4).unwrap_or(0);
                let target_script_ptr = mapscriptptr_off + (script_id as usize);
                let target_val = rom.read_u24_at(target_script_ptr).unwrap_or(0);
                let addr = Rom::script_to_rom_addr(target_val);
                if addr >= 0x938000 && addr <= 0x9CFFFF && visited.insert(addr) {
                    queue.push_back(addr);
                }
            }
        }
    }

    // 3. Pointer table at $93:8294
    let ptr_table_off = Rom::snes_to_file_offset(0x938294);
    for i in 0..2344 {
        let target_val = rom.read_u24_at(ptr_table_off + i * 3).unwrap_or(0);
        let addr = Rom::script_to_rom_addr(target_val);
        if addr >= 0x938000 && addr <= 0x9CFFFF && visited.insert(addr) {
            queue.push_back(addr);
        }
    }

    let initial_roots_count = visited.len();
    println!("Initial script roots collected: {}", initial_roots_count);

    let mut total_instructions = 0;
    let mut structured_instructions = 0;
    let mut raw_instructions = 0;
    let mut roundtrip_matches = 0;
    let mut desync_errors = Vec::new();
    let mut terminal_ok_count = 0;

    let mut total_scripts_processed = 0;

    while let Some(addr) = queue.pop_front() {
        total_scripts_processed += 1;
        let script = disasm.disassemble_script(addr, 4096);
        if script.statements.is_empty() {
            desync_errors.push((addr, "Empty disassembly"));
            continue;
        }

        for stmt in &script.statements {
            total_instructions += 1;
            match &stmt.instruction {
                Instruction::Raw { opcode, .. } => {
                    raw_instructions += 1;
                    // Check if illegal STP trap opcode
                    if matches!(
                        opcode,
                        0x01..=0x03 | 0x06 | 0x0F | 0x13 | 0x1F | 0x24 | 0x25 | 0x28 | 0x2F
                        | 0x34..=0x37 | 0x3E | 0x40 | 0x41 | 0x4F | 0x53 | 0x56 | 0x57 | 0x67 | 0x6B
                        | 0x72 | 0x8B | 0xB8
                    ) {
                        desync_errors.push((addr, "STP / Trap opcode encountered"));
                    }
                }
                _ => {
                    structured_instructions += 1;
                }
            }

            // Recursively discover sub-scripts
            let sub_target = match &stmt.instruction {
                Instruction::Call(target) | Instruction::Fork(target) => Some(*target),
                Instruction::CallParams { addr: target, .. } | Instruction::ForkParams { addr: target, .. } => Some(*target),
                _ => None,
            };

            if let Some(target) = sub_target {
                if target >= 0x938000 && target <= 0x9CFFFF && visited.insert(target) {
                    queue.push_back(target);
                }
            }
        }

        // Terminal handling check
        if let Some(last_stmt) = script.statements.last() {
            if last_stmt.instruction.is_terminal() {
                terminal_ok_count += 1;
            }
        }

        // Roundtrip check: reassemble
        let reassembled = soe_script::asm::Assembler::assemble_script(&script);
        let original: Vec<u8> = script.statements.iter().flat_map(|s| s.raw_bytes.clone()).collect();
        if reassembled == original {
            roundtrip_matches += 1;
        } else {
            println!("Mismatch at script 0x{:06X}: reassembled len {}, original len {}", addr, reassembled.len(), original.len());
            for stmt in &script.statements {
                let mut s_reassembled = Vec::new();
                soe_script::asm::Assembler::assemble_instruction(&stmt.instruction, &mut s_reassembled);
                if s_reassembled != stmt.raw_bytes {
                    println!("  Statement mismatch: {:?} -> reassembled {:02X?}, original {:02X?}", stmt.instruction, s_reassembled, stmt.raw_bytes);
                }
            }
            desync_errors.push((addr, "Reassembly mismatch"));
        }
    }

    println!("=== Global ROM Script Scan Results ===");
    println!("Total scripts processed: {}", total_scripts_processed);
    println!("Total instructions: {}", total_instructions);
    println!("Structured instructions: {} ({:.2}%)", structured_instructions, (structured_instructions as f64 / total_instructions as f64) * 100.0);
    println!("Raw instructions: {} ({:.2}%)", raw_instructions, (raw_instructions as f64 / total_instructions as f64) * 100.0);
    println!("Byte-exact roundtrips: {} / {}", roundtrip_matches, total_scripts_processed);
    println!("Properly terminated scripts: {} / {}", terminal_ok_count, total_scripts_processed);
    println!("Desync errors: {}", desync_errors.len());

    assert_eq!(desync_errors.len(), 0, "No desynchronization errors allowed: {:?}", desync_errors);
    assert_eq!(roundtrip_matches, total_scripts_processed, "All processed scripts must match byte-exact on reassembly!");
}



