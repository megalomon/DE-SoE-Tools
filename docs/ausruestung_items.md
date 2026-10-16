# Ausrüstung, Waffen & Items (Secret of Evermore – Deutsche PAL ROM)

Diese Dokumentation beschreibt das vollständige Ausrüstungs-, Waffen- und Gegenstandssystem der **deutschen PAL-Version** von *Secret of Evermore* (`Secret of Evermore (Germany).sfc`).

Alle hier aufgeführten Bezeichnungen entsprechen **exakt den authentischen Ingame-Namen** der deutschen Lokalisierung (Übersetzung von Claude M. Moyse) und wurden direkt aus den Texttabellen der SNES-ROM (Bank `$05` ab `0x05077C` und `0x0519E8`) extrahiert.

---

## 1. Waffen & Waffenlevel

Im Spiel verfügt der Held über drei primäre Nahkampfwaffengattungen (**Schwerter**, **Äxte**, **Speere**) mit jeweils vier Entwicklungsstufen sowie über eine Fernkampfwaffe (**Bazooka**) und den Angriff des Hundes.

### Waffensystem & Level-Mechanik
- Jede Nahkampfwaffe kann im Spiel durch Benutzung von **Level 1** bis **Level 3** gesteigert werden (Anzeige im Menü z. B. `Level 1:45`, `Level 2:80`, `Level 3:00`).
- Im WRAM belegt jede Waffe ein **16-Bit Word (2 Bytes)** ab `$7E0ADD`:
  - **Low-Byte (`+0`):** XP-Zähler von `0` bis `255` (`0x00` bis `0xFF`).
  - **High-Byte (`+1`):** Level-Stufe (`1`, `2` oder `3`).
- **Berechnung der Menüanzeige:**
  $$\text{Anzeige-Prozent} = \frac{\text{XP} \times 100}{256} \quad (0 \dots 99\%)$$
  - Maximalwert: Level 3 bei 0% XP = `0x0300` (wird als `3:00` dargestellt).
- **Aufladebalken (Angriffsstufen):**
  - **Stufe 1 (100% Balken):** Standard-Schlag.
  - **Stufe 2 (200% Balken, ab Level 2):** Aufgeladener Spezialschlag mit erhöhtem Schaden und Reichweite.
  - **Stufe 3 (300% Balken, ab Level 3):** Maximaler Flächen- oder Durchschlagstreffer.

---

### A. Schwerter

| Stufe | Deutscher Name (ROM) | US-Originalname | ROM-Offset | Basis-Angriff | Ingame-Beschreibung (ROM) | WRAM XP | WRAM Lvl |
| :---: | :--- | :--- | :---: | :---: | :--- | :---: | :---: |
| 1 | **Knochenknüppel** | Bone Crusher | `0x0507A0` | **10** | *Effektiv gegen Moskitos.* | `$7E0ADF` | `$7E0AE0` |
| 2 | **Drachentöter** | Gladiator | `0x05077C` | **20** | *Liegt gut in der Hand.* | `$7E0AE1` | `$7E0AE2` |
| 3 | **Exkalibur** | Crusader | `0x050789` | **30** | *Das Schwert aus der Legende.* | `$7E0AE3` | `$7E0AE4` |
| 4 | **Laserschwert** | Neutron Blade | `0x050793` | **50** | *Das ultimative Schwert.* | `$7E0AE5` | `$7E0AE6` |

---

### B. Äxte

Äxte dienen neben dem Kampf auch zum Beseitigen von Hindernissen auf den Maps:
- **Tarantelaxt:** Zerschlägt störendes Buschwerk und Gestrüpp (z. B. in Prähistorie).
- **Bronzeaxt & höher:** Zertrümmert Felsen, Barrikaden und Steinsäulen.

