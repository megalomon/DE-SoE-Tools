use std::collections::{HashSet, HashMap, VecDeque};
use std::fs::File;
use std::io::Write;
use soe_core::rom::Rom;
use soe_core::text::TextDecoder;
use soe_script::disasm::Disassembler;
use soe_script::ast::Instruction;

#[derive(Debug, Clone)]
struct TextUsage {
    map_id: Option<u8>,
    map_name: Option<String>,
    trigger_kind: String,
    script_addr: u32,
}

fn resolve_call_rel(snes_addr: u32, delta: i32) -> u32 {
    let bank = (snes_addr >> 16) as i32;
    let pc = (snes_addr & 0xFFFF) as i32;
    let diff = bank - 0x93;
    let carry = diff & 1;
    let bank_word = diff >> 1;
    let pc_mod = if carry == 1 { pc | 0x8000 } else { pc & 0x7FFF };
    let res = pc_mod + delta;
    let new_bank_word = bank_word + (res >> 16);
    let rem = res & 0xFFFF;
    let sub_bank = if rem >= 0x8000 { 1 } else { 0 };
    let final_bank = 0x93 + new_bank_word * 2 + sub_bank;
    let final_pc = 0x8000 + (rem & 0x7FFF);
    ((final_bank as u32) << 16) | (final_pc as u32)
}

