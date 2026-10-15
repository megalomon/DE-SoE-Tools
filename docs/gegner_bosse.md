# Gegner, Bosse und Charakter-Daten (Secret of Evermore - German PAL)

Dieses Dokument dokumentiert die vollständige Struktur, Speicheradressen und Statuswerte aller 142 Charaktere, Gegner und Bosse aus der deutschen Version von *Secret of Evermore* (`Secret of Evermore (Germany).sfc`).

---

## 1. Speicherarchitektur & Datenstrukturen

### 1.1 Basistabelle im ROM
- **SNES-Basisadresse:** `$8E:B678` (File-Offset: `0x0EB678`)
- **Eintragsgröße:** 74 Bytes (`0x4A` Bytes pro Datensatz)
- **Gesamtanzahl:** 142 Einträge (Index `0x00` bis `0x8D` bzw. `0..141`)
- **Gesamtgröße der Tabelle:** 10.508 Bytes (`142 * 74`)
- **Endadresse im ROM:** `$8E:DF84` (File-Offset: `0x0EDF84`)

### 1.2 Namenszeiger & Lokalisierung (Bank $05)
- Jedes Charakter-Struct beginnt bei Offset `+0x00` mit einem 24-Bit-Zeiger (`Little-Endian`, 3 Bytes):
  - Für den spielbaren Helden (Index 0) und Hund (Index 1) zeigt der Zeiger in das WRAM (`$7E:2210` bzw. `$7E:2234`).
  - Für alle NPCs, regulären Gegner und Bosse (Index 2..141) zeigt der Zeiger in Bank `$05` (`$C5:xxxx`, File-Offset: `0x050000 + xxxx`).
  - Die Namen liegen dort als null-terminierte ASCII/PAL-Strings mit spezieller deutscher Umlaut-Kodierung (`0xE3` = ä, `0xEF` = ö, `0xF3` = ü, `0xDF` = ß, `0xC4` = Ä).

### 1.3 Aufbau des 74-Byte Datensatzes

| Offset | Typ | Feldname | Beschreibung |
|--------|-----|----------|--------------|
| `+0x00` | `u24` | `name_ptr` | 24-Bit-Pointer auf den null-terminierten Namen (Bank `$05` oder `$7E`) |
| `+0x03` | `u16` | `sprite_id` | Sprite-/Grafik-Definition |
| `+0x05` | `u8`  | `palette` | Farbpaletten-Index |
| `+0x06` | `u8`  | `collision_w` | Kollisionsbreite / Hitbox X |
| `+0x07` | `u8`  | `collision_h` | Kollisionshöhe / Hitbox Y |
| `+0x08` | `u16` | `anim_table` | Animations-Zeiger |
| `+0x0A` | `u16` | `script_init` | Initialisierungs-Skript |
| `+0x0C` | `u16` | `script_ai` | KI-Verhaltens-Skript |
| `+0x0E` | `u8`  | `flags_1` | Status- und Render-Flags |
| `+0x0F` | `u16` | `hp` | Maximale Kraftpunkte (KP) |
| `+0x11` | `u16` | `ai_param` | KI-Parameter / Reaktionsradius |
| `+0x13` | `u16` | `script_damage` | Treffer-/Schadensreaktion |
| `+0x15` | `u16` | `script_death` | Todes-/Sterbeskript |
| `+0x17` | `u16` | `behavior_flags` | Flug-/Boden-/Boss-Status |
| `+0x19` | `u16` | `attack` | Angriffskraft (ATK) |
| `+0x1B` | `u16` | `defense` | Abwehrkraft (DEF) |
| `+0x1D` | `u16` | `magic_defense` | Magie-Abwehr (M-DEF) |
| `+0x1F` | `u16` | `evade` | Ausweichwahrscheinlichkeit (EVA in %) |
| `+0x21` | `u16` | `hit_rate` | Trefferquote (HIT in %) |
| `+0x23` | `u32` | `exp` | Erfahrungspunkte (EXP) bei Sieg |
| `+0x27` | `u16` | `money` | Erhaltenes Geld (Talente/Dukaten/Juwelen) |
| `+0x29` | `u8`  | `drop_item_1` | Beute 1 (Item-ID) |
| `+0x2A` | `u8`  | `drop_rate_1` | Drop-Wahrscheinlichkeit 1 |
| `+0x2B` | `u8`  | `drop_item_2` | Beute 2 (Item-ID) |
| `+0x2C` | `u8`  | `drop_rate_2` | Drop-Wahrscheinlichkeit 2 |
| `+0x2D` | `u8`  | `alch_resist` | Resistenz gegen Alchemiezauber |
| `+0x2E` | `u8`  | `status_immune` | Immunitäten (Gift, Starre, Verwirrung) |
| `+0x2F`..`+0x49` | `[u8; 27]` | `reserved` | Sound-IDs, Zauberlisten, Phasendaten |