| Stufe | Deutscher Name (ROM) | US-Originalname | ROM-Offset | Basis-Angriff | Ingame-Beschreibung (ROM) | WRAM XP | WRAM Lvl |
| :---: | :--- | :--- | :---: | :---: | :--- | :---: | :---: |
| 1 | **Tarantelaxt** | Spider's Claw | `0x0507AF` | **15** | *Zerstört störendes Buschwerk.* | `$7E0AE7` | `$7E0AE8` |
| 2 | **Bronzeaxt** | Bronze Axe | `0x0507BB` | **25** | *Zertrümmert sogar solide Felsen.* | `$7E0AE9` | `$7E0AEA` |
| 3 | **Streitaxt** | Knight's Basher | `0x0507C5` | **35** | *Vernichtet alle Arten von Gegnern.* | `$7E0AEB` | `$7E0AEC` |
| 4 | **Atomaxt** | Atom Smasher | `0x0507CF` | **50** | *Zerteilt alles - sogar Atome.* | `$7E0AED` | `$7E0AEE` |

---

### C. Speere

Speere bieten eine höhere Nahkampfreichweite und können bei aufgeladenem Schlag geworfen werden oder über Schalterbrücken hebeln.

| Stufe | Deutscher Name (ROM) | US-Originalname | ROM-Offset | Basis-Angriff | Ingame-Beschreibung (ROM) | WRAM XP | WRAM Lvl |
| :---: | :--- | :--- | :---: | :---: | :--- | :---: | :---: |
| 1 | **Speer** | Horn Spear | `0x0507D7` | **20** | *Die ideale Nahkampfwaffe.* | `$7E0AEF` | `$7E0AF0` |
| 2 | **Bronzespeer** | Bronze Spear | `0x0507DD` | **30** | *Eine höchst ansehnliche Waffe.* | `$7E0AF1` | `$7E0AF2` |
| 3 | **Elfenbeinspeer** | Lance | `0x0507E9` | **40** | *Sogar Du kannst sie benutzen.* | `$7E0AF3` | `$7E0AF4` |
| 4 | **Neutronenspeer** | Laser Lance | `0x0507F8` | **50** | *Neutralisiert die Gegner.* | `$7E0AF5` | `$7E0AF6` |

---

### D. Bazooka & Munition

Die **Bazooka** (im ROM-Text `0x050830` wörtlich *Bazooka*) ist die schwere Fernkampfwaffe des Jungen. Sie besitzt kein Waffenlevel, sondern verbraucht bei jedem Schuss eine von drei Munitionsarten:

| Munition (ROM) | US-Originalname | ROM-Offset | Basis-Angriff | WRAM-Adresse | Wertebereich |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **Donnergranaten** | Thunder Ball | `0x050807` | **200** | `$7E0B09` | `0` – `99` (`0x63`) |
| **Plasmaraketen** | Particle Bomb | `0x050816` | **350** | `$7E0B0A` | `0` – `99` (`0x63`) |
| **Cyberbomben** | Cryo-Blast | `0x050824` | **800** | `$7E0B0B` | `0` – `99` (`0x63`) |

- **Bazooka Ausrüstungseintrag:** `$7E0AF7` / `$7E0AF8` (Status im Ringmenü).

---

### E. Angriff des Hundes

Auch der Hund besitzt ein eigenes Angriffslevel:
- **Hund-Angriffslevel:** WRAM **`$7E0B07`** (Low: XP, High: Level 1–3).
- **Hundeform je Zeitzone:**
  - **Prähistorie:** Urzeit-Wolfhund
  - **Antika:** Schlanker Windhund / Schakal
  - **Gotika:** Edelpudel mit Zopffrisur
  - **Assitopia / Omnitopia:** Toaster-Roboterhund

---

## 2. ROM-Tabellenarchitektur (Bank $C4) & Ausrüstungs-WRAM

