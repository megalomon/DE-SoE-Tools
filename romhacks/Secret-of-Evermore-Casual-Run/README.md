# Secret of Evermore: Casual Run (Deutsche PAL Version) – Version 2.1

Eine native Portierung des beliebten ROM-Hacks **Secret of Evermore: Casual Run** (aktuelle **Version 2.1** von Andrew Clunn), speziell entwickelt und kalibriert für die offizielle **deutsche PAL-ROM** (`Secret of Evermore (Germany).sfc`).

---

## 1. Über diesen ROM-Hack

*Casual Run* macht *Secret of Evermore* dynamischer, zugänglicher und beseitigt frustrierende Engpässe des Originals durch modernisierte Steuerung, geteilte Erfahrungspunkte, stark reduziertes Grinding und umfassendes Rebalancing. Die originale Story, die Welt, Rätsel und die SNES-Präsentation bleiben vollständig unangetastet.

> [!IMPORTANT]
> **Grundlage:**  
> Dieser ROM-Hack basiert auf der aktuellen Version 2.1 des ursprünglichen Hacks von **Andrew Clunn** ([GitHub-Repository](https://github.com/andrewclunn/Secret-of-Evermore-Casual-Run)) und wurde für die offizielle deutsche PAL-ROM (`Secret of Evermore (Germany).sfc`) reimplementiert.

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
  - **Speere:** Speer, Bronzespeer, Elfenbeinspeer, Neutronenspeer
- Erhält eine geführte Waffe im Kampf Erfahrung, leveln alle vier Waffen derselben Familie sofort mit. Veraltete Waffen müssen nach einem Upgrade nicht mehr mühsam nachgelevelt werden!

### 50 % weniger Grinding (Halbierte EXP-Kurve)
- **Halbierte Level-99 EXP-Kurve:**  
  Die erforderlichen Erfahrungspunkte für alle Level von 1 bis 99 wurden für den Jungen und den Hund um 50 % reduziert.
- **Flüssiger Spielfluss:**  
  Bosse und neue Areale können ohne Zwangspausen zum Level-Grinding gemeistert werden.

### Gegner- & Boss-Rebalancing (89 Datensätze)
- **Doppelte Währungsbelohnung:**  
  Besiegte reguläre Gegner geben das Doppelte an Währung (Krallen in Prähistorie, Juwelen in Antika, Goldmünzen in Gotika und Kreditkarten in Assitopia).
- **Angepasste Boss-Kraftpunkte (HP):**  
  Extrem zähe Bosse mit überzogenen Lebenspunkte-Polstern wurden moderat abgeschwächt für dynamischere, spannendere Kämpfe.
- **Verbesserte Beute- & Zutatendropraten:**  
  Zutaten- und Beutefunde treten häufiger und verlässlicher auf.

### Ausrüstungs-, Item- & Alchemie-Balancing
- **Rüstungs- & Helm-Rebalancing:**  
  Moderate Abwehrwert-Anpassungen für 10 Helme (Schädelhelm bis Magiehelm) und 10 Armbänder (Klauenreif bis Cyber-Armband) für einen ausgeglicheneren Schadensverlauf, wobei alle originalen deutschen Namenszeiger und Strukturdaten unangetastet bleiben.
- **Verstärkte Basiswaffen:**  
  Frühe Nahkampfwaffen wurden moderat gestärkt (z. B. Knochenknüppel ATK 10 $\rightarrow$ 13).
- **Alchemie-Levelkurve:**  
  Beschleunigter Levelaufstieg für Zauberformeln auf den Stufen 1 bis 6 (direkt in Bank `$C5` bei `$C5:0202`).

### Karten- & Dungeon-Reparaturen
- **Pyramiden-Kacheln:**  
  Symbol- und Rückweg-Fixes in der Pyramide von Antika verhindern Hänger und Dead-Ends (Map 86 auf `$F0:1000`).
- **Hundelabyrinth:**  
  Verbindungskacheln im Hundelabyrinth repariert (Map 115 auf `$FF:3000`).

---

## 3. Technische Adress-Matrix (Deutsche PAL-ROM)

Die deutsche PAL-ROM (`Secret of Evermore (Germany).sfc`) unterscheidet sich in ihrem Bank- und Skript-Layout fundamental von der US-Version. Alle Patches wurden forensisch auf die deutschen 65816-Offsets kalibriert:

| System / Bereich | US-Offset (v2.1) | Deutscher PAL-Offset | Technische Umsetzung |
| :--- | :--- | :--- | :--- |
| **Waffen-Tabelle (Bank $C4)** | `$C4:38E6` | **`$C4:3F26`** (`0x043F26`) | 15 Waffen-Einträge (Stride 36 Bytes) |
| **Helme & Armbänder (Bank $C4)** | `$C4:3B8E` / `$C4:3C06` | **`$C4:41CE`** & **`$C4:4246`** | 20 isolierte 4-Byte-Patches (Abwehrwerte), deutsche Textzeiger in Bank `$C5` bleiben intakt |
| **Alchemie-Levelkurve (Bank $C5)** | `$C4:5B9D` | **`$C5:0203`** (`0x050203`) | 6 Bytes modifizierte Zuwachswerte für Stufen 1–6 |
| **EXP-Kurve Level 1–99 (Bank $CC)** | `$CC:8BD3` | **`$CC:8F65`** (`0x0C8F65`) | 594 Bytes (Junge + Hund EXP-Tabelle, halbiert) |
| **Status-Wachstumstabellen (Bank $CC)** | `$CC:9285` | **`$CC:9617`** (`0x0C9617`) | BoyDefense, MagicDefense, Hundestats |
| **Gegner- & Boss-Datensätze (Bank $CE)** | `$CE:C545` | **`$CE:C545`** (`0x0EC545`) | 89 Datensätze (HP & 2x Kill-Gold in HiROM Bank `$CE`) |
| **Waffen-XP Routine (Bank $CF)** | `$CF:B717` | **`$CF:B6C8`** & **`$CF:B729`** | Call-Site-Hooks nach `$F0:0010`; Helper ruft native Routine `$8F:9714` auf |
| **Bewegung & Auto-Run (Bank $D0)** | `$90:82AA` | **`$D0:82B0`** & **`$D0:82B8`** | Jaguar-Ring-Bypass (`EA EA`) & Default-Dash-Invertierung (`F0 07`) |
| **Karten-Zeigertabelle (Bank $E0)** | `$E0:FDE5` | **`$E0:FF3D`** & **`$E0:FFB1`** | Zeiger für Map 86 (Pyramide) und Map 115 (Hundelabyrinth) auf erweiterte Bänke |
| **Erweiterter Code & Maps (Bank $F0 / $FF)** | Bank `$F0` / `$FF` | **Bank `$F0` / `$FF`** | 4 MiB HiROM-Expansion (`0x300000`-`0x3FFFFF`) |

---

## 4. Bauen & Patchen

### Option A: Fertigen IPS-Patch anwenden (Empfohlen)
1. Verwende die Patch-Datei `Secret_of_Evermore_Casual_Run_German.ips` (oder das Release-Zip).
2. Wende den Patch mit einem IPS-Patcher (z. B. [FLIPS](https://www.romhacking.net/utilities/1040/), Lunar IPS oder [RomPatcher.js](https://www.marcrobledo.com/RomPatcher.js/)) auf deine unmodifizierte deutsche Basis-ROM an.

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
  - SHA-256: `e75b0b6f1b7926e0d7c0d495d107298cda704ecef9d28d4b194f086433845faf`
  - SNES-Prüfsumme: `0x2F12`

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