---

## 2. Vollständige Liste aller 142 Charaktere und Gegner

| ID | Name | SNES-Adresse | HP | ATK | DEF | M-DEF | EVA | HIT | EXP | Geld |
|---|---|---|---|---|---|---|---|---|---|---|
| 0 | Held (Junge) | $8EB678 | 30 | 0 | 0 | 0 | 38% | 38% | 0 | 0 |
| 1 | Hund | $8EB6C2 | 36 | 0 | 0 | 0 | 50% | 50% | 0 | 0 |
| 2 | Junge | $8EB70C | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 3 | Mädchen | $8EB756 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 4 | Mann | $8EB7A0 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 5 | Frau | $8EB7EA | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 6 | Alter Mann | $8EB834 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 7 | Alte Frau | $8EB87E | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 8 | Schmusetier | $8EB8C8 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 9 | Schmusetier | $8EB912 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 10 | Alchemist | $8EB95C | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 11 | Harry | $8EB9A6 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 12 | Zora Zottelzopf | $8EB9F0 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 13 | Sarah Spalthaar | $8EBA3A | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 14 | Junge | $8EBA84 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 15 | Mädchen | $8EBACE | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 16 | Mann | $8EBB18 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 17 | Frau | $8EBB62 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 18 | Alter Mann | $8EBBAC | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 19 | Alte Frau | $8EBBF6 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 20 | Berater | $8EBC40 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 21 | Alchemist | $8EBC8A | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 22 | Hektor Lektor | $8EBCD4 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 23 | Felsbrocken | $8EBD1E | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 24 | Felsbrocken | $8EBD68 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 25 | Dummy 25 | $8EBDB2 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 26 | Dummy 26 | $8EBDFC | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 27 | Statue | $8EBE46 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 28 | Brücke | $8EBE90 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 29 | Legendärer Junge | $8EBEDA | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 30 | Legendäres Mädchen | $8EBF24 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 31 | Legendäre Großmutter | $8EBF6E | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 32 | Legendärer König | $8EBFB8 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 33 | Legendärer Mann | $8EC002 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 34 | Legendärer Wikinger | $8EC04C | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 35 | Schlauer Bär | $8EC096 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 36 | Moronius | $8EC0E0 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 37 | Hektors Bruder | $8EC12A | 30 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 38 | Edgar | $8EC174 | 30 | 0 | 0 | 0 | 0% | 0% | 15 | 10 |
| 39 | Dr. Nierenfels | $8EC1BE | 30 | 0 | 0 | 0 | 0% | 0% | 15 | 10 |
| 40 | Dr. Gallenstein | $8EC208 | 30 | 0 | 0 | 0 | 0% | 0% | 15 | 10 |
| 41 | Prof. Igor Seltsam | $8EC252 | 30 | 0 | 0 | 0 | 0% | 0% | 15 | 10 |
| 42 | Brunhilde von Chaosturm | $8EC29C | 30 | 0 | 0 | 0 | 0% | 0% | 15 | 10 |
| 43 | Gunilla von Fettamsel | $8EC2E6 | 30 | 0 | 0 | 0 | 0% | 0% | 15 | 10 |
| 44 | Marktschreier | $8EC330 | 10 | 0 | 0 | 0 | 0% | 0% | 915 | 10 |
| 45 | Erwin | $8EC37A | 150 | 0 | 0 | 0 | 0% | 0% | 915 | 10 |
| 46 | Harry | $8EC3C4 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 47 | Morbius | $8EC40E | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 48 | Morbius | $8EC458 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 49 | Morbius | $8EC4A2 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 50 | Morbius | $8EC4EC | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 51 | Doppelgänger | $8EC536 | 120 | 61 | 160 | 38 | 0% | 85% | 20 | 20 |
| 52 | Flatterschädel | $8EC580 | 200 | 36 | 0 | 25 | 15% | 75% | 20 | 20 |
| 53 | Irrlicht | $8EC5CA | 40 | 41 | 160 | 38 | 20% | 80% | 20 | 20 |
| 54 | Ureusstatue | $8EC614 | 100 | 88 | 1200 | 50 | 0% | 90% | 100 | 10 |
| 55 | Ureusstatue | $8EC65E | 100 | 88 | 1200 | 50 | 0% | 90% | 100 | 10 |
| 56 | Oglin | $8EC6A8 | 120 | 47 | 88 | 32 | 10% | 75% | 150 | 100 |
| 57 | Panzerminos | $8EC6F2 | 90 | 53 | 180 | 42 | 5% | 80% | 180 | 10 |
| 58 | Doppelgänger (Elite) | $8EC73C | 700 | 85 | 200 | 51 | 15% | 90% | 400 | 333 |
| 59 | Gestrüpp | $8EC786 | 60 | 23 | 80 | 12 | 0% | 70% | 50 | 40 |
| 60 | Bastetzepter | $8EC7D0 | 100 | 41 | 240 | 40 | 5% | 85% | 160 | 60 |
| 61 | Blutpudding | $8EC81A | 100 | 110 | 240 | 51 | 0% | 95% | 600 | 40 |
| 62 | Bioschleim | $8EC864 | 70 | 31 | 120 | 20 | 0% | 70% | 50 | 30 |
| 63 | Sabberblob | $8EC8AE | 70 | 42 | 160 | 30 | 5% | 75% | 150 | 30 |
| 64 | Satyr | $8EC8F8 | 100 | 50 | 160 | 35 | 10% | 80% | 70 | 10 |
| 65 | Satyr | $8EC942 | 100 | 50 | 160 | 35 | 10% | 80% | 70 | 10 |
| 66 | Nuklearmorpher | $8EC98C | 300 | 117 | 200 | 45 | 10% | 90% | 500 | 0 |
| 67 | Morphkopierer | $8EC9D6 | 30 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 68 | Wächtereinheit | $8ECA20 | 30 | 2 | 0 | 0 | 0% | 50% | 0 | 0 |
| 69 | Wächtereinheit | $8ECA6A | 500 | 125 | 320 | 60 | 10% | 95% | 500 | 20 |
| 70 | Reinigungsroboter | $8ECAB4 | 600 | 85 | 160 | 57 | 7% | 25% | 600 | 280 |
| 71 | Aegis (Boss) | $8ECAFE | 3800 | 20 | 80 | 40 | 0% | 100% | 3000 | 1200 |
| 72 | Tentakel | $8ECB48 | 400 | 52 | 160 | 25 | 10% | 80% | 500 | 0 |
| 73 | Minitentakel | $8ECB92 | 200 | 32 | 160 | 20 | 10% | 75% | 300 | 0 |
| 74 | Monsterqualle | $8ECBDC | 2500 | 0 | 0 | 50 | 0% | 100% | 5000 | 0 |
| 75 | Dummy 75 | $8ECC26 | 1 | 32 | 0 | 0 | 0% | 50% | 100 | 0 |
| 76 | Baumdrache | $8ECC70 | 2000 | 86 | 120 | 38 | 5% | 85% | 2200 | 2000 |
| 77 | Feuerdrache | $8ECCBA | 3200 | 71 | 160 | 42 | 8% | 90% | 3300 | 2000 |
| 78 | Cybermax | $8ECD04 | 2400 | 55 | 200 | 48 | 12% | 85% | 850 | 200 |
| 79 | Rattus | $8ECD4E | 3425 | 0 | 0 | 30 | 0% | 100% | 1050 | 1000 |
| 80 | Ratte | $8ECD98 | 20 | 30 | 120 | 15 | 0% | 70% | 30 | 10 |
| 81 | Ratte | $8ECDE2 | 20 | 35 | 120 | 18 | 0% | 75% | 30 | 10 |
| 82 | Vigor (Boss) | $8ECE2C | 1050 | 53 | 100 | 30 | 5% | 85% | 1050 | 1000 |
| 83 | Bastet (Schatten) | $8ECE76 | 1 | 0 | 0 | 0 | 0% | 0% | 0 | 0 |
| 84 | Bastet (Phase 1) | $8ECEC0 | 1200 | 40 | 80 | 32 | 5% | 80% | 1200 | 1000 |
| 85 | Bastet (Phase 2) | $8ECF0A | 3000 | 145 | 80 | 45 | 10% | 90% | 3000 | 1000 |
| 86 | Irrlicht | $8ECF54 | 40 | 13 | 40 | 10 | 15% | 75% | 4 | 4 |
| 87 | Lavarex (Mini) | $8ECF9E | 1000 | 37 | 40 | 20 | 5% | 80% | 500 | 900 |
| 88 | Dinotaurus | $8ECFE8 | 2600 | 70 | 120 | 35 | 5% | 85% | 2500 | 3000 |
| 89 | Raptor | $8ED032 | 50 | 27 | 48 | 16 | 10% | 75% | 24 | 48 |
| 90 | Raptor (Alpha) | $8ED07C | 300 | 80 | 48 | 24 | 15% | 85% | 290 | 48 |
| 91 | Echsenkönig | $8ED0C6 | 250 | 30 | 92 | 28 | 8% | 80% | 160 | 200 |
| 92 | Echsenbrut | $8ED110 | 125 | 25 | 80 | 20 | 5% | 75% | 80 | 50 |
| 93 | Pirat | $8ED15A | 200 | 53 | 40 | 25 | 10% | 80% | 100 | 10 |
| 94 | Morbius | $8ED1A4 | 60 | 28 | 80 | 18 | 5% | 75% | 20 | 75 |
| 95 | Ureus | $8ED1EE | 160 | 36 | 80 | 22 | 8% | 80% | 120 | 40 |
| 96 | Sachmet | $8ED238 | 200 | 41 | 120 | 30 | 10% | 85% | 250 | 250 |
| 97 | Minitaurus | $8ED282 | 500 | 56 | 76 | 26 | 5% | 80% | 1000 | 10 |
| 98 | Feuerflamingo | $8ED2CC | 30 | 14 | 56 | 12 | 15% | 70% | 20 | 15 |
| 99 | Flippo | $8ED316 | 40 | 18 | 60 | 14 | 10% | 70% | 12 | 19 |
| 100 | Gifttarantel | $8ED360 | 40 | 14 | 48 | 10 | 12% | 70% | 40 | 12 |
| 101 | Sandkrabbler | $8ED3AA | 74 | 33 | 48 | 15 | 8% | 75% | 72 | 18 |
| 102 | Witwenbeine | $8ED3F4 | 160 | 47 | 160 | 32 | 10% | 80% | 180 | 30 |
| 103 | Schädelgeier | $8ED43E | 40 | 28 | 80 | 20 | 20% | 85% | 300 | 40 |
| 104 | Flatterschädel | $8ED488 | 90 | 47 | 80 | 24 | 18% | 85% | 400 | 50 |
| 105 | Knochenviper | $8ED4D2 | 50 | 18 | 32 | 14 | 10% | 75% | 22 | 17 |
| 106 | Sumpfmonster | $8ED51C | 2000 | 32 | 80 | 28 | 5% | 80% | 700 | 66 |
| 107 | Höllenrose (Boss) | $8ED566 | 10000 | 2125 | 2400 | 65 | 0% | 100% | 600 | 100 |
| 108 | Grabschtulpe | $8ED5B0 | 30 | 17 | 48 | 12 | 5% | 70% | 6 | 7 |
| 109 | Fummelprimel | $8ED5FA | 18 | 9 | 28 | 8 | 5% | 65% | 2 | 2 |
| 110 | Raptor | $8ED644 | 40 | 11 | 32 | 10 | 8% | 70% | 16 | 29 |
| 111 | Feuermade | $8ED68E | 150 | 88 | 12 | 15 | 5% | 75% | 85 | 10 |
| 112 | Lavawurm | $8ED6D8 | 30 | 12 | 12 | 8 | 5% | 65% | 4 | 4 |
| 113 | Moskito | $8ED722 | 1 | 2 | 0 | 0 | 25% | 50% | 1 | 1 |
| 114 | Moskito | $8ED76C | 1 | 175 | 0 | 0 | 30% | 60% | 1 | 1 |
| 115 | Lakosius | $8ED7B6 | 5000 | 0 | 160 | 45 | 0% | 100% | 8000 | 0 |
| 116 | Faustus | $8ED800 | 500 | 78 | 100 | 30 | 10% | 85% | 1000 | 250 |
| 117 | Mephista | $8ED84A | 500 | 78 | 0 | 20 | 10% | 85% | 1000 | 250 |
| 118 | Vulgors Herzkammer | $8ED894 | 600 | 0 | 0 | 15 | 0% | 100% | 500 | 750 |
| 119 | Gorvuls Herzkammer | $8ED8DE | 6000 | 0 | 0 | 50 | 0% | 100% | 10000 | 4000 |
| 120 | Rechte Klaue | $8ED928 | 2250 | 17 | 32 | 15 | 5% | 80% | 4166 | 400 |
| 121 | Linke Klaue | $8ED972 | 2500 | 175 | 32 | 15 | 5% | 80% | 4166 | 400 |
| 122 | Rechte Klaue | $8ED9BC | 250 | 17 | 32 | 10 | 5% | 75% | 250 | 150 |
| 123 | Linke Klaue | $8EDA06 | 250 | 17 | 32 | 10 | 5% | 75% | 250 | 150 |
| 124 | Fratzenwand | $8EDA50 | 4000 | 0 | 800 | 60 | 0% | 100% | 4000 | 2000 |
| 125 | Glutdrache | $8EDA9A | 300 | 55 | 160 | 30 | 8% | 80% | 150 | 60 |
| 126 | Arsendrache | $8EDAE4 | 300 | 88 | 160 | 35 | 8% | 85% | 150 | 60 |
| 127 | Kreiselkiller | $8EDB2E | 700 | 101 | 300 | 50 | 10% | 90% | 300 | 10 |
| 128 | Radarmine | $8EDB78 | 1000 | 101 | 80 | 40 | 5% | 90% | 70 | 10 |
| 129 | Ventilator | $8EDBC2 | 2500 | 0 | 1400 | 70 | 0% | 100% | 0 | 0 |
| 130 | Lautsprecher | $8EDC0C | 1004 | 0 | 1400 | 57 | 0% | 60% | 0 | 0 |
| 131 | Ratte | $8EDC56 | 20 | 35 | 120 | 38 | 0% | 25% | 30 | 10 |
| 132 | Reinigungsroboter | $8EDCA0 | 600 | 85 | 160 | 57 | 7% | 25% | 50 | 280 |
| 133 | Tentakel | $8EDCEA | 400 | 105 | 280 | 12 | 10% | 40% | 500 | 0 |
| 134 | Minitentakel | $8EDD34 | 200 | 85 | 240 | 16 | 10% | 60% | 300 | 0 |
| 135 | Bombe | $8EDD7E | 200 | 0 | 800 | 65 | 0% | 100% | 0 | 0 |
| 136 | Raptor | $8EDDC8 | 4000 | 225 | 400 | 51 | 25% | 75% | 24 | 48 |
| 137 | Todesspinne (Boss) | $8EDE12 | 6000 | 325 | 400 | 57 | 0% | 100% | 5000 | 250 |
| 138 | Bastets Auge | $8EDE5C | 6000 | 175 | 400 | 0 | 0% | 100% | 1050 | 0 |
| 139 | Schappschapp (Boss) | $8EDEA6 | 10000 | 175 | 240 | 57 | 40% | 80% | 5000 | 20 |
| 140 | Lavarex (Boss) | $8EDEF0 | 25000 | 170 | 360 | 0 | 9% | 110% | 50000 | 0 |
| 141 | Edgars Roboter (Endboss) | $8EDF3A | 30000 | 220 | 360 | 60 | 9% | 110% | 100000 | 0 |

