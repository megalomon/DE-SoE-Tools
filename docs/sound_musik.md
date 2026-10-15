# Sound- & Musik-Architektur (Secret of Evermore – Deutsche PAL ROM)

Dieses Dokument beschreibt die vollständige Audio-Architektur, das SPC700-Kommunikationsprotokoll, alle Sound- und Musikbefehle der SIGIL-Skript-Engine sowie die vollständigen Musik- und Soundeffekt-Tabellen der **deutschen PAL-Version** von *Secret of Evermore* (`Secret of Evermore (Germany).sfc`).

---

## 1. Übersicht & Audio-Hardware

*Secret of Evermore* besitzt einen der meisterhaftesten Soundtracks der 16-Bit-Ära, komponiert von **Jeremy Soule**. Im Gegensatz zu den melodisch getriebenen Soundtracks traditioneller JRPGs setzt *Secret of Evermore* auf cineastische Ambient-Klanglandschaften, organische Naturgeräusche (Wind, fließendes Wasser, Tierrufe), orchestrale Passagen und düstere Synthesizer-Texturen.

### 1.1 Hardware-Architektur des SNES APU
Das Super Nintendo Audio Processing Unit (APU) besteht aus:
- **Sony SPC700:** 8-Bit-Audio-Koprozessor mit 64 KB integriertem SRAM und eigenem Takt (1,024 MHz).
- **Sony S-DSP:** 8-Kanal 16-Bit PCM-Stereo-DSP mit Hardware-ADSR-Hüllkurven, BRR-Sampledekodierung (*Bit Rate Reduction* 4:1 Kompression), FIR-Gauss-Filterung, Stereo-Panning und programmierbarem Echo/Hall.
- **Kommunikation:** 4 bidirektionale 8-Bit-Kommunikationsregister (`$2140` bis `$2143`), die Master-CPU (65816) und Audio-Koprozessor verbinden.

### 1.2 Speicherarchitektur im SNES ROM

| Speicherbereich | SNES-Adresse | File-Offset | Inhalt / Beschreibung |
|:---|:---:|:---:|:---|
| **SPC700 Sound-Engine** | `$81:8000` | `0x018000` | Maschinencode des SPC700-Audiotreibers (wird via IPL übertragen) |
| **BGM-Katalog (Verzeichnis)** | `$81:9900` | `0x019900` | Verzeichnis der 70 physischen Musiktracks (24-Bit-Zeiger) |
| **Musik- & Sample-Bank 1** | `$8A:8000..$8A:FFFF` | `0x0A8000` | Trackdaten & Instrumentensamples Songs `0x00`..`0x3A` |
| **Musik- & Sample-Bank 2** | `$8B:8000..$8B:FFFF` | `0x0B8000` | Trackdaten & Instrumentensamples Songs `0x3B`..`0x45` |
| **APU-Transfer-Routine** | `$8C:84F1` | `0x0C84F1` | CPU-seitige Handshake- & Übertragungsroutine an `$2140..$2143` |
| **BGM-Startroutine** | `$8C:85E7` | `0x0C85E7` | Wechselt Hintergrundmusik (`PLAY_BGM`) |
| **SFX-Startroutine** | `$8C:8662` | `0x0C8662` | Spielt Soundeffekt (`PLAY_SFX`) |
| **SFX-Lookup-Tabelle** | `$8C:8700` | `0x0C8700` | 112 16-Bit-Word-Einträge für SFX-Opcodes |
| **BGM-Lookup-Tabelle** | `$8C:87E0` | `0x0C87E0` | 73 16-Bit-Word-Einträge für Skript-Musik-Offsets |
| **Lautstärkeblende-Routine** | `$8C:89B7` | `0x0C89B7` | Steuert lineares Ein- und Ausblenden (`FADE_IN/OUT`) |

---

## 2. APU-Kommunikationsprotokoll & Ports

Die Kommunikation zwischen der SNES-Haupt-CPU (65816) und dem SPC700 erfolgt asynchron über die vier Memory-Mapped I/O-Ports:

```
SNES 65816 CPU                      Sony SPC700 Audio CPU
+-------------------+               +-------------------+
| Port 0 ($2140)    | ------------> | APU0 ($F4)        |  (Kommando / Param Low)
| Port 1 ($2141)    | ------------> | APU1 ($F5)        |  (Parameter High)
| Port 2 ($2142)    | <-----------> | APU2 ($F6)        |  (Sync-Counter / Quittung)
| Port 3 ($2143)    | <-----------> | APU3 ($F7)        |  (Status / Echo)
+-------------------+               +-------------------+
```

### 2.1 Handshake-Routine `$8C:84F1`
Jeder Audio-Befehl wird über die Kernroutine `$8C:84F1` gesendet. Die Routine sichert den Status, prüft eine Timeout-Schleife und garantiert zuverlässige Synchronisation:

```assembly
; Routine $8C:84F1: APU-Befehl synchron an SPC700 übertragen
; Eingabe: A (16-Bit) = APU-Befehlscode, Y (16-Bit) = Parameter
8C:84F1  08           PHP
8C:84F2  EE 53 0E     INC $0E53        ; Inkrementiert Sound-Call-Zähler
8C:84F5  E2 20        SEP #$20         ; 8-Bit Akkumulator
8C:84F7  C2 10        REP #$10         ; 16-Bit Indexregister
8C:84F9  EB           XBA              ; Befehlscode im oberen Akkumulator sichern
8C:84FA  A2 00 28     LDX #$2800       ; Timeout: 10.240 Schleifendurchläufe
8C:84FD  A5 9F        LDA $9F          ; Vorherige Sequenznummer aus Direct Page
8C:84FF  CD 42 21     CMP $2142        ; Wartet auf Quittierung vom SPC700
8C:8502  F0 06        BEQ .ready       ; SPC700 ist bereit!
8C:8504  CA           DEX              ; Timeout-Zähler dekrementieren
8C:8505  D0 F8        BNE $8C:84FD     ; Weiter warten
8C:8507  AD 42 21     LDA $2142        ; Bei Timeout: Letzten Portwert lesen
8C:850A  1A           INC A            ; Neue Sequenznummer erzwingen
8C:850B  F0 FD        BEQ $8C:850A
.ready:
8C:850D  85 9F        STA $9F          ; Neue Sequenznummer speichern
8C:850F  C2 30        REP #$30         ; 16-Bit A, X, Y
8C:8511  AA           TAX              ; Sequenznummer nach X
8C:8512  98           TYA              ; Parameter aus Y nach A
8C:8513  E2 20        SEP #$20         ; 8-Bit Akkumulator
8C:8515  8D 40 21     STA $2140        ; Parameter Low-Byte an APU Port 0
8C:8518  EB           XBA
8C:8519  8D 41 21     STA $2141        ; Parameter High-Byte an APU Port 1
8C:851C  C2 20        REP #$20         ; 16-Bit Akkumulator
8C:851E  8A           TXA              ; Sequenznummer zurück in A
8C:851F  8D 42 21     STA $2142        ; Triggere Port 2 (Quittierung & Befehlsstart)
8C:8522  28           PLP
8C:8523  6B           RTL
```

### 2.2 APU-Befehlssatz (Command Codes)

| Befehlscode (`A`) | Parameter (`Y`) | Funktion / Bedeutung |
|:---:|:---:|:---|
| `0x0004` | `sfx_id` | **Soundeffekt abspielen:** Startet den angegebenen SFX-Kanal. |
| `0x0006` | `track_id` | **Hintergrundmusik abspielen:** Lädt und startet den angegebenen Musiktrack. |
| `0x0016` | `sfx_id` | **Umgebungs- / Schrittgeräusche:** Spielt spezifische Umgebungsgeräusche ab. |
| `0x001A` | `0x0000` | **Kanal stummschalten / Stop:** Stoppt laufende Musik oder Voices (Key-Off). |
| `0x001C` | `$8080` | **Stereo-Balance Initialisierung:** Setzt Links/Rechts-Panning auf Neutral (Mitte). |
| `0x0026` | `sfx_id` | **Sekundärer Sound-Loop:** Startet Ambient-Dauerloops (z. B. Wasserfall, Wind). |
| `0x0028` | `0x00..0xFF` | **Master-Musiklautstärke:** Regelt die globale Musiklautstärke (`0` = Stille, `255` = Maximum). |
| `0x002A` | `pitch/param` | **Soundeffekt-Modulation:** Ändert Tonhöhe oder Lautstärke des SFX-Kanals. |
| `0x002C` | `pan_pos` | **SFX Stereo-Panning:** Positioniert Soundeffekte im Stereopanorama. |
| `0x0030` | `pan_pos` | **Kanal-Stereoposition:** Räumliche Audio-Positionierung (für Zwischensequenzen). |
| `0x0036` | `rate` | **Fade-In Rate:** Setzt Schrittweite für sanftes Einblenden der Musik. |
| `0x003E` | `rate` | **Fade-Out Rate:** Setzt Schrittweite für sanftes Ausblenden der Musik. |
| `0x0048` | `0x0000` | **Audio-Reset:** Reinitialisiert die Audio-Treiber-Zustände. |

---

## 3. SIGIL-Skriptbefehle für Sound & Musik

Die SIGIL-Skript-Engine steuert die Soundausgabe über dedizierte Bytecode-Befehle:

### 3.1 Übersicht der Audio-Opcodes

| Opcode | Routine | Argumente | Everscript-Syntax | Beschreibung |
|:---:|:---:|:---|:---|:---|
| `0x30` | `$8C:DA90` | `sfx: u8` | `play_sound(0, sfx_id);` | Spielt Soundeffekt auf **Kanal 1** (`sfx` ist Index in `$8C:8700`). |
| `0x31` | `$8C:DA90` | `sfx: u8` | `play_sound(1, sfx_id);` | Spielt Soundeffekt auf **Kanal 2** (`sfx` ist Index in `$8C:8700`). |
| `0x32` | `$8C:DA90` | `sfx: u8` | `play_sound(2, sfx_id);` | Spielt Soundeffekt auf **Kanal 3** (`sfx` ist Index in `$8C:8700`). |
| `0x33` | `$8C:DABF` | `track: u8` | `play_music(track_id);` | Wechselt Hintergrundmusik (`track` ist gerader Byte-Offset in `$8C:87E0`). |
| `0x58` | `$8C:E088` | *keine* | `fade_in_music();` | Blendet Musiklautstärke allmählich ein (Ziel: `$FF`). |
| `0x59` | `$8C:E075` | *keine* | `fade_out_music();` | Blendet Musiklautstärke allmählich aus (Ziel: `$00`). |
| `0x86` | `$8C:E67C` | `val: expr` | `set_music_volume(val);` / `sound_cmd_28(val);` | Setzt Musiklautstärke dynamisch (`0x00`..`0xFF`) via APU-Befehl `$28`. |
| `0x87` | `$8C:E696` | `val: expr` | `sound_cmd_2a(val);` | Sendet SFX-Modulationsparameter dynamisch via APU-Befehl `$2A`. |