Die Ausrüstungsdaten des Spiels werden in **Bank `$C4`** über eine Master-Zeigertabelle bei **`$84:3EAD` / `$C4:3EAD`** adressiert:
- **Waffen:** `$C4:3F26` (15 Einträge, Stride **36 Bytes / `0x24`**)
- **Körperrüstungen:** `$C4:4142` (12 Einträge, Stride **10 Bytes / `0x0A`**)
- **Helme:** `$C4:41BA` (12 Einträge, Stride **10 Bytes / `0x0A`**)
- **Armbänder:** `$C4:4232` (12 Einträge, Stride **10 Bytes / `0x0A`**)
- **Hundehalsbänder:** `$C4:42AA` (4 Einträge, Stride **10 Bytes / `0x0A`**)

### 10-Byte-Struktur für Rüstungen, Helme, Armbänder & Halsbänder:
```
+0x00 (2 Bytes): Abwehr-Bonus (Defense)
+0x02 (2 Bytes): Identisch zu +0x00 (Delta +0 in allen 40 Records; kein Kaufpreis)
+0x04 (2 Bytes): Zeiger auf deutschen Textnamen in Bank $05
+0x06 (2 Bytes): Konstante 0x0753 (in allen 40 Records)
+0x08 (2 Bytes): ID-Zähler in 2er-Schritten (0x00A0..0x00EE, kein Padding)
```

### WRAM: Ausgerüstete Gegenstände vs. Kampf-Charge-Register:
> [!IMPORTANT]
> Frühere inoffizielle Dokumentationen gaben irrtümlich `$7E:2350..2356` für ausgerüstete Gegenstände an; dieser Bereich wird im ROM jedoch nie referenziert. Die tatsächlichen Ausrüstungs-Speicheradressen im WRAM lauten:
> - **Ausgerüstete Rüstung (Held):** **`$7E:0AC0`** (Zeiger auf Struktur)
> - **Ausgerüsteter Helm (Held):** **`$7E:0AC2`** (Zeiger auf Struktur)
> - **Ausgerüstetes Armband (Held):** **`$7E:0AC4`** (Zeiger auf Struktur)
> - **Ausgerüstete Waffe (Held):** **`$7E:0ABA`** (Waffenindex in 2er-Schritten)
> - *Charge-Limit Junge (`$7E:0A52`):* Waffenlevel × `0x400`
> - *Charge-Bonus Junge (`$7E:0A54`):* Additionsbonus bei `$8F:CC2D`
> - *Charge-Limit Hund (`$7E:0A9C`):* Aus Hund-Waffenlevel abgeleitet

---

## 3. Rüstungen (Body Armor)

In der deutschen ROM werden alle 12 Körperrüstungen in Bank `$05` ab Offset `0x0509AE` benannt. Ihre Werte stammen direkt aus der Item-Strukturtabelle bei `$C4:4142` (Stride 10 Bytes):
Der aktuell ausgerüstete Zeiger des Jungen liegt im WRAM an Adresse **`$7E:0AC0`** (Zeiger auf Rüstungsstruktur).

| Index | Deutscher Name (ROM) | US-Originalname | ROM-Offset | Abwehr (Def) | Epoche / Bereich |
| :---: | :--- | :--- | :---: | :---: | :--- |
| `0x00` | **Moosweste** | Grass Vest | `0x0509AE` | **+3** | Prähistorie (Dschungel) |
| `0x01` | **Panzerrüstung** | Shell Armor | `0x0509B8` | **+4** | Prähistorie (Dschungeldorf) |
| `0x02` | **Raptorleder** | Dino Skin | `0x0509C6` | **+7** | Prähistorie (Vulkan) |
| `0x03` | **Bronzerüstung** | Bronze Armor | `0x0509D2` | **+12** | Antika (Krozkrübel) |
| `0x04` | **Granitpanzer** | Stone Vest | `0x0509E0` | **+19** | Antika (Oase / Camp) |
| `0x05` | **Römertoga** | Centurion Cape | `0x0509ED` | **+28** | Antika (Allelachema Markt) |
| `0x06` | **Silberrüstung** | Silver Mail | `0x0509F7` | **+40** | Gotika (Chaosturm) |
| `0x07` | **Goldrüstung** | Gold Plated | `0x050A05` | **+55** | Gotika (Terrorfels Markt) |
| `0x08` | **Neonweste** | Shining Armor | `0x050A11` | **+73** | Gotika (Schloss) |
| `0x09` | **Stahlpanzer** | Magna Mail | `0x050A1B` | **+94** | Omnitopia (Schrottplatz) |
| `0x0A` | **Titaniumweste** | Titanium Vest | `0x050A27` | **+124** | Omnitopia (Metroplex) |
| `0x0B` | **Cyberweste** | Virtual Suit | `0x050A35` | **+169** | Omnitopia (Reaktor / Finale) |

