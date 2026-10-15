// crates/soe-core/src/text.rs
use crate::rom::{Rom, RomError};

pub const TEXT_POINTER_TABLE_OFFSET: usize = 0x128000;
pub const MARKOV_TABLE_OFFSET: usize = 0x12A41E;
pub const TOTAL_TEXT_ENTRIES: usize = 3082;

pub struct TextDecoder<'a> {
    rom: &'a Rom,
}

impl<'a> TextDecoder<'a> {
    pub fn new(rom: &'a Rom) -> Self {
        Self { rom }
    }

    /// Dekodiert einen Text-Eintrag anhand seines Index (0..3081)
    pub fn decode_entry(&self, entry_index: usize) -> Result<String, RomError> {
        if entry_index >= TOTAL_TEXT_ENTRIES {
            return Err(RomError::OutOfBounds(entry_index));
        }
        let ptr_offset = TEXT_POINTER_TABLE_OFFSET + entry_index * 3;
        let b0 = self.rom.read_u8_at(ptr_offset)?;
        let b1 = self.rom.read_u8_at(ptr_offset + 1)?;
        let b2 = self.rom.read_u8_at(ptr_offset + 2)?;

        let is_compressed = ((b2 as u16) << 8 | (b1 as u16)) & 0x8000 != 0;
        let p = (b0 as usize) | (((b1 & 0x7F) as usize) << 8);

        // Bank-Berechnung exakt wie in $8CD0B8
        let bank = 0xC0usize + ((((b2 as usize) << 1) | ((b1 as usize) >> 7)) & 0xFF);
        let file_offset = (bank & 0x3F) * 0x10000 + p;

        if is_compressed {
            self.decompress(file_offset)
        } else {
            self.decode_ascii(file_offset)
        }
    }

    /// Dekodiert unkomprimierten Text aus der ROM.
    fn decode_ascii(&self, mut offset: usize) -> Result<String, RomError> {
        let mut raw = Vec::new();
        while let Ok(b) = self.rom.read_u8_at(offset) {
            if b == 0 {
                break;
            }
            raw.push(b);
            offset += 1;
        }
        Ok(format_german_text(&raw))
    }

    /// Führt die exakte 65816-Dekomprimierung ($8CD147) der deutschen ROM aus.
    fn decompress(&self, start_offset: usize) -> Result<String, RomError> {
        let mut pos = start_offset; // BRA $D174 springt direkt zu LDA [$22] ohne vorheriges INC $22
        let mut state_02 = 1; // 1 = low nibble, 0 = high nibble
        let mut cur_byte = self.rom.read_u8_at(pos)?;

        let mut prev_char: usize = 0;
        let mut out = Vec::new();

        // Sicherheitsgrenze gegen Endlosschleifen
        for _ in 0..10_000 {
            let nibble = if state_02 == 1 {
                cur_byte & 0x0F
            } else {
                (cur_byte >> 4) & 0x0F
            };

            if nibble == 0 {
                if state_02 == 0 {
                    // 0CD1A9: Aligned raw byte
                    pos += 1;
                    let b = self.rom.read_u8_at(pos)?;
                    if b == 0 {
                        break;
                    }
                    out.push(b);
                    prev_char = b as usize;

                    pos += 1;
                    cur_byte = self.rom.read_u8_at(pos)?;
                    state_02 = 1;
                    continue;
                } else {
                    // 0CD1BA: Unaligned raw byte (LSR 4)
                    let w0 = self.rom.read_u8_at(pos)? as u16;
                    let w1 = self.rom.read_u8_at(pos + 1)? as u16;
                    let w = w0 | (w1 << 8);
                    let b = ((w >> 4) & 0xFF) as u8;
                    if b == 0 {
                        break;
                    }
                    out.push(b);
                    prev_char = b as usize;

                    pos += 1;
                    cur_byte = self.rom.read_u8_at(pos)?;
                    state_02 = 0;
                    continue;
                }
            } else if nibble >= 0x0E {
                // 0x0E oder 0x0F: Doppel-Schritt über Markov-Top-Nachfolger
                let count = (nibble - 0x0E) as usize;
                let mut terminated = false;
                for _ in 0..=count {
                    let idx = prev_char * 14;
                    let b = self.rom.read_u8_at(MARKOV_TABLE_OFFSET + idx)?;
                    if b == 0 {
                        terminated = true;
                        break;
                    }
                    out.push(b);
                    prev_char = b as usize;
                }
                if terminated {
                    break;
                }
            } else {
                // Nibbles 1..13: Übergangstabelle
                let idx = prev_char * 14 + (nibble as usize);
                let b = self.rom.read_u8_at(MARKOV_TABLE_OFFSET + idx)?;
                if b == 0 {
                    break;
                }
                out.push(b);
                prev_char = b as usize;
            }

            // Nächstes Nibble
            if state_02 == 1 {
                state_02 = 0;
            } else {
                state_02 = 1;
                pos += 1;
                cur_byte = self.rom.read_u8_at(pos)?;
            }
        }

        Ok(format_german_text(&out))
    }
}

/// Formatiert rohe Evermore-Byte-Sequenzen in lesbares deutsches UTF-8 mit Steuerzeichen.
pub fn format_german_text(bytes: &[u8]) -> String {
    let mut result = String::new();
    let mut i = 0;

    while i < bytes.len() {
        let b = bytes[i];
        match b {
            0x0A => {
                result.push('\n');
                i += 1;
            }
            0x81 => {
                result.push_str("[Boy]");
                i += 1;
            }
            0x82 => {
                result.push_str("[Dog]");
                i += 1;
            }
            0x80 => {
                i += 1;
                if i + 1 < bytes.len() {
                    let lo = bytes[i] as u16;
                    let hi = bytes[i + 1] as u16;
                    let frames = ((hi << 8 | lo) >> 1) & 0x3FFF;
                    result.push_str(&format!("[Pause:{}]", frames));
                    i += 2;
                } else {
                    result.push_str("[Pause]");
                    i = bytes.len();
                }
            }
            0x86 => {
                // Wartet auf Tastendruck (A/B-Taste) und leert DANACH das Fenster
                result.push_str("[Wait]");
                i += 1;
            }
            0x87 => {
                result.push_str("[Clear]");
                i += 1;
            }
            0x8B => {
                result.push_str("[Marker]");
                i += 1;
            }
            0x92 => {
                result.push_str("[Center]");
                i += 1;
            }
            0x93 => {
                result.push_str("[Left]");
                i += 1;
            }
            0x96 => {
                result.push_str("[TypewriterOn]");
                i += 1;
            }
            0x97 => {
                result.push_str("[TypewriterOff]");
                i += 1;
            }
            0xA1..=0xA8 => {
                result.push_str(&format!("[Val{}]", b - 0xA0));
                i += 1;
            }
            // Deutsche Zeichensatz-Umlaute der PAL-Version
            0xE3 => {
                result.push('ä');
                i += 1;
            }
            0xEF => {
                result.push('ö');
                i += 1;
            }
            0xF3 => {
                result.push('ü');
                i += 1;
            }
            0xC6 => {
                result.push('ß');
                i += 1;
            }
            0xCB => {
                result.push('Ä');
                i += 1;
            }
            0xDB => {
                result.push('Ö');
                i += 1;
            }
            0xDF => {
                result.push('Ü');
                i += 1;
            }
            // Standard ASCII
            32..=126 => {
                result.push(b as char);
                i += 1;
            }
            // Unbekannte Steuerzeichen
            _ => {
                result.push_str(&format!("[{b:02X}]"));
                i += 1;
            }
        }
    }

    result
}
