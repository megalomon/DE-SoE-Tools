// crates/soe-core/src/gfx.rs
use crate::rom::{Rom, RomError};

/// SNES BGR555 Farbkonvertierung
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct RgbaColor {
    pub r: u8,
    pub g: u8,
    pub b: u8,
    pub a: u8,
}

impl RgbaColor {
    pub const TRANSPARENT: Self = Self { r: 0, g: 0, b: 0, a: 0 };

    /// Konvertiert ein 16-Bit SNES BGR555 Word in RGBA (0..255).
    pub fn from_snes_bgr555(c: u16, transparent: bool) -> Self {
        if transparent {
            return Self::TRANSPARENT;
        }
        let r5 = (c & 0x1F) as u8;
        let g5 = ((c >> 5) & 0x1F) as u8;
        let b5 = ((c >> 10) & 0x1F) as u8;

        // Skalierung von 5-bit (0..31) auf 8-bit (0..255): (v << 3) | (v >> 2)
        let r = (r5 << 3) | (r5 >> 2);
        let g = (g5 << 3) | (g5 >> 2);
        let b = (b5 << 3) | (b5 >> 2);

        Self { r, g, b, a: 255 }
    }

    pub fn to_u32_argb(&self) -> u32 {
        ((self.a as u32) << 24) | ((self.r as u32) << 16) | ((self.g as u32) << 8) | (self.b as u32)
    }
}

/// SNES 16-Farben-Palette (4bpp Palette)
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Palette {
    pub colors: [RgbaColor; 16],
}

impl Default for Palette {
    fn default() -> Self {
        Self {
            colors: [RgbaColor::TRANSPARENT; 16],
        }
    }
}

impl Palette {
    /// Erzeugt eine Palette aus 16 SNES BGR555 Werten.
    pub fn from_snes_words(words: &[u16; 16], color0_transparent: bool) -> Self {
        let mut colors = [RgbaColor::TRANSPARENT; 16];
        for i in 0..16 {
            let transparent = (i == 0) && color0_transparent;
            colors[i] = RgbaColor::from_snes_bgr555(words[i], transparent);
        }
        Self { colors }
    }

    /// Liest eine 16-Farben-Palette (32 Bytes) direkt aus der ROM.
    pub fn from_rom(rom: &Rom, offset: usize, color0_transparent: bool) -> Result<Self, RomError> {
        let mut words = [0u16; 16];
        for (i, item) in words.iter_mut().enumerate() {
            *item = rom.read_u16_at(offset + i * 2)?;
        }
        Ok(Self::from_snes_words(&words, color0_transparent))
    }
}

/// Dekodiert ein SNES 4bpp 8x8 Tile (32 Bytes Planardaten) in ein Array von 64 Farbindizes (0..15).
pub fn decode_4bpp_tile_8x8(data: &[u8]) -> [u8; 64] {
    let mut pixels = [0u8; 64];
    if data.len() < 32 {
        return pixels;
    }

    for y in 0..8 {
        let bp0 = data[y * 2];
        let bp1 = data[y * 2 + 1];
        let bp2 = data[y * 2 + 16];
        let bp3 = data[y * 2 + 17];

        for x in 0..8 {
            let mask = 1 << (7 - x);
            let mut val = 0u8;
            if (bp0 & mask) != 0 {
                val |= 1;
            }
            if (bp1 & mask) != 0 {
                val |= 2;
            }
            if (bp2 & mask) != 0 {
                val |= 4;
            }
            if (bp3 & mask) != 0 {
                val |= 8;
            }
            pixels[y * 8 + x] = val;
        }
    }
    pixels
}

/// Dekodiert ein unkomprimiertes SNES 4bpp 16x16 Tile (128 Bytes: 4 Sub-Tiles 8x8).
pub fn decode_4bpp_tile_16x16(data: &[u8]) -> [u8; 256] {
    let mut pixels = [0u8; 256];
    if data.len() < 128 {
        return pixels;
    }

    let sub_tiles = [
        decode_4bpp_tile_8x8(&data[0..32]),   // Top-Left
        decode_4bpp_tile_8x8(&data[32..64]),  // Top-Right
        decode_4bpp_tile_8x8(&data[64..96]),  // Bottom-Left
        decode_4bpp_tile_8x8(&data[96..128]), // Bottom-Right
    ];

    for ty in 0..2 {
        for tx in 0..2 {
            let tile_idx = ty * 2 + tx;
            let sub = &sub_tiles[tile_idx];
            for y in 0..8 {
                for x in 0..8 {
                    let dest_y = ty * 8 + y;
                    let dest_x = tx * 8 + x;
                    pixels[dest_y * 16 + dest_x] = sub[y * 8 + x];
                }
            }
        }
    }

    pixels
}

