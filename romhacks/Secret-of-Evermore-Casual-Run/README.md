# Secret of Evermore: Casual Run (Deutsche PAL Version) – Version 2.1

Eine native Portierung des beliebten ROM-Hacks **Secret of Evermore: Casual Run** (aktuelle **Version 2.1** von Andrew Clunn), speziell entwickelt und kalibriert für die offizielle **deutsche PAL-ROM** (`Secret of Evermore (Germany).sfc`).

---

## 1. Über diesen ROM-Hack

*Casual Run* macht *Secret of Evermore* dynamischer, zugänglicher und beseitigt frustrierende Engpässe des Originals durch modernisierte Steuerung, geteilte Erfahrungspunkte, stark reduziertes Grinding und umfassendes Rebalancing. Die originale Story, die Welt, Rätsel und die SNES-Präsentation bleiben vollständig unangetastet.

> [!IMPORTANT]
> **Grundlage:**  
> Dieser ROM-Hack basiert auf der aktuellen **Version 2.1** des ursprünglichen Hacks von **Andrew Clunn** ([GitHub-Repository](https://github.com/andrewclunn/Secret-of-Evermore-Casual-Run)).  
> Sämtliche 65816-Hooks und Datentabellen wurden nativ für die **deutsche PAL-ROM** mit der Übersetzung von **Claude M. Moyse** reimplementiert.

> [!TIP]
> **Download des fertigen Patches:**  
> Der spielfertige IPS-Patch kann direkt über den [GitHub Release v2.1](https://github.com/megalomon/DE-SoE-Tools/releases/tag/casual-run-v2.1-de) heruntergeladen werden.

---

## 2. Gameplay-Features & Änderungen (Version 2.1)

### Modernisierte Steuerung & Bewegung
- **Standardmäßiger Dauerlauf (Default Dash):**  
  Der Junge läuft automatisch, sobald das Steuerkreuz betätigt wird (kein mühsames Halten der B-Taste mehr nötig).
- **B-Taste zum Gehen & schnellen Aufladen:**  
  Das Halten der B-Taste schaltet auf normales Gehen um (präzises Manövrieren bei schmalen Wegen und Fallen) und lädt den Waffenangriffsbalken deutlich schneller auf.
- **A- & B-Tastenbelegung:**  
  **A** greift an, interagiert und bestätigt Menüpunkte. **B** bricht verlässlich in allen Menüs ab.

### Geteilte Waffen-Erfahrung (Shared Weapon Experience)
- Alle Waffen derselben Gattung teilen sich den Erfahrungszuwachs simultan:
  - **Schwerter:** Knochenknüppel, Drachentöter, Exkalibur, Laserschwert
  - **Äxte:** Tarantelaxt, Bronzeaxt, Streitaxt, Atomaxt
  - **Speere:** Speer, Bronzespeer, Lanze, Tri-Spitze
- Erhält eine geführte Waffe im Kampf Erfahrung, leveln alle vier Waffen derselben Familie sofort mit. Veraltete Waffen müssen nach einem Upgrade nicht mehr mühsam nachgelevelt werden!

### 50 % weniger Grinding (Halbierte EXP-Kurve)
- **Halbierte Level-99 EXP-Kurve:**  
  Die erforderlichen Erfahrungspunkte für alle Level von 1 bis 99 wurden für den Jungen und den Hund um 50 % reduziert.
- **Flüssiger Spielfluss:**  
  Bosse und neue Areale können ohne Zwangspausen zum Level-Grinding gemeistert werden.

### Gegner- & Boss-Rebalancing (89 Datensätze)
- **Doppelte Währungsbelohnung:**  
  Besiegte reguläre Gegner lassen das Doppelte an Gold (Talente / Dukaten / Juwelen) fallen.
- **Angepasste Boss-Kraftpunkte (HP):**  
  Extrem zähe Bosse mit überzogenen Lebenspunkte-Polstern wurden moderat abgeschwächt für dynamischere, spannendere Kämpfe.
- **Verbesserte Beute- & Zutatendropraten:**  
  Zutaten- und Beutefunde treten häufiger und verlässlicher auf.

### Waffen-, Item- & Heilmittel-Balancing
- **Effektivere Heilmittel:**  
  - Blütenblätter heilen **80 KP** (vorher 40 KP).
  - Nektar heilt **200 KP** (vorher 100 KP).
  - Das Tragelimit für Schlammpfeffer wurde auf **99** erhöht.
- **Verstärkte Basiswaffen:**  
  Frühe Nahkampfwaffen wurden moderat gestärkt (z. B. Knochenknüppel ATK 10 $\rightarrow$ 13).

### Karten- & Dungeon-Reparaturen
- **Pyramiden-Kacheln:**  
  Symbol- und Rückweg-Fixes in der Pyramide von Antiqua verhindern Hänger und Dead-Ends.
- **Hundelabyrinth:**  
  Verbindungskacheln im Hundelabyrinth repariert.

---

## 3. Technische Adress-Matrix (Deutsche PAL-ROM)

Die deutsche PAL-ROM (`Secret of Evermore (Germany).sfc`) unterscheidet sich in ihrem Bank- und Skript-Layout fundamental von der US-Version. Alle Patches wurden forensisch auf die deutschen 65816-Offsets kalibriert:

| System / Bereich | US-Offset (v2.1) | Deutscher PAL-Offset | Technische Umsetzung |
| :--- | :--- | :--- | :--- |
| **Waffen-Tabelle (Bank $C4)** | `$C4:38E6` | **`$C4:3F26`** (`+0x0640`) | 15 Waffen-Einträge (Stride 36 Bytes) |
| **Heilmittel (Blüten/Nektar)** | `$C4:3B8E` | **`$C4:41CE`** (`+0x0640`) | KP-Heilwerte und Tragegrenzen |
| **EXP-Kurve Level 1–99** | `$CC:8BD3` | **`$CC:8F65`** (`+0x0392`) | 594 Bytes (Junge + Hund EXP-Tabelle) |
| **Status-Wachstumstabellen** | `$CC:9285` | **`$CC:9617`** (`+0x0392`) | BoyDefense, MagicDefense, Hundestats |
| **Gegner- & Boss-Datensätze** | `$CE:B678` | **`$8E:B678`** (`0x0EB678`) | 89 Datensätze (1:1 Dateioffset-Match) |
| **Waffen-XP Routine** | `$8F:9717` / `$8F:973E` | **`$8F:9714`** / **`$8F:973B`** | JML-Hook nach `$F0:0010` |
| **Bewegung & Auto-Run** | `$90:82AA` | **`$90:82B2`** (`0x1082B2`) | Invertierter B-Check (`D0 07` $\rightarrow$ `F0 07`) |
| **Erweiterter Code / Maps** | Bank `$F0` / `$FF` | **Bank `$F0` / `$FF`** | 4 MiB HiROM-Expansion (`0x300000`-`0x3FFFFF`) |

---

## 4. Bauen & Patchen

### Option A: Fertigen IPS-Patch anwenden (Empfohlen)
1. Lade `Secret_of_Evermore_Casual_Run_German.ips` aus dem [GitHub Release v2.1](https://github.com/megalomon/DE-SoE-Tools/releases/tag/casual-run-v2.1-de) herunter.
2. Wende den Patch mit einem IPS-Patcher (z. B. [FLIPS](https://www.romhacking.net/utilities/1040/), Lunar IPS oder [RomPatcher.js](https://www.marcrobledo.com/RomPatcher.js/)) auf deine deutsche Basis-ROM an.

### Option B: Aus dem Quellcode selbst bauen
Mit dem beiliegenden Python-Build-Skript:
```bash
python3 romhacks/Secret-of-Evermore-Casual-Run/build_german.py
```

Das Skript validiert die deutsche Basis-ROM, erweitert sie sauber auf 4 MiB, assembliert alle Patches und erzeugt die fertige `.sfc`-ROM sowie die `.ips`-Datei.

#### Prüfsummen

- **Deutsche Basis-ROM:** `Secret of Evermore (Germany).sfc` (unheadered)
  - Dateigröße: `3.145.728` Bytes (3 MiB)
  - SHA-256: `c341668847170d36fa5cfb720568b0b1ecbb24fc426a821f665f1d3853a46a6d`
  - SHA-1: `5e5c2082526690d05f962c3ffbd7e080c681bfa4`
- **Gepatchte ROM:** `Secret of Evermore Casual Run (Germany).sfc`
  - Dateigröße: `4.194.304` Bytes (4 MiB HiROM)
  - SHA-256: `703c241aa327a637691bb1e4c49bca6ae01e4b0083909ebb6be1eeeb5840bdef`
  - SNES-Prüfsumme: `0x02AF`

---

## 5. Dateistruktur

```
romhacks/Secret-of-Evermore-Casual-Run/
├── README.md                                  <- Diese Dokumentation (Version 2.1)
├── Secret_of_Evermore_Casual_Run_German.asm   <- ASM-Quellcode für die deutsche ROM
├── build_german.py                            <- Python Build-Pipeline für deutsche ROM
├── Secret_of_Evermore_Casual_Run_v2.1.asm     <- Originaler US-Source v2.1 von Andrew Clunn
└── build.py                                   <- Upstream US Build-Skript
```

---

## 6. Credits & Danksagung

- **Andrew Clunn:** Für die Entwicklung des fantastischen Original-ROM-Hacks *Casual Run* (v2.1) und die Erlaubnis zur Portierung.
- **Claude M. Moyse:** Für die deutsche Original-Lokalisierung.