### 3.2 Detailbeschreibung der Befehle

#### `0x30..0x32: PLAY_SFX_1..3`
- **Bytecode:** `[ 0x30/0x31/0x32 ] [ sfx_id ]`
- **Ablauf:** Die Engine liest `sfx_id`, nutzt diesen als Index in die SFX-Tabelle `$8C:8700`, ermittelt den Hardware-SFX-Wert und sendet APU-Befehl `0x04` via `$8C:8662`.
- **Everscript:**
  ```everscript
  play_sound(0, 0x42); // Menü-Klick oder Bestätigungston
  play_sound(1, 0x76); // Magie-Aufprall / Explosion
  ```

#### `0x33: PLAY_BGM`
- **Bytecode:** `[ 0x33 ] [ track_offset ]`
- **Ablauf:** `track_offset` ist ein gerader Offset (`0x02`, `0x04`, `0x06`, `0x40`, `0x74` etc.) in die BGM-Lookup-Tabelle bei `$8C:87E0`.
  1. Die Engine liest das 16-Bit-Word `song_idx = Word($8C:87E0 + track_offset)`.
  2. Falls `song_idx == 0xFFFF`, wird die aktuelle Musik gestoppt (APU-Befehl `$1A`).
  3. Andernfalls liest die Engine den 24-Bit-Zeiger aus `$81:9903 + 3 * song_idx` in Bank `$8A` oder `$8B`, initialisiert Stereo-Panning (`APU $1C, $8080`) und startet den Song (`APU $06, song_idx`).
- **Everscript:**
  ```everscript
  play_music(0x06); // Titelbildschirm-Thema
  play_music(0x40); // Nobilia Marktplatz ("Merchant Sands")
  play_music(0x74); // Schloss Terrorfels / Ivor Tower
  ```

#### `0x58 & 0x59: FADE_IN_MUSIC & FADE_OUT_MUSIC`
- **Bytecode:** `[ 0x58 ]` bzw. `[ 0x59 ]` (jeweils 1 Byte ohne Operanden).
- **Ablauf:** Setzt die Direct-Page-Variable `$9B` auf eine positive Schrittweite `+0x10` (Fade In) bzw. negative Schrittweite `-0x10` (`0xF0`, Fade Out). Die NMI-/Frame-Schleife ruft `$8C:89B7` auf, bis die Ziellautstärke `$FF` bzw. `$00` erreicht ist.
- **Everscript:**
  ```everscript
  fade_out_music();
  transition_to_cutscene();
  fade_in_music();
  ```

#### `0x86: SET_MUSIC_VOLUME (APU_SOUND_CMD_28)`
- **Bytecode:** `[ 0x86 ] [ Expression... ]`
- **Ablauf:** Wertet den mathematischen Ausdruck über den SIGIL-Evaluator `$8C:EE44` aus (z. B. RAM-Variable, Konstante, Berechnung) und sendet das Ergebnis `0..255` als APU-Kommando `0x0028` an den SPC700.
- **Everscript:**
  ```everscript
  set_music_volume(128); // 50% Lautstärke für Dialoge
  set_music_volume(255); // 100% Lautstärke nach Cutscene
  ```

---

## 4. BGM-Lookup-Tabelle (`$8C:87E0`)

Die BGM-Tabelle bei `$8C:87E0` (File-Offset `0x0C87E0`) enthält 73 Einträge à 16 Bit. Skripte referenzieren diese Tabelle über den Byte-Offset (`0x00` bis `0x90`):