---

## 3. Boss-Mechaniken und Schlüsselbegegnungen

1. **Höllenrose (ID 107 - Sumpf von Prehistoria):**
   - **KP:** 10.000, **DEF:** 2.400, **ATK:** 2.125.
   - Verfügt über extreme Verteidigungswerte; Schwachpunkt sind die Blütenblätter und Ranken sowie Alchemie-Zauber wie *Säureregen* und *Hitzeblitz*.

2. **Lavarex (ID 140 - Vulkan):**
   - **KP:** 25.000, **DEF:** 360, **EXP:** 50.000.
   - Immunsystem gegen Feuerschaden; erleidet massiven Bonusschaden durch Kälte- und Frostzauber (*Hagelsturm*, *Trockeneis*).

3. **Gorvuls Herzkammer (ID 119 - Gothica Katakomben):**
   - **KP:** 6.000, **EXP:** 10.000, **Geld:** 4.000.
   - Stationärer Kern; feuert in festen Phasen Laserimpulse und ruft Schutzkristalle herbei.

4. **Edgars Roboter (ID 141 - Omnitopia Endkampf):**
   - **KP:** 30.000, **ATK:** 220, **DEF:** 360, **EXP:** 100.000.
   - Der finale Bosskampf von *Secret of Evermore*. Besitzt rotierende Phasen:
     - Laserbarriere und Raketensalve
     - Rufen von Reinigungsrobotern (ID 132) und Bomben (ID 135)
     - Nahkampfschockwellen bei Annäherung des Hundes
