// crates/soe-dumper/tests/map_dump_test.rs
use soe_core::Rom;
use soe_dumper::Dumper;

#[test]
fn test_dump_all_128_maps() {
    let rom_path = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc";
    let rom = Rom::load(rom_path).expect("German ROM should load successfully");
    let dumper = Dumper::new(&rom);

    let mut valid_map_count = 0;
    let mut total_step_on_triggers = 0;
    let mut total_b_triggers = 0;

    for map_id in 0..128u8 {
        let dump_result = dumper.dump_map(map_id);
        assert!(dump_result.is_ok(), "dump_map({}) should not return an Err", map_id);

        let map_opt = dump_result.unwrap();

        if map_id == 127 {
            // Map 127 is out-of-bounds in the map list table ($A0:FDE5 has 127 entries, 0..126)
            assert!(
                map_opt.is_none(),
                "Map 127 must return Ok(None) because only 127 maps (0..126) exist"
            );
            continue;
        }

        let map = map_opt.unwrap_or_else(|| panic!("Map {} (0x{:02X}) must exist", map_id, map_id));
        valid_map_count += 1;

        // Verify SNES address is valid HiROM pointer
        assert!(
            map.data_snes_addr >= 0x800000 && map.data_snes_addr <= 0xAFFFFF,
            "Map {} data address 0x{:06X} outside valid range",
            map_id,
            map.data_snes_addr
        );

        // Map 21 (0x15, Unbenutzt / Dummy-Map) edge case: script pointer is 0
        if map_id == 21 {
            assert_eq!(
                map.enter_script_snes_addr, 0,
                "Map 21 enter_script_snes_addr must be 0"
            );
            assert!(
                map.enter_script.is_none(),
                "Map 21 enter_script must be None"
            );
        }

        // Verify Step-On triggers
        for trigger in &map.step_on_triggers {
            assert!(
                trigger.script_snes_addr >= 0x800000 && trigger.script_snes_addr <= 0xC00000,
                "Step-on trigger script addr 0x{:06X} outside valid script ROM range",
                trigger.script_snes_addr
            );
            // Script must have disassembled at least one statement without crashing
            assert!(
                !trigger.script.statements.is_empty(),
                "Trigger script at 0x{:06X} should not be empty",
                trigger.script_snes_addr
            );
        }
        total_step_on_triggers += map.step_on_triggers.len();

        // Verify B-triggers
        for trigger in &map.b_triggers {
            assert!(
                trigger.script_snes_addr >= 0x800000 && trigger.script_snes_addr <= 0xC00000,
                "B-trigger script addr 0x{:06X} outside valid script ROM range",
                trigger.script_snes_addr
            );
            assert!(
                !trigger.script.statements.is_empty(),
                "B-Trigger script at 0x{:06X} should not be empty",
                trigger.script_snes_addr
            );
        }
        total_b_triggers += map.b_triggers.len();
    }

    assert_eq!(valid_map_count, 127, "Exactly 127 maps (0..126) must be dumped");
    println!(
        "Dumped 127 maps successfully with {} step-on triggers and {} B-triggers",
        total_step_on_triggers, total_b_triggers
    );
}
