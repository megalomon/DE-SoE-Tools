use soe_core::*;

#[test]
fn test_load_german_rom() {
    let rom_path = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc";
    let rom = Rom::load(rom_path).expect("German ROM should load successfully");
    assert_eq!(rom.len(), 3_145_728);

    // Test text decoder
    let decoder = TextDecoder::new(&rom);
    // Decode first few dialogue strings
    let text0 = decoder.decode_entry(0).expect("Entry 0 should decode");
    println!("Text 0: {}", text0);
    assert!(!text0.is_empty());

    // Test Trade Goods names
    let pot = TradeGood::Keramiktopf;
    assert_eq!(pot.german_name(), "Keramiktopf");
    let egg = TradeGood::ChocoboEi;
    assert_eq!(egg.german_name(), "Chocobo Ei");

    // Test script address conversions
    let rom_addr = 0x938294;
    let script_addr = Rom::rom_to_script_addr(rom_addr);
    let back_to_rom = Rom::script_to_rom_addr(script_addr);
    assert_eq!(rom_addr, back_to_rom);
}

#[test]
fn test_decode_all_text_entries() {
    let rom_path = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc";
    let rom = Rom::load(rom_path).expect("German ROM should load successfully");
    let decoder = TextDecoder::new(&rom);

    for i in 0..TOTAL_TEXT_ENTRIES {
        let res = decoder.decode_entry(i);
        assert!(res.is_ok(), "Failed to decode text entry {}: {:?}", i, res.err());
    }

    // Index 3082 and beyond must return OutOfBounds
    assert!(decoder.decode_entry(TOTAL_TEXT_ENTRIES).is_err());
    assert!(decoder.decode_entry(TOTAL_TEXT_ENTRIES + 1).is_err());
}