| Offset | Index | Song-Index | Bank & SNES-Adresse | Soundtrack-Thema / Verwendung |
|:---:|:---:|:---:|:---:|:---|
| `0x00` | 0 | `0xFFFF` (-1) | — | **Musik Stopp / Stille** |
| `0x02` | 1 | `0x0002` (2) | `$8A:B487` | **Hundeverwandlung / Übergang** (Map 9, 30) |
| `0x04` | 2 | `0x0001` (1) | `$8A:B397` | **Bosskampf-Thema 1** (Map 24 Bugboss) |
| `0x06` | 3 | `0x0000` (0) | `$8A:A874` | **Titelthema: "Secret of Evermore"** (Map 97) |
| `0x08` | 4 | `0x0006` (6) | `$8A:B8F6` | **Höhlenthema / Untergrund** |
| `0x0A` | 5 | `0x0008` (8) | `$8A:BC34` | **Vulkanthema & Lavahöhlen** (Map 91, 92, 105) |
| `0x0C` | 6 | `0x0007` (7) | `$8A:BA56` | **Sumpf-Thema & Alchemist** (Map 1, 102) |
| `0x0E` | 7 | `0x0015` (21) | `$8A:CF8E` | **Düstere Hallen / Kerker** |
| `0x10` | 8 | `0xFFFF` (-1) | — | Reserviert / Mute |
| `0x12` | 9 | `0x0005` (5) | `$8A:B7F8` | **Dorf der Feueraugen (Prehistoria)** (Map 37, 38) |
| `0x14` | 10 | `0x0009` (9) | `$8A:BE12` | **Käferlabyrinth (Bug Maze)** (Map 22, 23, 103) |
| `0x16` | 11 | `0x000A` (10) | `$8A:C00C` | **Stadtpfad / Übergang** (Map 27, 63) |
| `0x18` | 12 | `0x000B` (11) | `$8A:C18F` | **Königin von Terrorfels** (Map 17, 120) |
| `0x1A` | 13 | `0x000C` (12) | `$8A:C2FD` | **Schlossverlies / Katakomben** |
| `0x1C` | 14 | `0x000D` (13) | `$8A:C44F` | **Omnitopia Klimatechnik** (Map 66) |
| `0x1E` | 15 | `0x000E` (14) | `$8A:C577` | **Dunkler griechischer Tempel** (Map 36, 41, 44) |
| `0x20` | 16 | `0x0021` (33) | `$8A:DFEB` | **Große Pyramide (Antiqua)** (Map 85, 86, 87) |
| `0x22` | 17 | `0x000F` (15) | `$8A:C683` | **Lager des Historikers** (Map 47) |
| `0x24` | 18 | `0x0010` (16) | `$8A:C7F1` | **Minotaurus-Kammer & Bosskämpfe** (Map 42, 74, 88, 109) |
| `0x26` | 19 | `0x0011` (17) | `$8A:C943` | **Einsiedler-Höhle / Krater** (Map 46, 52, 80, 82) |
| `0x28` | 20 | `0x002A` (42) | `$8A:EA4C` | **Hütten-Interieur (Prehistoria)** (Map 81) |
| `0x2A` | 21 | `0x0012` (18) | `$8A:CB4B` | **Friedhof der Mammuts (Graveyard)** (Map 39) |
| `0x2C` | 22 | `0x0013` (19) | `$8A:CC6C` | **Diebesdorf (Thief Town)** (Map 48, 104) |
| `0x2E` | 23 | `0x0014` (20) | `$8A:CE74` | **Markttor / Kolosseum-Zugang** (Map 10, 28) |
| `0x30` | 24 | `0x0016` (22) | `$8A:D1B2` | **Omnitopia Intro-Sequenz** (Map 70) |
| `0x32` | 25 | `0x0018` (24) | `$8A:D4D4` | **Mode-7 Flugthema (Windwalker)** |
| `0x34` | 26 | `0x0017` (23) | `$8A:D3BA` | **Mittelalterliche Taverne** |
| `0x36` | 27 | `0x0019` (25) | `$8A:D546` | **Atmosphärische Nachtgeräusche** |
| `0x38` | 28 | `0x001C` (28) | `$8A:D8A2` | **Podunk Intro / Labor von Ruffleberg** (Map 49) |
| `0x3A` | 29 | `0x001B` (27) | `$8A:D806` | **Antike Lichtung & Hochebene** (Map 4, 7, 79, 104) |
| `0x3C` | 30 | `0x001D` (29) | `$8A:DA41` | **Omnitopia Steuerungszentrale** (Map 67, 70, 74) |
| `0x3E` | 31 | `0x001F` (31) | `$8A:DCD0` | **Omnitopia Tunnelsystem** (Map 72) |
| `0x40` | 32 | `0x001E` (30) | `$8A:DB85` | **Marktplatz von Nobilia ("Merchant Sands")** (Map 5, 6, 8, 10, 28, 58) |
| `0x42` | 33 | `0x0020` (32) | `$8A:DEED` | **Nobilia Innenräume** (Map 12) |
| `0x44` | 34 | `0x0022` (34) | `$8A:E05D` | **Oglin-Höhle** (Map 75, 100) |
| `0x46` | 35 | `0x0023` (35) | `$8A:E265` | **Dunkler Wald Eingang & Treibsand** (Map 33, 90, 107) |
| `0x48` | 36 | `0x0024` (36) | `$8A:E37F` | **Antike Ruinen** |
| `0x4A` | 37 | `0x0025` (37) | `$8A:E4B5` | **Palast von Nobilia** (Map 8, 11, 77) |
| `0x4C` | 38 | `0xFFFF` (-1) | — | Reserviert / Mute |
| `0x4E` | 39 | `0x0026` (38) | `$8A:E5EB` | **Spukhaus / Schlossruine** |
| `0x50` | 40 | `0x001A` (26) | `$8A:D716` | **Gefängniszelle / Verhör** |
| `0x52` | 41 | `0x0027` (39) | `$8A:E783` | **Mansion Schwarz/Weiß (Intro)** (Map 2) |
| `0x54` | 42 | `0x0028` (40) | `$8A:E83B` | **Kolosseum Arena-Kampf** (Map 29) |
| `0x56` | 43 | `0x0029` (41) | `$8A:E8EC` | **Kanalisation von Schloss Terrorfels** (Map 76, 121, 122) |
| `0x58` | 44 | `0x002B` (43) | `$8A:EB7B` | **Puppentheater (Puppet Show)** (Map 119) |
| `0x5A` | 45 | `0x002C` (44) | `$8A:ECBF` | **Zwischensequenz / Marionetten-Vorbereitung** (Map 31, 44, 119) |
| `0x5C` | 46 | `0x002D` (45) | `$8A:EDBD` | **Schlosstreppen & Geheimgänge** (Map 48, 53, 96, 115, 117) |
| `0x5E` | 47 | `0x002E` (46) | `$8A:EEE5` | **Dunkle griechische Gruft** (Map 35) |
| `0x60` | 48 | `0x002F` (47) | `$8A:F11E` | **Schachbrett-Rätsel & Brunnen** (Map 25, 108, 118) |
| `0x62` | 49 | `0x0030` (48) | `$8A:F238` | **Stadt Terrorfels (White Castle Town)** (Map 93, 123, 124, 125) |
| `0x64` | 50 | `0x0031` (49) | `$8A:F352` | **Wasserfall-Höhle** (Map 83, 106) |
| `0x66` | 51 | `0x0032` (50) | `$8A:F496` | **Rattenboss-Katakomben** (Map 40, 45, 94, 95) |
| `0x68` | 52 | `0x0033` (51) | `$8A:F59B` | **Dunkler Wald Labyrinth (Dark Forest)** (Map 19, 31, 32, 34, 43, 55, 64) |
| `0x6A` | 53 | `0x0034` (52) | `$8A:F6B5` | **Schweinerennen-Basar & Rattenboss** (Map 78, 93, 123, 124, 125) |
| `0x6C` | 54 | `0x0036` (54) | `$8A:FA01` | **Schachbrett Innen & Schrottplatz** (Map 26, 73, 89) |
| `0x6E` | 55 | `0x0038` (56) | `$8A:FCCF` | **Schloss Terrorfels Speisesaal & Hallen** (Map 13, 14, 15, 16, 94, 95) |
| `0x70` | 56 | `0x0037` (55) | `$8A:FB6F` | **Schlosstüftler & Landeplatz** (Map 20, 57) |
| `0x72` | 57 | `0x0039` (57) | `$8A:FDDB` | **Kerker von Terrorfels (Dungeon)** (Map 116) |
| `0x74` | 58 | `0x003A` (58) | `$8A:FF3B` | **Ivor Tower Palast & Thronsaal** (Map 110, 111) |
| `0x76` | 59 | `0x003B` (59) | `$8B:813C` | **Kuriositätenkabinett (Side Show)** (Map 98, 99) |
| `0x78` | 60 | `0x003C` (60) | `$8B:82E2` | **Gothica Schlossfestung** |
| `0x7A` | 61 | `0x003D` (61) | `$8B:84A4` | **Pfad zum Mammutfriedhof** (Map 65) |
| `0x7C` | 62 | `0x003F` (63) | `$8B:8772` | **Gewächshaus & Omnitopia-Lager** (Map 68, 71) |
| `0x7E` | 63 | `0x0040` (64) | `$8B:8934` | **Raumstations-Kern** |
| `0x80` | 64 | `0x0041` (65) | `$8B:899F` | **Weltraum-Dock & Flucht** |
| `0x82` | 65 | `0x003E` (62) | `$8B:85CC` | **Hunde-Labyrinth auf Schloss Terrorfels** (Map 112, 113, 114) |
| `0x84` | 66 | `0x0042` (66) | `$8B:8A18` | **Dschungel-Lichtung & Landeplatz** (Map 54, 57, 58) |
| `0x86` | 67 | `0x0043` (67) | `$8B:8AFA` | **Lavapfad (Prehistoria)** (Map 61) |
| `0x88` | 68 | `0x0035` (53) | `$8A:F885` | **Omnitopia Prominade & Zoo** (Map 69, 71, 84, 126) |
| `0x8A` | 69 | `0x0044` (68) | `$8B:8C22` | **Bosskampf-Thema 2 (Mittelalter)** |
| `0x8C` | 70 | `0x0045` (69) | `$8B:8E00` | **Endkampf: Carltron / Roboter** |
| `0x8E` | 71 | `0x0003` (3) | `$8A:B58C` | **Siegesfanfare / Level-Up** (Map 8, 17, 37, 70) |
| `0x90` | 72 | `0x0004` (4) | `$8A:B6B4` | **Item-/Zauber-Fanfare** |

