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

Die folgende Tabelle enthält die **exakten deutschen Ingame-Namen** (aus der ROM-Zeigertabelle bei `$C5:036F`), die US-Bezeichnungen, Speicheradressen, Rezepturen (aus `$C5:0685`) und originalen Ingame-Wirkungsbeschreibungen (aus `$C5:03B7`):

| ID | Deutscher Name (ROM) | US-Originalname | XP-Adresse | Level-Adresse | Benötigte Zutaten (Rezept) | Ingame-Wirkung (ROM) |
| :---: | :--- | :--- | :---: | :---: | :--- | :--- |
| **0** | **Säureregen** | Acid Rain | `$7E2F52` | `$7E2F98` | 1× Arnitamin, 3× Wasser | *Gegner werden verätzt.* |
| **1** | **Arnold** | Atlas | `$7E2F54` | `$7E2F9A` | 1× Arnitamin, 1× Asche | *Held wird zu Arnold.* |
| **2** | **Superschild** | Barrier | `$7E2F56` | `$7E2F9C` | 1× Kalkstein, 2× Knochenteil | *Held hat einen Schutzmantel.* |
| **3** | **Zauberperlen** | Call Up | `$7E2F58` | `$7E2F9E` | 1× Mondstein, 1× Trockeneis | *Füllt Zauberperlenvorrat auf.* |
| **4** | **Säuresturm** | Corrosion | `$7E2F5A` | `$7E2FA0` | 1× Pilz, 3× Wasser | *Ätzender Regenschauer.* |
| **5** | **Höllenfaust** | Crush | `$7E2F5C` | `$7E2FA2` | 1× Kalkstein, 1× Wachs | *Riesenfaust zermalmt Gegner.* |
| **6** | **Heilaura** | Cure | `$7E2F5E` | `$7E2FA4` | 2× Wurzel, 1× Öl | *Heilt alle Krankheiten.* |
| **7** | **Energieschild** | Defend | `$7E2F60` | `$7E2FA6` | 1× Lehm, 1× Arnitamin | *Steigert die Verteidigungskraft.* |
| **8** | **Supersog** | Double Drain | `$7E2F62` | `$7E2FA8` | 2× Äthanol, 2× Essig | *Stiehlt Gegnern viel KP.* |
| **9** | **Energiesog** | Drain | `$7E2F64` | `$7E2FAA` | 1× Äthanol, 2× Wurzel | *Stiehlt Gegnern einige KP.* |
| **10** | **Kosmokraft** | Energize | `$7E2F66` | `$7E2FAC` | 1× Kristall, 1× Eisenerz | *Held attackiert mit Kosmokraft.* |
| **11** | **Flucht** | Escape | `$7E2F68` | `$7E2FAE` | 1× Wachs, 1× Essig | *Ermöglicht Flucht aus Verliesen.* |
| **12** | **Explosion** | Explosion | `$7E2F6A` | `$7E2FB0` | 2× Äthanol, 1× Arnitamin | *Zerstört Hindernisse.* |
| **13** | **Feuerball** | Fireball | `$7E2F6C` | `$7E2FB2` | 1× Schwefel, 2× Arnitamin | *Ziel wird durch Feuer zerstört.* |
| **14** | **Hadesgranaten** | Fire Power | `$7E2F6E` | `$7E2FB4` | 1× Feder, 1× Schwefel | *Gegner werden zerstört.* |
| **15** | **Hitzeblitz** | Flash | `$7E2F70` | `$7E2FB6` | 1× Wachs, 2× Öl | *Kleine Feuerbälle.* |
| **16** | **Kraftfeld** | Force Field | `$7E2F72` | `$7E2FB8` | 1× Schmierfett, 1× Eisenerz | *Schützt den Helden vor Attacken.* |
| **17** | **Schlammbombe** | Hard Ball | `$7E2F74` | `$7E2FBA` | 1× Kristall, 1× Lehm | *Gegner werden vollgeschlammt.* |
| **18** | **Krafthauch** | Heal | `$7E2F76` | `$7E2FBC` | 1× Wurzel, 1× Wasser | *Füllt einige KP auf.* |
| **19** | **Lanzenattacke** | Lance | `$7E2F78` | `$7E2FBE` | 1× Eisenerz, 1× Eichel | *Eine Lanze trifft den Gegner.* |
| **20** | **Laserinferno** | Laser | `$7E2F7A` | `$7E2FC0` | 1× Kristall, 1× Schwefel | *Halbiert die KP des Gegners.* |
| **21** | **Telekinese** | Levitate | `$7E2F7C` | `$7E2FC2` | 1× Wasser, 1× Pfeffer | *Räumt Felsen aus dem Weg.* |
| **22** | **Hagelsturm** | Lightning Storm | `$7E2F7E` | `$7E2FC4` | 1× Eisenerz, 2× Arnitamin | *Elektrische Blitze.* |
| **23** | **Heilkraft** | Miracle Cure | `$7E2F80` | `$7E2FC6` | 2× Wurzel, 1× Essig | *Heilt und kräftigt in einem.* |
| **24** | **Nitro** | Nitro | `$7E2F82` | `$7E2FC8` | 1× Dynamit, 2× Schmierfett | *Große Explosion.* |
| **25** | **Frischzellen** | One Up | `$7E2F84` | `$7E2FCA` | 1× Feder, 1× Wurzel | *Füllt die KP des Zieles auf.* |
| **26** | **Zauberspiegel** | Reflect | `$7E2F86` | `$7E2FCC` | 2× Schmierfett, 1× Eisenerz | *Reflektiert Zaubersprüche.* |
| **27** | **Etappenkraft** | Regrowth | `$7E2F88` | `$7E2FCE` | 1× Eichel, 2× Wasser | *Erhöht stufenweise die KP.* |
| **28** | **Zauberbrücke** | Revealer | `$7E2F8A` | `$7E2FD0` | 2× Arnitamin, 1× Wachs | *Läßt unsichtbare Wege erscheinen.* |
| **29** | **Hundeleben** | Revive | `$7E2F8C` | `$7E2FD2` | 3× Wurzel, 1× Knochenteil | *Weckt den Hund wieder auf.* |
| **30** | **Fegefeuer** | Slow Burn | `$7E2F8E` | `$7E2FD4` | 1× Eisenerz, 1× Schwefel | *Vermindert stufenweise die KP.* |
| **31** | **Turboantrieb** | Speed | `$7E2F90` | `$7E2FD6` | 1× Wachs, 2× Wasser | *Erhöht Beweglichkeit des Zieles.* |
| **32** | **Bienenattacke** | Sting | `$7E2F92` | `$7E2FD8` | 2× Wasser, 1× Essig | *Bienen attackieren die Gegner.* |
| **33** | **Unterbrechung** | Stop | `$7E2F94` | `$7E2FDA` | 2× Wachs, 1× Kristall | *Stoppt die Attacken der Gegner.* |
| **34** | **Gigakraft** | Super Heal | `$7E2F96` | `$7E2FDC` | 2× Äthanol, 1× Eichel | *Füllt KP von Held & Hund auf.* |

