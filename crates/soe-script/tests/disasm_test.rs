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
