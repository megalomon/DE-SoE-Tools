// crates/everscript/src/main.rs
use clap::{Parser, Subcommand};
use everscript::compiler::Compiler;
use everscript::linker::Linker;
use everscript::parser::Parser as EvsParser;
use everscript::token::Lexer;
use soe_core::Rom;
use std::fs;
use std::path::PathBuf;

#[derive(Parser)]
#[command(name = "everscript")]
#[command(about = "Secret of Evermore (German PAL ROM) SIGIL Script Compiler")]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// Kompiliert eine .evs Skriptdatei
    Compile {
        /// Quell-Skriptdatei (.evs)
        input: PathBuf,

        /// Basis-ROM (deutsch)
        #[arg(short, long, default_value = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc")]
        rom: PathBuf,

        /// Ausgabe einer gepatchten ROM-Datei (.sfc)
        #[arg(short, long)]
        out_rom: Option<PathBuf>,

        /// Ausgabe eines IPS-Patches (.ips)
        #[arg(long)]
        ips: Option<PathBuf>,

        /// Ausgabe des rohen Bytecodes (.bin)
        #[arg(short, long)]
        bin: Option<PathBuf>,
    },
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let cli = Cli::parse();

    match cli.command {
        Commands::Compile { input, rom, out_rom, ips, bin } => {
            println!("Lese Skript: {}", input.display());
            let source = fs::read_to_string(&input)?;

            println!("Tokenisiere...");
            let mut lexer = Lexer::new(&source);
            let tokens = lexer.tokenize().map_err(|e| format!("Lexer-Fehler: {}", e))?;

            println!("Parse AST...");
            let mut parser = EvsParser::new(tokens);
            let ast = parser.parse_file().map_err(|e| format!("Parser-Fehler: {}", e))?;

            println!("Kompiliere in SIGIL-Bytecode...");
            let mut compiler = Compiler::new();
            let blocks = compiler.compile_file(&ast).map_err(|e| format!("Compiler-Fehler: {}", e))?;

            println!("Kompilierte Blöcke: {}", blocks.len());
            for b in &blocks {
                let addr_str = b.address.map(|a| format!("${:06X}", a)).unwrap_or_else(|| "Dynamic".to_string());
                println!("  - Block '{}': {} Bytes @ {}", b.name, b.bytecode.len(), addr_str);
            }

            if let Some(bin_path) = bin {
                let mut all_bytes = Vec::new();
                for b in &blocks {
                    all_bytes.extend_from_slice(&b.bytecode);
                }
                fs::write(&bin_path, all_bytes)?;
                println!("Roher Bytecode gespeichert unter: {}", bin_path.display());
            }

            if let Some(ips_path) = ips {
                Linker::create_ips_patch(&blocks, &ips_path)?;
                println!("IPS-Patch gespeichert unter: {}", ips_path.display());
            }

            if let Some(out_rom_path) = out_rom {
                println!("Lade Basis-ROM: {}", rom.display());
                let mut rom = Rom::load(&rom)?;
                Linker::patch_rom(&mut rom, &blocks)?;
                rom.save_to(&out_rom_path)?;
                println!("Gepatchte ROM gespeichert unter: {}", out_rom_path.display());
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

