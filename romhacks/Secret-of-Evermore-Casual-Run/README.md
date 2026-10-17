# Secret of Evermore: Casual Run (Deutsche PAL Version) – Version 2.1

Vollständige native Reimplementierung des ROM-Hacks **Secret of Evermore: Casual Run** (Version 2.1 von Andrew Clunn) für die offizielle **deutsche PAL-ROM** (`Secret of Evermore (Germany).sfc`).

Sämtliche 16 Module wurden direkt auf das Adress- und Skript-Layout der deutschen PAL-Fassung portiert, assembliert und bitgenau verifiziert.

---

## 1. Übersicht

*Casual Run* beseitigt Frust- und Grinding-Engpässe des Originals durch modernisierte Steuerung, geteilte Waffen- und Alchemie-Erfahrungspunkte, überarbeitetes Pacing sowie Fehlerbehebungen in Karten und Skripten. Storyline, Skripte, Rätsel und Dialoge der deutschen Fassung bleiben vollständig erhalten.

---

## 2. Die 16 Gameplay- & System-Module

### Modul 1: Waffen-Balancing & Anfangswaffen
- Anpassung der 13 Basiswaffen in Bank `$C4` (`$C4:3F26`).
- Frühe Waffen wurden moderat verstärkt (z. B. Knochenknüppel Angriffskraft 10 $\rightarrow$ 13).
- Betrifft alle Waffenklassen:
  - **Schwerter:** Knochenknüppel, Drachentöter, Exkalibur, Laserschwert
  - **Äxte:** Tarantelaxt, Bronzeaxt, Streitaxt, Atomaxt
  - **Speere:** Speer, Bronzespeer, Elfenbeinspeer, Neutronenspeer

### Modul 2: Gegner- & Boss-Rebalancing (89 Datensätze)
- Tabelle ab `$CE:C545` in Bank `$CE`:
  - Verdopplung der Belohnungswährung bei allen regulären Gegnern: Krallen (Prähistorie), Juwelen (Antika), Goldmünzen (Gotika) und Kreditkarten (Assitopia).
  - Kraftpunkte-Anpassung (HP) übermäßig zäher Bosse für flüssigere Kämpfe.

### Modul 3: Rüstungs-Balancing (Helme & Armbänder)
- 10 Helme (`$C4:41CE`) und 10 Armbänder (`$C4:4246`) mit moderat angepassten Abwehrwerten.
- Deutsche Textzeiger in Bank `$C5` sowie Menübeschriftungen ("Kleidung") bleiben unberührt.

### Modul 4: Halbierte Level-99 Erfahrungskurve & Statuswachstum
- EXP-Bedarf für Junge und Hund auf den Stufen 1–99 um 50 % gesenkt (`$CC:8F65`, 594 Bytes).
- Statuswachstumskurven für Junge (Verteidigung, Magieabwehr) und Hund ab `$CC:9617`.

### Modul 5: Geteilte Waffen-Erfahrung (Shared Weapon Experience)
- Hooks an `$CF:B6C8` und `$CF:B729` rufen Erweiterungsroutine an `$F0:0E00` auf.
- Erhält eine Waffe im Kampf Erfahrung, wird die native deutsche Routine `$8F:9714` für alle vier Waffen der gleichen Kategorie ausgeführt.

### Modul 6: Standardmäßiger Dauerlauf (Default Dash)
- Invertierung der Sprint-Abfrage in Bank `$D0` (`$D0:82B0` / `$D0:82B8`):
  - Normales Bewegen: Dauerlauf ohne Halten einer Taste.
  - Halten von **B**: Normales Gehen für präzise Steuerung an Engstellen.

### Modul 7: Karten- & Dungeon-Reparaturen
- Pyramide Map 86 (`$E0:FF3D` $\rightarrow$ `$F0:1000`): Kacheln und Rückwege korrigiert.
- Hundelabyrinth Map 115 (`$E0:FFB1` $\rightarrow$ `$FF:3000`): Verbindungskacheln repariert.
- Marktplatz Allelachema Map 10 (`$E0:FE0D` $\rightarrow$ `$FC:0000`): Überarbeitetes Raum-Layout.

