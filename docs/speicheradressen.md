# Speicheradressen & Memory Map (Secret of Evermore – Deutsche PAL ROM)

Diese Dokumentation bietet eine vollständige, disassemblierte und verifizierte Übersicht aller relevanten Speicheradressen der **deutschen PAL-Version** von *Secret of Evermore* (`Secret of Evermore (Germany).sfc`).

> [!IMPORTANT]
> **Hinweis zur PAL-Version:**  
> Sämtliche Adressen in diesem Dokument wurden direkt aus dem deutschen ROM-Binary (`SNES HiROM`) bzw. dem RAM-Verhalten analysiert. Sie weichen an vielen Stellen von der US-Version (und allgemeinen Wiki-Einträgen wie DataCrystal) ab.

---

## Inhaltsverzeichnis

1. [WRAM: Währungen](#1-wram-währungen)
2. [WRAM: Waffenlevel & Erfahrung](#2-wram-waffenlevel--erfahrung)
3. [WRAM: Bazooka-Munition](#3-wram-bazooka-munition)
4. [WRAM: Alchemie-Zauber & Level](#4-wram-alchemie-zauber--level)
5. [WRAM: Alchemie-Zutaten](#5-wram-alchemie-zutaten)
6. [WRAM: Charakter- & Begleiter-Status](#6-wram-charakter---begleiter-status)
7. [WRAM: Story- & Event-Flags (Bitfield)](#7-wram-story---event-flags-bitfield)
8. [WRAM: Ausrüstung & Verbrauchs-Items](#8-wram-ausrüstung--verbrauchs-items)
9. [ROM: Wichtige Offsets & Zeigertabellen](#9-rom-wichtige-offsets--zeigertabellen)

---

## 1. WRAM: Währungen

Secret of Evermore besitzt 4 Zeitzonen mit jeweils eigener Währung. Alle Beträge werden als **24-Bit Little-Endian Integer** (3 Bytes, Wertebereich `0` bis `16.777.215`) gespeichert:

| Währung | Zeitzone | WRAM-Startadresse | Bytes | Format / Typ |
| :--- | :--- | :--- | :---: | :--- |
| **Krallen** (Talons) | Prähistorie | `$7E0AC6` – `$7E0AC8` | 3 | 24-Bit Little-Endian |
| **Juwelen / Edelsteine** (Jewels) | Antika (Nobilia) | **`$7E0AC9` – `$7E0ACB`** | 3 | 24-Bit Little-Endian |
| **Goldmünzen** (Gold Coins) | Gotika | `$7E0ACC` – `$7E0ACE` | 3 | 24-Bit Little-Endian |
| **Kreditkarten** (Credits) | Omnitopia | `$7E0ACF` – `$7E0AD1` | 3 | 24-Bit Little-Endian |

- **Aktiver Währungs-Offset:** `$7E2348`  
  Gibt an, welche Währung aktuell im Menü und bei Händlern genutzt wird:
  - `0x00`: Krallen
  - `0x03`: Juwelen
  - `0x06`: Goldmünzen
  - `0x09`: Kreditkarten

*(Handler von Opcode 7C (GIVE_MONEY) im deutschen ROM: `$8C:D940` – `ADC $000AC6, X`).*

---

## 2. WRAM: Waffenlevel & Erfahrung

Jede normale Waffe und auch der Hund belegen **2 Bytes (16-Bit Word)** im WRAM ab `$7E0ADD`:

```
+---------------+---------------+
|   High-Byte   |   Low-Byte    |
|   Level (1-3) |  XP (0-255)   |
+---------------+---------------+
```

- **Low-Byte (`+0`):** Interner Erfahrungszähler (`0` bis `255` bzw. `0x00` bis `0xFF`).
- **High-Byte (`+1`):** Aktuelles Level (`1`, `2` oder `3`).
- **Menü-Berechnung:** Das Menü berechnet den Prozentwert über die SNES-Hardwaremultiplikation (`$4202` / `$4216`):
  $$\text{Anzeige-Prozent} = \frac{\text{XP} \times 100}{256} \quad (0 \dots 99\%)$$
  - `0x00` = `0%`
  - `0x80` (128) = `50%`
  - `0xFF` (255) = `99%`
  - Maximaler Wert: Level 3 bei 0% = `0x0300` (wird als `3:00` angezeigt).

### Adressliste aller Waffen

| Waffe (DE-ROM Name) | Kategorie | Low-Byte (XP) | High-Byte (Level) | Max-Wert (Lvl 3) |
| :--- | :--- | :--- | :--- | :--- |
| **Faustkampf** (Fäuste) | Nahkampf | `$7E0ADD` | `$7E0ADE` | `00 03` |
| **Knochenknüppel** | Schwert 1 | `$7E0ADF` | `$7E0AE0` | `00 03` |
| **Drachentöter** | Schwert 2 | `$7E0AE1` | `$7E0AE2` | `00 03` |
| **Exkalibur** | Schwert 3 | `$7E0AE3` | `$7E0AE4` | `00 03` |
| **Laserschwert** | Schwert 4 | `$7E0AE5` | `$7E0AE6` | `00 03` |
| **Tarantelaxt** | Axt 1 | `$7E0AE7` | `$7E0AE8` | `00 03` |
| **Bronzeaxt** | Axt 2 | `$7E0AE9` | `$7E0AEA` | `00 03` |
| **Streitaxt** | Axt 3 | `$7E0AEB` | `$7E0AEC` | `00 03` |
| **Atomaxt** | Axt 4 | `$7E0AED` | `$7E0AEE` | `00 03` |
| **Speer** | Lanze 1 | `$7E0AEF` | `$7E0AF0` | `00 03` |
| **Bronzespeer** | Lanze 2 | `$7E0AF1` | `$7E0AF2` | `00 03` |
| **Elfenbeinspeer** | Lanze 3 | `$7E0AF3` | `$7E0AF4` | `00 03` |
| **Neutronenspeer** | Lanze 4 | `$7E0AF5` | `$7E0AF6` | `00 03` |
| **Bazooka** | Fernkampf | `$7E0AF7` | `$7E0AF8` | *Kein Level* |
| **Hund (Angriff / Biss)** | Hund | `$7E0B07` | `$7E0B08` | `00 03` |

- **Aktueller Waffenindex (Junge):** `$7E0ABA` (Offset in 2er-Schritten: `0x00` = Faust, `0x02` = Knochenknüppel, etc.).
- **Ausgerüsteter Waffenslot:** `$7E235F` / `$7E2360`.

---

## 3. WRAM: Bazooka-Munition

Die Bazooka steigt nicht im Level auf, sondern verwendet drei verschiedene Munitionsarten:

| Munitionsart (DE-ROM Name) | WRAM-Adresse | Wertebereich | Max |
| :--- | :--- | :--- | :---: |
| **Donnergranaten** (Thunder Ball) | `$7E0B09` | `0x00` – `0x63` | 99 |
| **Plasmaraketen** (Particle Bomb) | `$7E0B0A` | `0x00` – `0x63` | 99 |
| **Cyberbomben** (Cryo-Blast) | `$7E0B0B` | `0x00` – `0x63` | 99 |

---

## 4. WRAM: Alchemie-Zauber & Zutaten

> [!TIP]
> Die vollständige, detaillierte Aufstellung aller **35 Zauberformeln mit ihren exakten deutschen Ingame-Namen**, benötigten Zutatenmengen, Fundorten und Level-Berechnungen befindet sich im separaten Dokument:  
> 👉 [**`docs/alchemie.md`**](alchemie.md)

### Kurzüberblick Alchemie-Speicher:
- **XP-Bereich (Low-Byte):** `$7E2F52` bis `$7E2F96` (Schritte von 2 Bytes)
- **Level-Bereich (High-Byte):** `$7E2F98` bis `$7E2FDC` (Schritte von 2 Bytes, Stufen `0` bis `9`)
- **Aktive Ringmenü-Slots (9 Zauber):** `$7E0ADA` (Slot 0) bis `$7E0AD2` (Slot 8)
- **Alle 22 Zutaten (Zähler 0–99):** `$7E:22FF` bis `$7E:2314` (direkt über `$7E:22FF + ID` in `$91:CCD0` adressiert; z. B. Wachs `$7E:22FF`, Wasser `$7E:2300`, Essig `$7E:2301`, Wurzel `$7E:2302`, Eichel `$7E:2314`)

---

## 5. WRAM: Alchemie-Zutaten

Die Anzahlen aller 22 Zutaten werden ab Basisadresse `$7E:22FF` als 1-Byte-Werte (`0` bis `99` / `0x63`) gespeichert und von der Zauberroutine direkt über `$7E:22FF + Zutaten-ID` gelesen und abgezogen (`$91:CCD0`, `$91:CCFD`):

| Zutat (DE-ROM Name) | Interner Index | WRAM-Adresse (`$7E:22FF + ID`) | Wertebereich | US-Entsprechung |
| :--- | :---: | :--- | :---: | :--- |
| **Wachs** | `0x00` | `$7E:22FF` | `0` – `99` | Wax |
| **Wasser** | `0x01` | `$7E:2300` | `0` – `99` | Water |
| **Essig** | `0x02` | `$7E:2301` | `0` – `99` | Vinegar |
| **Wurzel** | `0x03` | `$7E:2302` | `0` – `99` | Root |
| **Öl** | `0x04` | `$7E:2303` | `0` – `99` | Oil |
| **Pilz** | `0x05` | `$7E:2304` | `0` – `99` | Mushroom |
| **Pfeffer** | `0x06` | `$7E:2305` | `0` – `99` | Mud Pepper |
| **Mondstein** | `0x07` | `$7E:2306` | `0` – `99` | Meteorite |
| **Kalkstein** | `0x08` | `$7E:2307` | `0` – `99` | Limestone |
| **Eisenerz** | `0x09` | `$7E:2308` | `0` – `99` | Iron |
| **Dynamit** | `0x0A` | `$7E:2309` | `0` – `99` | Gunpowder |
| **Schmierfett** | `0x0B` | `$7E:230A` | `0` – `99` | Grease |
| **Feder** | `0x0C` | `$7E:230B` | `0` – `99` | Feather |
| **Äthanol** | `0x0D` | `$7E:230C` | `0` – `99` | Ethanol |
| **Trockeneis** | `0x0E` | `$7E:230D` | `0` – `99` | Dry Ice |
| **Kristall** | `0x0F` | `$7E:230E` | `0` – `99` | Crystal |
| **Lehm** | `0x10` | `$7E:230F` | `0` – `99` | Clay |
| **Schwefel** | `0x11` | `$7E:2310` | `0` – `99` | Brimstone |
| **Knochenteil** | `0x12` | `$7E:2311` | `0` – `99` | Bone |
| **Asche** | `0x13` | `$7E:2312` | `0` – `99` | Ash |
| **Arnitamin** | `0x14` | `$7E:2313` | `0` – `99` | Atlas Medallion |
| **Eichel** | `0x15` | `$7E:2314` | `0` – `99` | Acorn |

---

## 6. WRAM: Charakter- & Begleiter-Status

| Eigenschaft | Junge | Hund | Format / Typ |
| :--- | :--- | :--- | :--- |
| **Aktuelle Lebenspunkte (HP)** | `$7E:4EB3` (Entity `+0x2A`, Held `$4E89`) | `$7E:4F61` (Entity `+0x2A`, Hund `$4F37`) | 16-Bit Little-Endian |
| **Maximale Lebenspunkte (Max HP)** | `$7E:0A35` | `$7E:0A7F` | 16-Bit Little-Endian (Begrenzung auf 999 bei `$8F:83A6`, kopiert nach `$4F61` bei `$8F:84FC`) |
| **Charakter-Level** | `$7E:0A50` | `$7E:0A9A` | 16-Bit Little-Endian (`$8F:832D` nutzt `$0A50`×2 als Wachstumsindex) |
| **Erfahrungspunkte (EXP)** | `$7E:0A49` – `$7E:0A4C` | `$7E:0A93` – `$7E:0A96` | 32-Bit Little-Endian |

---

## 7. WRAM: Story- & Event-Flags (Bitfield)

> [!TIP]
> Die vollständige Aufstellung aller **Event-Flags** (inklusive aller 24 Bosse, Nobilia-Marktplatz-Tauschflags, Quest-Fortschritte und Hund-Schnüffelstellen) befindet sich im separaten Dokument:  
> 👉 [**`docs/event_flags.md`**](event_flags.md)

Story-Fortschritte, Händler-Tauschgeschäfte und Truhen werden in einem Bitfield ab Basisadresse **`$7E2258`** gespeichert:

### Berechnungsformel für ein Flag mit ID $F$:
- **Byte-Adresse im WRAM:**
  $$\text{Adresse} = \$7E2258 + \lfloor F / 8 \rfloor = \$7E2258 + (F \gg 3)$$
- **Bit-Position:**
  $$\text{Bit-Index} = F \pmod 8 = F \ \& \ 7 \quad (\text{Bitmaske} = 1 \ll (F \ \& \ 7))$$

### Bekannte Schlüssel-Flags

| Flag-ID | Beschreibung | Byte-Adresse | Bit-Maske | Bedeutung |
| :---: | :--- | :---: | :---: | :--- |
| **`0x004E`** | **Chocobo-Ei** (Pot Trader Nobilia) | **`$7E2261`** | `0x40` (Bit 6) | `1` = Ei erhalten / getauscht |
| **`0x0052`** | **Mythenschärpe** (Magic Gourd) | **`$7E2262`** | `0x04` (Bit 2) | `1` = Schärpe im Besitz |
| **`0x002B`** | Allelachema Markt Einlass / Eintritt | `$7E225D` | `0x08` (Bit 3) | `1` = Tor offen |

---

## 8. WRAM: Ausrüstung & Verbrauchs-Items

> [!TIP]
> Die vollständige Dokumentation aller **Waffen, Rüstungen, Helme, Armbänder, Hundehalsbänder, Verbrauchsgegenstände und Tauschwaren** mit ihren exakten deutschen Ingame-Namen und ROM-Offsets befindet sich im separaten Dokument:  
> 👉 [**`docs/ausruestung_items.md`**](ausruestung_items.md)

### Ausgerüstete Gegenstände (Ringmenü-Ausrüstung im WRAM)
- **Ausgerüstete Rüstung (Held):** `$7E:2350` (Item-ID `0` bis `11`, z. B. `0` = Moosweste, `11` = Cyberweste)
- **Ausgerüsteter Helm (Held):** `$7E:2352` (Item-ID `0` bis `11`, z. B. `0` = Hippiemütze, `11` = Elektrohelm)
- **Ausgerüstetes Armband (Held):** `$7E:2354` (Item-ID `0` bis `11`, z. B. `0` = Gemüsearmband, `11` = Elektroarmband)
- **Ausgerüstetes Halsband (Hund):** `$7E:2356` (Item-ID `0` bis `3`, z. B. `0` = Lederhalsband, `3` = Juwelenhalsband)
- **Ausgerüstete Waffe (Held):** `$7E:235F` / `$7E:2360` (Waffenslot im Ringmenü)

### Heil- & Unterstützungsitems (Zähler 0–99 im WRAM)
- **Blätter:** `$7E2364` (Zähler 0–99)
- **Nektar:** `$7E2366` (Zähler 0–99)
- **Honig:** `$7E2368` (Zähler 0–99)
- **Hundekuchen:** `$7E236A` (Zähler 0–99)
- **Flügel:** `$7E236C` (Zähler 0–99)
- **Elixier:** `$7E236E` (Zähler 0–99)

### Kampf- und Charge-Register
> [!NOTE]
> Diese Register dienen der Kampfengine zur Berechnung von Angriffskraft und Aufladebalken:
- **Charge-Limit Junge:** `$7E:0A52` (`$8F:8262` schreibt Waffenlevel × `0x400`)
- **Charge-Bonus Junge:** `$7E:0A54` (wird bei `$8F:CC2D` zum Charge addiert)
- **Hund Waffenlevel:** `$7E:0B07` (Low = EXP, High = Level 1..3, gesteigert bei `$8F:9787`)
- **Charge-Limit Hund:** `$7E:0A9C` (abgeleitet aus Hund-Waffenlevel)

---

## 9. ROM: Wichtige Offsets & Zeigertabellen

| Bereich / Struktur | SNES-Adresse | Datei-Offset (PC) | Format & Hinweise |
| :--- | :--- | :--- | :--- |
| **Map-List Zeigertabelle** | `$A0:FDE5` | `0x20FDE5` | 127 Maps (je 4 Bytes, 4. Byte = 0 für IDs 0..126) |
| **Skript-Startadresse** | `$93:8000` | `0x138000` | Start der SIGIL-Bytecode-Banken ($93..$9C) |
| **Opcode-Sprungtabelle** | `$8C:ECBE` | `0x0CECBE` | 195 Einträge (168 aktive Handler, 27 STP-Traps) |
| **Ausdrucks-Sprungtabelle** | `$8C:F442` | `0x0CF442` | Tabelle für Ausdrucks-Evaluator ($8C:EE44) |
| **Dialogtext-Zeigertabelle** | `$92:8000` | `0x128000` | Exakt 3082 Einträge (endet an Markov-Tabelle `$92:A41E`) |
| **Markov-Dekomprimierer** | `$8C:D147` | `0x0CD147` | Huffman/Markov-Dekomprimierung für deutsche Texte |
| **Markov-Häufigkeitstabelle**| `$92:A41E` | `0x12A41E` | 14 Nachfolger-Zeichen pro Vorläufer-Char |
| **16×16 Background-Tiles** | `$EF:0000` | `0x2F0000` | 6.708 komprimierte Hintergrund-Tiles |
| **16×16 Sprite-Parts** | `$EE:0000` | `0x2E0000` | 4.876 Sprite-Parts |
| **8×8 Sprite-Blöcke** | `$D9:0000` | `0x190000` | 6.282 8×8 Tiles (Banks $D2..$D8) |
| **Sound-Effekt-Tabelle** | `$8C:8700` | `0x0C8700` | Lookup-Tabelle für SFX-Opcodes `0x30`..`0x32` (`PLAY_SFX_1..3`) |
| **BGM-Musik-Tabelle** | `$8C:87E0` | `0x0C87E0` | Lookup-Tabelle für BGM-Opcode `0x33` (`PLAY_BGM`, 16-Bit-Word-Einträge) |
| **Charakter- & Gegnerdaten** | `$8E:B678` | `0x0EB678` | 142 Tabelleneinträge à 74 Bytes |