/// Dekomprimiert ein Evermore Map-Tile (16x16, 4bpp) basierend auf der Original-ROM-Logik.
pub fn decompress_map_tile(rom: &Rom, data_addr: u32) -> Result<Vec<u8>, RomError> {
    let file_off = Rom::snes_to_file_offset(data_addr);
    let tile_info = rom.read_u8_at(file_off)?;
    let is_compressed = (tile_info & 0x80) != 0;

    let uncompressed_size = 128usize; // 16x16 at 4bpp = 128 bytes
    let mut planar = vec![0u8; uncompressed_size];

    if !is_compressed {
        let mut word_count = ((tile_info & 0x7F) as usize) + 1;
        if word_count > 64 {
            word_count = 64;
        }
        let copy_bytes = (word_count * 2).min(uncompressed_size);
        for i in 0..copy_bytes {
            planar[i] = rom.read_u8_at(file_off + 1 + i)?;
        }
        // Falls word_count < 64: Letztes Word bis zum Ende wiederholen
        if copy_bytes >= 2 && copy_bytes < uncompressed_size {
            let last_w0 = planar[copy_bytes - 2];
            let last_w1 = planar[copy_bytes - 1];
            for i in (copy_bytes..uncompressed_size).step_by(2) {
                planar[i] = last_w0;
                if i + 1 < uncompressed_size {
                    planar[i + 1] = last_w1;
                }
            }
        }
    } else {
        let data_offset = (tile_info & 0x7F) as usize;
        let mut data_ptr = file_off + data_offset;
        let mut cmd_ptr = file_off + 1;
        let mut cmd_second_half = false;
        let mut out_pos = 0usize;

        let mut read4_cmd = || -> Result<u8, RomError> {
            let mut res = rom.read_u8_at(cmd_ptr)?;
            if cmd_second_half {
                res &= 0x0F;
                cmd_ptr += 1;
            } else {
                res >>= 4;
            }
            cmd_second_half = !cmd_second_half;
            Ok(res)
        };

        'outer: loop {
            let mut comp_indicators = rom.read_u8_at(data_ptr)?;
            data_ptr += 1;

            for _ in 0..8 {
                if (comp_indicators & 0x80) == 0 {
                    // Unkomprimiertes Word
                    if out_pos < uncompressed_size {
                        planar[out_pos] = rom.read_u8_at(data_ptr)?;
                        out_pos += 1;
                    }
                    data_ptr += 1;
                    if out_pos < uncompressed_size {
                        planar[out_pos] = rom.read_u8_at(data_ptr)?;
                        out_pos += 1;
                    }
                    data_ptr += 1;
                } else {
                    // Komprimiertes Token
                    let mode = read4_cmd()?;
                    match mode {
                        0 => {
                            if out_pos < uncompressed_size { planar[out_pos] = 0x00; out_pos += 1; }
                            if out_pos < uncompressed_size { planar[out_pos] = 0x00; out_pos += 1; }
                        }
                        1 => {
                            if out_pos < uncompressed_size { planar[out_pos] = 0xFF; out_pos += 1; }
                            if out_pos < uncompressed_size { planar[out_pos] = 0x00; out_pos += 1; }
                        }
                        2 => {
                            if out_pos < uncompressed_size { planar[out_pos] = 0x00; out_pos += 1; }
                            if out_pos < uncompressed_size { planar[out_pos] = 0xFF; out_pos += 1; }
                        }
                        3 => {
                            if out_pos < uncompressed_size { planar[out_pos] = 0xFF; out_pos += 1; }
                            if out_pos < uncompressed_size { planar[out_pos] = 0xFF; out_pos += 1; }
                        }
                        4 => {
                            let b = rom.read_u8_at(data_ptr)?;
                            data_ptr += 1;
                            if out_pos < uncompressed_size { planar[out_pos] = b; out_pos += 1; }
                            if out_pos < uncompressed_size { planar[out_pos] = 0x00; out_pos += 1; }
                        }
                        5 => {
                            let b = rom.read_u8_at(data_ptr)?;
                            data_ptr += 1;
                            if out_pos < uncompressed_size { planar[out_pos] = b; out_pos += 1; }
                            if out_pos < uncompressed_size { planar[out_pos] = 0xFF; out_pos += 1; }
                        }
                        6 => {
                            let b = rom.read_u8_at(data_ptr)?;
                            data_ptr += 1;
                            if out_pos < uncompressed_size { planar[out_pos] = 0x00; out_pos += 1; }
                            if out_pos < uncompressed_size { planar[out_pos] = b; out_pos += 1; }
                        }
                        7 => {
                            let b = rom.read_u8_at(data_ptr)?;
                            data_ptr += 1;
                            if out_pos < uncompressed_size { planar[out_pos] = 0xFF; out_pos += 1; }
                            if out_pos < uncompressed_size { planar[out_pos] = b; out_pos += 1; }
                        }
                        8 => {
                            let b = rom.read_u8_at(data_ptr)?;
                            data_ptr += 1;
                            if out_pos < uncompressed_size { planar[out_pos] = b; out_pos += 1; }
                            if out_pos < uncompressed_size { planar[out_pos] = b; out_pos += 1; }
                        }
                        9..=12 => {
                            let extra = if mode == 12 { read4_cmd()? } else { 0 };
                            let n = ((mode - 9 + 1) + extra) as usize;
                            for _ in 0..n {
                                let (w0, w1) = if out_pos >= 2 {
                                    (planar[out_pos - 2], planar[out_pos - 1])
                                } else {
                                    (0, 0)
                                };
                                if out_pos < uncompressed_size { planar[out_pos] = w0; out_pos += 1; }
                                if out_pos < uncompressed_size { planar[out_pos] = w1; out_pos += 1; }
                                if out_pos >= uncompressed_size {
                                    break;
                                }
                            }
                        }
                        13 => {
                            let last = if out_pos >= 2 { planar[out_pos - 2] } else { 0 };
                            let b = rom.read_u8_at(data_ptr)?;
                            data_ptr += 1;
                            if out_pos < uncompressed_size { planar[out_pos] = last; out_pos += 1; }
                            if out_pos < uncompressed_size { planar[out_pos] = b; out_pos += 1; }
                        }
                        14 => {
                            let b = rom.read_u8_at(data_ptr)?;
                            data_ptr += 1;
                            let last = if out_pos >= 2 { planar[out_pos - 1] } else { 0 };
                            if out_pos < uncompressed_size { planar[out_pos] = b; out_pos += 1; }
                            if out_pos < uncompressed_size { planar[out_pos] = last; out_pos += 1; }
                        }
                        15 => {
                            let b = rom.read_u8_at(data_ptr)?;
                            data_ptr += 1;
                            if out_pos < uncompressed_size { planar[out_pos] = b; out_pos += 1; }
                            if out_pos < uncompressed_size { planar[out_pos] = b ^ 0xFF; out_pos += 1; }
                        }
                        _ => unreachable!(),
                    }
                }

                if out_pos >= uncompressed_size {
                    break 'outer;
                }
                comp_indicators <<= 1;
            }
        }
    }

    // Wandelt die dekomprimierten 128 Planar-Bytes in 256 Pixel-Indizes um
    Ok(decode_4bpp_tile_16x16(&planar).to_vec())
}

