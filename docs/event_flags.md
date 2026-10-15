# Event-Flags & Story-Fortschritt (Secret of Evermore – Deutsche PAL ROM)

In *Secret of Evermore* werden sämtliche Spielzustände – wie besiegte Bosse, geöffnete Truhen, gefundene Alchemieformeln, Händler-Tauschgeschäfte und Story-Meilensteine – in einem zentralen **Bitfield im WRAM** gespeichert.

---

## 1. Das Bitfield-System im WRAM

Alle Flags liegen in einem zusammenhängenden Speicherbereich ab Basisadresse **`$7E2258`**:

### Berechnungsformel für ein Flag mit ID $F$:

$$\text{WRAM-Adresse} = \$7E2258 + \lfloor F / 8 \rfloor = \$7E2258 + (F \gg 3)$$

$$\text{Bit-Position} = F \pmod 8 = F \ \& \ 7$$

$$\text{Bitmaske} = 1 \ll (F \ \& \ 7)$$

- Jedes Byte im WRAM speichert **8 Flags** (Bits 0 bis 7).
- Ein Wert von `1` bedeutet: Flag ist aktiv (z. B. Boss besiegt, Event abgeschlossen, Item erhalten).
- Ein Wert von `0` bedeutet: Flag ist inaktiv.

---

## 2. Bosse & Mini-Bosse (Besiegt-Status)

Wird ein Boss besiegt, setzt die Skript-Engine das entsprechende Flag auf `1`. Dies steuert den Raumwechsel, das Freischalten von Ausgängen und das Einstellen der Kampfmusik:

| Flag-ID | WRAM-Adresse | Bit & Maske | Boss / Gegner (DE-ROM) | Ort / Gebiet (DE-ROM) |
| :---: | :---: | :---: | :--- | :--- |
| **`0x0044`** | `$7E2260` | Bit 4 (`0x10`) | **Vulgor** (Thraxx) | Käfersteppe (Prähistorie) |
| **`0x0037`** | `$7E225E` | Bit 7 (`0x80`) | **Moorhexe** (Salabog) | Sumpf (Prähistorie) |
| **`0x003A`** | `$7E225F` | Bit 2 (`0x04`) | **Viper Commander** | Mammut-Friedhof (Prähistorie) |
| **`0x0024`** | `$7E225C` | Bit 4 (`0x10`) | **Vulkan Viper Commander** | Vulkan-Höhle (Prähistorie) |
| **`0x0046`** | `$7E2260` | Bit 6 (`0x40`) | **Magmar** (Lavaboss) | Vulkangipfel (Prähistorie) |
| **`0x043F`** | `$7E22DF` | Bit 7 (`0x80`) | **Höhlen-Raptoren** | Raptor-Kluft (Prähistorie) |
| **`0x0023`** | `$7E225C` | Bit 3 (`0x08`) | **Monsterqualle** (Aquagoth) | Schiffswrack (Antika) |
| **`0x0025`** | `$7E225C` | Bit 5 (`0x20`) | **Mad Monk** | Hektors Camp / Oase (Antika) |
| **`0x003D`** | `$7E225F` | Bit 5 (`0x20`) | **Vigor** (Gladiator) | Allelachema Arena (Antika) |
| **`0x0406`** | `$7E22D8` | Bit 6 (`0x40`) | **Bastet / Rimsala** | Pyramide Spitze (Antika) |
| **`0x0407`** | `$7E22D8` | Bit 7 (`0x80`) | **Panzerminos** (Megataur) | Collosia Tempel (Antika) |
| **`0x040B`** | `$7E22D9` | Bit 3 (`0x08`) | **Aegis** | Allelachema Marktplatz (Antika) |
| **`0x045D`** | `$7E22E3` | Bit 5 (`0x20`) | **Minitaurus** (Tiny) | Pyramide Untergeschoss (Antika) |
| **`0x0428`** | `$7E22DD` | Bit 0 (`0x01`) | **Rattus** (Verminator) | Chaosturm Kanalisation (Gotika) |
| **`0x0429`** | `$7E22DD` | Bit 1 (`0x02`) | **Feuerdrache** (Sterling) | Chaosturm Schlosshof (Gotika) |
| **`0x042A`** | `$7E22DD` | Bit 2 (`0x04`) | **Baumdrache** (Timberdrake) | Schattenwald (Gotika) |
| **`0x0438`** | `$7E22DF` | Bit 0 (`0x01`) | **Doppelgänger** (Bad Boys) | Schattenwald (Gotika) |
| **`0x0456`** | `$7E22E2` | Bit 6 (`0x40`) | **Dr. Gallenstein & Dr. Nierenfels** | Chaosturm Labor (Gotika) |
| **`0x046E`** | `$7E22E5` | Bit 6 (`0x40`) | **Mungola** (Puppenspieler) | Terrorfels Puppentheater (Gotika) |
| **`0x0470`** | `$7E22E6` | Bit 0 (`0x01`) | **Footknight** | Terrorfels Burgtor (Gotika) |
| **`0x0477`** | `$7E22E6` | Bit 7 (`0x80`) | **Fratzenwand** (Wall Face) | Schachbrett-Verlies (Gotika) |
| **`0x0486`** | `$7E22E8` | Bit 6 (`0x40`) | **Gorvul** (Coleoptera) | Vulkan-Röhrenlabyrinth (Prähistorie) |
| **`0x048E`** | `$7E22E9` | Bit 6 (`0x40`) | **Minitaur** | Kerker (Gotika) |
| **`0x04CE`** | `$7E22F1` | Bit 6 (`0x40`) | **Edgars Roboter** | Finaler Thronsaal Assitopia (Endboss) |