---

## 5. Physischer Track-Katalog (Bank `$81:9903`)

Das Master-Verzeichnis aller 70 Musikstücke liegt ab `$81:9900`. Byte `$81:9900` gibt die Anzahl an (`0x46` = 70 Tracks). Ab `$81:9903` folgt eine Tabelle mit **3-Byte 24-Bit-Zeigern** auf die Songheader:

```
[ Addr Low ] [ Addr High ] [ Bank ]
  Byte 0       Byte 1        Byte 2
```

| Song-Index | Bank & SNES-Adresse | File-Offset | Track-Header (Hex) | Primäre Nutzung |
|:---:|:---:|:---:|:---|:---|
| `0x00` | `$8A:A874` | `0x0AA874` | `97 01 20 00 E6 9B 81 E0...` | **Secret of Evermore Titel-Thema** |
| `0x01` | `$8A:B397` | `0x0AB397` | `22 00 04 00 46 A8 81 38...` | **Standard Bosskampf-Thema** |
| `0x02` | `$8A:B487` | `0x0AB487` | `25 00 04 00 5A A8 81 4C...` | **Hundeverwandlung / Transitions** |
| `0x03` | `$8A:B58C` | `0x0AB58C` | `2A 00 04 00 72 A8 81 50...` | **Siegesfanfare** |
| `0x04` | `$8A:B6B4` | `0x0AB6B4` | `2E 00 04 00 86 A8 81 64...` | **Belohnungsfanfare** |
| `0x05` | `$8A:B7F8` | `0x0AB7F8` | `24 00 04 00 9E A8 81 48...` | **Dorf der Feueraugen** |
| `0x06` | `$8A:B8F6` | `0x0AB8F6` | `32 00 04 00 AE A8 81 50...` | **Höhlensysteme** |
| `0x07` | `$8A:BA56` | `0x0ABA56` | `44 00 04 00 C6 A8 81 70...` | **Urzeit-Sumpf** |
| `0x08` | `$8A:BC34` | `0x0ABC34` | `44 00 04 00 E6 A8 81 98...` | **Vulkan-Labyrinth** |
| `0x09` | `$8A:BE12` | `0x0ABE12` | `48 00 04 00 12 A9 81 7C...` | **Käferlabyrinth** |
| `0x0A` | `$8A:C00C` | `0x0AC00C` | `37 00 04 00 2E A9 81 70...` | **Weg nach Nobilia** |
| `0x0B` | `$8A:C18F` | `0x0AC18F` | `34 00 04 00 4E A9 81 78...` | **Königin Camelia** |
| `0x0C` | `$8A:C2FD` | `0x0AC2FD` | `30 00 04 00 66 A9 81 C8...` | **Gothica Katakomben** |
| `0x0D` | `$8A:C44F` | `0x0AC44F` | `2A 00 04 00 7E A9 81 64...` | **Omnitopia Klimatechnik** |
| `0x0E` | `$8A:C577` | `0x0AC577` | `26 00 04 00 96 A9 81 D8...` | **Antiker Tempel** |
| `0x0F` | `$8A:C683` | `0x0AC683` | `34 00 04 00 AE A9 81 64...` | **Historiker-Lager** |
| `0x10` | `$8A:C7F1` | `0x0AC7F1` | `30 00 04 00 CA A9 81 CC...` | **Minotaurus Arena** |
| `0x11` | `$8A:C943` | `0x0AC943` | `4A 00 04 00 E6 A9 81 54...` | **Einsiedler-Höhle** |
| `0x12` | `$8A:CB4B` | `0x0ACB4B` | `29 00 04 00 12 AA 81 5C...` | **Mammutfriedhof** |
| `0x13` | `$8A:CC6C` | `0x0ACC6C` | `4A 00 04 00 22 AA 81 48...` | **Diebeslager** |
| `0x14` | `$8A:CE74` | `0x0ACE74` | `28 00 04 00 42 AA 81 6C...` | **Kolosseum-Eingang** |
| `0x15` | `$8A:CF8E` | `0x0ACF8E` | `4E 00 04 00 56 AA 81 50...` | **Dunkle Verliese** |
| `0x16` | `$8A:D1B2` | `0x0AD1B2` | `4A 00 04 00 8A AA 81 14...` | **Omnitopia Ankunft** |
| `0x17` | `$8A:D3BA` | `0x0AD3BA` | `28 00 04 00 BE AA 81 44...` | **Tavernen-Musik** |
| `0x18` | `$8A:D4D4` | `0x0AD4D4` | `10 00 04 00 D2 AA 81 28...` | **Windwalker Flugmaschine (Mode 7)** |
| `0x19` | `$8A:D546` | `0x0AD546` | `42 00 04 00 D6 AA 81 54...` | **Nacht-Atmosphäre** |
| `0x1A` | `$8A:D716` | `0x0AD716` | `22 00 04 00 EE AA 81 28...` | **Gefängnis & Verhör** |
| `0x1B` | `$8A:D806` | `0x0AD806` | `16 00 04 00 FE AA 81 28...` | **Antike Lichtung** |
| `0x1C` | `$8A:D8A2` | `0x0AD8A2` | `3B 00 04 00 06 AB 81 78...` | **Podunk 1965 Intro** |
| `0x1D` | `$8A:DA41` | `0x0ADA41` | `2E 00 04 00 22 AB 81 48...` | **Omnitopia Kontrolle** |
| `0x1E` | `$8A:DB85` | `0x0ADB85` | `2F 00 04 00 3A AB 81 30...` | **Markt von Nobilia ("Merchant Sands")** |
| `0x1F` | `$8A:DCD0` | `0x0ADCD0` | `4D 00 04 00 56 AB 81 3C...` | **Omnitopia Tunnels** |
| `0x20` | `$8A:DEED` | `0x0ADEED` | `24 00 04 00 7E AB 81 30...` | **Nobilia Wohnräume** |
| `0x21` | `$8A:DFEB` | `0x0ADFEB` | `10 00 04 00 92 AB 81 C8...` | **Große Pyramide** |
| `0x22` | `$8A:E05D` | `0x0AE05D` | `4A 00 04 00 9A AB 81 54...` | **Oglin-Höhle** |
| `0x23` | `$8A:E265` | `0x0AE265` | `28 00 04 00 BE AB 81 70...` | **Treibsand & Dünen** |
| `0x24` | `$8A:E37F` | `0x0AE37F` | `2C 00 04 00 D2 AB 81 98...` | **Antike Ruinen** |
| `0x25` | `$8A:E4B5` | `0x0AE4B5` | `2C 00 04 00 EE AB 81 48...` | **Nobilia Palast** |
| `0x26` | `$8A:E5EB` | `0x0AE5EB` | `3A 00 04 00 06 AC 81 5C...` | **Geisterhaus** |
| `0x27` | `$8A:E783` | `0x0AE783` | `1A 00 04 00 26 AC 81 64...` | **Mansion Schwarz/Weiß** |
| `0x28` | `$8A:E83B` | `0x0AE83B` | `19 00 04 00 2E AC 81 74...` | **Kolosseum Gladiatorenkampf** |
| `0x29` | `$8A:E8EC` | `0x0AE8EC` | `32 00 04 00 3A AC 81 38...` | **Terrorfels Kanalisation** |
| `0x2A` | `$8A:EA4C` | `0x0AEA4C` | `2B 00 04 00 5A AC 81 98...` | **Urzeithütten** |
| `0x2B` | `$8A:EB7B` | `0x0AEB7B` | `2E 00 04 00 72 AC 81 54...` | **Puppentheater** |
| `0x2C` | `$8A:ECBF` | `0x0AECBF` | `24 00 04 00 82 AC 81 68...` | **Schattenspiel** |
| `0x2D` | `$8A:EDBD` | `0x0AEDBD` | `2A 00 04 00 92 AC 81 5C...` | **Geheimgänge** |
| `0x2E` | `$8A:EEE5` | `0x0AEEE5` | `51 00 04 00 AA AC 81 70...` | **Griechische Gruft** |
| `0x2F` | `$8A:F11E` | `0x0AF11E` | `28 00 04 00 CE AC 81 48...` | **Schachbrett Rätsel** |
| `0x30` | `$8A:F238` | `0x0AF238` | `28 00 04 00 E6 AC 81 5C...` | **Schlossstadt Terrorfels** |
| `0x31` | `$8A:F352` | `0x0AF352` | `2E 00 04 00 FA AC 81 5C...` | **Wasserfallgrotte** |
| `0x32` | `$8A:F496` | `0x0AF496` | `25 00 04 00 0E AD 81 48...` | **Rattenkeller** |
| `0x33` | `$8A:F59B` | `0x0AF59B` | `28 00 04 00 1E AD 81 DC...` | **Dunkler Wald (Dark Forest)** |
| `0x34` | `$8A:F6B5` | `0x0AF6B5` | `42 00 04 00 36 AD 81 54...` | **Schweinerennen Basar** |
| `0x35` | `$8A:F885` | `0x0AF885` | `36 00 04 00 5E AD 81 64...` | **Omnitopia Prominade** |
| `0x36` | `$8A:FA01` | `0x0AFA01` | `34 00 04 00 7A AD 81 7C...` | **Schrottplatz-Docks** |
| `0x37` | `$8A:FB6F` | `0x0AFB6F` | `32 00 04 00 92 AD 81 44...` | **Tüftler-Werkstatt** |
| `0x38` | `$8A:FCCF` | `0x0AFCCF` | `26 00 04 00 AA AD 81 64...` | **Schloss Terrorfels Hallen** |
| `0x39` | `$8A:FDDB` | `0x0AFDDB` | `32 00 04 00 BE AD 81 64...` | **Kerkergewölbe** |
| `0x3A` | `$8A:FF3B` | `0x0AFF3B` | `49 00 04 00 D6 AD 81 14...` | **Ivor Tower Thronsaal** |
| `0x3B` | `$8B:813C` | `0x0B813C` | `3C 00 04 00 FA AD 81 48...` | **Kuriositäten-Show** |
| `0x3C` | `$8B:82E2` | `0x0B82E2` | `40 00 04 00 1A AE 81 64...` | **Schlossfestung** |
| `0x3D` | `$8B:84A4` | `0x0B84A4` | `2A 00 04 00 3A AE 81 64...` | **Mammutfriedhof Zugang** |
| `0x3E` | `$8B:85CC` | `0x0B85CC` | `3C 00 04 00 52 AE 81 54...` | **Hunde-Irrgarten** |
| `0x3F` | `$8B:8772` | `0x0B8772` | `40 00 04 00 76 AE 81 48...` | **Bio-Kuppel Gewächshaus** |
| `0x40` | `$8B:8934` | `0x0B8934` | `0F 00 04 00 92 AE 81 B0...` | **Reaktorkern** |
| `0x41` | `$8B:899F` | `0x0B899F` | `11 00 04 00 9A AE 81 6C...` | **Weltraum-Flucht** |
| `0x42` | `$8B:8A18` | `0x0B8A18` | `20 00 04 00 A2 AE 81 54...` | **Dschungel-Lichtung** |
| `0x43` | `$8B:8AFA` | `0x0B8AFA` | `2A 00 04 00 B2 AE 81 70...` | **Lavaströme** |
| `0x44` | `$8B:8C22` | `0x0B8C22` | `44 00 04 00 C2 AE 81 60...` | **Großer Bosskampf (Gothica)** |
| `0x45` | `$8B:8E00` | `0x0B8E00` | `2E 00 04 00 E6 AE 81 64...` | **Finale: Carltron & Riesen-Roboter** |

