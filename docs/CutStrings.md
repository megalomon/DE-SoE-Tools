# Cut Content & Forensischer Text-Audit (Secret of Evermore – Deutsche PAL-Version)

Dieses Dokument bietet eine lückenlose, forensische Gesamtanalyse aller **tatsächlich ungenutzten Texte**, verworfenen Übersetzungen, toten Code-Zweige, internen Entwickler-Strings und fremdsprachigen Relikte in der deutschen Version von *Secret of Evermore* (`Secret of Evermore (Germany).sfc`, SHA-1 `5E5C2082526690D05F962C3FFBD7E080C681BFA4`).

Alle hier aufgeführten Texte und Strings wurden direkt auf Maschinencode-Ebene verifiziert. Sie sind im regulären Spielablauf **nicht erreichbar**, da sie entweder von keinem Zeiger referenziert werden, in verwaisten Skriptroutinen liegen (*Dead Code*) oder durch unerfüllbare Flag-Hierarchien blockiert sind.

---

## 1. Übersicht der ungenutzten Textkategorien

| Kategorie | Fundort im ROM | Typ / Ursprung | Beschreibung |
| :--- | :--- | :--- | :--- |
| **Ungenutzte Dialoge & Sequenzen** | Bank `$91`/`$92` via `$93`–`$9C` | Dead Code / Toter Verzweigungszweig | Dialoge vor Bosskämpfen, gestrichene Alchemisten, Dead-End Flag-Checks. |
| **Fremdsprachige Reste & Fallbacks** | Bank `$91`/`$92` via `$93B114` | Lokalisierungsrelikte | Spanische und englische Fallbacks für Items und Grenz-Assertionen. |
| **Verworfene Alchemie-Übersetzungen** | Bank `$C5` | Frühe Lokalisierungsstufe | Verworfene deutsche Formelnamen und alternative Wirkungsbeschreibungen. |
| **Ungenutzte Zauber & Testzauber** | Bank `$C5` | Gestrichene Magie & Debug | Fertig programmierte, aber unzugängliche Zauber und Entwickler-Testspells. |
| **Verworfene Gegner- & Kampftexte** | Bank `$C5` | Nicht referenzierte Tabelleneinträge | Verworfene Gegnervarianten (*Rotorschädel*) und ungenutzte Kampf-Popups. |
| **Entwickler-Debug-Menü** | Bank `$C5` | Debug-Code | 8 ungenutzte Menüpunkte der US-Entwickler. |
| **Kartennamen & Engine-Strings** | Bank `$AD` & `$8C` | Interne ASCII-Tabellen | 92 interne englische Map-Namen und Interpreter-Fehlermeldungen. |

---

## 2. Ungenutzte Dialoge & verwaiste Skripte (Bank $91/$92)

### 2.1 Text 1609: Ungenutzter englischer Dialog in Allelachema (Toter Verzweigungszweig)
* **Text-ID:** `1609` (`0x0649`)
* **SNES-Adresse:** `$97:B8C7` (in Enter-Skript von Map 10, Allelachema Markt)
* **Textinhalt:**  
  `[TypewriterOn]We've got to go to the city square.[Wait]That guy with the Diamond Eyes is probably placing them in the statue right now![Wait]`
* **Forensischer Nachweis der Unerreichbarkeit:**  
  Das Skript prüft an Adresse `$97:B8AE` folgende Bedingungen:
  1. Ist `FLAG[0x003D]` (Vigor besiegt / Hund wiedergefunden) noch nicht gesetzt, zeigt das Skript Text 1608 (*„Alle weg! Sicher hat die Kundgebung schon angefangen!“*) und führt unmittelbar `skip(+14)` aus – womit Text 1609 übersprungen wird.
  2. Ist `FLAG[0x003D]` bereits gesetzt, könnte theoretisch die zweite Verzweigung an `$97:B8BE` greifen (`if (!FLAG[0x040B])`). Jedoch wird dieser gesamte Block bei `$97:B89A` durch die Abfrage `if (!((FLAG[0x002B] && !FLAG[0x04B9]))) skip(+40)` geschützt. Da `FLAG[0x04B9]` bereits beim ersten Betreten des Gebiets permanent auf 1 gesetzt wird, ist `!FLAG[0x04B9]` stets falsch.
  *Ergebnis:* Der Sprung zu Text 1609 wird im realen Spielverlauf **niemals ausgeführt**. Der unübersetzte englische Satz ist toter Code.

