// crates/soe-dumper/src/main.rs
use clap::{Parser, Subcommand};
use soe_core::Rom;
use soe_script::disasm::Disassembler;
use std::fs;
use std::path::PathBuf;

use soe_dumper::Dumper;

#[derive(Parser)]
#[command(name = "soe-dumper")]
#[command(about = "Secret of Evermore (German PAL ROM) Room, Script & Dialogue Dumper")]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// Dumped alle Maps, Skripte und deutschen Texte in ein Verzeichnis
    DumpAll {
        #[arg(short, long, default_value = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc")]
        rom: PathBuf,

        #[arg(short, long, default_value = "./dump_de")]
        out_dir: PathBuf,
    },
    /// Zeigt Informationen und Skripte einer einzelnen Map an
    Map {
        #[arg(short, long, default_value = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc")]
        rom: PathBuf,

        #[arg(short, long)]
        id: String,
    },
    /// Zeigt deutsche Dialog-Texte an
    Text {
        #[arg(short, long, default_value = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc")]
        rom: PathBuf,

        #[arg(short, long)]
        id: Option<usize>,

        #[arg(short, long, default_value_t = 100)]
        limit: usize,
    },
    /// Disassembliert ein Skript an einer beliebigen SNES-Adresse
    Script {
        #[arg(short, long, default_value = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc")]
        rom: PathBuf,

        #[arg(short, long)]
        addr: String,

        #[arg(short, long, default_value_t = 500)]
        max_bytes: usize,
    },
    /// Zeigt alle 35 alchemistischen Formeln mit Zutaten und Beschreibungen
    Alchemy {
        #[arg(short, long, default_value = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc")]
        rom: PathBuf,
    },
    /// Zeigt alle 142 Charaktere und Gegner der deutschen ROM
    Characters {
        #[arg(short, long, default_value = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc")]
        rom: PathBuf,

        #[arg(short, long, default_value_t = 142)]
        limit: usize,
    },
    /// Zeigt alle Gegenstände, Waffen, Rüstungen und Tauschwaren
    Items {
        #[arg(short, long, default_value = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc")]
        rom: PathBuf,
    },
}

