# Alchemie & Zauberformeln (Secret of Evermore – Deutsche PAL ROM)

In *Secret of Evermore* basiert das Magiesystem auf **Alchemie**. Anstelle von Manapunkten (MP) verbraucht jeder Zauber eine Kombination aus zwei spezifischen **Zutaten**. 

In der **deutschen PAL-Version** existieren genau **35 Zauberformeln**, deren Namen, Beschreibungen und Werte direkt im 65816-Binärcode verankert sind.

---

## 1. Funktionsweise & Levelsystem

Jede gelernte Zauberformel kann im Spiel bis auf **Level 9** gesteigert werden (Anzeige im Menü z. B. `Level 3:54` oder `Level 9:00`). Im WRAM belegt jede Formel zwei 16-Bit-Speicherstellen:

- **XP-Zähler (Low-Byte):** Liegt im Bereich **`$7E2F52` bis `$7E2F96`** (Schritte von 2 Bytes). Zählt von `0x0000` bis `0x00FF` hoch.
- **Level-Stufe (High-Byte):** Liegt im Bereich **`$7E2F98` bis `$7E2FDC`** (Schritte von 2 Bytes). Speichert das Level von `0` (nicht gelernt) bis `9` (Maximum).
- **Level-Up Routine:** Liegt im deutschen ROM bei `$91:CC6C`. Wenn ein Zauber eingesetzt wird, steigt sein XP-Wert. Bei Erreichen von 256 XP wird das Level um 1 erhöht (`INC $2F98, X`), der XP-Wert genullt (`STZ $2F52, X`) und eine Fanfare abgespielt.

### Aktive Ringmenü-Slots
Der Junge kann bis zu 9 Zauber gleichzeitig im Ringmenü ausrüsten. Die zugewiesenen Zauber-IDs (0 bis 34) liegen an folgenden Byte-Adressen:
- Slot 0: `$7E0ADA` | Slot 1: `$7E0AD9` | Slot 2: `$7E0AD8`
- Slot 3: `$7E0AD7` | Slot 4: `$7E0AD6` | Slot 5: `$7E0AD5`
- Slot 6: `$7E0AD4` | Slot 7: `$7E0AD3` | Slot 8: `$7E0AD2`

---

## 2. Alle 35 Zauberformeln (Deutsche ROM)

Die folgende Tabelle enthält die **exakten deutschen Ingame-Namen**, die US-Bezeichnungen, die Speicheradressen und die benötigten Zutatenmengen (ausgelesen aus der ROM-Tabelle bei `$C5:0685` / `0x050685`):

| ID | Deutscher Name (ROM) | US-Originalname | XP-Adresse | Level-Adresse | Benötigte Zutaten (Rezept) |
| :---: | :--- | :--- | :---: | :---: | :--- |
| **0** | **Säuresturm** | Acid Rain | `$7E2F52` | `$7E2F98` | 1× Atlas-Medaillon, 3× Wasser |
| **1** | **Kraftmeierei** | Atlas | `$7E2F54` | `$7E2F9A` | 1× Atlas-Medaillon, 1× Asche |
| **2** | **Zauberwand** | Barrier | `$7E2F56` | `$7E2F9C` | 1× Kalkstein, 2× Knochen |
| **3** | **Lehmgranaten** | Call Up | `$7E2F58` | `$7E2F9E` | 1× Meteorit, 1× Trockeneis |
| **4** | **Verätzung** | Corrosion | `$7E2F5A` | `$7E2FA0` | 1× Pilz, 3× Wasser |
| **5** | **Höllenfaust** | Crush | `$7E2F5C` | `$7E2FA2` | 1× Kalkstein, 1× Wachs |
| **6** | **Heilaura** | Cure | `$7E2F5E` | `$7E2FA4` | 2× Wurzel, 1× Öl |
| **7** | **Energieschild** | Defend | `$7E2F60` | `$7E2FA6` | 1× Ton, 1× Atlas-Medaillon |
| **8** | **Supersog** | Double Drain | `$7E2F62` | `$7E2FA8` | 2× Äthanol, 2× Essig |
| **9** | **Energiesog** | Drain | `$7E2F64` | `$7E2FAA` | 1× Äthanol, 2× Wurzel |
| **10** | **Kosmokraft** | Energize | `$7E2F66` | `$7E2FAC` | 1× Kristall, 1× Eisen |
| **11** | **Flucht** | Escape | `$7E2F68` | `$7E2FAE` | 1× Wachs, 1× Essig |
| **12** | **Explosion** | Explosion | `$7E2F6A` | `$7E2FB0` | 2× Äthanol, 1× Atlas-Medaillon |
| **13** | **Feuerball** | Fireball | `$7E2F6C` | `$7E2FB2` | 1× Schwefel, 2× Atlas-Medaillon |
| **14** | **Hadesgranaten** | Fire Power | `$7E2F6E` | `$7E2FB4` | 1× Feder, 1× Schwefel |
| **15** | **Hitzeblitz** | Flash | `$7E2F70` | `$7E2FB6` | 1× Wachs, 2× Öl |
| **16** | **Kraftfeld** | Force Field | `$7E2F72` | `$7E2FB8` | 1× Fett, 1× Eisen |
| **17** | **Schlammbombe** | Hard Ball | `$7E2F74` | `$7E2FBA` | 1× Kristall, 1× Ton |
| **18** | **Krafthauch** | Heal | `$7E2F76` | `$7E2FBC` | 1× Wurzel, 1× Wasser |
| **19** | **Lanzenattacke** | Lance | `$7E2F78` | `$7E2FBE` | 1× Eisen, 1× Eichel |
| **20** | **Laserinferno** | Laser | `$7E2F7A` | `$7E2FC0` | 1× Kristall, 1× Schwefel |
| **21** | **Telekinese** | Levitate | `$7E2F7C` | `$7E2FC2` | 1× Wasser, 1× Schlammpfeffer |
| **22** | **Hagelsturm** | Lightning Storm | `$7E2F7E` | `$7E2FC4` | 1× Eisen, 2× Atlas-Medaillon |
| **23** | **Heilkraft** | Miracle Cure | `$7E2F80` | `$7E2FC6` | 2× Wurzel, 1× Essig |
| **24** | **Nitro** | Nitro | `$7E2F82` | `$7E2FC8` | 1× Schießpulver, 2× Fett |
| **25** | **Frischzellen** | One Up | `$7E2F84` | `$7E2FCA` | 1× Feder, 1× Wurzel |
| **26** | **Zauberspiegel** | Reflect | `$7E2F86` | `$7E2FCC` | 2× Fett, 1× Eisen |
| **27** | **Etappenkraft** | Regrowth | `$7E2F88` | `$7E2FCE` | 1× Eichel, 2× Wasser |
| **28** | **Zauberbrücke** | Revealer | `$7E2F8A` | `$7E2FD0` | 2× Atlas-Medaillon, 1× Wachs |
| **29** | **Hundeleben** | Revive | `$7E2F8C` | `$7E2FD2` | 3× Wurzel, 1× Knochen |
| **30** | **Fegefeuer** | Slow Burn | `$7E2F8E` | `$7E2FD4` | 1× Eisen, 1× Schwefel |
| **31** | **Turboantrieb** | Speed | `$7E2F90` | `$7E2FD6` | 1× Wachs, 2× Wasser |
| **32** | **Splitter** | Sting | `$7E2F92` | `$7E2FD8` | 2× Wasser, 1× Essig |
| **33** | **Unterbrechung** | Stop | `$7E2F94` | `$7E2FDA` | 2× Wachs, 1× Kristall |
| **34** | **Gigakraft** | Super Heal | `$7E2F96` | `$7E2FDC` | 2× Äthanol, 1× Eichel |

