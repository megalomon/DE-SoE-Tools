# Secret of Evermore: Casual Run (Deutsche PAL Version)

Eine native Portierung des beliebten ROM-Hacks *Secret of Evermore: Casual Run* (Version 2.1 von Andrew Clunn), speziell entwickelt für die offizielle **deutsche PAL-ROM** (`Secret of Evermore (Germany).sfc`).

---

## 1. Übersicht & Zielsetzung

Dieser Port bringt die beliebten Komfort- und Rebalancing-Features von *Casual Run* direkt auf die deutsche PAL-Version von *Secret of Evermore*, ohne auf die US-ROM angewiesen zu sein. 

Die originalen deutschen Bildschirmtexte, Dialoge und Übersetzungen von **Claude M. Moyse** bleiben zu 100 % erhalten, während die Spielmechanik durch modernisierte Komfortfunktionen und ein stark reduziertes Grinding aufgewertet wird.

---

## 2. Enthaltene Features

### 🏃 Modernisierte Steuerung & Bewegung
- **Standardmäßiger Dauerlauf (Default Dash):**  
  Der Junge läuft automatisch, sobald das Steuerkreuz betätigt wird (kein mühsames Halten der B-Taste mehr nötig).
- **B-Taste zum Gehen & schnellen Aufladen:**  
  Das Halten der B-Taste schaltet auf normales Gehen um (präzises Manövrieren bei schmalen Wegen und Fallen) und lädt den Waffenangriffsbalken schneller auf.

### ⚔️ Geteilte Waffen-Erfahrung (Shared Weapon Experience)
- Alle Waffen derselben Gattung teilen sich den Erfahrungszuwachs:
  - **Schwerter:** Knochenknüppel, Drachentöter, Exkalibur, Laserschwert
  - **Äxte:** Tarantelaxt, Bronzeaxt, Streitaxt, Atomaxt
  - **Speere:** Speer, Bronzespeer, Lanze, Tri-Spitze
- Sobald eine geführte Waffe XP erhält, werden alle vier Waffen der Familie simultan mitlevelnd aktualisiert. Kein mühsames Nachleveln veralteter Waffen mehr!

### ⏳ 50 % weniger Grinding & Halbierte EXP-Kurve
- **Halbierte Level-99 EXP-Kurve:**  
  Die erforderlichen Erfahrungspunkte für alle Level von 1 bis 99 wurden für den Jungen und den Hund um 50 % reduziert.
- **Schnelleres Vorankommen:**  
  Flüssiger Spielfluss ohne Zwangspausen zum Level-Grinding vor Bosskämpfen.

### 💰 Gegner- & Boss-Rebalancing (89 Anpassungen)
- **Doppelte Währungsbelohnung:**  
  Besiegte reguläre Gegner lassen das Doppelte an Gold/Talenten/Dukaten/Juwelen fallen.
- **Angepasste Boss-Kraftpunkte (HP):**  
  Extrem zähe Bossgegner (wie z. B. Magmarock, Mechano-Dinos, etc.) haben reduzierte Lebenspunkte für dynamischere Kämpfe.
- **Verbesserte Drop-Raten:**  
  Zutaten- und Beutefunde treten häufiger und verlässlicher auf.

### 🛡️ Waffen- & Gegenstands-Balancing
- **Überarbeitete Waffenstärken:**  
  Basis-Angriffswerte früher Nahkampfwaffen wurden moderat angehoben (z. B. Knochenknüppel ATK 10 $\rightarrow$ 13).
- **Effektivere Heilmittel:**  
  - Blütenblätter heilen **80 KP** (vorher 40 KP).
  - Nektar heilt **200 KP** (vorher 100 KP).
  - Das Tragelimit für Schlammpfeffer wurde auf **99** erhöht.

### 🗺️ Dungeon- & Karten-Reparaturen
- **Pyramiden-Kacheln:**  
  Symbol- und Rückweg-Fixes in der Pyramide von Antiqua verhindern Hänger.
- **Hundelabyrinth:**  
  Verbindungskacheln im Hundelabyrinth korrigiert.

---

## 3. Technische Adress-Matrix (German PAL vs. US)

Die deutsche PAL-ROM unterscheidet sich in ihrem Bank- und Skript-Layout signifikant von der US-Version. Die Anpassungen wurden exakt auf die deutschen 65816-Offsets kalibriert:

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

### Voraussetzungen
- Python 3
- Die offizielle deutsche PAL-ROM: `Secret of Evermore (Germany).sfc`
  - Größe: `3.145.728` Bytes
  - SHA-256: `c341668847170d36fa5cfb720568b0b1ecbb24fc426a821f665f1d3853a46a6d`

### Build-Befehl
Im Projektverzeichnis ausführen:
```bash
python3 romhacks/Secret-of-Evermore-Casual-Run/build_german.py
```

### Generierte Dateien
1. **`Secret_of_Evermore_Casual_Run_German.sfc`** (4.194.304 Bytes / 4 MiB):  
   Die spielfertig gepatchte und erweiterte deutsche ROM mit aktualisierter SNES-Prüfsumme.
2. **`Secret_of_Evermore_Casual_Run_German.ips`** (~160 KB):  
   Ein eigenständiger IPS-Patch, der mit jedem gängigen Patcher (Lunar IPS, FLIPS, Romhacking Online-Patcher) direkt auf `Secret of Evermore (Germany).sfc` angewendet werden kann.

---

## 5. Dateistruktur im Ordner

```
romhacks/Secret-of-Evermore-Casual-Run/
├── Secret_of_Evermore_Casual_Run_German.asm   <- ASM-Quellcode für die deutsche ROM
├── Secret_of_Evermore_Casual_Run_German.sfc   <- Fertig gebaute 4-MiB deutsche ROM
├── Secret_of_Evermore_Casual_Run_German.ips   <- Release-Patch für deutsche Basis-ROM
├── build_german.py                            <- Python Build-Pipeline für deutsche ROM
├── GERMAN_PORT_README.md                      <- Dieses Dokument
├── Secret_of_Evermore_Casual_Run_v2.1.asm     <- Originaler US-Source von Andrew Clunn
├── build.py                                   <- Upstream US Build-Skript
└── README.md                                  <- Upstream englische Dokumentation
```