### 2.2 Texte 646–656: Verwaiste Boss-Szene & Frühfassung „Feuerauge“
* **Verwaistes Skript:** `$95:B7E8` (Bank `$95`, Datei-Offset `0x15B7E8`)
* **Hintergrund:** Ein vollständig programmierter Dialogablauf vor dem Vulkan-Bosskampf (*Magmarock / Lavapiranya*), der im fertigen Spiel durch keinen Trigger aufgerufen wird.
* **Historischer Lokalisierungsbefund:** Hier wird Zora Zottelzopf noch wörtlich nach der US-Version (*Fire Eyes*) als **„Feuerauge“** bezeichnet – ein Beleg der allerersten Übersetzungsphase vor ihrer endgültigen Umbenennung.
* **Wortlaut der Sequenz:**
  * **ID 646:** `Hallo, Zwerg!`
  * **ID 647:** `Feuerauge?`
  * **ID 648:** `Hast Du gerufen?`
  * **ID 649:** `Hey Süße! Was willst Du hier?`
  * **ID 650:** `Wer bist denn Du?`
  * **ID 651:** `Rate mal? Ich bin Dein böses Ich! Und ich werde Dich vernichten! So heiß der Vulkan auch sein mag, die Außentemperatur wird sinken_ _weil ich die Hitzequelle ausschalten werde!`
  * **ID 652:** `Die Eiszeit wird kommen und mein Dorf wird sterben!`
  * **ID 653:** `Gut kombiniert, Hasenhirn!`
  * **ID 654:** `Dann werde ich mit meinen Echsen die Welt regieren!`
  * **ID 655:** `Ich würde mich gerne noch mit Dir unterhalten, Schätzchen, aber ich habe noch viel zu tun. Also, halte die Ohren steif! Du wirst jetzt verschwinden!`
  * **ID 656:** `Sag 'Hallo' zum Schmusetierchen!`

### 2.3 Texte 550–552: Verworfener Alchemist für „Säureregen“
* **Verwaistes Skript:** `$94:B240` (Bank `$94`, Datei-Offset `0x14B240`)
* **Hintergrund:** Früher Alchemisten-Dialog in der Prähistorie, der die Formel *Säureregen* sowie Starterzutaten vergab. Im fertigen Spiel wird die Formel an anderer Stelle überreicht; dieses Skript wurde abgekoppelt:
  * **ID 550:** `Du siehst irgendwie fertig aus! Wahrscheinlich machen Dir die Insekten da draußen zu schaffen.`
  * **ID 551:** `Das stimmt!` (Antwort des Jungen)
  * **ID 552:** `Hier hast Du etwas, das Dir helfen wird! Die Formel heißt Säureregen! 3 Tropfen Wasser und etwas Asche erzeugen einen ätzenden Säureregen.`