---

## 3. Alle 22 Alchemie-Zutaten (WRAM-Inventar)

Die Anzahlen aller Zutaten liegen als 1-Byte-Werte (`0` bis `99` / `0x63`) ab WRAM-Adresse `$7E2370`:

| Zutat (DE-ROM Name) | Interner Index | WRAM-Adresse | Max-Menge | US-Entsprechung |
| :--- | :---: | :--- | :---: | :--- |
| **Wachs** | `0x00` | `$7E2398` | 99 | Wax |
| **Wasser** | `0x01` | `$7E2396` | 99 | Water |
| **Essig** | `0x02` | `$7E2394` | 99 | Vinegar |
| **Wurzel** | `0x03` | `$7E2392` | 99 | Root |
| **Öl** | `0x04` | `$7E2390` | 99 | Oil |
| **Pilz** | `0x05` | `$7E238E` | 99 | Mushroom |
| **Pfeffer** | `0x06` | `$7E238C` | 99 | Mud Pepper |
| **Mondstein** | `0x07` | `$7E238A` | 99 | Meteorite |
| **Kalkstein** | `0x08` | `$7E2388` | 99 | Limestone |
| **Eisenerz** | `0x09` | `$7E2386` | 99 | Iron |
| **Dynamit** | `0x0A` | `$7E2382` | 99 | Gunpowder |
| **Schmierfett** | `0x0B` | `$7E2380` | 99 | Grease |
| **Feder** | `0x0C` | `$7E237E` | 99 | Feather |
| **Äthanol** | `0x0D` | `$7E237C` | 99 | Ethanol |
| **Trockeneis** | `0x0E` | `$7E237A` | 99 | Dry Ice |
| **Kristall** | `0x0F` | `$7E2378` | 99 | Crystal |
| **Lehm** | `0x10` | `$7E2376` | 99 | Clay |
| **Schwefel** | `0x11` | `$7E2374` | 99 | Brimstone |
| **Knochenteil** | `0x12` | `$7E2372` | 99 | Bone |
| **Asche** | `0x13` | `$7E2370` | 99 | Ash |
| **Arnitamin** | `0x14` | `$7E2384` | 99 | Atlas Medallion |
| **Eichel** | `0x15` | `$7E239A` | 99 | Acorn |