### Modul 8: Heilmittel & Inventar-Kapazität
- Blätter heilen 80 KP (`$C5:0106`).
- Nektar heilt 200 KP (`$C5:0108`).
- Maximale Tragekapazität für Verbrauchsgegenstände auf 9 Einheiten vereinheitlicht (`$CF:B899`, `$CF:DC18`).

### Modul 9: Zauberformeln-Rebalancing & Wirkungsdauer
- Schaden angepasst: Höllenfaust (`$C5:04DB` = `0x3D`), Supersog (`$C5:04E1` = `0x20`), Energiesog (`$C5:04E3` = `0x20`).
- Schadens- und Heilungs-Äquivalenz für Absaugzauber implementiert (`$D1:9D0C` $\rightarrow$ `$F5:1100`, Skalierungstabelle an `$C5:020B`).
- Wirkungsdauer: Atlas 60 Sekunden (`$D1:AF37`), Kraftfeld 30 Sekunden (`$D1:AF8A`).

### Modul 10: Markt-, Quest- & Softlock-Fixes
- Marktplatz Allelachema als nativer Raum an `$FC:0000` (20.299 Bytes).
- Amulett des Karon beim Händler auf 500 Juwelen gesetzt (`$D6:C529`, `$D6:C547`).
- Atlas-Händler unbegrenzt nachfüllbar (`$D6:ECEF`, `$D6:ECFE`).
- Treibsand-Skelettschnecke entfernt (`$D3:AD75`).
- Kaskadengrotte: Speer-Bedingungszweig korrigiert (`$D7:940A`).
- Verlies: Softlock am Fallgitter behoben (`$D5:9E15`).
- Pyramide: Wiederherstellung des Hundes nach Bosskampf gesichert (`$D5:94A3` $\rightarrow$ `$F7:F150`).

### Modul 11: Hund-Schnüffel-Erfahrung & Angriffslevel
- Hook an `$CC:D6BD` verweist auf `$F6:0500`.
- Beim Ausgraben von Zutaten erhält der Hund Alchemie-Erfahrung (`$8F:84E5`) und Angriffslevel-Zuwachs (`$8F:97C8`).

### Modul 12: Beute & Zutatendrops (Remains & Drops)
- Dropraten-Hook an `$D0:856C` (`$F5:1000`).
- Beute-Hook an `$D0:8580` (`$F1:6000`), Zuweisungstabellen ab `$F1:6100` und Ausgabedialoge ab `$F1:6800` / `$F1:9000`.

### Modul 13: Windbeutel-Minikarte standardmäßig aktiv
- Hook an `$C0:C9CC` leitet auf `$F7:EF40` um.
- Beim Einsteigen in den Windbeutel wird die Minikarte (`$0B1D = 1`) automatisch aktiviert.

### Modul 14: Geteilte Alchemie-Erfahrung (Shared Alchemy Experience)
- Hooks an `$D1:CC74` und `$D1:CCA4` verweisen auf `$F6:0000`.
- Alchemie-Zauber sind in Formelgruppen gegliedert (`$F6:0100`); bei erfolgreicher Anwendung leveln alle Zauber derselben Gruppe mit.
- Schnellere Levelkurve auf Stufen 1–6 über `$C5:0202`.

### Modul 15: Schadensberechnung bei aufgeladenem Angriff
- Hook an `$CF:BFE0` verweist auf `$F6:0260`.
- Saubere arithmetische Skalierung des Angriffsschadens bei Stufe-2- und Stufe-3-Angriffen.

### Modul 16: Ringmenü-Shortcuts, B-Cancel, 2-Spieler-Koop & Sound-Fixes
- **Ringmenü & Steuerung:**
  - L/R-Schultertasten-Shortcuts im Ringmenü.
  - B-Taste zum verlässlichen Abbrechen im Ringmenü und im Speichermenü (`$CD:CB36`).
  - Schnelleres Aufladen des Angriffsbalkens beim Halten von **B**.