---

## 6. Soundeffekt-Tabelle (`$8C:8700`)

Die SFX-Tabelle bei `$8C:8700` (File-Offset `0x0C8700`) enthält 112 Einträge à 16 Bit. Die Skriptbefehle `0x30`, `0x31` und `0x32` referenzieren diese Tabelle über den Byte-Offset (`0x00` bis `0xDE`):

```assembly
; Routine $8C:DA90 (Auszug)
8C:DAA6  A7 82        LDA [dp] 82      ; Lese SFX-Operand aus Skript
8C:DAA8  E6 82        INC dp 82        ; Inkrementiere Skript-PC
8C:DAAA  29 FF 00     AND #$00FF       ; Maskiere Byte
8C:DAB1  AA           TAX              ; Byte als Tabellen-Offset in X
8C:DAB2  BF 00 87 8C  LDA $8C8700,X    ; Lese Hardware-SFX-ID aus Tabelle
8C:DAB8  22 62 86 8C  JSL $8C:8662     ; Übertrage an APU via Befehl $04
```

### 6.1 Wichtige SFX-Einträge & Kategorien

| Offset | Index | Hardware-SFX | Kategorie / Soundbeschreibung |
|:---:|:---:|:---:|:---|
| `0x00` | 0 | `0x0003` (3) | **Schwertschwung / Standard-Angriff** |
| `0x04` | 2 | `0x0001` (1) | **Knochenkeule / Stumpfer Schlag** |
| `0x06` | 3 | `0x0002` (2) | **Axt-Hieb / Schwerer Treffer** |
| `0x0A` | 5 | `0x000F` (15) | **Hundebellen (Prehistoria Wolf)** |
| `0x0C` | 6 | `0x0004` (4) | **Speerstoß / Pfeilschuss** |
| `0x10` | 8 | `0x0016` (22) | **Treffer auf Gegner / Fleisch-Aufprall** |
| `0x12` | 9 | `0x0045` (69) | **Metall-Klingeln / Rüstungsblock** |
| `0x14` | 10 | `0x0046` (70) | **Kritischer Treffer / Schmetterschlag** |
| `0x1A` | 13 | `0x0005` (5) | **Hundejammern / Schmerzenslaut** |
| `0x20` | 16 | `0x0007` (7) | **Alchemiezauber Zündung (Feuerball)** |
| `0x22` | 17 | `0x003E` (62) | **Säure-Zischen / Giftnebel** |
| `0x24` | 18 | `0x0010` (16) | **Heilungsglocke / Genesungszauber** |
| `0x38` | 28 | `0x0003` (3) | **Schrittgeräusch (Gras/Erde)** |
| `0x40` | 32 | `0x0043` (67) | **Menü-Cursor / Ring-Drehung** |
| `0x42` | 33 | `0x004B` (75) | **Menü-Auswahl / Bestätigungston** |
| `0x46` | 35 | `0x004C` (76) | **Menü-Abbruch / Schließen** |
| `0x48` | 36 | `0x004F` (79) | **Alchemie-Rezept erlernt** |
| `0x4A` | 37 | `0x0050` (80) | **Gegenstand erhalten / Schatztruhe** |
| `0x5A` | 45 | `0x002B` (43) | **Große Explosion / Boss-Treffer** |
| `0x5C` | 46 | `0x0028` (40) | **Feuerstrahl / Flammenwand** |
| `0x60` | 48 | `0x0052` (82) | **Blitzschlag / Donnergrollen** |
| `0x64` | 50 | `0x0042` (66) | **Tür öffnen / Schalter einrasten** |
| `0x66` | 51 | `0x0029` (41) | **Wasserplatscher / Eintauchen** |
| `0x76` | 59 | `0x0041` (65) | **Erdbeben / Einstürzende Steine** |
| `0x7A` | 61 | `0x0053` (83) | **Magie-Barriere / Schildklang** |
| `0xC4` | 98 | `0x0008` (8) | **Todesröcheln / Monsterzerfall** |

