# Dokumentation – DE-SoE-Tools

Dieses Verzeichnis dient als modulare, deutsche Offline-Dokumentation für **Secret of Evermore (Deutsche PAL ROM)** – ähnlich wie ein hochdetailliertes DataCrystal-Wiki, jedoch modular aufgeteilt und exakt auf die europäische/deutsche Version (`Secret of Evermore (Germany).sfc`) zugeschnitten.

---

## Modulare Dokumente im Überblick

| Dokument | Themenschwerpunkt & Inhalt |
| :--- | :--- |
| [**`alchemie.md`**](alchemie.md) | **Alchemie & Zaubersystem:** Alle 35 Zauberformeln mit ihren **exakten deutschen Ingame-Namen aus der ROM** (z. B. *Säuresturm*, *Kraftmeierei*, *Höllenfaust*, *Heilaura*, *Energieschild*, *Supersog*), allen 22 Zutaten, genauen Rezepten, Level- & XP-WRAM-Adressen (`$7E2F52` bis `$7E2FDC`) und Cheat-Codes. |
| [**`event_flags.md`**](event_flags.md) | **Event- & Story-Flags:** Vollständige Aufschlüsselung des WRAM-Bitfields ab `$7E2258`, alle 24 Boss-Besiegt-Flags (Thraxx, Salabog, Vigor, Megataur, Rimsala, etc.), alle Nobilia-Marktplatz-Tauschgeschäfte (Chocobo-Ei, Mythenschärpe, Jadereif, Sonnenstein), Sniff-Spots und Mesen2-Manipulationsguide. |
| [**`speicheradressen.md`**](speicheradressen.md) | **WRAM- & System-Speicherübersicht:** Die 4 Währungen (Krallen, Juwelen, Goldmünzen, Credits), Waffenlevel (16-Bit Word: XP Low-Byte, Level High-Byte), Bazooka-Munition, Charakter-Stats (Boy & Dog), Verbrauchsitems und SNES-Offsets. |
| [**`maps.md`**](maps.md) | **Map-Architektur & Raum-Verzeichnis:** Detaillierte Tabelle aller 127 Maps (`0x00` bis `0x7E`) mit SNES-Header-Adressen, Enter-Skripten, Step-On-Triggern (Raumwechsel) und B-Triggern (NPCs/Truhen). |
| [**`sigil_skripte.md`**](sigil_skripte.md) | **SIGIL Script-Engine & Bytecode-Referenz:** Opcode-Sprungtabellen (`$8C:ECBE` / `$8C:F442`), Befehlssatz (Opcodes `0x00` bis `0x7A`), Kontrollfluss, Variablenbereiche (`FLAG`, `RAM`, `TEMP`) und annotiertes Disassembly. |
| [**`text_dekomprimierung.md`**](text_dekomprimierung.md) | **Dialog- & Textsystem:** Zeigertabelle bei `$92:8000`, hardwarenahe Markov-Huffman-Dekomprimierung (`$8C:D147` / `$92:A41E`), 4-Bit-Nibble-Logik, Steuerzeichen (`[Box]`, `[Page]`, `[Delay]`, `[Choice]`) und deutsche Umlaute. |

---

> [!NOTE]
> Sämtliche Daten in diesen Dokumenten wurden durch statische und dynamische Disassemblierung der originalen 65816-Binärdaten der deutschen PAL-ROM verifiziert.
