# Dokumentation – DE-SoE-Tools

Dieses Verzeichnis dient als modulare, deutsche Offline-Dokumentation für **Secret of Evermore (Deutsche PAL ROM)** – ähnlich wie ein hochdetailliertes DataCrystal-Wiki, jedoch modular aufgeteilt und exakt auf die europäische/deutsche Version (`Secret of Evermore (Germany).sfc`) zugeschnitten.

---

## Modulare Dokumente im Überblick

| Dokument | Themenschwerpunkt & Inhalt |
| :--- | :--- |
| [**`alchemie.md`**](alchemie.md) | **Alchemie & Zaubersystem:** Alle 35 spielbaren Zauberformeln mit ihren **exakten deutschen Ingame-Namen aus der ROM** (z. B. *Säureregen*, *Arnold*, *Superschild*, *Zauberperlen*, *Höllenfaust*, *Heilaura*, *Bienenattacke*), allen 22 Zutaten, genauen Rezepten sowie Level- & XP-WRAM-Adressen (`$7E2F52` bis `$7E2FDC`). Zudem vollständige Dokumentation der **7 englischen Test- & Debug-Zauber** (*Magic: Thud Ball Missile*, *High Voltage*, etc.), der **ungenutzten Übersetzungs-Entwürfe** (*Kraftmeierei*, *Lehmgranaten*, *Zauberwand*, *Splitter*) und der **17 Gegnerzauber** (*Feuerhölle*, *Hitzewelle*, *Orkantornado*, *Disruptor*, etc.) inklusive der internen Kampf-Laufschrifttabelle bei `$C5:062B`. |
| [**`ausruestung_items.md`**](ausruestung_items.md) | **Ausrüstung, Waffen & Items:** Vollständiges Verzeichnis aller 12 Waffen (Schwerter, Äxte, Speere) mit verifizierten Basis-Angriffswerten und authentischen Beschreibungen, Bazooka-Munition, 12 Rüstungen (*Moosweste*, *Panzerrüstung*, *Cyberweste*) mit exakten Abwehrwerten, 12 Helme (*Hippiemütze*, *Panzerhelm*), 12 Armbänder, 4 Hundehalsbänder, Verbrauchsitems (*Blätter*, *Nektar*, *Honig*), alle Allelachema-Tauschwaren (*Keramiktopf*, *Perle*, *Gewürz*) und 14 permanente Relikte (*Armor Ultra*, *Chocobo-Ei*, *Jaguarring*). |
| [**`event_flags.md`**](event_flags.md) | **Event- & Story-Flags:** Vollständige Aufschlüsselung des WRAM-Bitfields ab `$7E2258`, alle 24 Boss-Besiegt-Flags mit authentischen deutschen Ingame-Namen (*Vulgor*, *Sumpfmonster*, *Knochenviper*, *Lavarex*, *Panzerminos*, *Bastet*, *Monsterqualle*, *Rattus*, *Baumdrache*, *Dr. Gallenstein*, *Edgars Roboter & Edgar*, etc.), alle Allelachema-Marktplatz-Tauschgeschäfte (*Chocobo-Ei*, *Mythenschärpe*, *Jadereif*, *Sonnenstein*) und Sniff-Spots (Hund-Schnüffelstellen). |
| [**`speicheradressen.md`**](speicheradressen.md) | **WRAM- & System-Speicherübersicht:** Die 4 Währungen (Krallen, Juwelen, Goldmünzen, Kreditkarten), Waffenlevel (16-Bit Word: XP Low-Byte, Level High-Byte), Bazooka-Munition, Charakter-Stats (Boy & Dog), Verbrauchsitems und SNES-Offsets. |
| [**`maps.md`**](maps.md) | **Map-Architektur & Raum-Verzeichnis:** Detaillierte Tabelle aller 127 Maps (`0x00` bis `0x7E`) mit deutschen Ingame-Ortsbezeichnungen (*Allelachema*, *Krozkrübel*, *Terrorfels*, *Chaosturm*, *Assitopia*, *Großostheim*), SNES-Header-Adressen, Enter-Skripten, Step-On-Triggern (Raumwechsel) und B-Triggern (NPCs/Truhen). |
| [**`sigil_skripte.md`**](sigil_skripte.md) | **SIGIL Script-Engine & Bytecode-Referenz:** Vollständige 65816-Interpreter-Architektur in Bank `$8C`, kooperativer Multitasking-Scheduler (`$8C:D3EC` / `$7E:2F28`), Master-Tabelle aller 195 Opcodes (`0x00` bis `0xC2`), Sub-Opcode-Auswertung auf dem Hardware-Stack (`$8C:F442`), 15-Bit gepackte Skript-Adressierung, Dialog-Steuerzeichen und Map-Trigger-Integration. |
| [**`text_dekomprimierung.md`**](text_dekomprimierung.md) | **Dialog- & Textsystem:** Zeigertabelle bei `$92:8000` (exakt 3082 Texte), hardwarenahe Markov-Huffman-Dekomprimierung (`$8C:D147` / `$92:A41E`), 4-Bit-Nibble-Logik, Steuerzeichen (`[Pause:n]`, `[Wait]`, `[Clear]`, `[Marker]`, `[Left]`, `[Center]`, `[TypewriterOn]`) und deutsche Umlaute. |

---

> [!NOTE]
> Sämtliche Daten in diesen Dokumenten wurden durch statische und dynamische Disassemblierung der originalen 65816-Binärdaten der deutschen PAL-ROM verifiziert.
