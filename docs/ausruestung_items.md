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

## 2. Rüstungen (Body Armor)

In der deutschen ROM werden alle 12 Körperrüstungen in Bank `$05` ab Offset `0x0509AE` definiert. Ihre Werte stammen direkt aus der Item-Strukturtabelle bei `$C4:4142`:
Der aktuell ausgerüstete Index des Jungen liegt im WRAM an Adresse **`$7E0A52`**.

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

## 3. Helme (Helmets)

Die 12 Kopfbedeckungen liegen in Bank `$05` ab Offset `0x050A40`. Ihre Werte stammen aus der Item-Strukturtabelle ab `$C4:41BA`:
Der aktuell ausgerüstete Helm des Jungen liegt im WRAM an Adresse **`$7E0A54`**.

| Index | Deutscher Name (ROM) | US-Originalname | ROM-Offset | Abwehr (Def) | Epoche / Bereich |
| :---: | :--- | :--- | :---: | :---: | :--- |
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

## 4. Armbänder (Bracers / Gloves)

Die 12 Armschutze liegen in Bank `$05` ab Offset `0x050ACE`. Ihre Werte stammen aus der Item-Strukturtabelle ab `$C4:4232`:
Der aktuell ausgerüstete Armschutz des Jungen liegt im WRAM an Adresse **`$7E0A56`**.

| Index | Deutscher Name (ROM) | US-Originalname | ROM-Offset | Abwehr (Def) | Epoche / Bereich |
| :---: | :--- | :--- | :---: | :---: | :--- |
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

## 5. Hundehalsbänder (Dog Collars)

Die 4 Halsbänder für den Hund liegen in Bank `$05` ab Offset `0x050B69`. Ihre Werte stammen aus der Item-Strukturtabelle ab `$C4:42AA`:
Das aktuell ausgerüstete Halsband des Hundes liegt im WRAM an Adresse **`$7E0A9C`**.

| Index | Deutscher Name (ROM) | US-Originalname | ROM-Offset | Abwehr (Def) | Epoche / Bereich |
| :---: | :--- | :--- | :---: | :---: | :--- |
| `0x00` | **Lederhalsband** | Leather Collar | `0x050B69` | **+5** | Prähistorie |
| `0x01` | **Nietenhalsband** | Spiky Collar | `0x050B77` | **+42** | Antika (Allelachema) |
| `0x02` | **Silberhalsband** | Defender Collar | `0x050B86` | **+86** | Gotika (Terrorfels) |
| `0x03` | **Juwelenhalsband** | Spot's Collar | `0x050B95` | **+135** | Omnitopia |

---

## 6. Verbrauchsgegenstände (Consumables)

Die Verbrauchsitems liegen in Bank `$05` ab Offset `0x0519E8`. Im WRAM werden ihre Mengen (jeweils `0` bis `99`) in einem 2-Byte-Abstand gespeichert:

| Deutscher Name (ROM) | US-Originalname | ROM-Offset | WRAM-Adresse | Funktion / Wirkung |
| :--- | :--- | :---: | :---: | :--- |
| **Blätter** | Petals | `0x0519E8` | `$7E2364` | Heilt 40 KP bei Held oder Hund |
| **Nektar** | Nectar | `0x0519F0` | `$7E2366` | Heilt 120 KP |
| **Honig** | Honey | `0x0519F7` | `$7E2368` | Heilt 300 KP |
| **Hundekuchen** | Dog Biscuit | `0x0519FD` | `$7E236A` | Füllt die KP des Hundes komplett auf |
| **Flügel** | Wings | `0x051A09` | `$7E236C` | Teleportiert sofort zum Raumeingang (Flucht) |
| **Elixier** | Essence | `0x051A10` | `$7E236E` | Füllt alle KP von Held und Hund vollständig auf |
| **Elfenstaub** | Pixie Dust | `0x051A18` | — | Entfernt Statusveränderungen (Gift, Lähmung) |
| **Zauberperle** | Call Bead | `0x051A23` | — | Aktiviert mächtige Zaubersprüche der Vorfahren |

---

## 7. Tauschwaren auf dem Basar von Allelachema (Trade Goods)

Auf dem großen Markt von **Allelachema** (Nobilia) tauscht der Held Güter in komplexen Tauschketten. Im WRAM werden die Stückzahlen der Waren in der 16-Bit-Variablen-Tabelle ab `$7E2258` verwaltet:

| Tauschware (ROM) | US-Originalname | ROM-Offset | WRAM-Adresse | Basar-Verwendung |
| :--- | :--- | :---: | :---: | :--- |
| **Keramiktopf** | Ceramic Pot | `0x051A65` | `$7E251B` | Basisware; Startpunkt der Tauschketten |
| **Perle** | Bead | `0x051A5F` | `$7E251D` | Universelle Handelswährung auf dem Basar |
| **Gewürz** | Spice | `0x051AB4` | `$7E251F` | Wichtiges Gewürz für Schakalfiguren und Seide |
| **Schakalfigur** | Golden Jackal | `0x051A76` | `$7E2521` | Wertvolle Reliktfigur für Großtausche |
| **Juwelenskarabäus** | Jeweled Scarab | `0x051A83` | `$7E2523` | Edelstein-Käfer für permanente Relikte |
| **Kalksteintafel** | Limestone Tablet | `0x051A94` | `$7E2525` | Schrifttafel für Amulette und Spezialgüter |
| **Huhn** | Chicken | `0x051A71` | `$7E2527` | Federvieh für seltene Tauschgeschäfte |
| **Reis** | Rice | `0x051AAF` | `$7E2529` | Nahrungsmittel; Schlüssel für Töpferwaren |
| **Rosenwasser** | Perfume | `0x051AA3` | `$7E252B` | Wohlriechendes Duftwasser für Marktstände |
| **Silberlöffel** | Spoon | `0x051ABB` | `$7E252D` | Besteck für Händler im oberen Marktbereich |
| **Seide** | Silk | `0x051AC8` | `$7E252F` | Kostbarer Stoff für Rüstungs-Upgrades |
| **Eintrittskarte** | Ticket | `0x051ACE` | `$7E2531` | Eintrittskarte für die Allelachema-Arena |

