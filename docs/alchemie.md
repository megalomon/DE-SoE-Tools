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

---

## 4. Testzauber & Debug-Magie (Entwickler-Befehle)

In der deutschen ROM sind im Textblock von Bank `$05` unmittelbar vor den spielbaren Alchemie-Formeln (ab `$C5:0CA2` bzw. Dateioffset `0x050CA2`) **sieben unfertige Test- und Debug-Zauber** sowie neun Entwickler-Debugaktionen in englischer Originalsprache erhalten geblieben. Diese wurden von den Programmierern bei Square Soft während der Entwicklung für Kampf- und Grafikeffekt-Tests verwendet:

| ID / Zeiger | Interner Name im ROM | Datei-Offset (PC) | SNES-Adresse | Funktion / Entwicklerzweck |
| :---: | :--- | :---: | :---: | :--- |
| **Debug-1** | `Magic: Thud Ball Missile` | `0x050CA2` | `$C5:0CA2` | Projektiltest: Feuert Schappschapp-/Thud-Projektile ab. |
| **Debug-2** | `Magic: Orb2Missile` | `0x050CBB` | `$C5:0CBB` | Projektiltest Stufe 2: Magische Sphäre Stufe 2. |
| **Debug-3** | `Magic: Orb3Missile` | `0x050CCE` | `$C5:0CCE` | Projektiltest Stufe 3: Magische Sphäre Stufe 3. |
| **Debug-4** | `Magic: Shak'em to DEATH!` | `0x050CE1` | `$C5:0CE1` | Screen-Shake & Instant-Kill Testzauber. |
| **Debug-5** | `Magic: Beam me up Scotty` | `0x050CFA` | `$C5:0CFA` | Star-Trek Hommage: Raum-Teleportations- und Escape-Test. |
| **Debug-6** | `Magic: Thud Vortex` | `0x050D13` | `$C5:0D13` | Wirbel-Effekt Testzauber (Schappschapp-Vortex). |
| **Debug-7** | `Magic: High Voltage` | `0x050D26` | `$C5:0D26` | Blitz- und Hochspannungs-Effekttest. |

### Vorangehende Debug-Menü-Aktionen (ab `$C5:0BBE`)
Direkt vor den Testzaubern liegen die Menüstrings für das integrierte SNES-Debugmenü:
- `0x050BBE` (`$C5:0BBE`): `Debug: Show thud balls on path`
- `0x050BDD` (`$C5:0BDD`): `Debug: Turn off both backgrounds`
- `0x050BFE` (`$C5:0BFE`): `Debug: Show background 1 only`
- `0x050C1C` (`$C5:0C1C`): `Debug: Show background 2 only`
- `0x050C3A` (`$C5:0C3A`): `Debug: Show both backgrounds`
- `0x050C57` (`$C5:0C57`): `Debug: Create a monster`
- `0x050C6F` (`$C5:0C6F`): `Debug: Select map`
- `0x050C81` (`$C5:0C81`): `Debug: Mode 7 Flight`
- `0x050C96` (`$C5:0C96`): `Debug: Heel`
- `0x050D3A` (`$C5:0D3A`): `ROM Creation Date`

---

## 5. Ungenutzte Übersetzungs-Entwürfe (Draft Strings)

Im Textbereich der deutschen Lokalisierung existieren mehrere Zaubernamen und Beschreibungstexte, die während der Übersetzung von Claude M. Moyse angelegt, im fertigen Spiel jedoch vor dem Release durch andere Formulierungen ersetzt wurden:

| Entwurfs-String (ROM) | Datei-Offset (PC) | SNES-Adresse | Ursprünglicher Zweck / Analyse |
| :--- | :---: | :---: | :--- |
| **`Kraftmeierei`** | `0x050E60` | `$C5:0E60` | Ursprünglicher Entwurf für *Atlas*, bevor die Formel zu Ehren von Arnold Schwarzenegger final in **Arnold** umbenannt wurde. |
| **`Lehmgranaten`** | `0x050EB3` | `$C5:0EB3` | Ursprünglicher Entwurf für *Hard Ball* oder *Call Up*, später durch **Schlammbombe** bzw. **Zauberperlen** ersetzt. |
| **`Zauberwand`** | `0x050F1D` | `$C5:0F1D` | Ursprünglicher Entwurf für *Barrier*, später durch **Superschild** ersetzt. |
| **`Splitter`** | `0x050F28` | `$C5:0F28` | Ursprünglicher Entwurf für *Sting*, später durch **Bienenattacke** ersetzt. |
| **`Hebt & bewegt schwere Gegenstände.`** | `0x051140` | `$C5:1140` | Ursprüngliche Beschreibung für *Telekinese* (*Levitate*), im Ringmenü ersetzt durch: *Räumt Felsen aus dem Weg.* |
| **`Ziel wird heftig vollgeschlammt.`** | `0x0511FE` | `$C5:11FE` | Zugehörige Entwurfsbeschreibung zur verworfenen Formel *Lehmgranaten*. |
| **`Schützt vor Zaubersprüchen.`** | `0x051300` | `$C5:1300` | Zugehörige Entwurfsbeschreibung zum Entwurf *Zauberwand*. |
| **`Ziel bekämpft seinen Doppelgänger.`** | `0x05131C` | `$C5:131C` | Unbenutzte Zauberbeschreibung für einen Verwirrungs- oder Spiegelungszauber. |

