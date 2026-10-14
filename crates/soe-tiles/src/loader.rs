// crates/soe-tiles/src/loader.rs
use serde::{Deserialize, Serialize};
use soe_core::{constants::*, gfx, Rom, RomError};

pub const MAP_TILES_COUNT: usize = 6687;
pub const SPRITE_BLOCKS_16_COUNT: usize = 4854;
pub const SPRITE_BLOCKS_8_COUNT: usize = 6265;
pub const CHARACTERS_COUNT: usize = 142;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CharacterStats {
    pub id: usize,
    pub snes_addr: u32,
    pub hp: u16,
    pub attack: u16,
    pub defense: u16,
    pub magic_defense: u16,
    pub evade: u16,
    pub hit_rate: u16,
    pub exp: u32,
    pub money: u16,
}

pub struct TileLoader<'a> {
    rom: &'a Rom,
}

impl<'a> TileLoader<'a> {
    pub fn new(rom: &'a Rom) -> Self {
        Self { rom }
    }

    /// Lädt und dekomprimiert ein 16x16 Map-Tile (Index 0..6686).
    pub fn load_map_tile(&self, index: usize) -> Result<Vec<u8>, RomError> {
        let ptr_addr = DE_MAP_TILES_PTR_TABLE + (index as u32) * 3;
        let data_addr = self.rom.read_u24_snes(ptr_addr)?;
        gfx::decompress_map_tile(self.rom, data_addr)
    }

    /// Lädt und dekomprimiert einen Sprite-Block (16x16 oder 8x8).
    pub fn load_sprite_block(&self, index: usize, is_16x16: bool) -> Result<Vec<u8>, RomError> {
        let (ptr_base, addr_base) = if is_16x16 {
            (DE_SPRITE_BLOCKS_16_PTR_TABLE, 0xD90000u32)
        } else {
            (DE_SPRITE_BLOCKS_8_PTR_TABLE, 0xD10000u32)
        };

        let ptr_addr = ptr_base + (index as u32) * 3;
        let raw = self.rom.read_u24_snes(ptr_addr)?;
        let compressed = (raw >> 23) != 0;
        let data_addr = (raw & 0x7FFFFF) + addr_base;

        gfx::decompress_sprite_block(self.rom, data_addr, is_16x16, compressed)
    }

    /// Lädt die Statuswerte eines Gegners/Charakters (0..141).
    pub fn load_character(&self, index: usize) -> Result<CharacterStats, RomError> {
        let snes_addr = DE_CHARACTER_DATA_BASE_ADDR + (index as u32) * 74;
        let off = Rom::snes_to_file_offset(snes_addr);

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

        Ok(CharacterStats {
            id: index,
            snes_addr,
            hp,
            attack,
            defense,
            magic_defense,
            evade,
            hit_rate,
            exp,
            money,
        })
    }
}