### 2.4 Texte 1945–1948: Verwaister Fallgruben-Zähler & Vierte-Wand-Bruch
* **Verwaistes Skript:** `$98:9296` (Bank `$98`, Datei-Offset `0x189296`)
* **Hintergrund:** Ein 4-stufiger Reaktions-Zähler für Stürze in Fallgruben über `TEMP[0x0005]`. Im fertigen Spiel setzen Gruben den Spieler direkt ohne Zähleraufruf zurück:
  * **1. Sturz (ID 1945):** `Fast hätten die Stacheln uns zermalmt. Glück gehabt!`
  * **2. Sturz (ID 1946):** `Cool, [Dog]! Unser Schwerkraftexperiment scheint gelungen zu sein.`
  * **3. Sturz (ID 1947):** `Wir sollten damit aufhören, ständig in Gruben zu stürzen!`
  * **12. Sturz (ID 1948 - Easter Egg):** `Ähm, sorry! Ja, Du bist gemeint! Du da draußen! Könntest Du bitte dafür sorgen, daß wir nicht andauernd abstürzen? Das wäre nett!`

### 2.5 Texte 2444–2449: Verworfene Raketenteile-Kombinationen bei Dr. Gallenstein
* **Verwaistes Skript:** `$9A:8B38` (Bank `$9A`, Datei-Offset `0x1A8B38`)
* **Hintergrund:** Gallenstein prüft in `$9A:8910` die drei Bauteile (*Ventil*, *Wagenrad*, *Diamantenaugen*). Die detaillierten Dialoge für jede unvollständige 2er- und 1er-Kombination blieben unaufgerufen:
  * **ID 2444:** `Jetzt fehlt mir nur noch ein Ventil, und die Sache ist perfekt.`
  * **ID 2445:** `Jetzt fehlt mir nur noch das Wagenrad, um meine Erfindung fertigzustellen.`
  * **ID 2446:** `Nun fehlen nur noch die Diamantenaugen, und die Erfindung ist fertig.`
  * **ID 2447:** `Nun fehlen nur noch die Diamantenaugen und das Wagenrad.`
  * **ID 2448:** `Nun fehlen nur noch die Diamantenaugen und das Ventil.`
  * **ID 2449:** `Nun fehlen nur noch das Wagenrad und das Ventil.`

### 2.6 Verwaiste Einzelzeilen & Warn-Fallen
* **ID 1633 (`$97:D270`):** `Warte, [Dog]!` (Verwaiste Hunde-Verfolgungssequenz in Antika).
* **ID 2041–2042 (`$99:8C70`):** Gruben-Warnungen in Gotika (`Hmmm_ Das sieht gefährlich aus. Ich bin besser vorsichtig.` / `Hey, [Dog]! Geh weg von dem Loch!`).
* **ID 2016 (`$98:BEA5`):** `Sollte nicht gesehen werden!` (Grenz-Assertion-Falle, deutsche Übersetzung von `should not see this`).
* **ID 1942 (`ScriptTable #2176`):** `should not see this` (Ungelöschte englische Assertion-Falle).
* **IDs 2486–2488 (Map 34 `$9A:921B`):** Step-On Trigger an den Kartenrändern des Schattenwald-Labyrinths:
  * `you shouldn't see this map 1 north`
  * `you shouldn't see this map 2 north`
  * `you shouldn't see this map 4 South`

---

## 3. Ungenutzte Fallbacks & fremdsprachige Relikte

Im universellen Item-Pickup-Handler (`$93:B114`) blieben englische und spanische Fallback-Texte zurück, die bei unbekannten Objekt-IDs aufgerufen werden:

| Text-ID | Hex-ID | Sprache | Textinhalt | Ursache / Funktion |
| :---: | :---: | :---: | :--- | :--- |
| **0000** | `0x0000` | Englisch | `gain item: unknown misc. item [Val2]` | Fallback für unbekanntes Verbrauchsitem. |
| **0001** | `0x0001` | Englisch | `gain item: unknown item [Val2]` | Fallback für unbekanntes Item. |
| **0003** | `0x0003` | Englisch | `gain item: unknown armor [Val2]` | Unreferenzierter Rüstungs-Fallback. |
| **0023** | `0x0017` | Spanisch | `Encontró unknown item [Val2]` | Spanisches Relikt bei gesetztem Flag `0x049B`. |
| **0068** | `0x0044` | Spanisch | `Encontró unknown ingredient [Val2]` | Spanisches Relikt für unbekannte Zutaten. |
| **0119** | `0x0077` | Englisch | `Received unknown item [Val2]` | Zweiter unübersetzter Item-Fallback. |
| **0183** | `0x00B7` | Englisch | `Received unknown armor [Val2]` | Zweiter unübersetzter Rüstungs-Fallback. |
| **0184** | `0x00B8` | Englisch | `Received unknown type of item [Val2]` | Unübersetzter Typ-Fallback. |
| **0216** | `0x00D8` | Spanisch | `No puedes llevar objetos desconocidos [Val2]` | Drittes spanisches Relikt (Inventar voll für unbekanntes Item). |

