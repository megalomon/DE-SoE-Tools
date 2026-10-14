# Raum- & Map-Architektur (Secret of Evermore – Deutsche PAL ROM)

Diese Dokumentation beschreibt die vollständige Raum- und Map-Struktur der **deutschen PAL-Version** von *Secret of Evermore* (`Secret of Evermore (Germany).sfc`) inklusive aller 127 Maps, Zeigertabellen, Trigger-Systeme und Skript-Einstiegspunkte.

---

## 1. Technischer Aufbau des Map-Systems

In der deutschen ROM werden Räume über eine zentrale Zeigertabelle in Bank `$A0` verwaltet:

- **Map-List Zeigertabelle:** `$A0:FDE5` (`0x20FDE5`)  
  Enthält 127 Einträge für die Map-IDs `0x00` bis `0x7E` (0 bis 126). Jeder Eintrag besteht aus **4 Bytes**:
  - `Byte 0..2`: 24-Bit SNES-Adresse des Map-Datenheaders (`$800000` bis `$AFFFFF`)
  - `Byte 3`: Padding / reserviert

### Format des Map-Datenheaders

An der adressierten SNES-Adresse des Raumes liegt der Map-Header mit folgendem Binäraufbau:

| Offset | Länge | Datentyp | Beschreibung |
| :---: | :---: | :--- | :--- |
| `+0x00` | 1 Byte | `u8` | Tileset / Hintergrundgrafik-Index |
| `+0x01` | 1 Byte | `u8` | Farbpaletten-Index |
| `+0x02` | 3 Bytes | `u24` | SNES-Zeiger auf die komprimierten Tilemap-Ebenendaten |
| `+0x05` | 8 Bytes | `bytes` | Layer-, Scroll- und Dimensionseinstellungen |
| `+0x0D` | 2 Bytes | `u16` | **Länge der Step-On-Trigger-Tabelle** (`m_len`, Vielfaches von 6) |
| `+0x0F` | `m_len` | `Array` | Liste aller Step-On-Trigger (Raumwechsel, Fallen, Trittplatten) |
| `+0x0F + m_len` | 2 Bytes | `u16` | **Länge der B-Trigger-Tabelle** (`b_len`, Vielfaches von 6) |
| `+0x11 + m_len` | `b_len` | `Array` | Liste aller B-Trigger (B-Button Interaktionen, NPCs, Kisten, Töpfe) |

### Aufbau eines Trigger-Eintrags (6 Bytes)

Sowohl Step-On-Trigger als auch B-Trigger verwenden das gleiche 6-Byte-Kompaktformat:

```
[ Y1 ] [ X1 ] [ Y2 ] [ X2 ] [ Script_ID (16-Bit Little Endian) ]
Byte 0  Byte 1  Byte 2  Byte 3  Byte 4..5
```
- `(X1, Y1)` bis `(X2, Y2)`: Rechteckige Bounding-Box auf der Map in Tile-Koordinaten.
- `Script_ID`: Offset in die globale Map-Skript-Zeigertabelle.

---

## 2. Skript-Einstiegspunkte (Enter-Skripte & Trigger)

Secret of Evermore nutzt ein zweistufiges Skriptsystem:

### A. Raum-Enter-Skripte
Wird ein Raum betreten, liest die Engine das Enter-Skript aus der Tabelle ab `$93:801B`:
$$\text{SNES-Zeiger} = \$93:801B + 5 \times \text{Map\_ID}$$
Das Enter-Skript initialisiert die NPCs, startet Cutscenes oder setzt Hintergrundmusik und Raumzustände.

### B. Trigger-Skripte (Step-On & B-Button)
Die `Script_ID` aus den Triggern ist ein Offset in die MapScript-Zeigertabelle. Die Basisadresse dieser Tabelle wird aus dem ersten 16-Bit-Word bei `$93:8000` (`0x138000`) gelesen:
$$\text{MapScript-Tabelle} = \$93:8000 + \text{Word}(\$93:8000) = \$93:8294$$
An Adresse `$\$93:8294 + \text{Script\_ID}` liegt die absolute 24-Bit-Zieladresse des SIGIL-Bytecodes.

---

## 3. Vollständige Übersicht aller 127 Maps