---

## 6. Gegnerzauber & Boss-Magie (Enemy Magic)

Gegner und Bosse verwenden ein eigenständiges Magiesystem. Im Binärcode werden 17 exklusive Gegnerzauber ab Datei-Offset `0x051491` geführt. Ihre Bindung an Animationen und Skripte erfolgt über die 8-Byte-Objekttabelle in Bank `$0E` ab `$0E:85D8`:

| Interner Index | Deutscher Name (ROM) | Datei-Offset (PC) | SNES-Adresse | Animations-Zeiger | Typ / Einsatz |
| :---: | :--- | :---: | :---: | :---: | :--- |
| `0x0000` | **Hitzewelle** | `0x05149C` | `$C5:149C` | `$5BEE` | Feuerangriff (Bosse / Lavawürmer) |
| `0x0002` | **Orkantornado** | `0x0514A7` | `$C5:14A7` | `$5BFA` | Wind- & Wirbelsturm-Magie |
| `0x0004` | **Feuerhölle** | `0x051491` | `$C5:1491` | `$5BF6` | Starker Flächenfeuerzauber |
| `0x0006` | **Zeitsprung** | `0x0514C2` | `$C5:14C2` | `$5BFE` | Zeitmanipulation / Verlangsamung |
| `0x0008` | **Erste Hilfe** | `0x0514CD` | `$C5:14CD` | `$5C02` | Heilzauber für Gegner |
| `0x000A` | **Konfusion** | `0x0514D9` | `$C5:14D9` | `$5C06` | Statuszauber: Verwirrt den Helden/Hund |
| `0x000C` | **Blitzgenesung** | `0x0514E3` | `$C5:14E3` | `$5C0A` | Schnelle Regeneration von Boss-KP |
| `0x000E` | **Aura** | `0x0514F1` | `$C5:14F1` | `$5C0E` | Schutz- und Stärkungsaura |
| `0x0010` | **Schockwelle** | `0x0514F6` | `$C5:14F6` | `$5C12` | Erschütterungs- und Druckwellen-Angriff |
| `0x0012` | **Schild** | `0x051502` | `$C5:1502` | `$5C16` | Physischer Abwehrschild |
| `0x0014` | **Beulenpest** | `0x051509` | `$C5:1509` | `$5C1A` | Starker Vergiftungszauber |
| `0x0016` | **Trance** | `0x051514` | `$C5:1514` | `$5C1E` | Schlaf- und Lähmungsmagie |
| `0x0018` | **Regeneration** | `0x051525` | `$C5:1525` | `$5C22` | Kontinuierliche Selbstheilung |
| `0x001A` | **Erzwinger** | `0x05151B` | `$C5:151B` | — | Zwangseffekt / Boss-Event |
| `0x001C` | **Stromschock** | `0x051532` | `$C5:1532` | `$5C26` | Elektrischer Schockangriff |
| `0x001E` | **Disruptor** | `0x05153E` | `$C5:153E` | `$5C2A` | Omnitopia-Laser & Desintegrationsangriff |
| — | **Reinkarnation** | `0x0514B4` | `$C5:14B4` | `$5BF2` | Wiederbelebungseffekt (z. B. Phönix/Bosse) |

### Kampf-Laufschrift-Tabelle (Battle HUD Spell Banner)
Wenn im Gefecht ein Zauber gewirkt wird, lädt die SNES-Routine bei `$CD:D511` (`LDA $C5062B, X`) den anzuzeigenden Namen aus einer 23 Einträge umfassenden Zeigertabelle bei `$C5:062B` (`0x05062B`):
- Enthält die animierten Spielerzauber (*Säureregen*, *Hitzeblitz*, *Höllenfaust*, *Energiesog*, *Supersog*, *Bienenattacke*, *Hagelsturm*, *Explosion*, *Säuresturm*, *Nitro*, *Unterbrechung*, *Feuerball*, *Heilaura*, *Krafthauch*, *Heilkraft*, *Frischzellen*, *Fegefeuer*, *Kraftfeld*).
- Enthält direkt integriert die 5 aktiven Kampf-Gegnerzauber:
  - `0x14D9`: **Konfusion**
  - `0x149C`: **Hitzewelle**
  - `0x14A7`: **Orkantornado**
  - `0x153E`: **Disruptor**
  - `0x1509`: **Beulenpest**



