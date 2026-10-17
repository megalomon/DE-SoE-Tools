use std::collections::{HashSet, HashMap, VecDeque};
use soe_core::rom::Rom;
use soe_core::text::TextDecoder;
use soe_script::disasm::Disassembler;
use soe_script::ast::Instruction;

fn main() {
    let rom_path = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc";
    let rom = match Rom::load(rom_path) {
        Ok(r) => r,
        Err(e) => {
            eprintln!("Failed to load ROM: {}", e);
            return;
        }
    };

    println!("ROM loaded successfully.");
    let disasm = Disassembler::new(&rom);
    let decoder = TextDecoder::new(&rom);

    // 1. Decode all 3082 text entries
    println!("Decoding all text entries (0..3082)...");
    let mut all_texts = HashMap::new();
    for i in 0..3082 {
        if let Ok(text) = decoder.decode_entry(i) {
            if !text.trim().is_empty() {
                all_texts.insert(i as u16, text);
            }
        }
    }
    println!("Decoded {} non-empty text entries.", all_texts.len());

    // 2. Discover all script roots across the ROM
    let mut queue = VecDeque::new();
    let mut visited = HashSet::new();

    // Map enter scripts
    let map_table_snes = 0x93801B;
    for i in 0..128 {
        let entry_snes = map_table_snes + (i as u32) * 5;
        let script_ptr = rom.read_u24_snes(entry_snes).unwrap_or(0);
        if script_ptr != 0 {
            let addr = Rom::script_to_rom_addr(script_ptr);
            if (0x938000..=0x9CFFFF).contains(&addr) && visited.insert(addr) {
                queue.push_back(addr);
            }
        }
    }

    // Step-on and B-triggers
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

        // Step-on
        let m_len = rom.read_u16_at(data_file_off + 0x0D).unwrap_or(0);
        let m_ptr_off = data_file_off + 0x0D + 2;
        if m_len % 6 == 0 && m_len <= 600 {
            for i in 0..(m_len / 6) as usize {
                let entry_off = m_ptr_off + i * 6;
                let script_id = rom.read_u16_at(entry_off + 4).unwrap_or(0);
                let target_script_ptr = mapscriptptr_off + (script_id as usize);
                let target_val = rom.read_u24_at(target_script_ptr).unwrap_or(0);
                if target_val != 0 {
                    let addr = Rom::script_to_rom_addr(target_val);
                    if (0x938000..=0x9CFFFF).contains(&addr) && visited.insert(addr) {
                        queue.push_back(addr);
                    }
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
                if target_val != 0 {
                    let addr = Rom::script_to_rom_addr(target_val);
                    if (0x938000..=0x9CFFFF).contains(&addr) && visited.insert(addr) {
                        queue.push_back(addr);
                    }
                }
            }
        }
    }

    // All pointers in $93:8294 table
    let table_off = Rom::snes_to_file_offset(mapscriptptr_snes);
    for idx in 0..1000 {
        let entry_off = table_off + idx * 3;
        if entry_off + 3 <= rom.len() {
            let val = rom.read_u24_at(entry_off).unwrap_or(0);
            if val != 0 {
                let addr = Rom::script_to_rom_addr(val);
                if (0x938000..=0x9CFFFF).contains(&addr) && visited.insert(addr) {
                    queue.push_back(addr);
                }
            }
        }
    }

    println!("Discovered {} unique script roots.", visited.len());

    // 3. Disassemble all reachable scripts and collect all referenced text IDs
    let mut referenced_texts: HashMap<u16, Vec<u32>> = HashMap::new();
    let mut total_scripts = 0;

    let mut record_text = |raw_val: u16, addr: u32| {
        // In SoE SIGIL bytecode, text operands are table byte offsets (3 * index)
        let idx = if raw_val % 3 == 0 && raw_val / 3 < 3082 {
            raw_val / 3
        } else {
            raw_val
        };
        referenced_texts.entry(idx).or_default().push(addr);
        // Also record raw_val just in case
        if raw_val < 3082 {
            referenced_texts.entry(raw_val).or_default().push(addr);
        }
    };

    while let Some(addr) = queue.pop_front() {
        total_scripts += 1;
        let script = disasm.disassemble_script(addr, 2000);
        for stmt in &script.statements {
            match &stmt.instruction {
                Instruction::ShowText(id) | Instruction::ShowTextEnd(id) | Instruction::ShowMessage(id) => {
                    record_text(*id, addr);
                }
                Instruction::ShowWindowText { text_id, .. } => {
                    record_text(*text_id, addr);
                }
                Instruction::ShowNamingScreen(id) => {
                    record_text(*id, addr);
                }
                Instruction::Call(target) | Instruction::Fork(target) => {
                    let t_addr = Rom::script_to_rom_addr(*target);
                    if (0x938000..=0x9CFFFF).contains(&t_addr) && visited.insert(t_addr) {
                        queue.push_back(t_addr);
                    }
                }
                _ => {}
            }
        }
    }

    println!("Scanned {} scripts in total. Found {} unique referenced text IDs.", total_scripts, referenced_texts.len());

    // 4. Find all unreferenced text entries
    let mut unreferenced = Vec::new();
    for id in 0..3082 {
        if let Some(text) = all_texts.get(&id) {
            if !referenced_texts.contains_key(&id) {
                unreferenced.push((id, text.clone()));
            }
        }
    }

    println!("\n=======================================================");
    println!("TOTAL UNREFERENCED TEXT ENTRIES: {}", unreferenced.len());
    println!("=======================================================\n");

    for (id, text) in &unreferenced {
        let clean = text.replace('\n', " \\n ");
        println!("[ID {:04} / 0x{:04X}] {}", id, id, clean);
    }
}