---

## 4. Helme (Helmets)

Die 12 Kopfbedeckungen liegen in Bank `$05` ab Offset `0x050A40`. Ihre Werte stammen aus der Item-Strukturtabelle ab `$C4:41BA` (Stride 10 Bytes):
Der aktuell ausgerüstete Helm-Zeiger des Jungen liegt im WRAM an Adresse **`$7E:0AC2`** (Zeiger auf Helmstruktur).

| Index | Deutscher Name (ROM) | US-Originalname | ROM-Offset | Abwehr (Def) | Epoche / Bereich |
| :---: | :--- | :--- | :--- | :---: | :--- |
| `0x00` | **Hippiemütze** | Grass Hat | `0x050A40` | **+2** | Prähistorie (Start) |
| `0x01` | **Panzerhelm** | Shell Hat | `0x050A4C` | **+3** | Prähistorie (Dschungeldorf) |
| `0x02` | **Schädelhelm** | Dino Helm | `0x050A57` | **+6** | Prähistorie (Käfersteppe) |
| `0x03` | **Bronzehelm** | Bronze Helmet | `0x050A63` | **+11** | Antika (Krozkrübel) |
| `0x04` | **Blecheimer** | Obsidian Helm | `0x050A6E` | **+18** | Antika (Davids Höhle) |
| `0x05` | **Römerhelm** | Centurion Helm | `0x050A79` | **+27** | Antika (Allelachema) |
| `0x06` | **Titanenkrone** | Titan's Crown | `0x050A83` | **+39** | Gotika (Schattenwald) |
| `0x07` | **Drachenhelm** | Dragon Helm | `0x050A90` | **+54** | Gotika (Chaosturm) |
| `0x08` | **Ritterhelm** | Knight's Helm | `0x050A9C` | **+72** | Gotika (Terrorfels) |
| `0x09` | **Blitzableiter** | Lightning Helm | `0x050AA7` | **+93** | Omnitopia (Gewächshaus) |
| `0x0A` | **Lampenschirm** | Old Reliable | `0x050AB5` | **+117** | Omnitopia (Lagerhalle) |
| `0x0B` | **Elektrohelm** | Brainstorm | `0x050AC2` | **+144** | Omnitopia (Labor) |

---

## 5. Armbänder (Bracers / Gloves)

Die 12 Armschutze liegen in Bank `$05` ab Offset `0x050ACE`. Ihre Werte stammen aus der Item-Strukturtabelle ab `$C4:4232` (Stride 10 Bytes):
Der aktuell ausgerüstete Armschutz-Zeiger des Jungen liegt im WRAM an Adresse **`$7E:0AC4`** (Zeiger auf Armschutzstruktur).

