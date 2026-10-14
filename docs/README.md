# Dokumentation – DE-SoE-Tools

Dieses Verzeichnis dient als umfassende, deutsche Offline-Dokumentation für **Secret of Evermore (Deutsche PAL ROM)** – ähnlich wie ein hochdetailliertes DataCrystal-Wiki, jedoch exakt auf die europäische/deutsche Version (`Secret of Evermore (Germany).sfc`) zugeschnitten.

---

## Dokumenten-Übersicht

| Dokument | Beschreibung |
| :--- | :--- |
| [**`speicheradressen.md`**](speicheradressen.md) | **Vollständige WRAM- & Speicherübersicht:** Alle 4 Währungen, Waffenlevel & XP-Formeln, Bazooka-Munition, 35 Alchemie-Zauber, 22 Zutaten, Verbrauchsitems, Story-Flags (Bitfield ab `$7E2258`), Charakter-Stats und Mesen2-Cheat-Guide. |
| [**`maps.md`**](maps.md) | **Map-Architektur & Raum-Verzeichnis:** Detaillierte Tabelle aller 127 Maps (`0x00` bis `0x7E`) mit SNES-Header-Adressen, Enter-Skripten, Step-On-Triggern (Raumwechsel) und B-Triggern (NPCs/Truhen). |
| [**`sigil_skripte.md`**](sigil_skripte.md) | **SIGIL Script-Engine & Bytecode-Referenz:** Opcode-Sprungtabellen (`$8C:ECBE` / `$8C:F442`), Befehlssatz (Opcodes `0x00` bis `0x7A`), Kontrollfluss, Variablenbereiche (`FLAG`, `RAM`, `TEMP`) und Disassembly-Beispiele. |
| [**`text_dekomprimierung.md`**](text_dekomprimierung.md) | **Dialog- & Textsystem:** Zeigertabelle bei `$92:8000`, hardwarenahe Markov-Huffman-Dekomprimierung (`$8C:D147` / `$92:A41E`), 4-Bit-Nibble-Logik, Steuerzeichen (`[Box]`, `[Page]`, `[Delay]`, `[Choice]`) und deutsche Umlaute. |

---

> [!NOTE]
> Alle hier dokumentierten Daten wurden durch Disassemblierung des originalen 65816-Binärcodes der deutschen PAL-ROM verifiziert.