---

## 7. Speicheradressen & Registerübersicht

### 7.1 WRAM & Direct Page Variablen (Audio-Status)

| Adresse | Länge | Name | Bedeutung / Funktion |
|:---:|:---:|:---|:---|
| `$7E:009A` | `u8` | `fade_target_vol` | Ziellautstärke bei Blenden (`$00`..`$FF`). |
| `$7E:009B` | `i8` | `fade_delta_step` | Schrittweite der Lautstärkeblende (`+0x10` oder `-0x10`). |
| `$7E:009F` | `u8` | `apu_seq_counter` | Aktuelle Handshake-Sequenznummer an Port `$2142`. |
| `$7E:0B83` | `u8` | `stereo_pan_left` | Lautstärkepegel linker Kanal (`0x00`..`0xFF`). |
| `$7E:0B84` | `u8` | `stereo_pan_right` | Lautstärkepegel rechter Kanal (`0x00`..`0xFF`). |
| `$7E:0E4F` | `u16` | `current_bgm_track` | Aktuell abgespielter Musiktrack-Index. |
| `$7E:0E51` | `u8` | `sfx_queue_param` | Soundeffekt-Übergabeparameter. |
| `$7E:0E52` | `u8` | `sfx_queue_channel` | Soundeffekt-Kanalzuordnung. |
| `$7E:0E53` | `u16` | `apu_call_counter` | Zähler aller abgesetzten APU-Befehle (Debug/Statistik). |

### 7.2 SNES PPU / APU Hardware-Register

| Register | Richtung | Name | Funktion |
|:---:|:---:|:---|:---|
| `$2140` | Write | `APUI00` | Befehlscode / Parameter Low-Byte an SPC700 |
| `$2141` | Write | `APUI01` | Parameter High-Byte an SPC700 |
| `$2142` | R/W | `APUI02` | Handshake-Sequenznummer (Trigger zur Befehlsausführung) |
| `$2143` | Read | `APUI03` | SPC700 Antwort- / Status-Register |
