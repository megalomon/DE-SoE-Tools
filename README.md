# DE-SoE-Tools

Ein modernes, modulares Toolset in **Rust** für **Secret of Evermore (Deutsche PAL ROM)**.

Dieses Projekt portiert und adaptiert drei Kern-Werkzeuge der SoE-Hacking-Community vollständig auf die deutsche PAL-Version (`Secret of Evermore (Germany).sfc`):
1. **everscript** (SIGIL Script-Compiler / Assembler)
2. **SoEScriptDumper** (Room-, Map- und Skript-Disassembler & Dialogue-Dumper)
3. **SoETilesViewer** (Tile-, Sprite- und Paletten-Dekoder mit PNG-Export)

Die Kompatibilität zur US-Version wurde verworfen; sämtliche Algorithmen, Tabellen und Zeigerstrukturen sind exakt auf das deutsche ROM-Layout abgestimmt.

---

## Workspace-Architektur

Das Projekt ist als Cargo-Workspace mit 5 Crates aufgebaut:

| Crate | Typ | Beschreibung |
|---|---|---|
| `soe-core` | Library | Basis-ROM-Handling, HiROM-Adresskonvertierung, deutsches Text-Dekomprimierungssystem (`$8CD147`, Markov-Tabellen), SNES BGR555 Paletten, SNES 4bpp Planar-Tile-Dekoder & Evermore RLE/Nibble-Dekomprimierung. |
| `soe-script` | Library | SIGIL Skript-AST, Disassembler und Assembler / Bytecode-Emitter für die deutsche ROM. |
| `soe-dumper` | Binary | CLI-Port von *SoEScriptDumper*. Dumped alle 127 Maps, Step-On-Triggers, B-Triggers (NPCs) und deutsche Dialoge. |
| `everscript` | Binary + Lib | CLI-Port des *Everscript*-Compilers in Rust. Kompiliert `.evs` / `.ev` Quellcode in SIGIL-Bytecode, patchen in die deutsche ROM oder erzeugt IPS-Patches. |
| `soe-tiles` | Binary + Lib | CLI-Port von *SoETilesViewer*. Extrahiert Map-Tiles (16x16), Sprite-Blocks (16x16 / 8x8) und Charakter-Stats und exportiert sie als PNG. |

---

## Wichtige Adressen der deutschen ROM (PAL)

Im Gegensatz zur US-ROM (und veralteten DataCrystal-Angaben) gelten für die deutsche Version folgende Offsets:

- **Script Opcode Jump Table:** `$8C:ECBE` (`0x0CECBE`)
- **Script Sub-Instruction Table:** `$8C:F442` (`0x0CF442`)
- **Script Start-Adresse:** `$93:8000` (`0x138000`)
- **Map-List Zeigertabelle:** `$A0:FDE5` (`0x20FDE5`) (127 Maps)
- **Dialog-Text Zeigertabelle:** `$92:8000` (`0x128000`)
- **Dialog-Text Markov-Dekodiermethode:** `$8C:D147` mit Tabelle bei `$92:A41E` (`0x12A41E`)
- **Map-Tiles (16x16) Zeigertabelle:** `$EE:0000` (`0x2E0000`) (6.687 Tiles)
- **Sprite-Blocks (16x16) Zeigertabelle:** `$EC:0000` (`0x2C0000`) (4.854 Blocks)
- **Sprite-Blocks (8x8) Zeigertabelle:** `$D8:0000` (`0x180000`) (6.265 Blocks)
- **Charakter- / Gegner-Daten:** `$8E:B678` (`0x0EB678`) (142 Einträge á 74 Bytes)

---

## CLI-Nutzung

### 1. `soe-dumper` (Map- & Script-Dumper)

```bash
# Alle 127 Maps, Trigger, Enter-Skripte und deutschen Dialoge dumpen:
soe-dumper dump-all --rom "rom/Secret of Evermore (Germany).sfc" --out-dir ./dump_de

# Einzelne Map disassemblieren (z.B. Nobilia Markt = 0x0A):
soe-dumper map --id 0x0A

# Deutsche Dialog-Texte anzeigen:
soe-dumper text --limit 20
soe-dumper text --id 5

# Beliebiges Skript an einer SNES-Adresse disassemblieren:
soe-dumper script --addr 0x978712
```

### 2. `everscript` (SIGIL Script-Compiler)

```bash
# Kompiliert ein .evs Skript und patcht direkt eine Kopie der deutschen ROM:
everscript compile script.evs --rom "rom/Secret of Evermore (Germany).sfc" --out-rom patched.sfc

# Erzeugt einen IPS-Patch:
everscript compile script.evs --ips patch.ips

# Gibt rohen SIGIL-Bytecode aus:
everscript compile script.evs --bin script.bin
```

Beispiel für Everscript-Syntax:
```c
enum FLAGS {
    CHOCOBO_EGG = 0x004E,
    MAGIC_GOURD = 0x0052,
}

fun pot_trader() = 0x978712 {
    if (!FLAG[FLAGS.MAGIC_GOURD]) {
        text(0x0F15);
        FLAG[FLAGS.CHOCOBO_EGG] = 1;
        give_jewels(50);
        text_end(0x0F27);
    } else {
        text(0x0F2A);
    }
    end();
}
```

### 3. `soe-tiles` (Grafik- & Tile-Exporter)

```bash
# Einzelnes 16x16 Map-Tile als PNG exportieren:
soe-tiles tile --id 10 --out tile_10.png --palette "Podunk 1"

# Sprite-Block (16x16 oder 8x8) als PNG exportieren:
soe-tiles sprite-block --id 0 --out boy_sprite_0.png --palette "Boy"
soe-tiles sprite-block --id 0 --small --out boy_sprite_8x8.png --palette "Boy"

# 64 Map-Tiles als Grid/Sheet exportieren:
soe-tiles sheet --start 0 --count 64 --columns 8 --out tilesheet.png

# Charakter- und Gegnerstatistiken anzeigen:
soe-tiles characters --limit 25
```

---

## Build & Tests

```bash
cargo build --workspace --release
cargo test --workspace
```