fn parse_hex_or_dec(s: &str) -> Result<u32, std::num::ParseIntError> {
    let s = s.trim();
    if let Some(stripped) = s.strip_prefix("0x").or_else(|| s.strip_prefix("0X")).or_else(|| s.strip_prefix('$')) {
        u32::from_str_radix(stripped, 16)
    } else {
        s.parse::<u32>()
    }
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let cli = Cli::parse();

    match cli.command {
        Commands::DumpAll { rom, out_dir } => {
            println!("Lade deutsche ROM: {}", rom.display());
            let rom = Rom::load(&rom)?;
            let dumper = Dumper::new(&rom);

            fs::create_dir_all(&out_dir)?;
            let maps_dir = out_dir.join("maps");
            fs::create_dir_all(&maps_dir)?;

            println!("Dumpe deutsche Dialog-Texte...");
            let texts = dumper.dump_texts(soe_core::text::TOTAL_TEXT_ENTRIES);
            let mut texts_txt = String::new();
            for (idx, text) in &texts {
                texts_txt.push_str(&format!("[ID {:04X} ({:4})]\n{}\n\n", idx * 3, idx, text));
            }
            fs::write(out_dir.join("dialog_texts_de.txt"), texts_txt)?;
            println!("{} deutsche Dialoge gespeichert.", texts.len());

            println!("Dumpe 127 Maps...");
            let mut total_step_on = 0;
            let mut total_b_triggers = 0;
            let mut map_count = 0;

            for id in 0..128u8 {
                if let Ok(Some(map)) = dumper.dump_map(id) {
                    map_count += 1;
                    total_step_on += map.step_on_triggers.len();
                    total_b_triggers += map.b_triggers.len();

                    let map_file = maps_dir.join(format!("map_{:02X}_{}.evs", id, sanitize_filename(&map.name)));
                    let mut content = String::new();
                    content.push_str(&format!("// Map 0x{:02X}: {}\n", id, map.name));
                    content.push_str(&format!("// Data: ${:06X}, Enter Script: ${:06X}\n\n", map.data_snes_addr, map.enter_script_snes_addr));

                    if let Some(es) = &map.enter_script {
                        content.push_str("// --- Enter Script ---\n");
                        content.push_str(&es.to_everscript_string());
                        content.push_str("\n");
                    }

                    content.push_str(&format!("// --- Step-On Triggers (Count: {}) ---\n", map.step_on_triggers.len()));
                    for (t_idx, t) in map.step_on_triggers.iter().enumerate() {
                        content.push_str(&format!("// Trigger #{}: [{},{} - {},{}] Script ID 0x{:04X} @ ${:06X}\n",
                            t_idx, t.x1, t.y1, t.x2, t.y2, t.script_id, t.script_snes_addr));
                        content.push_str(&t.script.to_everscript_string());
                        content.push_str("\n");
                    }

                    content.push_str(&format!("// --- B-Triggers / NPCs (Count: {}) ---\n", map.b_triggers.len()));
                    for (t_idx, t) in map.b_triggers.iter().enumerate() {
                        content.push_str(&format!("// B-Trigger #{}: [{},{} - {},{}] Script ID 0x{:04X} @ ${:06X}\n",
                            t_idx, t.x1, t.y1, t.x2, t.y2, t.script_id, t.script_snes_addr));
                        content.push_str(&t.script.to_everscript_string());
                        content.push_str("\n");
                    }

                    fs::write(&map_file, content)?;
                }
            }

            println!("Dumpe alchemistische Formeln...");
            let formulas = dumper.dump_alchemy()?;
            let mut alchemy_txt = String::new();
            alchemy_txt.push_str("=== Secret of Evermore (DE) - 35 Alchemistische Formeln ===\n\n");
            for f in &formulas {
                alchemy_txt.push_str(&format!(
                    "[{:2}] {:<16} : {}x {} + {}x {} | Grundkosten: {}\n     Beschreibung: {}\n\n",
                    f.id, f.name, f.count1, f.ingredient1, f.count2, f.ingredient2, f.cost_level1, f.description
                ));
            }
            fs::write(out_dir.join("alchemy_de.txt"), alchemy_txt)?;
            println!("35 alchemistische Formeln gespeichert.");

            println!("Dumpe Charaktere und Gegner...");
            let characters = dumper.dump_characters()?;
            let mut chars_txt = String::new();
            chars_txt.push_str("=== Secret of Evermore (DE) - 142 Charaktere & Gegner ===\n\n");
            chars_txt.push_str(&format!(
                "{:<4} {:<24} {:<10} {:<6} {:<6} {:<6} {:<6} {:<6} {:<6} {:<8} {:<6}\n",
                "ID", "Name", "SNES-Adr", "HP", "ATK", "DEF", "M-DEF", "EVA", "HIT", "EXP", "Geld"
            ));
            chars_txt.push_str(&format!("{:-<96}\n", ""));
            for c in &characters {
                chars_txt.push_str(&format!(
                    "{:<4} {:<24} ${:<9X} {:<6} {:<6} {:<6} {:<6} {:<6} {:<6} {:<8} {:<6}\n",
                    c.id, c.name, c.snes_addr, c.hp, c.attack, c.defense, c.magic_defense, c.evade, c.hit_rate, c.exp, c.money
                ));
            }
            fs::write(out_dir.join("characters_de.txt"), chars_txt)?;
            println!("142 Charaktere/Gegner gespeichert.");

            println!("Dumpe Gegenstände, Waffen & Rüstungen...");
            let items = dumper.dump_items()?;
            let mut items_txt = String::new();
            items_txt.push_str("=== Secret of Evermore (DE) - Gegenstände, Waffen & Rüstungen ===\n\n");
            for it in &items {
                if let Some(desc) = &it.description {
                    items_txt.push_str(&format!("[ID {:3}] [{}] {} - {}\n", it.id, it.category, it.name, desc));
                } else {
                    items_txt.push_str(&format!("[ID {:3}] [{}] {}\n", it.id, it.category, it.name));
                }
            }
            fs::write(out_dir.join("items_de.txt"), items_txt)?;
            println!("{} Gegenstände gespeichert.", items.len());

            println!("\nErfolgreich gedumpt:");
            println!("  Maps: {}", map_count);
            println!("  Step-On Triggers: {}", total_step_on);
            println!("  B-Triggers / NPCs: {}", total_b_triggers);
            println!("  Alchemie-Formeln: {}", formulas.len());
            println!("  Charaktere/Gegner: {}", characters.len());
            println!("  Gegenstände/Waffen: {}", items.len());
            println!("  Zielverzeichnis: {}", out_dir.display());
        }
        Commands::Map { rom, id } => {
            let map_id = parse_hex_or_dec(&id)? as u8;
            let rom = Rom::load(&rom)?;
            let dumper = Dumper::new(&rom);

            if let Some(map) = dumper.dump_map(map_id)? {
                println!("=== Map 0x{:02X}: {} ===", map.id, map.name);
                println!("  Data SNES-Adresse: ${:06X}", map.data_snes_addr);
                println!("  Enter Script: ${:06X}", map.enter_script_snes_addr);
                println!("  Step-On Triggers: {}", map.step_on_triggers.len());
                println!("  B-Triggers (NPCs): {}", map.b_triggers.len());

                for (idx, t) in map.b_triggers.iter().enumerate() {
                    println!("\n--- B-Trigger #{}: [{},{} - {},{}] Script ID 0x{:04X} @ ${:06X} ---",
                        idx, t.x1, t.y1, t.x2, t.y2, t.script_id, t.script_snes_addr);
                    println!("{}", t.script.to_disassembly_string());
                }
            } else {
                println!("Map 0x{:02X} existiert nicht oder hat ungültige Daten.", map_id);
            }
        }
        Commands::Text { rom, id, limit } => {
            let rom = Rom::load(&rom)?;
            let decoder = soe_core::TextDecoder::new(&rom);

            if let Some(id) = id {
                let text = decoder.decode_entry(id)?;
                println!("[ID {:04X} ({})]:\n{}", id * 3, id, text);
            } else {
                for i in 0..limit {
                    if let Ok(text) = decoder.decode_entry(i) {
                        if !text.is_empty() {
                            println!("[ID {:04X} ({:3})]: {}", i * 3, i, text.replace('\n', " "));
                        }
                    }
                }
            }
        }
        Commands::Script { rom, addr, max_bytes } => {
            let snes_addr = parse_hex_or_dec(&addr)?;
            let rom = Rom::load(&rom)?;
            let disasm = Disassembler::new(&rom);
            let script = disasm.disassemble_script(snes_addr, max_bytes);
            println!("{}", script.to_disassembly_string());
            println!("\n--- Everscript ---");
            println!("{}", script.to_everscript_string());
        }
        Commands::Alchemy { rom } => {
            let rom = Rom::load(&rom)?;
            let dumper = Dumper::new(&rom);
            let formulas = dumper.dump_alchemy()?;
            println!("=== Secret of Evermore (DE) - 35 Alchemistische Formeln ===\n");
            for f in &formulas {
                println!("[{:2}] {:<16} : {}x {} + {}x {} | Grundkosten: {}",
                    f.id, f.name, f.count1, f.ingredient1, f.count2, f.ingredient2, f.cost_level1);
                println!("     Beschreibung: {}\n", f.description);
            }
        }
        Commands::Characters { rom, limit } => {
            let rom = Rom::load(&rom)?;
            let dumper = Dumper::new(&rom);
            let characters = dumper.dump_characters()?;
            let count = limit.min(characters.len());

            println!("{:<4} {:<24} {:<10} {:<6} {:<6} {:<6} {:<6} {:<6} {:<6} {:<8} {:<6}",
                "ID", "Name", "SNES-Adr", "HP", "ATK", "DEF", "M-DEF", "EVA", "HIT", "EXP", "Geld");
            println!("{:-<96}", "");

            for c in characters.iter().take(count) {
                println!("{:<4} {:<24} ${:<9X} {:<6} {:<6} {:<6} {:<6} {:<6} {:<6} {:<8} {:<6}",
                    c.id, c.name, c.snes_addr, c.hp, c.attack, c.defense, c.magic_defense, c.evade, c.hit_rate, c.exp, c.money);
            }
        }
        Commands::Items { rom } => {
            let rom = Rom::load(&rom)?;
            let dumper = Dumper::new(&rom);
            let items = dumper.dump_items()?;
            println!("=== Secret of Evermore (DE) - Gegenstände, Waffen & Rüstungen ({} Einträge) ===\n", items.len());
            for it in &items {
                if let Some(desc) = &it.description {
                    println!("[ID {:3}] [{}] {} - {}", it.id, it.category, it.name, desc);
                } else {
                    println!("[ID {:3}] [{}] {}", it.id, it.category, it.name);
                }
            }
        }
    }

    Ok(())
}

fn sanitize_filename(name: &str) -> String {
    name.chars()
        .map(|c| if c.is_alphanumeric() || c == '_' || c == '-' { c } else { '_' })
        .collect()
}

#[cfg(test)]
mod tests {
    use super::*;
    use clap::CommandFactory;

    #[test]
    fn test_verify_cli() {
        Cli::command().debug_assert();
    }
}