---

## 4. Verworfene Alchemie: Frühfassungen, Cut-Zauber & Testzauber (Bank $C5)

### 4.1 Vollständig verworfener Alchemie-Zauber („Doppelgänger-Fluch“)
* **SNES-Adresse:** `$C5:131C` (Datei-Offset `0x05131C`)
* **Deutscher Text:** `Ziel bekämpft seinen Doppelgänger.`
* **Befund:** Liegt im Textblock der Zauberbeschreibungen zwischen Zauber 31 (*Turboantrieb*) und Zauber 32 (*Bienenattacke*). Die Zeigertabelle bei `$C5:03B7` überspringt diesen Text vollständig (von `$C5:12DF` direkt auf `$C5:133F`). Der Zauber existiert fertig übersetzt, ist aber im Spiel nicht aktivierbar.

### 4.2 Verworfene frühe deutsche Formelnamen
In Bank `$C5` existieren frühe Übersetzungen von Claude M. Moyse, die vor Release ersetzt wurden (0 Referenzen in `$C5:036F`):

| SNES-Adresse | Datei-Offset | Verworfener Name im ROM | Finaler Ingame-Name | US-Originalname | Hintergrund |
| :---: | :---: | :--- | :--- | :--- | :--- |
| `$C5:0E60` | `0x050E60` | **`Kraftmeierei`** | **`Arnold`** | *Atlas* | Ursprünglich wörtlich übersetzt; später durch den Schwarzenegger-Gag *„Arnold“* ersetzt. |
| `$C5:0EB3` | `0x050EB3` | **`Lehmgranaten`** | **`Schlammbombe`** | *Hard Ball* | Frühere Übersetzung für die Lehm-Angriffsformel. |
| `$C5:0F1D` | `0x050F1D` | **`Zauberwand`** | **`Superschild`** | *Barrier* | Ursprünglicher Name für den Schutzschild. |
| `$C5:0F28` | `0x050F28` | **`Splitter`** | *(Verworfen)* | *Shrapnel* | Gestrichener Angriffszauber. |

### 4.3 Verworfene frühe Wirkungsbeschreibungen
Ebenso blieben alternative Übersetzungen der Formel-Erklärungen im ROM ungenutzt liegen (0 Referenzen in `$C5:03B7`):

| SNES-Adresse | Datei-Offset | Verworfener Text im ROM | Finaler Text im Spiel | Zugehöriger Zauber |
| :---: | :---: | :--- | :--- | :--- |
| `$C5:1140` | `0x051140` | `Hebt & bewegt schwere Gegenstände.` | `Räumt Felsen aus dem Weg.` | **Telekinese** (*Levitate*) |
| `$C5:11FE` | `0x0511FE` | `Ziel wird heftig vollgeschlammt.` | `Gegner werden vollgeschlammt.` | **Schlammbombe** (*Hard Ball*) |
| `$C5:1300` | `0x051300` | `Schützt vor Zaubersprüchen.` | `Reflektiert Zaubersprüche.` | **Zauberspiegel** (*Reflect*) |