---

## 8. Permanente Relikte & Charms (Markt-Artefakte)

Auf dem Basar von Allelachema können 14 permanente Artefakte ertauscht werden, die dem Helden passive Statusboni verleihen. Ihr Besitz wird im **Event-Flag Bitfield** ab `$7E2258` gespeichert:

| Relikt (ROM-Name) | Event-Flag | ROM-Offset | Ingame-Beschreibung (ROM) |
| :--- | :---: | :---: | :--- |
| **Armor Ultra** | `0x0056` | `0x051ADD` | *Ultra Armor erhöht die Stärke Deiner Rüstung.* |
| **Chocobo Ei** | `0x004E` | `0x051AE9` | *Das Chocobo Ei erhöht die KP's derer, die es besitzen.* |
| **Insektengift** | `0x0058` | `0x051AF4` | *Wehrt Moskitos und Spinnen ab.* |
| **Jadereif** | `0x005B` | `0x051B01` | *Erhöht Deine Fähigkeit, ein bestimmtes Ziel zu treffen.* |
| **Jaguarring** | `0x004F` | `0x051B0A` | *Trage den Ring und drücke A, um wie ein Jaguar zu rennen.* |
| **Mythenschärpe** | `0x0052` | `0x051B15` | *Die Kräfte dieses Gegenstandes sind unbekannt.* |
| **Moxastab** | `0x005F` | `0x051B23` | *Deine Heilkräfte und Gegenstände werden durch den Stab effektiver.* |
| **Orakelknochen** | `0x0051` | `0x051B2C` | *Bringt einige Leute dazu, Dir mehr zu erzählen.* |
| **Rubinherz** | `0x005D` | `0x051B3A` | *Reduziert die Chancen der Gegner, Dir einen schweren Treffer zuzufügen.* |
| **Schleifstab** | `0x005E` | `0x051B44` | *Erhöht die Kräfte aller Schwertwaffen in Deinem Besitz.* |
| **Lebenszepter** | `0x0050` | `0x051B50` | *Erhöht Deine Fähigkeiten, Dich gegen Angriffe der Gegner zu erwehren.* |
| **Sonnenstein** | `0x005C` | `0x051B5D` | *Erhöht Deine körperliche Stärke.* |
| **Teufelskutte** | `0x0054` | `0x051B69` | *Erhöht Deine Fähigkeit, Angriffen auszuweichen.* |
| **Drachenmünze** | `0x0059` | `0x051B76` | *Erhöht die magischen Abwehrkräfte des Besitzers.* |

---

## 9. Schlüsselobjekte & Quest-Gegenstände

| Gegenstand (ROM) | US-Originalname | ROM-Offset | Quest-Bedeutung & Fundort |
| :--- | :--- | :---: | :--- |
| **Amulett des Karon** | Amulet of Karon | `0x051A4D` | Überfahrt über den Ozean / Skelettschiff (Flag `0x019D`) |
| **Schappschapp** | Thud | `0x051A40` | Hundefutter / Lockmittel für den Hund |
| **Mülleimer** | Trash Can | `0x051A36` | Rüstungs- und Alchemie-Behälter in Assitopia |
| **Beutel** | Magic Bag | `0x051A2F` | Erweitert die Tragekapazität von Items |
| **Diamantenauge** | Diamond Eye | `0x051B83` | Erstes Götzendiamantenauge (Pyramiden-Boss) |
| **Diamantenaugen** | Diamond Eyes | `0x051B91` | Beide Diamantenaugen vereint |
| **Energie** | Energy Core | `0x051BA0` | Reaktor-Energiekern für die Raumstation Assitopia |
| **Ventil** | Gauge / Valve | `0x051BA8` | Steuerventil für die Vulkan- und Rohrsysteme |
| **Königsschlüssel** | Queen's Key | `0x051BAF` | Öffnet die Gemächer im Schloss von Terrorfels |
| **Wagenrad** | Wheel | `0x051BBF` | Ersatzrad für den Planwagen in Gotika |

---

## 10. Währungen (Currencies)

In *Secret of Evermore* besitzt jede der vier Zeitzonen ihre eigene Währung:

| Epoche | Währung (DE-ROM) | US-Originalname | WRAM-Adresse (24-Bit Little-Endian) | Max-Betrag |
| :--- | :--- | :--- | :---: | :---: |
| **Prähistorie** | **Krallen** | Talons | `$7E0AC6` – `$7E0AC8` | 16.777.215 |
| **Antika** | **Juwelen** | Jewels | `$7E0AC9` – `$7E0ACB` | 16.777.215 |
| **Gotika** | **Goldmünzen** | Gold Coins | `$7E0ACC` – `$7E0ACE` | 16.777.215 |
| **Assitopia** | **Kreditkarten** | Credits | `$7E0ACF` – `$7E0AD1` | 16.777.215 |

- Beim Geldwechsler auf dem Markt von Allelachema können Krallen und Goldmünzen in Juwelen umgetauscht werden.
