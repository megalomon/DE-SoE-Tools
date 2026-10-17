// crates/soe-core/src/rom.rs
use std::fs::File;
use std::io::{self, Read};
use std::path::Path;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum RomError {
    #[error("I/O error: {0}")]
    Io(#[from] io::Error),
    #[error("Ungültige ROM-Größe: {0} Bytes (erwartet 3 MB oder 3 MB + 512 Byte Header)")]
    InvalidSize(usize),
    #[error("Keine gültige deutsche Secret of Evermore ROM (Header-Titel: '{0}', Region: 0x{1:02X})")]
    InvalidHeader(String, u8),
    #[error("Adresse 0x{0:06X} liegt außerhalb des ROM-Bereichs")]
    OutOfBounds(usize),
}

/// Repräsentiert die deutsche Secret of Evermore (PAL) ROM.
pub struct Rom {
    data: Vec<u8>,
    header_offset: usize,
}

impl Rom {
    pub const DE_HEADER_TITLE: &'static str = "SECRET OF EVERMORE   ";
    pub const DE_REGION_CODE: u8 = 0x09; // Deutschland / PAL
    pub const FAST_HIROM_MAP: u8 = 0x31;

    /// Lädt eine ROM aus einer Datei und validiert die deutsche Version.
    pub fn load<P: AsRef<Path>>(path: P) -> Result<Self, RomError> {
        let mut file = File::open(path)?;
        let mut data = Vec::new();
        file.read_to_end(&mut data)?;
        Self::from_bytes(data)
    }

    /// Erstellt eine Rom-Instanz aus einem Byte-Buffer.
    pub fn from_bytes(data: Vec<u8>) -> Result<Self, RomError> {
        let sz = data.len();
        let header_offset = if sz == 3_145_728 + 512 || sz == 3_670_016 + 512 || sz == 4_194_304 + 512 {
            512
        } else if sz == 3_145_728 || sz == 3_670_016 || sz == 4_194_304 {
            0
        } else {
            return Err(RomError::InvalidSize(sz));
        };

        let rom = Self { data, header_offset };
        rom.validate_de_header()?;
        Ok(rom)
    }

    /// Prüft den SNES-internen Header auf die deutsche Version.
    fn validate_de_header(&self) -> Result<(), RomError> {
        let header_pos = self.header_offset + 0xFFC0;
        if self.data.len() < header_pos + 0x30 {
            return Err(RomError::OutOfBounds(header_pos));
        }

        let title_bytes = &self.data[header_pos..header_pos + 21];
        let title = String::from_utf8_lossy(title_bytes).to_string();
        let region = self.data[header_pos + 0x19];

        if !title.starts_with("SECRET OF EVERMORE") || region != Self::DE_REGION_CODE {
            return Err(RomError::InvalidHeader(title, region));
        }

        Ok(())
    }

    /// Reiner Datenzugriff ohne 512-Byte SMC/Copier-Header.
    pub fn rom_bytes(&self) -> &[u8] {
        &self.data[self.header_offset..]
    }

    pub fn len(&self) -> usize {
        self.data.len() - self.header_offset
    }

    pub fn is_empty(&self) -> bool {
        self.len() == 0
    }

    /// Konvertiert eine 24-Bit SNES HiROM-Adresse in den Byte-Offset der ROM.
    /// In Secret of Evermore (HiROM) gilt:
    /// File-Offset = ((SNES_Addr >> 16) & 0x3F) * 0x10000 + (SNES_Addr & 0xFFFF)
    pub fn snes_to_file_offset(snes_addr: u32) -> usize {
        let bank_idx = ((snes_addr >> 16) & 0x3F) as usize;
        let addr_low = (snes_addr & 0xFFFF) as usize;
        bank_idx * 0x10000 + addr_low
    }

    /// Konvertiert einen File-Offset in eine SNES HiROM-Adresse (Standard in Bank $80..$FF).
    pub fn file_offset_to_snes(file_offset: usize) -> u32 {
        let bank_idx = (file_offset / 0x10000) as u32;
        let addr_low = (file_offset % 0x10000) as u32;
        ((bank_idx | 0x80) << 16) | addr_low
    }

    /// Liest ein Byte an einem ROM-Datei-Offset.
    pub fn read_u8_at(&self, offset: usize) -> Result<u8, RomError> {
        let real_off = self.header_offset + offset;
        if real_off < self.data.len() {
            Ok(self.data[real_off])
        } else {
            Err(RomError::OutOfBounds(offset))
        }
    }

    /// Liest ein 16-Bit Word (Little Endian) an einem ROM-Datei-Offset.
    pub fn read_u16_at(&self, offset: usize) -> Result<u16, RomError> {
        let b0 = self.read_u8_at(offset)? as u16;
        let b1 = self.read_u8_at(offset + 1)? as u16;
        Ok(b0 | (b1 << 8))
    }

    /// Liest eine 24-Bit Adresse (Little Endian) an einem ROM-Datei-Offset.
    pub fn read_u24_at(&self, offset: usize) -> Result<u32, RomError> {
        let b0 = self.read_u8_at(offset)? as u32;
        let b1 = self.read_u8_at(offset + 1)? as u32;
        let b2 = self.read_u8_at(offset + 2)? as u32;
        Ok(b0 | (b1 << 8) | (b2 << 16))
    }

    /// Liest ein Byte an einer 24-Bit SNES-Adresse.
    pub fn read_u8_snes(&self, snes_addr: u32) -> Result<u8, RomError> {
        let off = Self::snes_to_file_offset(snes_addr);
        self.read_u8_at(off)
    }

    /// Liest ein 16-Bit Word an einer 24-Bit SNES-Adresse.
    pub fn read_u16_snes(&self, snes_addr: u32) -> Result<u16, RomError> {
        let off = Self::snes_to_file_offset(snes_addr);
        self.read_u16_at(off)
    }

    /// Liest 24-Bit an einer 24-Bit SNES-Adresse.
    pub fn read_u24_snes(&self, snes_addr: u32) -> Result<u32, RomError> {
        let off = Self::snes_to_file_offset(snes_addr);
        self.read_u24_at(off)
    }

    /// Schreibt ein Byte an einem ROM-Datei-Offset.
    pub fn write_u8_at(&mut self, offset: usize, val: u8) -> Result<(), RomError> {
        let real_off = self.header_offset + offset;
        if real_off < self.data.len() {
            self.data[real_off] = val;
            Ok(())
        } else {
            Err(RomError::OutOfBounds(offset))
        }
    }

    /// Schreibt ein 16-Bit Word (Little Endian) an einem ROM-Datei-Offset.
    pub fn write_u16_at(&mut self, offset: usize, val: u16) -> Result<(), RomError> {
        self.write_u8_at(offset, (val & 0xFF) as u8)?;
        self.write_u8_at(offset + 1, ((val >> 8) & 0xFF) as u8)?;
        Ok(())
    }

    /// Schreibt eine Byte-Sequenz an einen ROM-Datei-Offset.
    pub fn write_bytes_at(&mut self, offset: usize, bytes: &[u8]) -> Result<(), RomError> {
        let real_off = self.header_offset + offset;
        if real_off + bytes.len() <= self.data.len() {
            self.data[real_off..real_off + bytes.len()].copy_from_slice(bytes);
            Ok(())
        } else {
            Err(RomError::OutOfBounds(offset))
        }
    }

    /// Schreibt ein Byte an einer 24-Bit SNES-Adresse.
    pub fn write_u8_snes(&mut self, snes_addr: u32, val: u8) -> Result<(), RomError> {
        let off = Self::snes_to_file_offset(snes_addr);
        self.write_u8_at(off, val)
    }

    /// Schreibt ein 16-Bit Word an einer 24-Bit SNES-Adresse.
    pub fn write_u16_snes(&mut self, snes_addr: u32, val: u16) -> Result<(), RomError> {
        let off = Self::snes_to_file_offset(snes_addr);
        self.write_u16_at(off, val)
    }

    /// Schreibt eine Byte-Sequenz an einer 24-Bit SNES-Adresse.
    pub fn write_bytes_snes(&mut self, snes_addr: u32, bytes: &[u8]) -> Result<(), RomError> {
        let off = Self::snes_to_file_offset(snes_addr);
        self.write_bytes_at(off, bytes)
    }

    /// Speichert die modifizierte ROM-Datei ab.
    pub fn save_to<P: AsRef<Path>>(&self, path: P) -> io::Result<()> {
        std::fs::write(path, &self.data)
    }

    /// Konvertiert eine SNES-ROM-Adresse in eine 24-Bit Skript-Adresse (im deutschen ROM ab 0x938000).
    pub fn rom_to_script_addr(rom_addr: u32) -> u32 {
        let start = crate::constants::DE_SCRIPTS_START_ADDR;
        let mut addr = rom_addr & !0x8000;
        addr = addr.saturating_sub(start & !0x8000);
        (addr & 0x7FFF) + ((addr & 0x1FF0000) >> 1)
    }

    /// Konvertiert eine 24-Bit Skript-Adresse zurück in eine SNES-ROM-Adresse (im deutschen ROM ab 0x938000).
    pub fn script_to_rom_addr(script_addr: u32) -> u32 {
        let start = crate::constants::DE_SCRIPTS_START_ADDR;
        start + (script_addr & 0x7FFF) + ((script_addr & 0xFF8000) << 1)
    }
}
