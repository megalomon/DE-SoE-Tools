# Secret of Evermore: Casual Run – Deutsche Portierung & Architektur-Konzept

Dieses Dokument analysiert die technische Architektur von *Secret of Evermore: Casual Run* (Version 2.1 von Andrew Clunn) und definiert die Roadmap für die deutsche Fassung im Verzeichnis `./romhacks/Secret-of-Evermore-Casual-Run/`.

---

## 1. Ausgangslage & Bestandsaufnahme

Im Verzeichnis `./romhacks/Secret-of-Evermore-Casual-Run/` liegen folgende Basisdateien:

1. **`Secret_of_Evermore_Casual_Run_v2.1.asm`** (3,3 MB, 58.797 Zeilen):  
   Der autoritative Quellcode der aktuellen Version 2.1, bereitgestellt direkt vom Entwickler.
2. **`build.py`**:  
   Das eigenständige, abhängigkeitsfreie Python-Build-Skript, das aus der Base-ROM und dem ASM-Source die 4-MiB-Erweiterungs-ROM und IPS-Patches erzeugt.
3. **`README.md`**:  
   Die vollständige Feature-Dokumentation von Casual Run v2.0/v2.1.

---

## 2. Die zwei technischen Wege & Empfehlung des Entwicklers

Andrew Clunn empfiehlt in seiner Nachricht ausdrücklich:
> *„IF you are vibe coding, I believe it will be MUCH easier to take Casual Run, translate it to German, and ensure that the save files use similar formats to the German game, than to reimplement all of Casual Run on top of the German ROM. I strongly suggest taking that approach. Hell, you can even change it from 60 to 50 FPS if that's really important to you (though likely not).“*

### Vergleich der beiden Ansätze:

| Kriterium | Ansatz A (Empfohlen): Casual Run eindeutschen | Ansatz B: Re-Implementierung auf deutscher PAL-ROM |
| :--- | :--- | :--- |
| **Basis-ROM** | US-ROM (`17c864a7...`) als technische 4-MiB-Engine | Deutsche PAL-ROM (`Secret of Evermore (Germany).sfc`) |
| **Framerate & Audio** | **60 FPS NTSC** (flüssig, originalgetreu) | **50 FPS PAL** (gebremste PAL-Balken, PAL-Timing) |
| **2-Spieler-Koop & Eingabe** | **100 % fertig integriert** (Controller 2 Start, Select-Kamera) | Muss an ~50 verschobene RAM/Register-Stellen im PAL-Code portiert werden |
| **Ring-Shortcuts** | **100 % fertig** (X = Items, Y = Alchemie, Start = Hauptmenü) | Menü-Dispatch in Bank `$84`/`$8C` muss neu geschrieben werden |
| **Geteilte XP & Rebalancing** | **100 % fertig** (Schwerter, Äxte, Speere, Alchemiefamilien) | Kampf- und Schadensroutinen in Bank `$C5`/`$8E` müssen portiert werden |
| **Text- & Dialogsystem** | Verwendet Casual Runs erweitertes Textsystem (`$F1`–`$FB`) mit Dialogstilen, Sprecherrahmen und NG+ | Deutsche PAL-ROM nutzt ein starres Nibble-Huffman-System in Bank `$91`/`$92`, das mit 4-MiB-Erweiterung kollidiert |
| **Aufwand & Stabilität** | **Sehr hochgradig stabil & deterministisch**, da die 4.729 ASM-Hooks intakt bleiben | **Extrem fehleranfällig**: 4.729 Hooks müssten einzeln an verschobene PAL-Offsets angepasst werden |

---

## 3. Die 37 Funktionalen Regionen von Casual Run v2.1

Casual Run erweitert die SNES-ROM von 3 MiB auf 4 MiB (`$F00000`–`$FFFFFF`). Die wichtigsten Module:

1. **Eingabe & 2-Spieler-Engine (`$F00000`–`$F00FFF`):**  
   - Dauerlauf standardmäßig (nach Erhalt des Jaguarrings).
   - Halten von **B** zum Gehen und schnelleren Aufladen.
   - **X** öffnet direkt das Item-Ringmenü des Jungen.
   - **Y** öffnet direkt das Alchemie-Ringmenü des Jungen.
   - **Start** öffnet/schließt das Haupt-Ringmenü.
   - **Start auf Controller 2** schaltet 2-Spieler-Koop ein/aus.
   - **Select** wechselt Spielfigur (1P) bzw. Kamerafokus (2P).
2. **Erfahrungspunkte & Levelsystem (`$C57410`–`$C576A3`, `$CC8BD3`):**  
   - Geteilte Waffen-XP innerhalb derselben Gattung (Schwerter, Äxte, Speere).
   - Geteilte Alchemie-XP innerhalb von Zauberfamilien (jeder 2. Cast trainiert verwandte Formeln).
   - Halbierter Gesamtaufwand bis Level 99.
   - Schnüffeln gibt dem Hund XP und Angriffsskill.
3. **Beute- & Drop-System (`$F16000`–`$F1633F`):**  
   - Doppelte Währungsbelohnung bei normalen Gegnern.
   - Regionale Beuteboxen auf 71 Kampfkarten (Währung, Zutaten, Tauschwaren).
   - Gewöhnliche Schnüffelfunde und Zutaten-Drops geben 2 Einheiten statt 1.
4. **Dialog-Stile & Präsentation (`$F77000`–`$F7EBA7`):**  
   - Eigene Fensterpositionen, Rahmen, Soundeffekte und Border-Styles je nach Sprecher (Junge, Roboter, Zora, Hektor, Camellia, Prof. Seltsam).
   - Nahtlose Speicher-Dialoge mit Charakter-Persönlichkeit.
5. **Dungeon- & Bugfixes (`$F01000`, `$F5A000`):**  
   - Pyramiden-Symbole und Rückweg repariert.
   - Hundelabyrinth-Verbindungskacheln.
   - Omnitopia-Röhren und Gehen durch Schächte mit gehaltener B-Taste.
   - Minikarte beim Gleiter-Flug standardmäßig aktiv.
6. **New Game Plus (`$F20000`–`$F4001E`):**  
   - Zeitreise-Option bei Jade in Prähistorie.
   - Mitnahme von Schlüsselwaffen und Jaguarring.
   - Replay-Dialogvarianten bei NPCs.

---

## 4. Konkreter Umsetzungsplan für die deutsche Fassung

Um die authentische deutsche Lokalisierung (Claude M. Moyse) mit dem modernen Casual-Run-Feature-Set zu vereinen:

1. **Text-Extraktion & Mapping:**  
   - Aus unserem Dumper in `DE-SoE-Tools` liegen alle 3.082 deutschen Originaltexte, 35 Alchemie-Namen/Beschreibungen, 142 Gegnernamen und Menütexte vor.
   - Einbindung der deutschen Texte in die `@TEXTARENA`-Struktur von Casual Run.
2. **Zeichensatz & Umlaute:**  
   - Sicherstellen der 8-Bit-Zeichenkodierung für deutsche Umlaute (`ä`, `ö`, `ü`, `ß`, `Ä`) in den erweiterten Dialog- und Menüroutinen.
3. **Menü- & Ring-Beschriftungen:**  
   - Deutsche Menübezeichnungen: *Waffen*, *Objekte*, *Alchemie*, *Status*, *Hunde-Ausrüstung*.
4. **Spielstand-Kompatibilität (SRAM):**  
   - Angleichung der SRAM-Prüfsummen und Speicherstruktur an das deutsche Format, sodass Spielstände austauschbar bleiben.
5. **Build-Pipeline:**  
   - Erweiterung von `build.py` für die automatisierte Generierung der deutschen Casual-Run-ROM.
