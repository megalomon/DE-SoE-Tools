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
| `0x00` |   0 | Assitopia - Alarmraum | `$ACF501` | `$9C8FB2` |  8 |  1 |
| `0x01` |   1 | Prähistorie - Davids Sumpfhütte Außenbereich | `$AAE403` | `$988E3C` |  4 |  0 |
| `0x02` |   2 | Intro - Großostheim 1965 Villa Außenbereich | `$ADC127` | `$93E962` |  0 |  0 |
| `0x03` |   3 | Intro - Großostheim 1995 Villa Außenbereich | `$ABEAB8` | `$94824B` |  0 |  0 |
| `0x04` |   4 | Antika - Krozkrübel Feuerstelle | `$ADD766` | `$98C171` |  2 |  0 |
| `0x05` |   5 | Antika - Weg zwischen Pyramide und Collosia | `$A5B938` | `$97C401` | 20 | 20 |
| `0x06` |   6 | Antika - Pyramide Außenbereich | `$9D8000` | `$97CF20` | 27 | 20 |
| `0x07` |   7 | Antika - Westlich von Krozkrübel | `$A893E9` | `$97BCDE` | 10 | 13 |
| `0x08` |   8 | Antika - Allelachema Marktplatz (Zentrum) | `$A6B42F` | `$96E4DD` |  5 |  5 |
| `0x09` |   9 | Antika - Allelachema Marktplatz (Aegis-Kampf) | `$AABCD2` | `$98BF0D` |  3 |  0 |
| `0x0A` |  10 | Antika - Allelachema Markt (Basar) | `$A0AAEA` | `$97B636` | 11 | 58 |
| `0x0B` |  11 | Antika - Allelachema Palasthof | `$A7964A` | `$97D5F9` | 10 | 12 |
| `0x0C` |  12 | Antika - Allelachema Hotel | `$AEA5D4` | `$96ED67` |  4 |  2 |
| `0x0D` |  13 | Gotika - Chaosturm Große Halle | `$AAD716` | `$99E839` |  8 |  0 |
| `0x0E` |  14 | Gotika - Chaosturm Speisesaal | `$ADD013` | `$99E8CE` |  2 |  1 |
| `0x0F` |  15 | Gotika - Chaosturm Westflügel | `$ABC913` | `$9BBC62` |  2 |  2 |
| `0x10` |  16 | Gotika - Chaosturm Buntglas-Galerie | `$AEC5C6` | `$9A8321` |  2 |  0 |
| `0x11` |  17 | Gotika - Chaosturm Gemach der Königin | `$ACBD8F` | `$99EFB2` |  2 |  0 |
| `0x12` |  18 | Gotika - Chaosturm Kanalisation | `$A68000` | `$9A903D` |  2 | 13 |
| `0x13` |  19 | Gotika - Zwischen Kanalisation, Schattenwald und Sumpf | `$ADB18A` | `$9A921B` |  4 |  1 |
| `0x14` |  20 | Gotika - Gallensteins Labor (Chaosturm) | `$ACD085` | `$9A8C6C` |  2 |  3 |
| `0x15` |  21 | Unbenutzt / Dummy-Map | `$A1FF54` | `$938000` |  0 |  0 |
| `0x16` |  22 | Prähistorie - Käfersteppe Eingang | `$A48000` | `$94C661` | 42 | 24 |
| `0x17` |  23 | Prähistorie - Käfersteppe Raum 2 | `$AD9952` | `$94C97F` |  8 | 12 |
| `0x18` |  24 | Prähistorie - Vulgors Herzkammer (Thraxx) | `$AC8AD3` | `$94D5A0` |  3 |  2 |
| `0x19` |  25 | Gotika - Schachbrett | `$A58000` | `$9AD8BE` |  5 | 19 |
| `0x1A` |  26 | Gotika - Schachbrett-Verlies (Fratzenwand) | `$A9E53F` | `$9ADB94` |  4 |  1 |
| `0x1B` |  27 | Antika - Schädelwüste | `$A78000` | `$9885CC` | 19 |  0 |
| `0x1C` |  28 | Antika - Nördlich von Allelachema | `$A8E154` | `$96CEC0` |  6 | 20 |
| `0x1D` |  29 | Antika - Allelachema Arena (Kampf gegen Vigor) | `$A8F396` | `$9AED20` |  0 |  0 |
| `0x1E` |  30 | Antika - Allelachema Arena Warteraum | `$ADDEB3` | `$96D3F7` |  1 |  9 |
| `0x1F` |  31 | Gotika - Schattenwald Doppelgänger-Lichtung | `$A9D4CC` | `$9ACCEB` |  2 |  0 |
| `0x20` |  32 | Gotika - Schattenwald Lichtung des Baumdrachen | `$ADE5C9` | `$9ACDEC` |  2 |  0 |
| `0x21` |  33 | Gotika - Schattenwald Eingang (Speicherpunkt) | `$ADF3B6` | `$9AA809` |  2 |  0 |
| `0x22` |  34 | Gotika - Schattenwald (Labyrinth) | `$A2C651` | `$9AC2DA` | 17 |  9 |
| `0x23` |  35 | Antika - Collosia Tempel Südwest | `$ADB965` | `$98906C` |  6 |  3 |
| `0x24` |  36 | Antika - Collosia Tempel Nordwest | `$A4BC85` | `$989ACA` | 29 |  7 |
| `0x25` |  37 | Prähistorie - Zora Zottelzopfs Dschungeldorf | `$A5D3C9` | `$95D119` | 13 | 20 |
| `0x26` |  38 | Prähistorie - West-Dschungel (Energieschild) | `$AECF58` | `$95E8D3` |  1 |  3 |
| `0x27` |  39 | Prähistorie - Mammut-Friedhof | `$A7D679` | `$94E3B6` |  3 | 30 |
| `0x28` |  40 | Antika - Collosia Einstürzende Brücke | `$A2A390` | `$98AF25` | 32 |  2 |
| `0x29` |  41 | Antika - Collosia Tempel Haupthalle | `$A8BB54` | `$9894F1` | 32 |  2 |
| `0x2A` |  42 | Antika - Collosia Panzerminos-Raum (Megataur) | `$AB98B7` | `$98A84A` |  1 |  0 |
| `0x2B` |  43 | Antika - Collosia Tempel Außenbereich | `$A8CE92` | `$96E953` |  2 | 17 |
| `0x2C` |  44 | Antika - Collosia Tempel Südost | `$AD911C` | `$989D2B` |  2 |  0 |
| `0x2D` |  45 | Antika - Collosia Tempel Nordost | `$A38000` | `$98A30A` | 18 |  5 |
| `0x2E` |  46 | Antika - Davids Höhle | `$AEC92D` | `$96B775` |  1 |  2 |
| `0x2F` |  47 | Antika - Hektors Camp (Oase) | `$A1CD25` | `$97DF96` |  6 | 20 |
| `0x30` |  48 | Antika - Krozkrübel Piratenschiff Innenraum | `$ABA4F7` | `$96C5C0` |  8 |  7 |
| `0x31` |  49 | Intro - Großostheim 1965 | `$ADC8B2` | `$93E7F2` |  0 |  0 |
| `0x32` |  50 | Intro - Großostheim 1995 (Kino) | `$AE8CBB` | `$94808F` |  0 |  0 |
| `0x33` |  51 | Prähistorie - Schlauer Bärs Hütte Außenbereich | `$AEB57D` | `$95E951` |  2 |  0 |
| `0x34` |  52 | Prähistorie - Schlauer Bärs Hütte Innenraum | `$AEBDEA` | `$95EAEB` |  1 |  3 |
| `0x35` |  53 | Höhlensystem (Käfersteppe, Vulkan & West-Höhle) | `$ABD4A9` | `$95AAC0` |  5 | 10 |
| `0x36` |  54 | Prähistorie - Beide Feuerstellen | `$A4F775` | `$98CBC8` |  2 |  4 |
| `0x37` |  55 | Gotika - Erwins Turm | `$9EBCF5` | `$9AA6D4` | 12 | 22 |
| `0x38` |  56 | Prähistorie - Süd-Dschungel (Startgebiet) | `$9F8000` | `$948878` |  2 | 31 |
| `0x39` |  57 | Gotika - Chaosturm Feuerstelle | `$ADA982` | `$9BCF9E` |  2 |  0 |
| `0x3A` |  58 | Antika - Allelachema Feuerstelle | `$AEABD6` | `$98C5A8` |  2 |  0 |
| `0x3B` |  59 | Prähistorie - Vulkan Raum 2 | `$A3C0A8` | `$959CB4` |  4 | 34 |
| `0x3C` |  60 | Prähistorie - Vulkan Raum 1 | `$A3A162` | `$95A2BF` | 21 | 25 |
| `0x3D` |  61 | Prähistorie - Vulkan-Röhrenlabyrinth | `$A49EC8` | `$95B003` | 39 |  0 |
| `0x3E` |  62 | Prähistorie - Vulkan Röhren-Nebenräume | `$AA8000` | `$95B4C6` | 12 | 14 |
| `0x3F` |  63 | Prähistorie - Gorvuls Herzkammer (Coleoptera) | `$ABBD2D` | `$95C09A` |  1 |  0 |
| `0x40` |  64 | Gotika - Sumpf südlich von Erwins Turm | `$AC8000` | `$9A9383` |  2 |  0 |
| `0x41` |  65 | Prähistorie - Nord-Dschungel | `$A6E6BF` | `$9498DE` |  4 | 23 |
| `0x42` |  66 | Assitopia - Reaktorraum & Reaktorkontrolle | `$AAF0BC` | `$9CBA1E` | 28 |  2 |
| `0x43` |  67 | Assitopia - Kontrollraum | `$ACB3C7` | `$9C8000` |  1 |  6 |
| `0x44` |  68 | Assitopia - Gewächshäuser | `$ABF590` | `$9C85C1` |  2 |  1 |
| `0x45` |  69 | Assitopia - Geheimer Bossraum | `$ACEC05` | `$9C88DB` |  2 |  0 |
| `0x46` |  70 | Assitopia - Prof. Seltsams Labor & Shuttle-Bucht | `$A7EB32` | `$9CDC37` |  5 |  3 |
| `0x47` |  71 | Assitopia - Lagerhalle | `$AB8C6E` | `$9C8CE6` |  1 |  7 |
| `0x48` |  72 | Assitopia - Metroplex-Tunnel | `$A0D4E2` | `$9BD3E4` | 56 | 53 |
| `0x49` |  73 | Assitopia - Schrottplatz (Landestelle) | `$A5EE50` | `$9CE278` | 13 |  0 |
| `0x4A` |  74 | Assitopia - Finaler Thronsaal (Edgars Roboter) | `$A4DA2D` | `$9CB942` |  2 |  8 |
| `0x4B` |  75 | Antika - Oglin-Höhle | `$A1A80C` | `$98D88D` | 50 | 32 |
| `0x4C` |  76 | Antika - Allelachema Brunnenplatz & Schlangenstatuen | `$AC958E` | `$96DB49` |  2 | 10 |
| `0x4D` |  77 | Antika - Allelachema Palast Innenbereich | `$AE8669` | `$96D86F` |  0 |  0 |
| `0x4E` |  78 | Gotika - Terrorfels West-Gasse (Markt) | `$ABB125` | `$9BA2BC` |  2 |  0 |
| `0x4F` |  79 | Antika - Östlich von Krozkrübel | `$A1F132` | `$96BF0B` |  6 | 16 |
| `0x50` |  80 | Prähistorie - Himmel über dem Vulkankrater | `$A6FD61` | `$9589BF` |  0 |  0 |
| `0x51` |  81 | Prähistorie - Dschungeldorf Hütten & Davids Hütte | `$9DF0C3` | `$95E544` |  9 | 25 |
| `0x52` |  82 | Prähistorie - Vulkangipfel (Vulkankrater) | `$ADFA67` | `$958773` |  1 |  0 |
| `0x53` |  83 | Antika - Ankunft Cutscene | `$ACE308` | `$95EE6B` |  0 |  0 |
| `0x54` |  84 | Assitopia - Einkaufszentrum / Shops | `$AB8000` | `$9C9F2F` |  7 |  3 |
| `0x55` |  85 | Antika - Pyramide Unterste Ebene (Start des Hundes) | `$9FD770` | `$96976D` | 47 | 24 |
| `0x56` |  86 | Antika - Pyramide Oberste Ebene (Start des Helden) | `$A7C154` | `$969E36` |  6 | 24 |
| `0x57` |  87 | Antika - Pyramide Untergeschoss (Minitaurus) | `$A8A7A2` | `$96ACF2` | 21 | 11 |
| `0x58` |  88 | Antika - Pyramide Spitze (Bastet / Rimsala) | `$AE930D` | `$96B43F` |  5 |  0 |
| `0x59` |  89 | Prähistorie - Treibsandwüste | `$A18000` | `$94B056` | 65 | 28 |
| `0x5A` |  90 | Prähistorie - Säuresturm-Alchemist | `$AE995A` | `$94B2A5` |  1 |  2 |
| `0x5B` |  91 | Prähistorie - Ost-Dschungel | `$A88000` | `$94B54B` |  5 | 17 |
| `0x5C` |  92 | Prähistorie - Raptor-Kluft | `$A9F593` | `$9494CB` |  3 |  4 |
| `0x5D` |  93 | Gotika - Chaosturm Schlosshof | `$ACD9DC` | `$9AEE2E` |  7 |  0 |
| `0x5E` |  94 | Gotika - Chaosturm Thronsaal (Rattus) | `$ADECCD` | `$9B81A0` | 10 |  0 |
| `0x5F` |  95 | Gotika - Chaosturm Seitenräume | `$AEB9D2` | `$9B8286` |  4 |  0 |
| `0x60` |  96 | Gotika - Chaosturm Vorratskammer | `$AECC7E` | `$9B83D9` |  1 |  3 |
| `0x61` |  97 | Intro - Flug über die Traummaschine | `$A9B3AA` | `$93E46C` |  0 |  0 |
| `0x62` |  98 | Gotika - Terrorfels Westplatz (Planwagen) | `$AAAED0` | `$9BAAE8` |  9 |  0 |
| `0x63` |  99 | Gotika - Terrorfels Planwagen Innenraum | `$AE8000` | `$9BB34A` |  2 |  0 |
| `0x64` | 100 | Antika - Höhleneingang unter der Pyramide | `$AEB119` | `$98DEAF` |  2 |  0 |
| `0x65` | 101 | Prähistorie - Sumpf (Hauptbereich) | `$9E8000` | `$959308` | 29 | 34 |
| `0x66` | 102 | Prähistorie - Westlich des Sumpfes | `$A9C450` | `$958BC5` |  7 | 19 |
| `0x67` | 103 | Prähistorie - Käfersteppe Außenbereich | `$9FABDE` | `$94BB69` | 13 | 42 |
| `0x68` | 104 | Antika - Krozkrübel Außenbereich | `$A7ABE2` | `$9687E7` | 13 |  0 |
| `0x69` | 105 | Prähistorie - Vulkanpfad | `$A28000` | `$958000` | 31 | 33 |
| `0x6A` | 106 | Antika - Ankunft Wasserfall Cutscene | `$AD88E1` | `$95EBFC` |  0 |  0 |
| `0x6B` | 107 | Antika - Wasserfall | `$AA9046` | `$98DDC5` |  7 |  0 |
| `0x6C` | 108 | Gotika - Südöstlich von Terrorfels (Brunnen) | `$ACC714` | `$9BBABD` |  1 |  1 |
| `0x6D` | 109 | Antika - Aquagoth-Schiffswrack | `$ACA9F8` | `$98E89B` |  0 |  0 |
| `0x6E` | 110 | Gotika - Terrorfels Große Halle | `$A9A2F5` | `$99A359` |  9 |  0 |
| `0x6F` | 111 | Gotika - Terrorfels Speisesaal | `$ABDFDE` | `$9BC384` |  2 |  2 |
| `0x70` | 112 | Gotika - Terrorfels Brücken und Balkone | `$AAC9FE` | `$9BD366` | 10 |  0 |
| `0x71` | 113 | Gotika - Terrorfels Ostflügel & Schlossküche | `$A08000` | `$99891C` | 57 | 32 |
| `0x72` | 114 | Gotika - Terrorfels Obergeschoss | `$A98000` | `$999061` | 19 | 18 |
| `0x73` | 115 | Gotika - Terrorfels Hundelabyrinth | `$AA9F92` | `$99950F` | 28 |  0 |
| `0x74` | 116 | Gotika - Kerker & Verlies (Chaosturm & Terrorfels) | `$A59D44` | `$99B011` | 33 |  1 |
| `0x75` | 117 | Gotika - Terrorfels Treppenhaus zum Verlies | `$AE9F98` | `$99B199` |  2 |  0 |
| `0x76` | 118 | Gotika - Südlich von Terrorfels (Burgtor) | `$9EEA50` | `$99BB7B` |  2 | 20 |
| `0x77` | 119 | Gotika - Terrorfels Puppentheater (Mungola) | `$ACA00C` | `$9B8BFF` |  3 |  0 |
| `0x78` | 120 | Gotika - Terrorfels Gemach von Königin Gunilla | `$ADA175` | `$999CA6` |  4 |  0 |
| `0x79` | 121 | Gotika - Terrorfels Kanalisation | `$A6CDDA` | `$99B359` |  4 |  8 |
| `0x7A` | 122 | Gotika - Terrorfels Kanalisation Ausgang | `$AEC1EF` | `$99B84B` |  2 |  0 |
| `0x7B` | 123 | Gotika - Chaosturm & Terrorfels Außenansicht Unten | `$A69A21` | `$99C42D` |  8 |  7 |
| `0x7C` | 124 | Gotika - Chaosturm & Terrorfels Außenansicht Oben | `$A3DFCC` | `$99C9CB` | 11 |  0 |
| `0x7D` | 125 | Gotika - Chaosturm & Terrorfels Innenräume | `$A2E7E4` | `$99DE9A` | 12 | 21 |
| `0x7E` | 126 | Assitopia - Gefängnis & Arrestzellen | `$A99236` | `$9C92DD` |  1 | 17 |

---

## 4. Nutzung mit `soe-dumper`

Alle Maps und ihre Skripte können mit dem im Repository enthaltenen Tool [`soe-dumper`](../crates/soe-dumper) analysiert und disassembliert werden:

```bash
# Details, Trigger und Skripte einer einzelnen Map anzeigen (z. B. Map 0x0A = Allelachema Markt):
soe-dumper map --id 10

# Alle 127 Maps vollständig in ein Verzeichnis extrahieren:
soe-dumper dump-all --rom "Secret of Evermore (Germany).sfc" --out-dir ./maps_dump_de
```