fn main() {
    let rom_path = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc";
    let rom = match Rom::load(rom_path) {
        Ok(r) => r,
        Err(e) => {
            eprintln!("Failed to load ROM: {}", e);
            return;
        }
    };

    let disasm = Disassembler::new(&rom);
    let decoder = TextDecoder::new(&rom);
    let map_names = soe_dumper::maps::MAPS.iter().map(|m| (m.id, m.name.to_string())).collect::<HashMap<_, _>>();

    // Decode all 3082 texts
    let mut all_texts = HashMap::new();
    for i in 0..3082 {
        if let Ok(t) = decoder.decode_entry(i) {
            all_texts.insert(i as u16, t);
        }
    }

    let mut text_usages: HashMap<u16, Vec<TextUsage>> = HashMap::new();
    let mut visited_scripts = HashSet::new();

    let mut record_usage = |raw_val: u16, map_id: Option<u8>, trigger_kind: &str, script_addr: u32| {
        let idx = if raw_val % 3 == 0 && (raw_val / 3) < 3082 {
            raw_val / 3
        } else {
            raw_val
        };
        let m_name = map_id.and_then(|id| map_names.get(&id).cloned());
        text_usages.entry(idx).or_default().push(TextUsage {
            map_id,
            map_name: m_name,
            trigger_kind: trigger_kind.to_string(),
            script_addr,
        });
    };

    let de_map_list_addr = 0xA0FDE5;
    let scripts_start_off = Rom::snes_to_file_offset(0x938000);
    let mapscript_ptr_word = rom.read_u16_at(scripts_start_off).unwrap_or(0);
    let mapscriptptr_snes = 0x938000 + (mapscript_ptr_word as u32);
    let mapscriptptr_off = Rom::snes_to_file_offset(mapscriptptr_snes);

    let mut queue = VecDeque::new();

    macro_rules! enqueue {
        ($addr:expr, $map_id:expr, $trigger_kind:expr) => {
            let a = $addr;
            if (0x900000..=0x9EFFFF).contains(&a) && visited_scripts.insert(a) {
                queue.push_back((a, $map_id, $trigger_kind.to_string()));
            }
        };
    }

    // 1. Scan 128 map enter scripts
    let map_table_snes = 0x93801B;
    for i in 0..128 {
        let entry_snes = map_table_snes + (i as u32) * 5;
        let script_ptr = rom.read_u24_snes(entry_snes).unwrap_or(0);
        if script_ptr != 0 {
            let addr = Rom::script_to_rom_addr(script_ptr);
            enqueue!(addr, Some(i), "Map Enter Script");
        }
    }

    // 2. Scan map step-on & B-triggers
    let map_list_off = Rom::snes_to_file_offset(de_map_list_addr);
    for map_id in 0..128 {
        let ptr_off = map_list_off + (map_id as usize) * 4;
        if ptr_off + 3 > rom.len() { continue; }
        let data_snes_addr = rom.read_u24_at(ptr_off).unwrap_or(0);
        if !(0x800000..=0xAFFFFF).contains(&data_snes_addr) { continue; }
        let data_file_off = Rom::snes_to_file_offset(data_snes_addr);

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
                    enqueue!(addr, Some(map_id), "Step-on Trigger");
                }
            }
        }

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
                    enqueue!(addr, Some(map_id), "B-Trigger (Talk/Inspect)");
                }
            }
        }
    }

    // 3. Scan all 2344 scripts in $93:8294
    for idx in 0..2344 {
        let entry_off = mapscriptptr_off + idx * 3;
        let val = rom.read_u24_at(entry_off).unwrap_or(0);
        if val != 0 {
            let addr = Rom::script_to_rom_addr(val);
            enqueue!(addr, None, &format!("ScriptTable #{}", idx));
        }
    }

    // 4. Scan 16 engine scripts in $9C
    let engine_table_off = 0x0CD002;
    for i in 0..16 {
        let p = rom.read_u16_at(engine_table_off + i * 2).unwrap_or(0);
        let addr = 0x9C0000 | (p as u32);
        enqueue!(addr, None, &format!("EngineScript $9C:{:04X}", p));
    }

    // Process work queue recursively
    while let Some((addr, map_id, trigger_kind)) = queue.pop_front() {
        let script = disasm.disassemble_script(addr, 2048);
        for stmt in &script.statements {
            match &stmt.instruction {
                Instruction::ShowText(id) | Instruction::ShowTextEnd(id) | Instruction::ShowMessage(id) => {
                    record_usage(*id, map_id, &trigger_kind, addr);
                }
                Instruction::ShowWindowText { text_id, .. } => {
                    record_usage(*text_id, map_id, &trigger_kind, addr);
                }
                Instruction::ShowNamingScreen(id) => {
                    record_usage(*id, map_id, &trigger_kind, addr);
                }
                Instruction::Call(target) | Instruction::Fork(target) => {
                    enqueue!(*target, map_id, &trigger_kind);
                }
                Instruction::CallParams { addr: t_addr, .. } | Instruction::ForkParams { addr: t_addr, .. } => {
                    enqueue!(*t_addr, map_id, &trigger_kind);
                }
                Instruction::CallRelative(offset) | Instruction::CallRelativeWordParams { offset, .. } => {
                    let t_addr = resolve_call_rel(stmt.snes_addr, *offset as i32);
                    enqueue!(t_addr, map_id, &trigger_kind);
                }
                Instruction::CallRelativeByte(offset) | Instruction::CallRelativeByteParams { offset, .. } => {
                    let t_addr = resolve_call_rel(stmt.snes_addr, *offset as i32);
                    enqueue!(t_addr, map_id, &trigger_kind);
                }
                Instruction::CallTableByte(idx) | Instruction::CallTableByteParams { idx, .. } => {
                    if (*idx as usize) < 2344 {
                        let entry_off = mapscriptptr_off + (*idx as usize) * 3;
                        if let Ok(val) = rom.read_u24_at(entry_off) {
                            if val != 0 {
                                let t_addr = Rom::script_to_rom_addr(val);
                                enqueue!(t_addr, map_id, &trigger_kind);
                            }
                        }
                    }
                }
                Instruction::CallTableWord(idx) | Instruction::CallTableWordParams { idx, .. } => {
                    if (*idx as usize) < 2344 {
                        let entry_off = mapscriptptr_off + (*idx as usize) * 3;
                        if let Ok(val) = rom.read_u24_at(entry_off) {
                            if val != 0 {
                                let t_addr = Rom::script_to_rom_addr(val);
                                enqueue!(t_addr, map_id, &trigger_kind);
                            }
                        }
                    }
                }
                Instruction::AttachScript { script_id, .. } => {
                    if (*script_id as usize) < 2344 {
                        let entry_off = mapscriptptr_off + (*script_id as usize) * 3;
                        if let Ok(val) = rom.read_u24_at(entry_off) {
                            if val != 0 {
                                let t_addr = Rom::script_to_rom_addr(val);
                                enqueue!(t_addr, map_id, &trigger_kind);
                            }
                        }
                    }
                }
                _ => {}
            }
        }
    }

    // Output complete TSV of all 3082 texts
    let out_path = "/data/data/com.termux/files/home/dev/soeTAS/scratchpad/all_texts_audit.tsv";
    let mut file = File::create(out_path).unwrap();
    writeln!(file, "ID\tHEX_ID\tSTATUS\tUSAGE_COUNT\tPRIMARY_MAP\tPRIMARY_TRIGGER\tSCRIPT_ADDR\tCONTENT").unwrap();

    let mut unref_count = 0;
    let mut ref_count = 0;

    for id in 0..3082 {
        let text = all_texts.get(&id).map(|s| s.replace('\t', " ").replace('\n', " \\n ")).unwrap_or_default();
        if let Some(usages) = text_usages.get(&id) {
            ref_count += 1;
            let u0 = &usages[0];
            let map_str = u0.map_name.clone().unwrap_or_else(|| u0.map_id.map(|m| format!("Map_{}", m)).unwrap_or_else(|| "Global/SubScript".to_string()));
            writeln!(file, "{}\t0x{:04X}\tUSED\t{}\t{}\t{}\t${:06X}\t{}",
                id, id, usages.len(), map_str, u0.trigger_kind, u0.script_addr, text).unwrap();
        } else {
            unref_count += 1;
            let status = if id <= 270 {
                "ENGINE_ITEM_PICKUP"
            } else if (418..=488).contains(&id) {
                "CREDITS"
            } else {
                "UNREFERENCED"
            };
            writeln!(file, "{}\t0x{:04X}\t{}\t0\t-\t-\t-\t{}",
                id, id, status, text).unwrap();
        }
    }

    println!("Audit written to {}. Total Used: {}, Total Unreferenced: {} (of which Item/Credits: {})",
        out_path, ref_count, unref_count, (271 + 71));
}