| Index | Deutscher Name (ROM) | US-Originalname | ROM-Offset | Abwehr (Def) | Epoche / Bereich |
| :---: | :--- | :--- | :--- | :---: | :--- |
| `0x00` | **Gemüsearmband** | Vine Bracelet | `0x050ACE` | **+1** | Prähistorie (Start) |
| `0x01` | **Bleiarmband** | Mammoth Guard | `0x050ADC` | **+2** | Prähistorie (Mammutfriedhof) |
| `0x02` | **Klauenreif** | Claw Guard | `0x050AE8` | **+5** | Prähistorie (Vulkan) |
| `0x03` | **Schlangenarmband** | Serpent Span | `0x050AF3` | **+10** | Antika (Krozkrübel) |
| `0x04` | **Bronzeklaue** | Bronze Gauntlet | `0x050B04` | **+17** | Antika (Pyramide) |
| `0x05` | **Feuerfetisch** | Gloves of Ra | `0x050B10` | **+26** | Antika (Allelachema Markt) |
| `0x06` | **Eisenarmband** | Iron Bracer | `0x050B1D` | **+37** | Gotika (Chaosturm) |
| `0x07` | **Roys Ring** | Dragon's Claw | `0x050B2A` | **+50** | Gotika (Sumpf / Erwins Turm) |
| `0x08` | **Drachenklaue** | Cybersleeve | `0x050B34` | **+65** | Gotika (Terrorfels) |
| `0x09` | **Cyberhandschuh** | Silver Sheath | `0x050B41` | **+82** | Omnitopia (Schrottplatz) |
| `0x0A` | **Karmaring** | Shining Armlet | `0x050B50` | **+101** | Omnitopia (Shops) |
| `0x0B` | **Elektroarmband** | Laser Glove | `0x050B5A` | **+122** | Omnitopia (Reaktor) |

---

## 6. Hundehalsbänder (Dog Collars)

Die 4 Halsbänder für den Hund liegen in Bank `$05` ab Offset `0x050B69`. Ihre Werte stammen aus der Item-Strukturtabelle ab `$C4:42AA` (Stride 10 Bytes):
Das aktuell ausgerüstete Halsband des Hundes wird im Entity-Datenblock des Hundes verwaltet (WRAM `$7E:2356` wird im ROM nicht referenziert).

| Index | Deutscher Name (ROM) | US-Originalname | ROM-Offset | Abwehr (Def) | Epoche / Bereich |
| :---: | :--- | :--- | :---: | :---: | :--- |
| `0x00` | **Lederhalsband** | Leather Collar | `0x050B69` | **+5** | Prähistorie |
| `0x01` | **Nietenhalsband** | Spiky Collar | `0x050B77` | **+42** | Antika (Allelachema) |
| `0x02` | **Silberhalsband** | Defender Collar | `0x050B86` | **+86** | Gotika (Terrorfels) |
| `0x03` | **Juwelenhalsband** | Spot's Collar | `0x050B95` | **+135** | Omnitopia |

---

## 7. Verbrauchsgegenstände (Consumables)

Die Verbrauchsitems liegen in Bank `$05` ab Offset `0x0519E8`. Im WRAM werden ihre Mengen (jeweils `0` bis `99`) unmittelbar anschließend an die Alchemie-Zutaten (`$7E:22FF` bis `$7E:2314`) als fortlaufende 1-Byte-Werte ab Basisadresse **`$7E:2315`** gespeichert (adressiert über `$7E:2315 + ID` in `$8E:8CDD`, `$8E:9B97`, `$8E:A818`):

| Index | Deutscher Name (ROM) | US-Originalname | ROM-Offset | WRAM-Adresse (`$7E:2315 + ID`) | Funktion / Wirkung |
| :---: | :--- | :--- | :---: | :---: | :--- |
| `0x00` | **Blätter** | Petals | `0x0519E8` | **`$7E:2315`** | Heilt 40 KP bei Held oder Hund (Tabelle `$C5:0106`) |
| `0x01` | **Nektar** | Nectar | `0x0519F0` | **`$7E:2316`** | Heilt 120 KP (Tabelle `$C5:0108`) |
| `0x02` | **Honig** | Honey | `0x0519F7` | **`$7E:2317`** | Heilt 300 KP (Tabelle `$C5:010A`) |
| `0x03` | **Hundekuchen** | Dog Biscuit | `0x0519FD` | **`$7E:2318`** | Füllt die KP des Hundes komplett auf |
| `0x04` | **Flügel** | Wings | `0x051A09` | **`$7E:2319`** | Teleportiert sofort zum Raumeingang (Flucht) |
| `0x05` | **Elixier** | Essence | `0x051A10` | **`$7E:231A`** | Füllt alle KP von Held und Hund vollständig auf |
| `0x06` | **Elfenstaub** | Pixie Dust | `0x051A18` | **`$7E:231B`** | Entfernt Statusveränderungen (Gift, Lähmung) |
| `0x07` | **Zauberperle** | Call Bead | `0x051A23` | **`$7E:231C`** | Aktiviert mächtige Zaubersprüche der Vorfahren |

