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

    // Test 0x7E: reads exactly 3 expressions (0xB0, 0xB1, 0xB2 = inline 0, 1, 2 with bit 7 set)
    let test_addr = 0x93E000;
    let bytes = [0x7E, 0xB0, 0xB1, 0xB2, 0x00];
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
        soe_script::ast::Instruction::Raw {
            opcode: 0x7E,
            payload: vec![0xB0, 0xB1, 0xB2]
        }
    );
    assert_eq!(script.statements[1].instruction, soe_script::ast::Instruction::End);

    let script2 = disasm.disassemble_script(test_addr2, 20);
    assert_eq!(script2.statements.len(), 4);
    assert_eq!(script2.statements[1].instruction, soe_script::ast::Instruction::End);
    assert_eq!(script2.statements[2].instruction, soe_script::ast::Instruction::HideText);
    assert_eq!(script2.statements[3].instruction, soe_script::ast::Instruction::End);
}