### 4.4 Formel 20: Laserinferno
* **ROM-Formel-Record:** `$C5:0E86` (Offset `0x050E86`)
* **Beschreibungstext:** `$C5:1196` (*„Halbiert die KP des Gegners.“*)
* **Zutaten:** 1x Wachs (`$7E:22FF`), 2x Essig (`$7E:2302`)
* **Schadensroutine / Animation:** Eigener Partikeleffekt-Handler bei `$8C:A910`
* **Status:** Vollständig im ROM programmiert, wird jedoch von keinem Alchemisten im Spielverlauf vergeben.

### 4.5 Ungenutzte Entwickler-Testzauber (Bank $C5)
Fünf interne Testzauber der Square-Entwickler, die vor den finalen Formelnamen verankert sind (0 Referenzen in regulären Skripten):

| SNES-Adresse | Datei-Offset | Testzauber-String | Zweck / Entsprechung |
| :---: | :---: | :--- | :--- |
| `$C5:0CCE` | `0x050CCE` | `Magic: Orb3Missile` | Debug-Projektiltest für dreifache Orb-Partikel. |
| `$C5:0CE1` | `0x050CE1` | `Magic: Shak'em to DEATH!` | Erdbeben- und Rütteleffekt-Test. |
| `$C5:0CFA` | `0x050CFA` | `Magic: Beam me up Scotty` | Teleport-/Flucht-Testzauber (Star-Trek-Hommage). |
| `$C5:0D13` | `0x050D13` | `Magic: Thud Vortex` | Wirbelsturm- und Gravitationstest. |
| `$C5:0D26` | `0x050D26` | `Magic: High Voltage` | Blitz- und Elektroeffekt-Test. |

---

## 5. Verworfene Gegnernamen & Kampfmeldungen (Bank $C5)

* **Gegnername `Rotorschädel` (`$C5:15F4`):**  
  Liegt in Bank `$C5` unmittelbar zwischen *Flatterschädel* (`$C5:15E5`) und *Schädelgeier* (`$C5:1601`). Im Spiel wurden beide Gegnervarianten (IDs 52 und 104) als *Flatterschädel* benannt; *Rotorschädel* besitzt 0 Zeiger in der Tabelle bei `$8E:B678`.
* **Kampfmeldung `Vergiß es, Junge!` (`$C5:1F96`):**  
  Vollständig übersetzter Kampf-Popup-String (*„Forget it, kid!“*). War für Aktionen gedacht, bei denen Gegner gegen Angriffe des Jungen immun waren (0 Referenzen im Kampf-Renderer).
* **Entity-Platzhalter `Person` (`$C5:1575`):**  
  Unbenutzter generischer Name für namenlose NPCs.

---

## 6. Ungenutztes Entwickler-Debug-Menü (Bank $C5)

Zwischen `$C5:0BBE` und `$C5:0C96` liegt eine vollständige englische Debug-Menüleiste der Entwickler (0 Verweise in regulären Menüs):
1. `Debug: Show thud balls on path` (`$C5:0BBE`) – Wegpunkt-Kollisionstest
2. `Debug: Turn off both backgrounds` (`$C5:0BDD`) – Layer-Deaktivierung (nur Sprites sichtbar)
3. `Debug: Show background 1 only` (`$C5:0BFE`) – Isoliert Layer 1
4. `Debug: Show background 2 only` (`$C5:0C1C`) – Isoliert Layer 2
5. `Debug: Create a monster` (`$C5:0C57`) – Monster-Spawn-Menü
6. `Debug: Select map` (`$C5:0C6F`) – Map-Auswahl / Warp-Menü
7. `Debug: Mode 7 Flight` (`$C5:0C81`) – Sofortiger Modus-7 Flugmodus
8. `Debug: Heel` (`$C5:0C96`) – Hund sofort bei Fuß rufen
9. `ROM Creation Date` (`$C5:0D3A`) – Header für Build-Datumsanzeige

---

## 7. Interne Entwickler-Kartennamen (Bank $AD) & Engine-Strings (Bank $8C)

