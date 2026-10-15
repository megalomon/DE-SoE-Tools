// crates/soe-dumper/src/dumper.rs
use crate::maps::get_map_name;
use serde::{Deserialize, Serialize};
use soe_core::{constants::*, Rom, RomError, TextDecoder};
use soe_script::ast::Script;
use soe_script::disasm::Disassembler;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MapTrigger {
    pub x1: u8,
    pub y1: u8,
    pub x2: u8,
    pub y2: u8,
    pub script_id: u16,
    pub script_snes_addr: u32,
    pub script: Script,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MapDump {
    pub id: u8,
    pub name: String,
    pub data_snes_addr: u32,
    pub enter_script_snes_addr: u32,
    pub enter_script: Option<Script>,
    pub step_on_triggers: Vec<MapTrigger>,
    pub b_triggers: Vec<MapTrigger>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AlchemyFormulaDump {
    pub id: usize,
    pub name: String,
    pub description: String,
    pub ingredient1: String,
    pub count1: u8,
    pub ingredient2: String,
    pub count2: u8,
    pub cost_level1: u8,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CharacterDump {
    pub id: usize,
    pub snes_addr: u32,
    pub name: String,
    pub hp: u16,
    pub attack: u16,
    pub defense: u16,
    pub magic_defense: u16,
    pub evade: u16,
    pub hit_rate: u16,
    pub exp: u32,
    pub money: u16,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ItemDump {
    pub id: usize,
    pub category: String,
    pub name: String,
    pub description: Option<String>,
}

pub struct Dumper<'a> {
    rom: &'a Rom,
    disasm: Disassembler<'a>,
}

impl<'a> Dumper<'a> {
    pub fn new(rom: &'a Rom) -> Self {
        Self {
            rom,
            disasm: Disassembler::new(rom),
        }
    }

    /// Dumped eine spezifische Map anhand ihrer ID (0..127).
    pub fn dump_map(&self, map_id: u8) -> Result<Option<MapDump>, RomError> {
        let map_list_off = Rom::snes_to_file_offset(DE_MAP_LIST_ADDR);
        let ptr_off = map_list_off + (map_id as usize) * 4;
        if ptr_off + 3 > self.rom.len() {
            return Ok(None);
        }

        let data_snes_addr = self.rom.read_u24_at(ptr_off)?;
        if data_snes_addr > 0xAFFFFF || data_snes_addr < 0x800000 {
            return Ok(None);
        }

        let data_file_off = Rom::snes_to_file_offset(data_snes_addr);
        let name = get_map_name(map_id).to_string();

        // Map-Script-Zeigertabelle im deutschen ROM
        let scripts_start_off = Rom::snes_to_file_offset(DE_SCRIPTS_START_ADDR);
        let mapscript_ptr_word = self.rom.read_u16_at(scripts_start_off)?;
        let mapscriptptr_snes = DE_SCRIPTS_START_ADDR + (mapscript_ptr_word as u32);
        let mapscriptptr_off = Rom::snes_to_file_offset(mapscriptptr_snes);

        // Enter-Skript
        let escript_ptr = DE_SCRIPTS_START_ADDR + 0x1B + 5 * (map_id as u32);
        let escript_ptr_off = Rom::snes_to_file_offset(escript_ptr);
        let escript_target = self.rom.read_u24_at(escript_ptr_off)?;
        let (enter_script_snes_addr, enter_script) = if escript_target != 0 {
            let addr = Rom::script_to_rom_addr(escript_target);
            if addr >= 0x800000 && addr <= 0xC00000 {
                (addr, Some(self.disasm.disassemble_script(addr, 500)))
            } else {
                (addr, None)
            }
        } else {
            (0, None)
        };

        // Step-On Triggers (mscripts)
        let m_len = self.rom.read_u16_at(data_file_off + 0x0D)?;
        let m_ptr_off = data_file_off + 0x0D + 2;
        let mut step_on_triggers = Vec::new();
        if m_len % 6 == 0 && m_len <= 600 {
            let count = (m_len / 6) as usize;
            for i in 0..count {
                let entry_off = m_ptr_off + i * 6;
                let y1 = self.rom.read_u8_at(entry_off)?;
                let x1 = self.rom.read_u8_at(entry_off + 1)?;
                let y2 = self.rom.read_u8_at(entry_off + 2)?;
                let x2 = self.rom.read_u8_at(entry_off + 3)?;
                let script_id = self.rom.read_u16_at(entry_off + 4)?;

                let target_script_ptr = mapscriptptr_off + (script_id as usize);
                let target_val = self.rom.read_u24_at(target_script_ptr)?;
                let script_snes_addr = Rom::script_to_rom_addr(target_val);
                let script = self.disasm.disassemble_script(script_snes_addr, 500);

                step_on_triggers.push(MapTrigger {
                    x1,
                    y1,
                    x2,
                    y2,
                    script_id,
                    script_snes_addr,
                    script,
                });
            }
        }

        // B-Triggers (bscripts)
        let b_len_off = data_file_off + 0x0D + 2 + (m_len as usize);
        let b_len = self.rom.read_u16_at(b_len_off)?;
        let b_ptr_off = b_len_off + 2;
        let mut b_triggers = Vec::new();
        if b_len % 6 == 0 && b_len <= 600 {
            let count = (b_len / 6) as usize;
            for i in 0..count {
                let entry_off = b_ptr_off + i * 6;
                let y1 = self.rom.read_u8_at(entry_off)?;
                let x1 = self.rom.read_u8_at(entry_off + 1)?;
                let y2 = self.rom.read_u8_at(entry_off + 2)?;
                let x2 = self.rom.read_u8_at(entry_off + 3)?;
                let script_id = self.rom.read_u16_at(entry_off + 4)?;

                let target_script_ptr = mapscriptptr_off + (script_id as usize);
                let target_val = self.rom.read_u24_at(target_script_ptr)?;
                let script_snes_addr = Rom::script_to_rom_addr(target_val);
                let script = self.disasm.disassemble_script(script_snes_addr, 500);

                b_triggers.push(MapTrigger {
                    x1,
                    y1,
                    x2,
                    y2,
                    script_id,
                    script_snes_addr,
                    script,
                });
            }
        }

        Ok(Some(MapDump {
            id: map_id,
            name,
            data_snes_addr,
            enter_script_snes_addr,
            enter_script,
            step_on_triggers,
            b_triggers,
        }))
    }

    /// Dumped alle deutschen Dialog-Texte (0..3082)
    pub fn dump_texts(&self, limit: usize) -> Vec<(usize, String)> {
        let decoder = TextDecoder::new(self.rom);
        let mut texts = Vec::new();
        for i in 0..limit {
            match decoder.decode_entry(i) {
                Ok(s) => {
                    if !s.is_empty() {
                        texts.push((i, s));
                    }
                }
                Err(_) => break,
            }
        }
        texts
    }

    /// Dumped alle 35 alchemistischen Formeln mit Zutaten und Beschreibungen
    pub fn dump_alchemy(&self) -> Result<Vec<AlchemyFormulaDump>, RomError> {
        let mut ingredients = Vec::new();
        for i in 0..22 {
            let ptr = self.rom.read_u16_at(0x050659 + i * 2)? as usize;
            let mut raw = Vec::new();
            let mut cur = 0x050000 + ptr;
            while let Ok(b) = self.rom.read_u8_at(cur) {
                if b == 0 {
                    break;
                }
                raw.push(b);
                cur += 1;
            }
            ingredients.push(soe_core::format_german_text(&raw));
        }

        let mut formulas = Vec::new();
        for i in 0..35 {
            let n_ptr = self.rom.read_u16_at(0x05036F + i * 2)? as usize;
            let mut raw_n = Vec::new();
            let mut cur_n = 0x050000 + n_ptr;
            while let Ok(b) = self.rom.read_u8_at(cur_n) {
                if b == 0 {
                    break;
                }
                raw_n.push(b);
                cur_n += 1;
            }
            let name = soe_core::format_german_text(&raw_n);

            let d_ptr = self.rom.read_u16_at(0x0503B7 + i * 2)? as usize;
            let mut raw_d = Vec::new();
            let mut cur_d = 0x050000 + d_ptr;
            while let Ok(b) = self.rom.read_u8_at(cur_d) {
                if b == 0 {
                    break;
                }
                raw_d.push(b);
                cur_d += 1;
            }
            let description = soe_core::format_german_text(&raw_d);

            let r_off = 0x050685 + i * 4;
            let i1 = self.rom.read_u8_at(r_off)? as usize;
            let i2 = self.rom.read_u8_at(r_off + 1)? as usize;
            let c1 = self.rom.read_u8_at(r_off + 2)?;
            let c2 = self.rom.read_u8_at(r_off + 3)?;

            let ingr1 = ingredients.get(i1).cloned().unwrap_or_else(|| format!("Zutat_{}", i1));
            let ingr2 = ingredients.get(i2).cloned().unwrap_or_else(|| format!("Zutat_{}", i2));

            let cost = self.rom.read_u8_at(0x050202 + i).unwrap_or(0);

            formulas.push(AlchemyFormulaDump {
                id: i + 1,
                name,
                description,
                ingredient1: ingr1,
                count1: c1,
                ingredient2: ingr2,
                count2: c2,
                cost_level1: cost,
            });
        }
        Ok(formulas)
    }

    /// Dumped alle 142 Charaktere/Gegner mit Statuswerten und deutschen Namen
    pub fn dump_characters(&self) -> Result<Vec<CharacterDump>, RomError> {
        let mut chars = Vec::new();
        for i in 0..142 {
            let snes_addr = DE_CHARACTER_DATA_BASE_ADDR + (i as u32) * 74;
            let off = Rom::snes_to_file_offset(snes_addr);

            let p0 = self.rom.read_u8_at(off)? as usize;
            let p1 = self.rom.read_u8_at(off + 1)? as usize;
            let p2 = self.rom.read_u8_at(off + 2)? as usize;
            let name = if p2 == 0x7E {
                if i == 0 {
                    "Held (Junge)".to_string()
                } else {
                    "Hund".to_string()
                }
            } else {
                let name_off = (p2 & 0x3F) * 0x10000 + (p0 | (p1 << 8));
                let mut raw = Vec::new();
                let mut cur = name_off;
                while let Ok(b) = self.rom.read_u8_at(cur) {
                    if b == 0 {
                        break;
                    }
                    raw.push(b);
                    cur += 1;
                }
                let decoded = soe_core::format_german_text(&raw);
                if decoded.is_empty() {
                    format!("Gegner_{:03}", i)
                } else {
                    decoded
                }
            };

            let hp = self.rom.read_u16_at(off + 0x0F)?;
            let attack = self.rom.read_u16_at(off + 0x19)?;
            let defense = self.rom.read_u16_at(off + 0x1B)?;
            let magic_defense = self.rom.read_u16_at(off + 0x1D)?;
            let evade = self.rom.read_u16_at(off + 0x1F)?;
            let hit_rate = self.rom.read_u16_at(off + 0x21)?;
            let b0 = self.rom.read_u8_at(off + 0x23)? as u32;
            let b1 = self.rom.read_u8_at(off + 0x24)? as u32;
            let b2 = self.rom.read_u8_at(off + 0x25)? as u32;
            let b3 = self.rom.read_u8_at(off + 0x26)? as u32;
            let exp = b0 | (b1 << 8) | (b2 << 16) | (b3 << 24);
            let money = self.rom.read_u16_at(off + 0x27)?;

            chars.push(CharacterDump {
                id: i,
                snes_addr,
                name,
                hp,
                attack,
                defense,
                magic_defense,
                evade,
                hit_rate,
                exp,
                money,
            });
        }
        Ok(chars)
    }

    /// Dumped alle Gegenstände, Waffen, Rüstungen und Tauschwaren
    pub fn dump_items(&self) -> Result<Vec<ItemDump>, RomError> {
        let mut items = Vec::new();
        let mut id = 1;

        // 1. Verbrauchsgegenstände
        let consumables = [
            ("Blätter", "Heilt 30 KP des Helden."),
            ("Nektar", "Heilt 40 KP des Hundes."),
            ("Honig", "Heilt 100 KP des Helden."),
            ("Hundekuchen", "Heilt 120 KP des Hundes."),
            ("Flügel", "Bringt die Helden zurück zum Eingang eines Dungeons."),
            ("Elixier", "Heilt alle KP von Held und Hund vollständig."),
            ("Elfenstaub", "Belebt gefallene Gefährten wieder."),
            ("Zauberperle", "Ermöglicht das Rufen von Zaubern ohne Alchemie-Zutaten."),
        ];
        for (name, desc) in consumables {
            items.push(ItemDump {
                id,
                category: "Verbrauchsgegenstand".to_string(),
                name: name.to_string(),
                description: Some(desc.to_string()),
            });
            id += 1;
        }

        // 2. Waffen
        let weapons = [
            ("Knochenknüppel", "Schwert", "Liegt gut in der Hand. Die erste Nahkampfwaffe."),
            ("Drachentöter", "Schwert", "Effektiv gegen Moskitos und Flugdrachen."),
            ("Exkalibur", "Schwert", "Das Schwert aus der Legende."),
            ("Laserschwert", "Schwert", "Das ultimative Hightech-Schwert."),
            ("Tarantelaxt", "Axt", "Zerstört störendes Buschwerk."),
            ("Bronzeaxt", "Axt", "Zertrümmert solide Felsen."),
            ("Streitaxt", "Axt", "Vernichtet alle Arten von Gegnern."),
            ("Atomaxt", "Axt", "Zerteilt alles - sogar Atome."),
            ("Speer", "Speer", "Die ideale Nahkampfwaffe mit Reichweite."),
            ("Bronzespeer", "Speer", "Eine höchst ansehnliche und scharfe Waffe."),
            ("Elfenbeinspeer", "Speer", "Starker Speer mit hoher Durchschlagskraft."),
            ("Neutronenspeer", "Speer", "Neutralisiert Gegner auf Distanz."),
            ("Bazooka", "Fernkampf", "Verschießt schwere Sprengmunition."),
        ];
        for (name, subcat, desc) in weapons {
            items.push(ItemDump {
                id,
                category: format!("Waffe ({})", subcat),
                name: name.to_string(),
                description: Some(desc.to_string()),
            });
            id += 1;
        }

        // 3. Rüstungen
        let armors = [
            ("Moosweste", "Rüstung"),
            ("Panzerrüstung", "Rüstung"),
            ("Raptorleder", "Rüstung"),
            ("Bronzerüstung", "Rüstung"),
            ("Granitpanzer", "Rüstung"),
            ("Römertoga", "Rüstung"),
            ("Silberrüstung", "Rüstung"),
            ("Goldrüstung", "Rüstung"),
            ("Neonweste", "Rüstung"),
            ("Stahlpanzer", "Rüstung"),
            ("Titaniumweste", "Rüstung"),
            ("Cyberweste", "Rüstung"),
            ("Hippiemütze", "Helm"),
            ("Panzerhelm", "Helm"),
            ("Schädelhelm", "Helm"),
            ("Bronzehelm", "Helm"),
            ("Blecheimer", "Helm"),
            ("Römerhelm", "Helm"),
            ("Titanenkrone", "Helm"),
            ("Drachenhelm", "Helm"),
            ("Ritterhelm", "Helm"),
            ("Blitzableiter", "Helm"),
            ("Lampenschirm", "Helm"),
            ("Elektrohelm", "Helm"),
            ("Gemüsearmband", "Armband"),
            ("Bleiarmband", "Armband"),
            ("Klauenreif", "Armband"),
            ("Schlangenarmband", "Armband"),
            ("Bronzeklaue", "Armband"),
            ("Feuerfetisch", "Armband"),
            ("Eisenarmband", "Armband"),
            ("Roys Ring", "Armband"),
            ("Drachenklaue", "Armband"),
            ("Cyberhandschuh", "Armband"),
            ("Karmaring", "Armband"),
            ("Elektroarmband", "Armband"),
            ("Lederhalsband", "Hundehalsband"),
            ("Nietenhalsband", "Hundehalsband"),
            ("Silberhalsband", "Hundehalsband"),
            ("Juwelenhalsband", "Hundehalsband"),
        ];
        for (name, cat) in armors {
            items.push(ItemDump {
                id,
                category: cat.to_string(),
                name: name.to_string(),
                description: None,
            });
            id += 1;
        }

        // 4. Tauschwaren & Schlüsselgegenstände aus Bank 05 ($C5:1A2F..$C5:1BCE)
        let mut cur = 0x051A2F;
        while cur < 0x051BD0 {
            let mut raw = Vec::new();
            while let Ok(b) = self.rom.read_u8_at(cur) {
                if b == 0 {
                    cur += 1;
                    break;
                }
                raw.push(b);
                cur += 1;
            }
            if raw.len() > 1 {
                let name = soe_core::format_german_text(&raw);
                if !name.is_empty() {
                    items.push(ItemDump {
                        id,
                        category: "Tauschware / Schlüsselgegenstand".to_string(),
                        name,
                        description: None,
                    });
                    id += 1;
                }
            }
        }

        Ok(items)
    }
}