---

## 8. Tauschwaren auf dem Basar (Trade Goods)

Auf den Märkten von **Allelachema** (Nobilia) und **Terrorfels** (Gotika) tauscht der Held Waren in komplexen Tauschketten. Die Namenstabelle liegt im ROM bei **`$8C:BFE3`** (`0x0CBFE3`). Im WRAM werden die Stückzahlen der 12 Waren in der 16-Bit-Variablen-Tabelle ab `$7E:2258` als 16-Bit Little-Endian Words im Bereich **`$7E:2519` bis `$7E:252F`** verwaltet:

| Index | Tauschware (ROM) | US-Originalname | ROM-Offset | WRAM-Adresse | Offset zu `$7E:2258` | Typische Verwendung / Markt |
| :---: | :--- | :--- | :---: | :---: | :---: | :--- |
| `0x00` | **Perle** | Bead | `0x051A5F` | **`$7E:2519`** | `+0x02C1` | Universelle Handelswährung auf dem Basar |
| `0x01` | **Keramiktopf** | Ceramic Pot | `0x051A65` | **`$7E:251B`** | `+0x02C3` | Basisware; Startpunkt der Tauschketten |
| `0x02` | **Huhn** | Chicken | `0x051A71` | **`$7E:251D`** | `+0x02C5` | Federvieh für seltene Tauschgeschäfte |
| `0x03` | **Schakalfigur** | Golden Jackal | `0x051A76` | **`$7E:251F`** | `+0x02C7` | Wertvolle Reliktfigur für Großtausche & Orakelknochen |
| `0x04` | **Juwelenskarabäus** | Jeweled Scarab | `0x051A83` | **`$7E:2521`** | `+0x02C9` | Edelstein-Käfer für permanente Relikte & Orakelknochen |
| `0x05` | **Kalksteintafel** | Limestone Tablet | `0x051A94` | **`$7E:2523`** | `+0x02CB` | Schrifttafel für Amulette und Spezialgüter |
| `0x06` | **Rosenwasser** | Perfume | `0x051AA3` | **`$7E:2525`** | `+0x02CD` | Wohlriechendes Duftwasser für Marktstände |
| `0x07` | **Reis** | Rice | `0x051AAF` | **`$7E:2527`** | `+0x02CF` | Nahrungsmittel; Schlüssel für Töpferwaren |
| `0x08` | **Gewürz** | Spice | `0x051AB4` | **`$7E:2529`** | `+0x02D1` | Wichtiges Gewürz für Schakalfiguren und Seide |
| `0x09` | **Silberlöffel** | Spoon | `0x051ABB` | **`$7E:252B`** | `+0x02D3` | Besteck für Händler im oberen Marktbereich |
| `0x0A` | **Seide** | Silk | `0x051AC8` | **`$7E:252D`** | `+0x02D5` | Kostbarer Stoff für Rüstungs-Upgrades |
| `0x0B` | **Eintrittskarte** | Ticket | `0x051ACE` | **`$7E:252F`** | `+0x02D7` | Eintrittskarte für Dr. Meinholds Freakshow |

> [!NOTE]
> Nicht alle Tauschwaren und Relikte werden in Allelachema gehandelt. Der **Orakelknochen** (`FLAG[0x0054]`) und die **Teufelskutte** (`FLAG[0x0059]`) werden exklusiv auf dem Markt in **Terrorfels / Gotika** (Map `0x7B` / `0x4E`) angeboten! Für den Orakelknochen verlangt der Händler dort 1 Schakalfigur (`$7E:251F`) und 1 Juwelenskarabäus (`$7E:2521`).

