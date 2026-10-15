// crates/soe-tiles/src/main.rs
use clap::{Parser, Subcommand};
use soe_core::Rom;
use soe_tiles::export::{export_sheet_to_png, export_tile_to_png};
use soe_tiles::loader::{TileLoader, CHARACTERS_COUNT};
use soe_tiles::palettes::get_palette_by_name;
use std::path::PathBuf;

#[derive(Parser)]
#[command(name = "soe-tiles")]
#[command(about = "Secret of Evermore (German PAL ROM) Tile, Sprite & Character Viewer/Exporter")]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// Exportiert ein einzelnes 16x16 Map-Tile als PNG
    Tile {
        #[arg(short, long, default_value = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc")]
        rom: PathBuf,

        #[arg(short, long)]
        id: usize,

        #[arg(short, long, default_value = "tile.png")]
        out: PathBuf,

        #[arg(short, long, default_value = "Podunk 1")]
        palette: String,

        /// Exportiert rohe, unkomprimierte Pixelbytes (.bin) statt PNG
        #[arg(long)]
        bin: bool,
    },
    /// Exportiert einen Sprite-Block (16x16 oder 8x8) als PNG oder Rohbinärdaten
    SpriteBlock {
        #[arg(short, long, default_value = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc")]
        rom: PathBuf,

        #[arg(short, long)]
        id: usize,

        #[arg(short, long)]
        small: bool,

        #[arg(short, long, default_value = "sprite.png")]
        out: PathBuf,

        #[arg(short, long, default_value = "Boy")]
        palette: String,

        /// Exportiert rohe, unkomprimierte Pixelbytes (.bin) statt PNG
        #[arg(long)]
        bin: bool,
    },
    /// Exportiert ein Grid/Sheet mehrerer Map-Tiles als zusammenhängendes PNG oder Rohbinärdaten
    Sheet {
        #[arg(short, long, default_value = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc")]
        rom: PathBuf,

        #[arg(short, long, default_value_t = 0)]
        start: usize,

        #[arg(short, long, default_value_t = 64)]
        count: usize,

        #[arg(short = 'C', long, default_value_t = 8)]
        columns: u32,

        #[arg(short, long, default_value = "sheet.png")]
        out: PathBuf,

        #[arg(short, long, default_value = "Podunk 1")]
        palette: String,

        /// Exportiert rohe, unkomprimierte Pixelbytes (.bin) statt PNG
        #[arg(long)]
        bin: bool,
    },
    /// Zeigt die Statuswerte aller Charaktere / Gegner aus der ROM
    Characters {
        #[arg(short, long, default_value = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc")]
        rom: PathBuf,

        #[arg(short, long, default_value_t = 20)]
        limit: usize,
    },
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let cli = Cli::parse();

    match cli.command {
        Commands::Tile { rom, id, out, palette, bin } => {
            let rom = Rom::load(&rom)?;
            let loader = TileLoader::new(&rom);

            println!("Lade 16x16 Map-Tile #{}...", id);
            let pixels = loader.load_map_tile(id)?;
            if bin {
                std::fs::write(&out, &pixels)?;
                println!("Rohe Pixelbytes erfolgreich gespeichert unter: {}", out.display());
            } else {
                let pal = get_palette_by_name(&palette);
                export_tile_to_png(&pixels, 16, 16, &pal, &out)?;
                println!("Tile erfolgreich gespeichert unter: {}", out.display());
            }
        }
        Commands::SpriteBlock { rom, id, small, out, palette, bin } => {
            let rom = Rom::load(&rom)?;
            let loader = TileLoader::new(&rom);
            let is_16x16 = !small;
            let size = if is_16x16 { 16 } else { 8 };

            println!("Lade {}x{} Sprite-Block #{}...", size, size, id);
            let pixels = loader.load_sprite_block(id, is_16x16)?;
            if bin {
                std::fs::write(&out, &pixels)?;
                println!("Rohe Pixelbytes erfolgreich gespeichert unter: {}", out.display());
            } else {
                let pal = get_palette_by_name(&palette);
                export_tile_to_png(&pixels, size, size, &pal, &out)?;
                println!("Sprite-Block erfolgreich gespeichert unter: {}", out.display());
            }
        }
        Commands::Sheet { rom, start, count, columns, out, palette, bin } => {
            let rom = Rom::load(&rom)?;
            let loader = TileLoader::new(&rom);

            println!("Lade {} Tiles ab Index {} ({} Spalten)...", count, start, columns);
            let mut tiles = Vec::new();
            for i in start..start + count {
                if let Ok(pix) = loader.load_map_tile(i) {
                    tiles.push(pix);
                }
            }
            if bin {
                let mut concat = Vec::new();
                for t in &tiles {
                    concat.extend_from_slice(t);
                }
                std::fs::write(&out, concat)?;
                println!("Rohe Sheet-Bytes ({} Tiles) gespeichert unter: {}", tiles.len(), out.display());
            } else {
                let pal = get_palette_by_name(&palette);
                export_sheet_to_png(&tiles, 16, columns, &pal, &out)?;
                println!("Tile-Sheet mit {} Tiles gespeichert unter: {}", tiles.len(), out.display());
            }
        }
        Commands::Characters { rom, limit } => {
            let rom = Rom::load(&rom)?;
            let loader = TileLoader::new(&rom);
            let count = limit.min(CHARACTERS_COUNT);

            println!("{:<4} {:<20} {:<10} {:<6} {:<6} {:<6} {:<6} {:<8} {:<6}",
                "ID", "Name", "SNES-Adr", "HP", "ATK", "DEF", "M-DEF", "EXP", "Geld");
            println!("{:-<80}", "");

            for i in 0..count {
                if let Ok(c) = loader.load_character(i) {
                    println!("{:<4} {:<20} ${:<9X} {:<6} {:<6} {:<6} {:<6} {:<8} {:<6}",
                        c.id, c.name, c.snes_addr, c.hp, c.attack, c.defense, c.magic_defense, c.exp, c.money);
                }
            }
        }
    }

    Ok(())
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