- **2-Spieler-Koop:** Volle Controller-2-Unterstützung für den Hund (Hooks in Bank `$C0`, `$CD`, `$CE`).
- **Soundeffekte:** Eliminierung störender Menügeräusche und Klick-Loops (u. a. an `$CC:AEB9`, Bank `$CF`, `$D0:88E9`, `$D0:8917`).

---

## 3. Technische Adress-Matrix (Deutsche PAL-ROM)

| System / Bereich | US-Offset (v2.1) | Deutscher PAL-Offset | Technische Umsetzung |
| :--- | :--- | :--- | :--- |
| **Waffen-Tabelle (Bank $C4)** | `$C4:38E6` | **`$C4:3F26`** (`0x043F26`) | 13 Waffen-Einträge (Stride 36 Bytes) |
| **Helme & Armbänder (Bank $C4)** | `$C4:3B8E` / `$C4:3C06` | **`$C4:41CE`** & **`$C4:4246`** | 20 isolierte 4-Byte-Patches (Abwehrwerte), deutsche Textzeiger intakt |
| **Alchemie-Levelkurve (Bank $C5)** | `$C4:5B9D` | **`$C5:0203`** (`0x050203`) | Modifizierte Zuwachswerte für Stufen 1–6 |
| **Heilmittel & KP-Werte (Bank $C5)** | `$C4:5A9E` / `$C4:5AA0` | **`$C5:0106`** & **`$C5:0108`** | Blätter (80 KP) und Nektar (200 KP) |
| **Zauberwerte (Bank $C5)** | `$C4:5E84` | **`$C5:04DB`**, **`$C5:04E1`**, **`$C5:04E3`** | Höllenfaust, Supersog, Energiesog |
| **EXP-Kurve Level 1–99 (Bank $CC)** | `$CC:8BD3` | **`$CC:8F65`** (`0x0C8F65`) | 594 Bytes (Junge + Hund EXP-Tabelle, halbiert) |
| **Status-Wachstumstabellen (Bank $CC)** | `$CC:9285` | **`$CC:9617`** (`0x0C9617`) | BoyDefense, MagicDefense, Hundestats |
| **Hund-Schnüffel Hook (Bank $CC)** | `$CC:D269` | **`$CC:D6BD`** (`0x0CD6BD`) | Hook nach `$F6:0500`, ruft `$8F:84E5` & `$8F:97C8` auf |
| **Gegner- & Boss-Datensätze (Bank $CE)** | `$CE:C545` | **`$CE:C545`** (`0x0EC545`) | 89 Datensätze (HP & 2x Kill-Währung) |
| **Waffen-XP Routine (Bank $CF)** | `$CF:B717` | **`$CF:B6C8`** & **`$CF:B729`** | Call-Site-Hooks nach `$F0:0E00`; Helper ruft native Routine `$8F:9714` auf |
| **Tragekapazität (Bank $CF)** | `$CF:B899` | **`$CF:B899`** & **`$CF:DC18`** | Limit auf 9 Einheiten |
| **Aufgeladener Angriff (Bank $CF)** | `$CF:BFDB` | **`$CF:BFE0`** (`0x0FBFE0`) | Hook nach `$F6:0260` (ChargeDamageArithmetic) |
| **Bewegung & Auto-Run (Bank $D0)** | `$90:82AA` | **`$D0:82B0`** & **`$D0:82B8`** | Jaguar-Ring-Bypass (`EA EA`) & Default-Dash-Invertierung (`F0 07`) |
| **Beute- & Dropchancen (Bank $D0)** | `$D0:8567` / `$D0:857B` | **`$D0:856C`** & **`$D0:8580`** | Hooks nach `$F5:1000` & `$F1:6000` |
| **Atlas & Kraftfeld Dauer (Bank $D1)** | `$D1:AF30` / `$D1:AF83` | **`$D1:AF37`** & **`$D1:AF8A`** | Atlas 60s (`10 0E`), Kraftfeld 30s (`08 07`) |
| **Drain-Heilungs-Äquivalenz (Bank $D1)**| `$D1:9D04` | **`$D1:9D0C`** (`0x119D0C`) | Hook nach `$F5:1100` |
| **Geteilte Alchemie (Bank $D1)** | `$D1:CC6B` / `$D1:CC9B` | **`$D1:CC74`** & **`$D1:CCA4`** | Hooks nach `$F6:0000` |
| **Minikarte Flug (Bank $C0)** | `$C0:C9C2` | **`$C0:C9CC`** (`0x00C9CC`) | Hook nach `$F7:EF40` (Default-Minimap ON) |
| **Karten-Zeigertabelle (Bank $E0)** | `$E0:FDE5` | **`$E0:FE0D`**, **`$E0:FF3D`**, **`$E0:FFB1`** | Map 10 (Allelachema), Map 86 (Pyramide), Map 115 (Hundelabyrinth) |
| **Erweiterter Code & Daten (Bank $F0-$FF)**| Bank `$F0`–`$FF` | **Bank `$F0`–`$FF`** | 4 MiB HiROM-Expansion (`0x300000`–`0x3FFFFF`) |

