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
    assert!(disasm_str.contains("IF"));
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

    for i in 0..126 {
        let entry_snes = map_table_snes + (i as u32) * 5;
        let script_ptr = rom.read_u24_snes(entry_snes).unwrap_or(0);
        let snes_addr = Rom::script_to_rom_addr(script_ptr);

        let script = disasm.disassemble_script(snes_addr, 2048);
        if !script.statements.is_empty() {
            total_statements += script.statements.len();
            successful_scripts += 1;
        }
    }

    println!("Total decoded map scripts: {}/126, statements: {}", successful_scripts, total_statements);
    assert_eq!(successful_scripts, 126);
    assert!(total_statements > 2000);
}