---

## 3. Markt von Allelachema & Tauschgeschäfte

Der Markt von Allelachema basiert auf einem komplexen System aus Tausch-Flags, die verhindern, dass einmalige Schlüsselgegenstände mehrfach gekauft oder getauscht werden:

| Flag-ID | WRAM-Adresse | Bit & Maske | Gegenstand / Tausch-Event | Beschreibung |
| :---: | :---: | :---: | :--- | :--- |
| **`0x002B`** | `$7E225D` | Bit 3 (`0x08`) | **Markteinlass Allelachema** | `1` = Wache lässt den Helden auf den Marktplatz. |
| **`0x004A`** | `$7E2261` | Bit 2 (`0x04`) | **Bestes Stück 1** | Töpfer hat erstes Hauptangebot verkauft. |
| **`0x004B`** | `$7E2261` | Bit 3 (`0x08`) | **Bestes Stück 2** | Händler-Angebot erschöpft. |
| **`0x004C`** | `$7E2261` | Bit 4 (`0x10`) | **Bestes Stück 3** | Händler-Angebot erschöpft. |
| **`0x004E`** | **`$7E2261`** | **Bit 6 (`0x40`)** | **Chocobo-Ei** | `1` = Chocobo-Ei vom Töpfer erhalten/getauscht. |
| **`0x0050`** | `$7E2262` | Bit 0 (`0x01`) | **Gewürzhandel abgeschlossen** | Händler-Transaktion beendet. |
| **`0x0052`** | **`$7E2262`** | **Bit 2 (`0x04`)** | **Mythenschärpe** (Magic Gourd) | `1` = Tausch gegen Chocobo-Ei abgeschlossen. |
| **`0x0056`** | `$7E2262` | Bit 6 (`0x40`) | **Armor Ultra** | `1` = Armor Ultra im Tausch erhalten. |
| **`0x005B`** | `$7E2263` | Bit 3 (`0x08`) | **Jadereif** | `1` = Jadereif gekauft / im Besitz. |
| **`0x005C`** | `$7E2263` | Bit 4 (`0x10`) | **Sonnenstein** | `1` = Sonnenstein gekauft / im Besitz. |
| **`0x005D`** | `$7E2263` | Bit 5 (`0x20`) | **Rubin-Herz** | `1` = Wertvollstes Tauschstück erhalten. |
| **`0x005F`** | `$7E2263` | Bit 7 (`0x80`) | **Moxastab** | `1` = Moxastab gekauft / im Besitz. |
| **`0x019D`** | `$7E228B` | Bit 5 (`0x20`) | **Amulett des Karon** | `1` = Amulett zur Oasenüberquerung gekauft. |
| **`0x019E`** | `$7E228B` | Bit 6 (`0x40`) | **Perlenhändler** | `1` = Perlen für 12 Juwelen erworben. |

---

## 4. Story-Meilensteine & Quest-Progress

| Flag-ID | WRAM-Adresse | Bit & Maske | Story-Ereignis |
| :---: | :---: | :---: | :--- |
| **`0x0011`** | `$7E225A` | Bit 1 (`0x02`) | Einführung in die Alchemie erhalten. |
| **`0x001C`** | `$7E225B` | Bit 4 (`0x10`) | Zauberbrückenformel (Revealer) erhalten. |
| **`0x001D`** | `$7E225B` | Bit 5 (`0x20`) | Hund hat Abenteurer-Status erreicht. |
| **`0x0020`** | `$7E225C` | Bit 0 (`0x01`) | Alchemist im Sumpf besucht. |
| **`0x0038`** | `$7E225F` | Bit 0 (`0x01`) | Große Flut in Prähistorie überstanden. |
| **`0x0039`** | `$7E225F` | Bit 1 (`0x02`) | Telekinese-Formel (Levitate) erhalten. |
| **`0x003D`** | `$7E225F` | Bit 5 (`0x20`) | Hund in Allelachema wiedergefunden (neue Gestalt). |
| **`0x0062`** | `$7E2264` | Bit 2 (`0x04`) | Ventil für die Vulkanmaschine gefunden. |
| **`0x0063`** | `$7E2264` | Bit 3 (`0x08`) | Wagenrad für die Vulkanmaschine gefunden. |
| **`0x0183`** | `$7E2288` | Bit 3 (`0x08`) | Alchemie-Meister in Gotika freigeschaltet. |
| **`0x0406`** | `$7E22D8` | Bit 6 (`0x40`) | Erstes Diamantauge (Auge des Rimsala) geborgen. |

---

## 5. Hund-Schnüffelstellen (Sniff-Spots)

Der Speicherbereich von **`$7E2265` bis `$7E22D9`** (Flags `0x0068` bis `0x040F`) ist für die **Schnüffelstellen des Hundes** reserviert:
- Jedes Mal, wenn der Hund an einer Stelle eine Zutat ausgräbt, wird das zugehörige Bit auf `1` gesetzt.
- Dadurch wird verhindert, dass der Hund dieselbe Zutat an exakt derselben Stelle unendlich oft hintereinander ausgräbt, bis das Gebiet neu betreten oder zurückgesetzt wird.


