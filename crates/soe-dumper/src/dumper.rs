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
        let enter_script_snes_addr = Rom::script_to_rom_addr(escript_target);
        let enter_script = if enter_script_snes_addr >= 0x800000 && enter_script_snes_addr <= 0xC00000 {
            Some(self.disasm.disassemble_script(enter_script_snes_addr, 500))
        } else {
            None
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

    /// Dumped alle deutschen Dialog-Texte (0..ca. 2500)
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
}