| ID (Hex) | ID (Dez) | Name / Bereich | Header-Adresse (SNES) | Enter-Skript (SNES) | Step-Triggers | B-Triggers |
| :---: | :---: | :--- | :---: | :---: | :---: | :---: |
| `0x00` |   0 | Omnitopia - Alarm room | `$ACF501` | `$978FB2` |  8 |  1 |
| `0x01` |   1 | Prehistoria - Exterior of Blimp's Hut | `$AAE403` | `$958E3C` |  4 |  0 |
| `0x02` |   2 | Intro - Mansion Exterior 1965 | `$ADC127` | `$936962` |  0 |  0 |
| `0x03` |   3 | Intro - Mansion Exterior 1995 | `$ABEAB8` | `$93824B` |  0 |  0 |
| `0x04` |   4 | Antiqua - Crustacia fire pit | `$ADD766` | `$95C171` |  2 |  0 |
| `0x05` |   5 | Antiqua - Between 'mids and halls | `$A5B938` | `$954401` | 20 | 20 |
| `0x06` |   6 | Antiqua - Outside of 'mids | `$9D8000` | `$954F20` | 27 | 20 |
| `0x07` |   7 | Antiqua - West of Crustacia | `$A893E9` | `$953CDE` | 10 | 13 |
| `0x08` |   8 | Antiqua - Nobilia, Square | `$A6B42F` | `$94E4DD` |  5 |  5 |
| `0x09` |   9 | Antiqua - Nobilia, Square during Aegis fight | `$AABCD2` | `$95BF0D` |  3 |  0 |
| `0x0A` |  10 | Antiqua - Nobilia, Market | `$A0AAEA` | `$953636` | 11 | 58 |
| `0x0B` |  11 | Antiqua - Nobilia, Palace grounds | `$A7964A` | `$9555F9` | 10 | 12 |
| `0x0C` |  12 | Antiqua - Nobilia, Inn | `$AEA5D4` | `$94ED67` |  4 |  2 |
| `0x0D` |  13 | Gothica - Ebon Keep Hall (Stairs, behind Verm) | `$AAD716` | `$966839` |  8 |  0 |
| `0x0E` |  14 | Gothica - Ebon Keep Dining Room | `$ADD013` | `$9668CE` |  2 |  1 |
| `0x0F` |  15 | Gothica - Ebon Keep West Room (Naris) | `$ABC913` | `$973C62` |  2 |  2 |
| `0x10` |  16 | Gothica - Ebon Keep Stained Glass Hallway | `$AEC5C6` | `$968321` |  2 |  0 |
| `0x11` |  17 | Gothica - Ebon Keep Queen's Room | `$ACBD8F` | `$966FB2` |  2 |  0 |
| `0x12` |  18 | Gothica - Ebon Keep sewers | `$A68000` | `$96903D` |  2 | 13 |
| `0x13` |  19 | Gothica - Between Ebon Keep sewers, Dark Forest and Swamp | `$ADB18A` | `$96921B` |  4 |  1 |
| `0x14` |  20 | Gothica - Ebon Keep Tinker's Room | `$ACD085` | `$968C6C` |  2 |  3 |
| `0x15` |  21 | Unbenutzt / Dummy-Map | `$A1FF54` | `$930000` |  0 |  0 |
| `0x16` |  22 | Prehistoria - BBM | `$A48000` | `$93C661` | 42 | 24 |
| `0x17` |  23 | Prehistoria - Bug room 2 | `$AD9952` | `$93C97F` |  8 | 12 |
| `0x18` |  24 | Prehistoria - Thraxx' room | `$AC8AD3` | `$93D5A0` |  3 |  2 |
| `0x19` |  25 | Gothica - Chessboard | `$A58000` | `$96D8BE` |  5 | 19 |
| `0x1A` |  26 | Gothica - Below chessboard | `$A9E53F` | `$96DB94` |  4 |  1 |
| `0x1B` |  27 | Antiqua - Desert of Doom | `$A78000` | `$9585CC` | 19 |  0 |
| `0x1C` |  28 | Antiqua - Nobilia, North of Market | `$A8E154` | `$94CEC0` |  6 | 20 |
| `0x1D` |  29 | Antiqua - Nobilia, Arena (Vigor Fight) | `$A8F396` | `$96ED20` |  0 |  0 |
| `0x1E` |  30 | Antiqua - Nobilia, Arena Holding Room | `$ADDEB3` | `$94D3F7` |  1 |  9 |
| `0x1F` |  31 | Gothica - Doubles room in forest | `$A9D4CC` | `$96CCEB` |  2 |  0 |
| `0x20` |  32 | Gothica - Timberdrake room in forest | `$ADE5C9` | `$96CDEC` |  2 |  0 |
| `0x21` |  33 | Gothica - Dark forest entrance (save point) | `$ADF3B6` | `$96A809` |  2 |  0 |
| `0x22` |  34 | Gothica - Dark Forest | `$A2C651` | `$96C2DA` | 17 |  9 |
| `0x23` |  35 | Antiqua - Halls SW | `$ADB965` | `$95906C` |  6 |  3 |
| `0x24` |  36 | Antiqua - Halls NW | `$A4BC85` | `$959ACA` | 29 |  7 |
| `0x25` |  37 | Prehistoria - Fire Eyes' Village | `$A5D3C9` | `$945119` | 13 | 20 |
| `0x26` |  38 | Prehistoria - West area with Defend | `$AECF58` | `$9468D3` |  1 |  3 |
| `0x27` |  39 | Prehistoria - Mammoth Graveyard | `$A7D679` | `$93E3B6` |  3 | 30 |
| `0x28` |  40 | Antiqua - Halls Collapsing Bridge | `$A2A390` | `$95AF25` | 32 |  2 |
| `0x29` |  41 | Antiqua - Halls main room | `$A8BB54` | `$9594F1` | 32 |  2 |
| `0x2A` |  42 | Antiqua - Halls Boss Room | `$AB98B7` | `$95A84A` |  1 |  0 |
| `0x2B` |  43 | Antiqua - Outside of halls | `$A8CE92` | `$94E953` |  2 | 17 |
| `0x2C` |  44 | Antiqua - Halls SE | `$AD911C` | `$959D2B` |  2 |  0 |
| `0x2D` |  45 | Antiqua - Halls NE | `$A38000` | `$95A30A` | 18 |  5 |
| `0x2E` |  46 | Antiqua - Blimp's Cave | `$AEC92D` | `$94B775` |  1 |  2 |
| `0x2F` |  47 | Antiqua - Horace's camp | `$A1CD25` | `$955F96` |  6 | 20 |
| `0x30` |  48 | Antiqua - Crustacia inside pirate ship | `$ABA4F7` | `$94C5C0` |  8 |  7 |
| `0x31` |  49 | Intro - Podunk 1965 | `$ADC8B2` | `$9367F2` |  0 |  0 |
| `0x32` |  50 | Intro - Podunk 1995 | `$AE8CBB` | `$93808F` |  0 |  0 |
| `0x33` |  51 | Prehistoria - Strong Heart's Exterior | `$AEB57D` | `$946951` |  2 |  0 |
| `0x34` |  52 | Prehistoria - Strong Heart's Hut | `$AEBDEA` | `$946AEB` |  1 |  3 |
| `0x35` |  53 | Act1 Quicksand, Bugmuck and Volcano caves + Act2 West Alchemy Cave | `$ABD4A9` | `$942AC0` |  5 | 10 |
| `0x36` |  54 | Prehistoria - Both fire pits (one room) | `$A4F775` | `$95CBC8` |  2 |  4 |
| `0x37` |  55 | Gothica - Gomi's Tower | `$9EBCF5` | `$96A6D4` | 12 | 22 |
| `0x38` |  56 | Prehistoria - South jungle / Start | `$9F8000` | `$938878` |  2 | 31 |
| `0x39` |  57 | Gothica - Ebon Keep Fire pit | `$ADA982` | `$974F9E` |  2 |  0 |
| `0x3A` |  58 | Antiqua - Nobilia, Fire pit | `$AEABD6` | `$95C5A8` |  2 |  0 |
| `0x3B` |  59 | Prehistoria - Volcano Room 2 | `$A3C0A8` | `$941CB4` |  4 | 34 |
| `0x3C` |  60 | Prehistoria - Volcano Room 1 | `$A3A162` | `$9422BF` | 21 | 25 |
| `0x3D` |  61 | Prehistoria - Pipe maze | `$A49EC8` | `$943003` | 39 |  0 |
| `0x3E` |  62 | Prehistoria - Side rooms of pipe maze | `$AA8000` | `$9434C6` | 12 | 14 |
| `0x3F` |  63 | Prehistoria - Volcano Boss Room | `$ABBD2D` | `$94409A` |  1 |  0 |
| `0x40` |  64 | Gothica - Swamp south of Gomi's Tower | `$AC8000` | `$969383` |  2 |  0 |
| `0x41` |  65 | Prehistoria - North jungle | `$A6E6BF` | `$9398DE` |  4 | 23 |
| `0x42` |  66 | Omnitopia - Reactor room and Reactor control | `$AAF0BC` | `$97BA1E` | 28 |  2 |
| `0x43` |  67 | Omnitopia - Control room | `$ACB3C7` | `$978000` |  1 |  6 |
| `0x44` |  68 | Omnitopia - Greenhouse (dark or both?) | `$ABF590` | `$9785C1` |  2 |  1 |
| `0x45` |  69 | Omnitopia - Secret boss room | `$ACEC05` | `$9788DB` |  2 |  0 |
| `0x46` |  70 | Omnitopia - Professor's lab and ship area, (also?) Intro | `$A7EB32` | `$97DC37` |  5 |  3 |
| `0x47` |  71 | Omnitopia - Storage room | `$AB8C6E` | `$978CE6` |  1 |  7 |
| `0x48` |  72 | Omnitopia - Metroplex tunnels (rimsalas, spheres) | `$A0D4E2` | `$9753E4` | 56 | 53 |
| `0x49` |  73 | Omnitopia - Junkyard (Landing spot) | `$A5EE50` | `$97E278` | 13 |  0 |
| `0x4A` |  74 | Omnitopia - Final Boss Room | `$A4DA2D` | `$97B942` |  2 |  8 |
| `0x4B` |  75 | Antiqua - Oglin cave | `$A1A80C` | `$95D88D` | 50 | 32 |
| `0x4C` |  76 | Antiqua - Nobilia, Fountain and snake statues | `$AC958E` | `$94DB49` |  2 | 10 |
| `0x4D` |  77 | Antiqua - Nobilia, Inside palace (Horace cutscene) | `$AE8669` | `$94D86F` |  0 |  0 |
| `0x4E` |  78 | Gothica - Ivor Tower, west alley (market) | `$ABB125` | `$9722BC` |  2 |  0 |
| `0x4F` |  79 | Antiqua - East of Crustacia | `$A1F132` | `$94BF0B` |  6 | 16 |
| `0x50` |  80 | Prehistoria - Sky above Volcano | `$A6FD61` | `$9409BF` |  0 |  0 |
| `0x51` |  81 | Prehistoria - Village Huts and Blimp's Hut | `$9DF0C3` | `$946544` |  9 | 25 |
| `0x52` |  82 | Prehistoria - Top of Volcano | `$ADFA67` | `$940773` |  1 |  0 |
| `0x53` |  83 | Antiqua - Act2 Start Cutscene | `$ACE308` | `$946E6B` |  0 |  0 |
| `0x54` |  84 | Omnitopia - Shops | `$AB8000` | `$979F2F` |  7 |  3 |
| `0x55` |  85 | Antiqua - 'mids bottom level (Dog start) | `$9FD770` | `$94976D` | 47 | 24 |
| `0x56` |  86 | Antiqua - 'mids top level (Boy start) | `$A7C154` | `$949E36` |  6 | 24 |
| `0x57` |  87 | Antiqua - 'mids basement level (Tiny) | `$A8A7A2` | `$94ACF2` | 21 | 11 |
| `0x58` |  88 | Antiqua - 'mids boss room (Rimsala) | `$AE930D` | `$94B43F` |  5 |  0 |
| `0x59` |  89 | Prehistoria - Quick sand desert | `$A18000` | `$93B056` | 65 | 28 |
| `0x5A` |  90 | Prehistoria - Acid rain guy | `$AE995A` | `$93B2A5` |  1 |  2 |
| `0x5B` |  91 | Prehistoria - East jungle | `$A88000` | `$93B54B` |  5 | 17 |
| `0x5C` |  92 | Prehistoria - Raptors | `$A9F593` | `$9394CB` |  3 |  4 |
| `0x5D` |  93 | Gothica - Ebon Keep Courtyard (South of Verm) | `$ACD9DC` | `$96EE2E` |  7 |  0 |
| `0x5E` |  94 | Gothica - Ebon Keep Front Room (Verm) | `$ADECCD` | `$9701A0` | 10 |  0 |
| `0x5F` |  95 | Gothica - Ebon Keep Verm side rooms | `$AEB9D2` | `$970286` |  4 |  0 |
| `0x60` |  96 | Gothica - Ebon Keep Storage Room | `$AECC7E` | `$9703D9` |  1 |  3 |
| `0x61` |  97 | Opening - Scrolling over Machine | `$A9B3AA` | `$93646C` |  0 |  0 |
| `0x62` |  98 | Gothica - Ivor Tower, west square (trailers) | `$AAAED0` | `$972AE8` |  9 |  0 |
| `0x63` |  99 | Gothica - Ivor Tower, inside trailers | `$AE8000` | `$97334A` |  2 |  0 |
| `0x64` | 100 | Antiqua - Cave entrance under 'mids | `$AEB119` | `$95DEAF` |  2 |  0 |
| `0x65` | 101 | Prehistoria - Swamp (main area) | `$9E8000` | `$941308` | 29 | 34 |
| `0x66` | 102 | Prehistoria - West of swamp | `$A9C450` | `$940BC5` |  7 | 19 |
| `0x67` | 103 | Prehistoria - Bugmuck exterior | `$9FABDE` | `$93BB69` | 13 | 42 |
| `0x68` | 104 | Antiqua - Crustacia exterior | `$A7ABE2` | `$9487E7` | 13 |  0 |
| `0x69` | 105 | Prehistoria - Volcano path | `$A28000` | `$940000` | 31 | 33 |
| `0x6A` | 106 | Antiqua - Act2 Start Cutscene - waterfall | `$AD88E1` | `$946BFC` |  0 |  0 |
| `0x6B` | 107 | Antiqua - Waterfall | `$AA9046` | `$95DDC5` |  7 |  0 |
| `0x6C` | 108 | Gothica - SE of Ivor Tower (Well) | `$ACC714` | `$973ABD` |  1 |  1 |
| `0x6D` | 109 | Antique - Aquagoth Room | `$ACA9F8` | `$95E89B` |  0 |  0 |
| `0x6E` | 110 | Gothica - Ivor Tower Hall | `$A9A2F5` | `$962359` |  9 |  0 |
| `0x6F` | 111 | Gothica - Ivor Tower Dining Room | `$ABDFDE` | `$974384` |  2 |  2 |
| `0x70` | 112 | Gothica - Ivor Tower Exterior Bridges and Balconies | `$AAC9FE` | `$975366` | 10 |  0 |
| `0x71` | 113 | Gothica - Ivor Tower East Room + Kitchen | `$A08000` | `$96091C` | 57 | 32 |
| `0x72` | 114 | Gothica - Ivor Tower East Upper Floor | `$A98000` | `$961061` | 19 | 18 |
| `0x73` | 115 | Gothica - Ivor Tower Dog Maze Underground | `$AA9F92` | `$96150F` | 28 |  0 |
| `0x74` | 116 | Gothica - Ebon Keep and Ivory Tower dungeon + pipe room | `$A59D44` | `$963011` | 33 |  1 |
| `0x75` | 117 | Gothica - Ivor Tower Stariwell to dungeon | `$AE9F98` | `$963199` |  2 |  0 |
| `0x76` | 118 | Gothica - South of Ivor Tower (Gate) | `$9EEA50` | `$963B7B` |  2 | 20 |
| `0x77` | 119 | Gothica - Ivor Tower Puppet Show / Mungola | `$ACA00C` | `$970BFF` |  3 |  0 |
| `0x78` | 120 | Gothica - Ivor Tower Queen's Room | `$ADA175` | `$961CA6` |  4 |  0 |
| `0x79` | 121 | Gothica - Ivor Tower Sewers | `$A6CDDA` | `$963359` |  4 |  8 |
| `0x7A` | 122 | Gothica - Ivor Tower Sewers Exterior (landing spot) | `$AEC1EF` | `$96384B` |  2 |  0 |
| `0x7B` | 123 | Gothica - Ebon Keep and Ivor Tower Exterior Bottom Half | `$A69A21` | `$96442D` |  8 |  7 |
| `0x7C` | 124 | Gothica - Ebon Keep and Ivor Tower Exterior Top Half | `$A3DFCC` | `$9649CB` | 11 |  0 |
| `0x7D` | 125 | Gothica - Ebon Keep and Ivor Tower Interior | `$A2E7E4` | `$965E9A` | 12 | 21 |
| `0x7E` | 126 | Omnitopia - Jail | `$A99236` | `$9792DD` |  1 | 17 |


---

## 4. Nutzung mit `soe-dumper`

Alle Maps und ihre Skripte können mit dem im Repository enthaltenen Tool [`soe-dumper`](../crates/soe-dumper) analysiert und disassembliert werden:

```bash
# Details, Trigger und Skripte einer einzelnen Map anzeigen (z. B. Map 0x0A = Nobilia Markt):
soe-dumper map --id 10

# Alle 127 Maps vollständig in ein Verzeichnis extrahieren:
soe-dumper dump-all --rom "Secret of Evermore (Germany).sfc" --out-dir ./maps_dump_de
```
