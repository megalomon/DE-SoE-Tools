# Deutsche Dialog- & Text-Dekomprimierung (Secret of Evermore)

In *Secret of Evermore* werden sämtliche Spieltexte (Dialoge, Item-Texte, Menü-Meldungen) komprimiert in Bank `$92` und `$C0` abgelegt. In der **deutschen PAL-Version** kommt ein spezieller, hardwarenaher **Markov-/Huffman-Algorithmus** auf 65816-Basis zum Einsatz.

---

## 1. Zeigertabelle: Text-ID zu ROM-Adresse

- **Basisadresse der Zeigertabelle:** `$92:8000` (`0x128000`)
- **Eintragsgröße:** 3 Bytes (`b0`, `b1`, `b2`)
- **Gesamtzahl Dialoge:** **3.082** Einträge (Index `0`..`3081`, endet exakt am Beginn der Markov-Tabelle `$92:A41E`)

### 65816-Adressberechnung (aus Routine `$8C:D0B8`):

Für eine gegebene Text-ID $T$:
```
Offset_in_Tabelle = $128000 + T * 3
b0 = ROM[Offset_in_Tabelle]
b1 = ROM[Offset_in_Tabelle + 1]
b2 = ROM[Offset_in_Tabelle + 2]
```

1. **Komprimierungs-Flag:**
   $$\text{is\_compressed} = (b_2 \ \& \ 0x80) \neq 0$$
   *(Ist Bit 7 von $b_2$ gesetzt, ist der Text komprimiert. Ist es gelöscht, liegt roher Null-terminierter Text vor).*

2. **SNES-Bank:**
   $$\text{Bank} = \$C0 + (((b_2 \ll 1) \ | \ (b_1 \gg 7)) \ \& \ 0xFF)$$

3. **In-Bank Offset:**
   $$\text{InBank\_Offset} = (b_0 \ | \ ((b_1 \ \& \ 0x7F) \ll 8)) \ \& \ 0x7FFF$$

4. **Datei-Offset in der ROM (`.sfc`):**
   $$\text{Datei-Offset} = ((\text{Bank} \ \& \ 0x3F) \times 0x10000) + \text{InBank\_Offset}$$

---

## 2. Der Dekomprimierungs-Algorithmus (`$8C:D147`)

Der Textstream wird nibbleweise (4-Bit-Blöcke) gelesen. Es beginnt **stets mit dem Low-Nibble** des ersten Bytes:

- **Häufigkeitstabelle (Markov-Matrix):** `$92:A41E` (`0x12A41E`)  
  Pro Vorläuferzeichen (`prev_char`, initial `0`) stehen 14 Folgezeichen zur Verfügung.

### Verarbeitungslogik pro Nibble:

```
                  +-------------------+
                  |  Nächstes Nibble  |
                  +---------+---------+
                            |
           +----------------+----------------+
           |                                 |
       Nibble == 0                     Nibble > 0
           |                                 |
+----------+----------+             +--------+--------+
| Ist Byte-Grenze     |             |                 |
| aligned (state==0)? |         Nibble 1..13     Nibble >= 14
+----+-----------+----+             |                 |
 Ja  |           | Nein             |         +-------+-------+
     v           v                  v         | Top-Nachfolger|
 Aligned      Unaligned        Tabellenwert   | (offset +0)   |
 Raw-Byte     Raw-Byte         prev*14+nibble | 1x oder 2x    |
 (INC pos)   (LSR 4 pos)            |         +---------------+
```

1. **Nibble = `0x00` (Rohes Byte / Escape):**
   - War das Nibble an einer geraden Byte-Grenze (`state == 0`), wird das folgende Byte direkt aus dem Stream als ASCII-Zeichen übernommen.
   - War das Nibble unaligned (`state == 1`), wird über `(w >> 4) & 0xFF` ein unaligned Byte gelesen.
   - Ist das gelesene Byte `0x00`, ist das Ende des Textes erreicht.
   - Das gelesene Byte wird das neue `prev_char`.

2. **Nibble `0x01` bis `0x0D` (1 bis 13 – Übergangstabelle):**
   - Das nächste Zeichen wird aus der Markov-Tabelle geladen:
     $$\text{Index} = (\text{prev\_char} \times 14) + \text{Nibble}$$
     $$\text{Neues Zeichen} = \text{ROM}[\$12A41E + \text{Index}]$$
   - Ist der geladene Wert `0x00`, endet der Text.
   - Andernfalls wird das Zeichen ausgegeben und wird das neue `prev_char`.

3. **Nibble `0x0E` und `0x0F` (14 und 15 – Häufigkeits-Spurt):**
   - Es wird der Spitzen-Nachfolger an Offset `+ 0` geladen (`count = Nibble - 0x0E`, also 1-mal für `0x0E`, 2-mal für `0x0F`):
     $$\text{Index} = \text{prev\_char} \times 14 + 0$$
   - Nach jedem ausgegebenen Zeichen wird `prev_char` sofort aktualisiert und der nächste Top-Nachfolger rekursiv geladen.

---

## 3. Steuerzeichen im Textstream

Die deutschen Texte enthalten spezielle Steuer- und Formatierungsbytes:

| Byte | Steuerzeichen | Bedeutung / Funktion im Spiel |
| :---: | :--- | :--- |
| `0x0A` | `\n` | Zeilenumbruch innerhalb der Box. |
| `0x81` | **`[Boy]`** | Name des Jungen (dynamisch aus Spieler-Eingabe). |
| `0x82` | **`[Dog]`** | Name des Hundes (dynamisch aus Spieler-Eingabe). |
| `0x86` | **`[Delay]`** | Wartet auf Bestätigung (A-Knopf) des Spielers. |
| `0x87` | **`[Choice]`**| Markiert ein interaktives Auswahlfenster (z. B. Händler / Fragen). |
| `0x8B` | **`[Marker]`**| Auswahlmarker für eine anwählbare Option (mit Positionsliste). |
| `0x92` | **`[Center]`**| Zentriert Textzeile im Fenster. |
| `0x93` | **`[Speaker]`**| Sprechername / Sprecherporträt. |
| `0x96` | **`[Box]`** | Öffnet das grafische Textfenster / leert Inhalt. |
| `0x97` | **`[Page]`** | Beginnt eine neue Textseite (wartet auf Bestätigung). |
| `0xA1..0xA8` | **`[Val1..8]`** | Dynamische Spielvariablen und Zahlenwerte aus `$7E:2535+`. |

### Deutsche Sonderzeichen-Codierung
- `0xE3`: `ä`
- `0xEF`: `ö`
- `0xF3`: `ü`
- `0xC6`: `ß`
- `0xCB`: `Ä`
- `0xDB`: `Ö`
- `0xDF`: `Ü`