---

## 9. Permanente Relikte & Charms (Markt-Artefakte)

Auf den Märkten können 14 permanente Artefakte erworben bzw. ertauscht werden, die passive Boni verleihen. Die Menüprüfung der 14 Relikte erfolgt in der ROM-Routine **`$8C:C760`** über die Tabellen **`$8C:BF91`** (WRAM-Adresse), **`$8C:BFB9`** (Bitmaske) und **`$8C:C793`** (Beschreibungs-Pointer in Bank `$C5`):

| Idx | Relikt (ROM-Name) | Event-Flag | WRAM-Adresse | Bitmaske | Name-Offset | Beschreibungs-Offset | Ingame-Beschreibung (ROM) |
| :---: | :--- | :---: | :---: | :---: | :---: | :---: | :--- |
| `0` | **Armor Ultra** | **`0x004D`** | `$7E:2261` | `0x0020` (Bit 5) | `0x051ADD` | `0x051BDC` | *Ultra Armor erhöht die Stärke Deiner Rüstung.* |
| `1` | **Chocobo Ei** | **`0x004E`** | `$7E:2261` | `0x0040` (Bit 6) | `0x051AE9` | `0x051C0A` | *Das Chocobo Ei erhöht die KP's derer, die es besitzen.* |
| `2` | **Insektengift** | **`0x004F`** | `$7E:2261` | `0x0080` (Bit 7) | `0x051AF4` | `0x051C41` | *Wehrt Moskitos und Spinnen ab.* |
| `3` | **Jadereif** | **`0x0050`** | `$7E:2262` | `0x0001` (Bit 0) | `0x051B01` | `0x051C60` | *Erhöht Deine Fähigkeit, ein bestimmtes Ziel zu treffen.* |
| `4` | **Jaguarring** | **`0x0051`** | `$7E:2262` | `0x0002` (Bit 1) | `0x051B0A` | `0x051C98` | *Trage den Ring und drücke A, um wie ein Jaguar zu rennen.* |
| `5` | **Mythenschärpe** | **`0x0052`** | `$7E:2262` | `0x0004` (Bit 2) | `0x051B15` | `0x051CD2` | *Die Kräfte dieses Gegenstandes sind unbekannt.* |
| `6` | **Moxastab** | **`0x0053`** | `$7E:2262` | `0x0008` (Bit 3) | `0x051B23` | `0x051D01` | *Deine Heilkräfte und Gegenstände werden durch den Stab effektiver.* |
| `7` | **Orakelknochen** | **`0x0054`** | `$7E:2262` | `0x0010` (Bit 4) | `0x051B2C` | `0x051D44` | *Bringt einige Leute dazu, Dir mehr zu erzählen.* |
| `8` | **Rubinherz** | **`0x0055`** | `$7E:2262` | `0x0020` (Bit 5) | `0x051B3A` | `0x051D74` | *Reduziert die Chancen der Gegner, Dir einen schweren Treffer zuzufügen.* |
| `9` | **Schleifstab** | **`0x0056`** | `$7E:2262` | `0x0040` (Bit 6) | `0x051B44` | `0x051DBC` | *Erhöht die Kräfte aller Schwertwaffen in Deinem Besitz.* |
| `10` | **Lebenszepter** | **`0x0057`** | `$7E:2262` | `0x0080` (Bit 7) | `0x051B50` | `0x051DF4` | *Erhöht Deine Fähigkeiten, Dich gegen Angriffe der Gegner zu erwehren.* |
| `11` | **Sonnenstein** | **`0x0058`** | `$7E:2263` | `0x0001` (Bit 0) | `0x051B5D` | `0x051E3A` | *Erhöht Deine körperliche Stärke.* |
| `12` | **Teufelskutte** | **`0x0059`** | `$7E:2263` | `0x0002` (Bit 1) | `0x051B69` | `0x051E5B` | *Erhöht Deine Fähigkeit, Angriffen auszuweichen.* |
| `13` | **Drachenmünze** | **`0x005A`** | `$7E:2263` | `0x0004` (Bit 2) | `0x051B76` | `0x051E8B` | *Erhöht die magischen Abwehrkräfte des Besitzers.* |

