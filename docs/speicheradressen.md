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
10. [Mesen2 Cheat- & Praxis-Guide](#10-mesen2-cheat---praxis-guide)

---

## 1. WRAM: Währungen

Secret of Evermore besitzt 4 Zeitzonen mit jeweils eigener Währung. Alle Beträge werden als **24-Bit Little-Endian Integer** (3 Bytes, Wertebereich `0` bis `16.777.215`) gespeichert:

| Währung | Zeitzone | WRAM-Startadresse | Bytes | Format / Typ |
| :--- | :--- | :--- | :---: | :--- |
| **Krallen** (Talons) | Prähistorie | `$7E0AC6` – `$7E0AC8` | 3 | 24-Bit Little-Endian |
| **Juwelen / Edelsteine** (Jewels) | Antika (Nobilia) | **`$7E0AC9` – `$7E0ACB`** | 3 | 24-Bit Little-Endian |
| **Goldmünzen** (Gold Coins) | Gotika | `$7E0ACC` – `$7E0ACE` | 3 | 24-Bit Little-Endian |
| **Credits** | Omnitopia | `$7E0ACF` – `$7E0AD1` | 3 | 24-Bit Little-Endian |

- **Aktiver Währungs-Offset:** `$7E2348`  
  Gibt an, welche Währung aktuell im Menü und bei Händlern genutzt wird:
  - `0x00`: Krallen
  - `0x03`: Juwelen
  - `0x06`: Goldmünzen
  - `0x09`: Credits

*(Routine zur Währungsänderung im deutschen ROM: `$8C:D940` – `ADC $000AC6, X`).*

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
| **Knochenknöppel** | Schwert 1 | `$7E0ADF` | `$7E0AE0` | `00 03` |
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
| **Donnerbüchse (Bazooka)** | Fernkampf | `$7E0AF7` | `$7E0AF8` | *Kein Level* |
| **Hund (Angriff / Biss)** | Hund | `$7E0B07` | `$7E0B08` | `00 03` |

- **Aktueller Waffenindex (Junge):** `$7E0ABA` (Offset in 2er-Schritten: `0x00` = Faust, `0x02` = Knochenknöppel, etc.).
- **Ausgerüsteter Waffenslot:** `$7E235F` / `$7E2360`.

---

## 3. WRAM: Bazooka-Munition

Die Donnerbüchse steigt nicht im Level auf, sondern verwendet drei verschiedene Munitionsarten:

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
- **Alle 22 Zutaten (Zähler 0–99):** `$7E2370` bis `$7E239A` (z. B. Asche `$7E2370`, Wachs `$7E2398`, Wasser `$7E2396`, Essig `$7E2394`, Wurzel `$7E2392`)

---

## 5. WRAM: Alchemie-Zutaten

Die Anzahlen aller 22 Zutaten werden ab Basisadresse `$7E2370` im 2-Byte-Abstand gespeichert (jeweils 1 Byte Zähler, `0` bis `99` / `0x63`):

| Zutat (DE-ROM Name) | WRAM-Adresse | Wertebereich |
| :--- | :--- | :--- |
| **Asche** (Ash) | `$7E2370` | `0` – `99` |
| **Knochen** (Bone) | `$7E2372` | `0` – `99` |
| **Schwefel** (Brimstone) | `$7E2374` | `0` – `99` |
| **Ton** (Clay) | `$7E2376` | `0` – `99` |
| **Kristall** (Crystal) | `$7E2378` | `0` – `99` |
| **Trockeneis** (Dry Ice) | `$7E237A` | `0` – `99` |
| **Äthanol** (Ethanol) | `$7E237C` | `0` – `99` |
| **Feder** (Feather) | `$7E237E` | `0` – `99` |
| **Fett** (Grease) | `$7E2380` | `0` – `99` |
| **Schießpulver** (Gunpowder) | `$7E2382` | `0` – `99` |
| **Atlas-Medaillon** | `$7E2384` | `0` – `99` |
| **Eisen** (Iron) | `$7E2386` | `0` – `99` |
| **Kalkstein** (Limestone) | `$7E2388` | `0` – `99` |
| **Meteorit** (Meteorite) | `$7E238A` | `0` – `99` |
| **Schlammpfeffer** (Mud Pepper) | `$7E238C` | `0` – `99` |
| **Pilz** (Mushroom) | `$7E238E` | `0` – `99` |
| **Öl** (Oil) | `$7E2390` | `0` – `99` |
| **Wurzel** (Root) | `$7E2392` | `0` – `99` |
| **Essig** (Vinegar) | `$7E2394` | `0` – `99` |
| **Wasser** (Water) | `$7E2396` | `0` – `99` |
| **Wachs** (Wax) | `$7E2398` | `0` – `99` |
| **Eichel** (Acorn) | `$7E239A` | `0` – `99` |

---

## 6. WRAM: Charakter- & Begleiter-Status

| Eigenschaft | Junge | Hund | Format / Typ |
| :--- | :--- | :--- | :--- |
| **Aktuelle Lebenspunkte (HP)** | `$7E4EB3` *(bzw. `$7E0834`)* | `$7E4EBD` | 16-Bit Little-Endian |
| **Maximale Lebenspunkte (Max HP)** | `$7E0A35` | `$7E0A7F` | 16-Bit Little-Endian |
| **Charakter-Level** | `$7E0A50` | `$7E0A9A` | 16-Bit Little-Endian |
| **Erfahrungspunkte (EXP)** | `$7E0A4E` – `$7E0A4F` | `$7E0A98` – `$7E0A99` | 16-Bit Little-Endian |

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
| **`0x002B`** | Nobilia Markt Einlass / Eintritt | `$7E225D` | `0x08` (Bit 3) | `1` = Tor offen |

> [!TIP]
> **Chocobo-Ei erneut ertauschen:**  
> Setze in Mesen2 an Adresse **`$7E2261`** das Bit 6 auf `0` (z. B. wenn das Byte `0x78` ist, ändere es auf `0x38`), damit der Töpfer das Chocobo-Ei erneut anbietet.

---

## 8. WRAM: Ausrüstung & Verbrauchs-Items

### Heil- & Unterstützungsitems (Zähler 0–99)
- **Blütenblätter:** `$7E2364`
- **Nektartropfen:** `$7E2366`
- **Honigtropfen:** `$7E2368`
- **Hundekuchen:** `$7E236A`
- **Elixier:** `$7E236C`

---

## 9. ROM: Wichtige Offsets & Zeigertabellen

| Bereich / Struktur | SNES-Adresse | Datei-Offset (PC) | Format & Hinweise |
| :--- | :--- | :--- | :--- |
| **Map-List Zeigertabelle** | `$A0:FDE5` | `0x20FDE5` | 127 Maps mit Tilemaps, Paletten & Skriptzeigern |
| **Skript-Startadresse** | `$93:8000` | `0x138000` | Start der SIGIL-Bytecode-Bank |
| **Opcode-Sprungtabelle** | `$8C:ECBE` | `0x0CECBE` | Primäre Sprungtabelle für Skriptbefehle |
| **Sub-Opcode-Sprungtabelle** | `$8C:F442` | `0x0CF442` | Sekundäre Sprungtabelle (Trigger & mathematische Befehle) |
| **Dialogtext-Zeigertabelle** | `$92:8000` | `0x128000` | 3 Bytes pro Eintrag: `Offset & 0x7FFF` + Bank |
| **Markov-Dekomprimierer** | `$8C:D147` | `0x0CD147` | Hardware-Dekomprimierung für deutsche Texte |
| **Markov-Häufigkeitstabelle**| `$92:A41E` | `0x12A41E` | 14 Nachfolger-Zeichen pro Vorläufer-Char |
| **16×16 Background-Tiles** | `$EE:0000` | `0x2E0000` | 6.687 komprimierte Hintergrund-Tiles |
| **16×16 Sprite-Blöcke** | `$EC:0000` | `0x2C0000` | 4.854 komprimierte Sprite-Blöcke |
| **8×8 Sprite-Blöcke** | `$D8:0000` | `0x180000` | 6.265 komprimierte 8×8 Tiles |
| **Charakter- & Gegnerdaten** | `$8E:B678` | `0x0EB678` | 142 Tabelleneinträge à 74 Bytes |

---

## 10. Mesen2 Cheat- & Praxis-Guide

### A. Alle 12 normalen Waffen auf Level 3:00 maxen
Öffne in Mesen2 den **Memory Viewer** (`Debug` → `Memory Viewer`), navigiere zu WRAM `$7E0ADF` und überschreibe die 24 aufeinanderfolgenden Bytes von **`$7E0ADF` bis `$7E0AF6`** mit:

```text
00 03 00 03 00 03 00 03 00 03 00 03 00 03 00 03 00 03 00 03 00 03 00 03
```
Und für den **Hund** an **`$7E0B07`**:
```text
00 03
```

### B. Maximales Geld für alle Zeitzonen
Setze die folgenden 12 Bytes ab **`$7E0AC6`**:
```text
FF FF FF  FF FF FF  FF FF FF  FF FF FF
```
Ergibt **16.777.215** Krallen, Juwelen, Goldmünzen und Credits.

### C. 99 Stück aller Alchemie-Zutaten
Setze den 44-Byte-Block ab **`$7E2370` bis `$7E239B`** auf `63 00 63 00 ...` (jede Zutat auf `0x63` = 99 decimal).