---

## 4. Bauen & Prüfsummen

### Bauen aus dem Quellcode
```bash
python3 romhacks/Secret-of-Evermore-Casual-Run/build_german.py
```

Das Skript validiert die deutsche Basis-ROM, erweitert sie auf 4 MiB HiROM, wendet alle 546 Patch-Sektionen an, korrigiert die SNES-Headerprüfsumme und erzeugt die `.sfc`- sowie `.ips`-Dateien.

### Prüfsummen

- **Deutsche Basis-ROM:** `Secret of Evermore (Germany).sfc` (ohne Header)
  - Dateigröße: `3.145.728` Bytes (3 MiB)
  - SHA-256: `c341668847170d36fa5cfb720568b0b1ecbb24fc426a821f665f1d3853a46a6d`
  - SHA-1: `5e5c2082526690d05f962c3ffbd7e080c681bfa4`
- **Gepatchte ROM:** `Secret_of_Evermore_Casual_Run_German.sfc`
  - Dateigröße: `4.194.304` Bytes (4 MiB HiROM)
  - SHA-256: `8e49b070865171c56e3e57c257d8b5b06b26888896b4b837e63e83844ab63709`
  - SNES-Prüfsumme: `0x6EF3`
- **IPS-Patch:** `Secret_of_Evermore_Casual_Run_German.ips`
  - Dateigröße: `197.591` Bytes (142.373 Bytes modifiziert / erweitert)
  - SHA-256: `db0327cd073babbfa1b1ad42d5855ad70a377e29aedc5a6537acb72d5d404f1f`

---

## 5. Dateistruktur

```
romhacks/Secret-of-Evermore-Casual-Run/
├── README.md                                  <- Dokumentation aller 16 Module
├── Secret_of_Evermore_Casual_Run_German.asm   <- Vollständiger ASM-Quellcode (deutsche ROM)
├── Secret_of_Evermore_Casual_Run_German.ips   <- Fertiger IPS-Patch
├── Secret_of_Evermore_Casual_Run_German.sfc   <- Gebaute deutsche 4 MiB ROM
├── build_german.py                            <- Build-Pipeline für deutsche ROM
├── generate_full_german_asm.py                <- Generator für native deutsche ASM
├── Secret_of_Evermore_Casual_Run_v2.1.asm     <- Original US-Referenz v2.1 (Andrew Clunn)
└── build.py                                   <- Upstream US Build-Skript
```

---

## 6. Credits

- **Andrew Clunn:** Entwickler des Original-ROM-Hacks *Secret of Evermore: Casual Run* (Version 2.1).