---

## 10. Schlüsselobjekte & Quest-Gegenstände

Die Schlüsselobjekte umfassen storyrelevante Items. Die Einträge 14 bis 19 der ROM-Tabellen `$8C:BF91` / `$8C:BFB9` verwalten die 6 Quest-Artefakte im WRAM bei **`$7E:2264`**:

| Idx | Gegenstand (ROM) | US-Originalname | Event-Flag | WRAM-Adresse / Maske | ROM-Offset | Quest-Bedeutung & Fundort |
| :---: | :--- | :--- | :---: | :---: | :---: | :--- |
| `14` | **Diamantenauge** | Diamond Eye | **`0x0060`** | `$7E:2264` (`0x0001`, Bit 0) | `0x051B83` | Erstes Götzendiamantenauge (Pyramiden-Boss Rimsala) |
| `15` | **Diamantenaugen** | Diamond Eyes | **`0x0061`** | `$7E:2264` (`0x0002`, Bit 1) | `0x051B91` | Beide Diamantenaugen vereint |
| `17` | **Ventil** | Gauge / Valve | **`0x0062`** | `$7E:2264` (`0x0004`, Bit 2) | `0x051BA8` | Steuerventil für die Vulkan- und Rohrsysteme |
| `19` | **Wagenrad** | Wheel | **`0x0063`** | `$7E:2264` (`0x0008`, Bit 3) | `0x051BBF` | Ersatzrad für den Planwagen in Gotika |
| `18` | **Königsschlüssel** | Queen's Key | **`0x0064`** | `$7E:2264` (`0x0010`, Bit 4) | `0x051BAF` | Öffnet die Gemächer im Schloss von Terrorfels |
| `16` | **Energie** | Energy Core | **`0x0065`** | `$7E:2264` (`0x0020`, Bit 5) | `0x051BA0` | Reaktor-Energiekern für die Raumstation Assitopia |
| — | **Amulett des Karon** | Amulet of Karon | `0x019D` | `$7E:228B` (`0x0020`, Bit 5) | `0x051A4D` | Überfahrt über den Ozean / Skelettschiff |
| — | **Schappschapp** | Thud | — | — | `0x051A40` | Hundefutter / Lockmittel für den Hund |
| — | **Mülleimer** | Trash Can | — | — | `0x051A36` | Rüstungs- und Alchemie-Behälter in Assitopia |
| — | **Beutel** | Magic Bag | — | — | `0x051A2F` | Erweitert die Tragekapazität von Items |

---

## 11. Währungen (Currencies)

In *Secret of Evermore* besitzt jede der vier Zeitzonen ihre eigene Währung:

| Epoche | Währung (DE-ROM) | US-Originalname | WRAM-Adresse (24-Bit Little-Endian) | Max-Betrag |
| :--- | :--- | :--- | :---: | :---: |
| **Prähistorie** | **Krallen** | Talons | `$7E0AC6` – `$7E0AC8` | 16.777.215 |
| **Antika** | **Juwelen** | Jewels | `$7E0AC9` – `$7E0ACB` | 16.777.215 |
| **Gotika** | **Goldmünzen** | Gold Coins | `$7E0ACC` – `$7E0ACE` | 16.777.215 |
| **Assitopia** | **Kreditkarten** | Credits | `$7E0ACF` – `$7E0AD1` | 16.777.215 |

- Beim Geldwechsler auf dem Markt von Allelachema können Krallen und Goldmünzen in Juwelen umgetauscht werden.