/// Dekomprimiert ein Evermore Sprite-Block Tile (8x8 oder 16x16).
pub fn decompress_sprite_block(rom: &Rom, data_addr: u32, is_16x16: bool, compressed: bool) -> Result<Vec<u8>, RomError> {
    let file_off = Rom::snes_to_file_offset(data_addr);
    let uncompressed_size = if is_16x16 { 128usize } else { 32usize };
    let mut planar = vec![0u8; uncompressed_size];

    if compressed {
        let mut din = file_off;
        let mut dout = 0usize;
        let words_count = uncompressed_size / 2;
        let groups = words_count / 8;

        for _ in 0..groups {
            let mut bits = rom.read_u8_at(din)?;
            din += 1;
            for _ in 0..8 {
                let bit = bits & 1;
                bits >>= 1;
                if bit == 0 {
                    // Wort direkt kopieren
                    if dout < uncompressed_size {
                        planar[dout] = rom.read_u8_at(din)?;
                        dout += 1;
                    }
                    din += 1;
                    if dout < uncompressed_size {
                        planar[dout] = rom.read_u8_at(din)?;
                        dout += 1;
                    }
                    din += 1;
                } else {
                    // Wort ist 0x0000 (bereits mit 0 initialisiert)
                    dout += 2;
                }
            }
        }
    } else {
        for i in 0..uncompressed_size {
            planar[i] = rom.read_u8_at(file_off + i)?;
        }
    }

    if is_16x16 {
        Ok(decode_4bpp_tile_16x16(&planar).to_vec())
    } else {
        Ok(decode_4bpp_tile_8x8(&planar).to_vec())
    }
}
