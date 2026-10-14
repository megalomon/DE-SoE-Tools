// crates/everscript/src/linker.rs
use crate::compiler::CompiledBlock;
use soe_core::{Rom, RomError};
use std::fs;
use std::path::Path;

pub struct Linker;

impl Linker {
    /// Patcht kompilierte Blöcke direkt in ein Rom-Objekt.
    pub fn patch_rom(rom: &mut Rom, blocks: &[CompiledBlock]) -> Result<(), RomError> {
        for block in blocks {
            if let Some(snes_addr) = block.address {
                rom.write_bytes_snes(snes_addr, &block.bytecode)?;
            }
        }
        Ok(())
    }

    /// Erzeugt einen IPS-Patch aus den kompilierten Blöcken.
    pub fn create_ips_patch<P: AsRef<Path>>(blocks: &[CompiledBlock], path: P) -> Result<(), std::io::Error> {
        let mut patch = Vec::new();
        // IPS Header: "PATCH"
        patch.extend_from_slice(b"PATCH");

        for block in blocks {
            if let Some(snes_addr) = block.address {
                let file_offset = Rom::snes_to_file_offset(snes_addr);
                let len = block.bytecode.len();
                if len == 0 || len > 0xFFFF {
                    continue;
                }

                // 3 bytes offset (Big Endian)
                patch.push(((file_offset >> 16) & 0xFF) as u8);
                patch.push(((file_offset >> 8) & 0xFF) as u8);
                patch.push((file_offset & 0xFF) as u8);

                // 2 bytes size (Big Endian)
                patch.push(((len >> 8) & 0xFF) as u8);
                patch.push((len & 0xFF) as u8);

                // Data
                patch.extend_from_slice(&block.bytecode);
            }
        }

        // IPS Trailer: "EOF"
        patch.extend_from_slice(b"EOF");

        fs::write(path, patch)?;
        Ok(())
    }
}