### 7.1 Interne englische Kartennamen (Bank `$AD` / Offset `0x2D8000`)
Tabelle mit 92 englischen Raumnamen, die für Debug-Builds und Levelauswahl verwendet wurden:

| Map-ID | Interner Name im ROM | Offizieller deutscher Spielname |
| :--- | :--- | :--- |
| `0x00` | `M.Brian's Test Ground` | Assitopia - Alarmraum |
| `0x02` | `M.1965 OUTSIDE MANSION` | Intro - Großostheim 1965 Villa Außenbereich |
| `0x03` | `M.1995 OUTSIDE MANSION` | Intro - Großostheim 1995 Villa Außenbereich |
| `0x09` | `M.AEGIS INTRO` | Antika - Allelachema Marktplatz (Aegis-Kampf) |
| `0x14` | `M.TOWER BASEMENT` | Gotika - Gallensteins Labor (Chaosturm) |
| `0x15` | `M.TEST MAP 1` | Unbenutzt / Dummy-Map |
| `0x18` | `M.BUG BOSS` | Prähistorie - Vulgors Herzkammer (Thraxx) |
| `0x19` | `M.CHESS BOARD` | Gotika - Schachbrett |
| `0x1A` | `M.CHESS DUNGEON` | Gotika - Schachbrett-Verlies (Fratzenwand) |
| `0x21` | `M.FOREST SAVE` | Gotika - Schattenwald Eingang (Speicherpunkt) |
| `0x2A` | `M.MINOTAUR BOSS` | Antika - Collosia Panzerminos-Raum (Megataur) |
| `0x30` | `M.PIRATE SHIP` | Antika - Krozkrübel Piratenschiff Innenraum |
| `0x31` | `M.1965 INSIDE MANSION` | Intro - Großostheim 1965 |
| `0x32` | `M.1995 THEATER` | Intro - Großostheim 1995 (Kino) |
| `0x48` | `M.SALABOSH BOSS` | Prähistorie - Magmarock-Höhle (Lavapiranya) |
| `0x51` | `M.VIPER BOSS` | Gotika - Chaosturm Vorraum (Schlangendrache) |
| `0x5E` | `M.WELL BOSS` | Gotika - Brunnen-Untergrund (Wasserdrache) |
| `0x60` | `M.FINAL BOSS` | Assitopia - Edgar Endkampf (Carltron) |
| `0x71` | `M.SEWER MAZE` | Gotika - Chaosturm Kanalisation Labyrinth |

### 7.2 Skript-Engine-Fehlermeldungen (Bank `$8C`)
| SNES-Adresse | Datei-Offset | ASCII-Inhalt | Funktion |
| :--- | :--- | :--- | :--- |
| `$8C:DDBE` | `0x0CDDBE` | `error: null life ptr used in script cmd` | Assertion im Entity-Lebenspunkte-Handler (Opcode `0x52` / `0x95`). |
| `$8C:8F14` | `0x0C8F14` | `HP: Attack: Defend: Hit %: Evade %: I can only talk about one life at a time!` | Debug-Monitor-Ausgabe für Entity-Statuswerte. |
| `$8C:A431` | `0x0CA431` | `player 3` | Überbleibsel des 3-Spieler-Codes aus der *Secret of Mana*-Enginebasis. |
| `$8C:A459` | `0x0CA459` | `player 4` | Überbleibsel des 4-Spieler-Multi-Tap-Codes. |

### 7.3 Build-Metadaten & Sound-Engine
* **Build-Zeitstempel (`$80:B75F`):** `11/22/95 9:35:11 AM` – Exakter Kompilierzeitpunkt des finalen deutschen PAL-ROM-Masters.
* **Audio-Engine (`$81:807E`):** `MK3  TEST ML` – Sound-Treiber-Identifikator aus der Sculptured Software / Williams Sound-Engine (stammt aus der *Mortal Kombat 3* SNES-Entwicklung).