---

## 3. Alle 22 Alchemie-Zutaten (WRAM-Inventar)

Die Anzahlen aller Zutaten liegen als 1-Byte-Werte (`0` bis `99` / `0x63`) ab WRAM-Adresse `$7E2370`:

| Zutat (DE-ROM Name) | Interner Index | WRAM-Adresse | Max-Menge |
| :--- | :---: | :--- | :---: |
| **Wachs** (Wax) | `0x00` | `$7E2398` | 99 |
| **Wasser** (Water) | `0x01` | `$7E2396` | 99 |
| **Essig** (Vinegar) | `0x02` | `$7E2394` | 99 |
| **Wurzel** (Root) | `0x03` | `$7E2392` | 99 |
| **Öl** (Oil) | `0x04` | `$7E2390` | 99 |
| **Pilz** (Mushroom) | `0x05` | `$7E238E` | 99 |
| **Schlammpfeffer** (Mud Pepper) | `0x06` | `$7E238C` | 99 |
| **Meteorit** (Meteorite) | `0x07` | `$7E238A` | 99 |
| **Kalkstein** (Limestone) | `0x08` | `$7E2388` | 99 |
| **Eisen** (Iron) | `0x09` | `$7E2386` | 99 |
| **Schießpulver** (Gunpowder) | `0x0A` | `$7E2382` | 99 |
| **Fett** (Grease) | `0x0B` | `$7E2380` | 99 |
| **Feder** (Feather) | `0x0C` | `$7E237E` | 99 |
| **Äthanol** (Ethanol) | `0x0D` | `$7E237C` | 99 |
| **Trockeneis** (Dry Ice) | `0x0E` | `$7E237A` | 99 |
| **Kristall** (Crystal) | `0x0F` | `$7E2378` | 99 |
| **Ton** (Clay) | `0x10` | `$7E2376` | 99 |
| **Schwefel** (Brimstone) | `0x11` | `$7E2374` | 99 |
| **Knochen** (Bone) | `0x12` | `$7E2372` | 99 |
| **Asche** (Ash) | `0x13` | `$7E2370` | 99 |
| **Atlas-Medaillon** (Atlas Medallion) | `0x14` | `$7E2384` | 99 |
| **Eichel** (Acorn) | `0x15` | `$7E239A` | 99 |

---

## 4. Mesen2 Cheat-Codes für Alchemie

### Alle 35 Zauber auf Level 9:00 setzen
Navigiere im Mesen2 Memory Viewer zu **`$7E2F98`** und überschreibe die 70 Bytes von `$7E2F98` bis `$7E2FDD` mit:
```text
09 00 09 00 09 00 09 00 09 00 09 00 09 00 09 00 09 00 09 00
09 00 09 00 09 00 09 00 09 00 09 00 09 00 09 00 09 00 09 00
09 00 09 00 09 00 09 00 09 00 09 00 09 00 09 00 09 00 09 00
09 00 09 00 09 00 09 00 09 00
```
Und setze optional die XP-Werte an **`$7E2F52` bis `$7E2F97`** auf `00 00 00 00 ...`.
