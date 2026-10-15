# DE-SoE-Tools

[![Rust](https://img.shields.io/badge/rust-2021%20edition-orange.svg)](https://www.rust-lang.org)
[![License](https://img.shields.io/badge/license-MIT%20OR%20Apache--2.0-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-SNES%20PAL%20(Germany)-red.svg)](#)
[![Vibe-Coded with Antigravity](https://img.shields.io/badge/vibe--coded%20with-Antigravity-8A2BE2.svg)](#)

Ein modernes, modulares All-in-One-Toolset in **Rust** für **Secret of Evermore (Deutsche PAL ROM)**.

Dieses Projekt portiert, vereinheitlicht und modernisiert drei essenzielle Werkzeuge der SoE-Hacking-Community von Grund auf in nativem Rust:

1. **`everscript`** (SIGIL Script-Compiler & Bytecode-Assembler – ursprünglich von [r-bin](https://github.com/r-bin/everscript))
2. **`soe-dumper`** (Map-, Script-, Trigger- und Dialogue-Dumper – ursprünglich *SoEScriptDumper* von [black-sliver](https://github.com/black-sliver/SoEScriptDumper))
3. **`soe-tiles`** (Tile-, Sprite- und Paletten-Dekoder mit PNG-Export – ursprünglich *SoETilesViewer* von [black-sliver](https://github.com/black-sliver/SoETilesViewer))

> [!IMPORTANT]
> **Fokus auf die deutsche PAL-Version (`Secret of Evermore (Germany).sfc`):**  
> Sämtliche Zeigertabellen, ROM-Offsets, Text-Dekomprimierungsroutinen und WRAM-Strukturen wurden direkt aus der deutschen PAL-ROM reverse-engineert. Die US-ROM-Kompatibilität wurde bewusst verworfen; veraltete Angaben aus US-zentrierten Wikis (z. B. DataCrystal) treffen hier nicht zu.

> [!WARNING]
> **Vibe-Coded mit Antigravity:**  
> Diese Codebase wurde maßgeblich mithilfe des KI-Assistenten **Antigravity** (Google DeepMind) erstellt und portiert („vibe-coded“). Obwohl sämtliche Dekompilierungs- und Assemblierungs-Routinen direkt gegen das 65816-Originalbinary der deutschen PAL-ROM geprüft und per Unit-Tests verifiziert wurden, können unerwartete Edge Cases oder Bugs auftreten. Nutzung auf eigene Gefahr – vor dem Patchen stets Backups der Original-ROM anlegen!

---

## Workspace-Architektur

Das Repository ist als Cargo-Workspace mit 5 sauber getrennten Crates organisiert:

```
DE-SoE-Tools/
├── Cargo.toml                  # Workspace-Definition & gemeinsame Abhängigkeiten
├── crates/
│   ├── soe-core/               # Basis-ROM-Handling, HiROM-Mapping, Markov-Text & Grafik
│   ├── soe-script/             # SIGIL AST, Disassembler, Bytecode-Assembler & Formatter
│   ├── soe-dumper/             # CLI-Tool: Map-, Skript- und Dialog-Extraktion
│   ├── everscript/             # CLI-Tool & Lib: SIGIL-Compiler, ROM-Patcher & IPS-Generator
│   └── soe-tiles/              # CLI-Tool & Lib: Tile-, Sprite- & Paletten-Viewer (PNG-Export)
```

| Crate | Typ | Beschreibung |
|---|---|---|
| **`soe-core`** | Library | Lädt die deutsche ROM, übernimmt HiROM-Adressberechnungen, dekomprimiert Dialogtexte nach dem originalen 65816-Algorithmus (`$8CD147`), parst SNES-BGR555-Farbpaletten und dekomprimiert 4bpp-Tiles sowie Sprite-Blöcke. |
| **`soe-script`** | Library | Beinhaltet den SIGIL-Befehlssatz (Opcode-Tabellen der DE-ROM), den Disassembler (`disasm.rs`), AST-Strukturen und den Bytecode-Assembler (`asm.rs`). |
| **`soe-dumper`** | Binary | Extrahiert Maps, B-Trigger (NPCs/Truhen), Step-On-Trigger, Raum-Skripte und alle deutschen Ingame-Dialoge in Text- oder JSON-Formate. |
| **`everscript`** | Binary + Lib | Kompiliert menschenlesbare `.evs`-Skripte in SIGIL-Bytecode. Unterstützt direktes Patchen der deutschen ROM sowie das Erzeugen von standardkonformen `.ips`-Patches. |
| **`soe-tiles`** | Binary + Lib | Liest Map-Tiles (16×16), Sprite-Blöcke (16×16 und 8×8) sowie Statuswerte von Charakteren/Gegnern aus und exportiert Grafiken als PNG. |

---

## Dokumentation (`docs/`)

Ausführliche, deutschsprachige Dokumente nach Vorbild von DataCrystal (speziell für die deutsche PAL-ROM):

- [**`docs/alchemie.md`**](docs/alchemie.md) – Alle 35 Zauberformeln mit echten deutschen Ingame-Namen, Rezepten, XP/Level-Adressen & Zutaten.
- [**`docs/ausruestung_items.md`**](docs/ausruestung_items.md) – Alle Waffen, Rüstungen, Helme, Armbänder, Hundehalsbänder, Verbrauchsitems, Allelachema-Tauschwaren & Relikte.
- [**`docs/event_flags.md`**](docs/event_flags.md) – Story- & Event-Flags, alle 24 Bosse (*Vulgor*, *Gorvul*, *Moorhexe*, etc.), Allelachema-Markt-Tauschflags & Sniff-Spots.
- [**`docs/speicheradressen.md`**](docs/speicheradressen.md) – WRAM-Systemübersicht: Währungen, Waffenlevel (16-Bit Word), Items & System-Offsets.
- [**`docs/maps.md`**](docs/maps.md) – Komplette Tabelle aller 127 Maps mit echten deutschen Ortsnamen (*Allelachema*, *Krozkrübel*, *Terrorfels*, *Chaosturm*, *Assitopia*), SNES-Headern, Enter-Skripten und Triggern.
- [**`docs/sigil_skripte.md`**](docs/sigil_skripte.md) – SIGIL Script-Engine, Opcode-Referenz und Kontrollfluss.
- [**`docs/text_dekomprimierung.md`**](docs/text_dekomprimierung.md) – 65816-Markov-Huffman-Dekomprimierer und Text-Steuerzeichen.

---

## Verifizierte Offsets der deutschen ROM (PAL)

Im Gegensatz zur US-ROM gelten für `Secret of Evermore (Germany).sfc` (SHA-1 / No-Intro PAL-Muster) folgende exakte Adressen:

| Bereich / Struktur | SNES-Adresse | Datei-Offset (PC) | Details |
|---|---|---|---|
| **Map-List Zeigertabelle** | `$A0:FDE5` | `0x20FDE5` | 127 Maps mit Tilemaps, Paletten & Skriptzeigern |
| **Script Start-Bereich** | `$93:8000` | `0x138000` | Bytecode aller Raumevents und Trigger |
| **Script Opcode Jump Table** | `$8C:ECBE` | `0x0CECBE` | Primäre Sprungtabelle für SIGIL-Befehle |
| **Script Sub-Opcode Table** | `$8C:F442` | `0x0CF442` | Sekundäre Sprungtabelle für Trigger-Befehle |
| **Text Pointer Table** | `$92:8000` | `0x128000` | 3 Bytes pro Eintrag: `(Offset & 0x7FFF)` + Bank |
| **Markov Text Decompressor**| `$8C:D147` | `0x0CD147` | Hardwarenahe 65816-Huffman/Markov-Dekomprimierung |
| **Markov Häufigkeitstabelle**| `$92:A41E` | `0x12A41E` | 14 Nachfolge-Zeichen pro Vorläuferzeichen |
| **16×16 Map-Tiles Tabelle** | `$EE:0000` | `0x2E0000` | 6.687 komprimierte Hintergrund-Tiles |
| **16×16 Sprite-Blocks** | `$EC:0000` | `0x2C0000` | 4.854 komprimierte Sprite-Blöcke |
| **8×8 Sprite-Blocks** | `$D8:0000` | `0x180000` | 6.265 komprimierte 8×8 Tiles |
| **Gegner- & Charakterdaten**| `$8E:B678` | `0x0EB678` | 142 Tabelleneinträge à 74 Bytes (HP, ATK, DEF etc.) |

---

## WRAM-Referenz (Deutsche ROM)

> [!TIP]
> Die vollständige, detaillierte Dokumentation aller Speicheradressen (inklusive aller 35 Zauberformeln, aller 22 Zutaten, Verbrauchsitems und Story-Flags) befindet sich in [**`docs/speicheradressen.md`**](docs/speicheradressen.md).

Für Romhacks, Skripte und TAS-Analysen:

### Währungen (24-Bit Little-Endian)
- **Krallen (Prähistorie):** `$7E0AC6` – `$7E0AC8`
- **Juwelen / Edelsteine (Antika):** `$7E0AC9` – `$7E0ACB`
- **Goldmünzen (Gotika):** `$7E0ACC` – `$7E0ACE`
- **Credits (Omnitopia):** `$7E0ACF` – `$7E0AD1`
- **Aktiver Währungsindex:** `$7E2348` (`0x00`, `0x03`, `0x06`, `0x09`)

### Waffenlevel & Erfahrung (16-Bit Word pro Waffe)
Aufbau: **Low-Byte (`+0`)** = XP / Ladefortschritt (`0..255`, im Statusmenü angezeigt als `(XP × 100) / 256` = `0..99%`), **High-Byte (`+1`)** = Level (`1..3`).

- **Fäuste:** `$7E0ADD`
- **Schwerter:**
  - Knochenknöppel: `$7E0ADF`
  - Drachentöter: `$7E0AE1`
  - Exkalibur: `$7E0AE3`
  - Laserschwert: `$7E0AE5`
- **Äxte:**
  - Tarantelaxt: `$7E0AE7`
  - Bronzeaxt: `$7E0AE9`
  - Streitaxt: `$7E0AEB`
  - Atomaxt: `$7E0AED`
- **Lanzen / Speere:**
  - Speer: `$7E0AEF`
  - Bronzespeer: `$7E0AF1`
  - Elfenbeinspeer: `$7E0AF3`
  - Neutronenspeer: `$7E0AF5`
- **Bazooka:** `$7E0AF7` (Verwendet Munition, kein Level)
- **Hund (Biss / Angriff):** `$7E0B07` (XP) & `$7E0B08` (Level)

---

## Kompilierung & Installation

Voraussetzung: Eine aktuelle Installation von **Rust** (mindestens Edition 2021).

```bash
# Repository klonen
git clone https://github.com/megalomon/DE-SoE-Tools.git
cd DE-SoE-Tools

# Alle Crates und CLI-Binaries im Release-Modus bauen
cargo build --release

# Workspace-Tests ausführen
cargo test --workspace
```

Die kompilierten Werkzeuge befinden sich anschließend in `target/release/`:
- `soe-dumper`
- `soe-tiles`
- `everscript`

---

## CLI-Handbuch

### 1. `soe-dumper`

```bash
# Alle Maps, Trigger, Skripte und deutschen Dialogtexte in ein Verzeichnis dumpen:
./target/release/soe-dumper dump-all --rom "Secret of Evermore (Germany).sfc" --out-dir ./dump_de

# Details & Skripte einer einzelnen Map anzeigen (z. B. Map 10 = Nobilia Markt):
./target/release/soe-dumper map --id 10

# Deutsche Dialogtexte auslesen (Standard: ab ID 0, Limit 20):
./target/release/soe-dumper text --limit 20

# Einen bestimmten Dialog gezielt ausgeben (z. B. ID 1284 = Pot Trader Lügner-Text):
./target/release/soe-dumper text --id 1284

# Beliebiges SIGIL-Skript an einer SNES-Adresse disassemblieren:
./target/release/soe-dumper script --addr 0x978712
```

### 2. `everscript`

```bash
# Kompiliert eine .evs Skriptdatei und patcht direkt eine Kopie der deutschen ROM:
./target/release/everscript compile script.evs --rom "Secret of Evermore (Germany).sfc" --out-rom patched.sfc

# Erzeugt einen IPS-Patch:
./target/release/everscript compile script.evs --ips patch.ips

# Gibt reinen Bytecode (.bin) zur Analyse oder Injektion aus:
./target/release/everscript compile script.evs --bin script.bin
```

#### Beispiel für Everscript-Quellcode (`test.evs`):
```c
enum FLAGS {
    CHOCOBO_EGG = 0x004E,
    MAGIC_GOURD = 0x0052,
}

fun pot_trader() = 0x978712 {
    if (!FLAG[FLAGS.MAGIC_GOURD]) {
        text(0x0F15);
        FLAG[FLAGS.CHOCOBO_EGG] = 1;
        give_jewels(100);
        text_end(0x0F27);
    } else {
        text(0x0F2A);
    }
    end();
}
```

### 3. `soe-tiles`

```bash
# Einzelnes 16x16 Map-Tile als PNG exportieren:
./target/release/soe-tiles tile --id 10 --out tile_10.png --palette "Podunk 1"

# 64 Map-Tiles als übersichtliches Grid/Sheet exportieren:
./target/release/soe-tiles sheet --start 0 --count 64 --columns 8 --out sheet_0_63.png

# 16x16 Sprite-Block als PNG exportieren:
./target/release/soe-tiles sprite-block --id 0 --out sprite_0.png --palette "Boy"

# 8x8 Sprite-Block als PNG exportieren:
./target/release/soe-tiles sprite-block --id 0 --small --out sprite_8x8.png --palette "Boy"

# Statuswerte aller 142 Charaktere und Monster aus der deutschen ROM anzeigen:
./target/release/soe-tiles characters --limit 30
```

---

## Danksagung & Credits

- **r-bin** für die bahnbrechende Arbeit an [everscript](https://github.com/r-bin/everscript).
- **black-sliver** für [SoEScriptDumper](https://github.com/black-sliver/SoEScriptDumper) und [SoETilesViewer](https://github.com/black-sliver/SoETilesViewer).
- **Nintendo of Europe & Square** für *Secret of Evermore* (PAL-Lokalisierung 1995/1996).

---

## Maintainer & Lizenz

- **Maintainer:** [megalomon](https://github.com/megalomon) (`megalomon@hotmail.de`)
- **Lizenz:** Dual-lizenziert unter [MIT](LICENSE-MIT) oder [Apache 2.0](LICENSE-APACHE).
