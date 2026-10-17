# Cut Content & Forensischer Text-Audit (Secret of Evermore – Deutsche PAL-Version)

Dieses Dokument bietet eine lückenlose, forensische Gesamtanalyse aller **3.082 Texteinträge** der Text-Bank sowie aller internen Entwickler-Strings, ungenutzten Zauberformeln, verworfenen Übersetzungen und fremdsprachigen Relikte der deutschen Version von *Secret of Evermore* (`Secret of Evermore (Germany).sfc`, SHA-1 `5E5C2082526690D05F962C3FFBD7E080C681BFA4`).

Die Daten basieren auf einer vollständigen Call-Graph-Traversierung aller 128 Maps, 1.187 Step-On-Trigger, 1.065 B-Trigger, aller 2.344 Skript-Wurzeln der Pointertabelle `$93:8294`, der 16 Engine-Skripte in Bank `$9C` sowie der rekursiven Auflösung aller Verzweigungen (`Call`, `Fork`, `CallParams`, `ForkParams`, `CallRelative`, `CallTableByte`, `CallTableWord` und `AttachScript`).

---

## 1. Gesamtergebnis des Text-Audits (Alle 3.082 Texte)

Die Text-Pointertabelle liegt bei `$92:8000` bis `$92:A41B` (Datei-Offset `0x128000`). Jeder Eintrag ist ein 24-Bit-Zeiger in Bank `$91` bzw. `$92`. Die Skriptbefehle `0x50` (`ShowWindowText`), `0x51` (`ShowText`), `0x52` (`ShowTextEnd`) und `0x8C` (`ShowMessage`) übergeben als 16-Bit-Operand den Tabellen-Byteoffset (`3 * Text_ID`).

| Status | Anzahl Texte | Prozent | Beschreibung |
| :--- | :--- | :--- | :--- |
| **Aktiv im Spiel verwendet (USED)** | **3.053** | **99,06 %** | Nachweisbar durch Map-Enter-, Trigger-, Dialog- oder Zwischensequenz-Skripte aufgerufen. |
| **Genuin ungenutzt / Cut (UNREFERENCED)** | **29** | **0,94 %** | Von keinem aktiven Skript erreichbar (verwaiste Skripte, Zensurreste, frühe Namensfassungen & Debug-Fallen). |
| **Gesamt** | **3.082** | **100,00 %** | Vollständiger Textdatenbestand der deutschen Lokalisierung in Bank `$91`/`$92`. |

---

## 2. Richtigstellung: Populäre Mythen & regulär im Spiel vorkommende Texte

Frühere inoffizielle Übersichten behaupteten fälschlicherweise, etliche markante deutsche Texte seien „verworfen“ oder „vor Release zensiert“ worden. Der forensische ROM-Audit beweist das exakte Gegenteil: **Diese Texte kommen ganz normal im regulären Spielverlauf vor!**

| Text-ID | Textinhalt (Auszug) | Status | Map / Fundstelle | Skript-Adresse | Richtigstellung & Kontext |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **3047** (`0x0BE7`) | `Edgar hält sich in einem Raum im Zentrum von Assitopia auf. Du kannst ihn nur mit der Energieeinheit erreichen...` | **USED** | Global / Roboter vor Edgar | `$9CCEEE` (Tabelle #2342) | **Assitopia ist NICHT verworfen!** Es ist der offizielle deutsche Name für Omnitopia. Er wird sowohl in Map-Headern (z.B. Map 0x00, 0x43) als auch in Dialogen regulär verwendet. |
| **506** (`0x01FA`) | `Irgendwie hat mich der Zoowärter an Robbie von Fake That erinnert...` | **USED** | Intro - Großostheim 1995 (Kino) | `$93EB8A` (via Map 32 `$9480A2`) | **Prolog-Zwischensequenz:** Läuft in den ersten 2 Minuten des Spiels beim Verlassen des Kinos über den Bildschirm! |
| **503–505** | `Ein cooler Film! ... Kampf zwischen dem Schleimmonster und dem buckeligen Zoowärter.` | **USED** | Intro - Großostheim 1995 (Kino) | `$93EB8A` | Gehört zur selben aktiven Prolog-Sequenz wie ID 506. |
| **509–513** | `Wow! Das kam gut! ... Großostheim! Es hat sich nichts verändert... Nähe zu Nintendo...` | **USED** | Epilog - Großostheim 1995 (Kino) | `$93ED08` (via Map 32 `$94809E`) | **Epilog-Zwischensequenz:** Vollständige Rückkehr-Szene am Spielende. |
| **1069** (`0x042D`) | `Ich bin Erwin, der Barbar. Ich bin stark, aber blöd!` | **USED** | Antika - Allelachema Markt | `$96CA56` | Regulärer NSC-Dialog bei der Begegnung mit Erwin (Tiny). |
| **1071** (`0x042F`) | `Komisch, ich dachte immer, Barbaren haben andere Namen. 'Erwin' klingt ziemlich bescheuert!` | **USED** | Antika - Allelachema Markt | `$96CA56` | Helden-Kommentar direkt anschließend an ID 1069. |
| **1986** (`0x07C2`) | `Ich bin Erwin, der Papa_ äh, Barbar. Ich bin sehr stark.` | **USED** | Gotika - Chaosturm Flucht | `$98B551` | Erwins Verhaspler-Dialog während der Fluchtsequenz. |
| **1987** (`0x07C3`) | `Ich bin stark, ich bin Erwin!` | **USED** | Gotika - Chaosturm Flucht | `$98B551` | Direkter Folgetext zu ID 1986. |
| **2307–2320** | `Großostheim? Was für ein seltsamer Name. Ist Dir mein Name bekannt? Mein Name ist Snofla... Alfons... Gorilla...` | **USED** | Gotika - Terrorfels Innenräume (Rüstungsshop) | `$99DACA` (B-Trigger) | **Vollständig spielbar:** Kompletter Snofla-Dialogbaum in Terrorfels inklusive Rüstungsrabatt! |
| **2389** (`0x0955`) | `Bevor Du gehst, solltest Du mit Gallenstein sprechen. Sicher kann er Dir helfen.` | **USED** | Gotika - Chaosturm | `$99EF65` | Wächter-Hinweis im Chaosturm vor dem Aufbruch. |
| **2560** (`0x0A00`) | `Ich bin Rattus, der König der Ratten! Wer wagt es, mein Reich zu betreten?` | **USED** | Gotika - Chaosturm Thronsaal (Map 94) | `$9AEF4A` (Step-On Trigger) | Bosskampf-Einleitung gegen Rattus. |
| **2571–2598** | `{Schwein gehabt oder nicht} von Willy Biershake ... ES WAR EINMAL EIN ALTES SCHLOSS UND KUNIBERT SO HIESS DER BOSS...` | **USED** | Gotika - Puppentheater Terrorfels (Map 0x77) | `$9B8870` | **Bühnenstück aufgeführt:** Die Puppen auf der Bühne führen das 28-zeilige Shakespeare-Parodiestück regulär auf! |
| **2617** (`0x0A39`) | `Laß mich raten, Du bist eine Mischung aus Pudel und Schwein. Bist Du etwa ein Schwudel?` | **USED** | Gotika - Chaosturm / Rennbahn | `$9B9347` | Regulärer Zuschauerkommentar beim Schweinerennen. |
| **2620** (`0x0A3C`) | `Ich stehe auf Schweinereien! Deshalb gehe ich zum Schweinerennen.` | **USED** | Gotika - Chaosturm / Rennbahn | `$9B9347` | Regulärer Stadtbewohner-Dialog vor der Rennbahn. |
| **2783** (`0x0ADF`) | `Hm, ich glaube es wäre besser gewesen, wenn wir ein Schwein als Pudel verkleidet hätten.` | **USED** | Gotika - Terrorfels Planwagen (Innen) | `$9BAC11` (B-Trigger) | Witz des Jungen im Zigeunerwagen über die Schweinetarnung. |
| **2889** (`0x0B49`) | `DB: Access Code is [Val1],[Val2],[Val3].` | **USED** | Assitopia - Kontrollraum (Map 67) | `$9C8210` (B-Trigger) | Computerterminal-Untersuchung (Debug-String absichtlich als Konsolentext aktiv gelassen). |
| **2890** (`0x0B4A`) | `DB: Secret door code is [Val1],[Val2],[Val3].` | **USED** | Assitopia - Kontrollraum (Map 67) | `$9C8210` (B-Trigger) | Zweiter Code am selben Terminal. |
| **1836–1910** | `Willkommen an Bord des Wüstenschiffs Nekrotour. Das Schiff fährt nonstop nach Krozkrübel...` | **USED** | Antika - Schädelwüste (Map 0x1B) | `$988000` (Step-On Trigger) | **Wortweiser Ticker:** Läuft während der Wüstenfahrt Wort für Wort getimt über das Textfenster! |
| **1609** (`0x0649`) | `We've got to go to the city square. That guy with the Diamond Eyes is probably placing them in the statue right now!` | **USED** | Antika - Allelachema Markt (Map 10) | `$97B636` (Map Enter Script) | **Aktiver Lokalisierungsfehler:** Komplett unübersetzter englischer Satz, der dem Spieler beim Betreten des Marktes regulär angezeigt wird! |

---

## 3. Die 29 tatsächlich ungenutzten Texte & verwaisten Skripte (Bank $91/$92)

Im gesamten ROM-Textbestand der Text-Bank sind exakt **29 Texte** von keinem aktiven Map- oder Spiel-Skript erreichbar. Diese 29 Texte verteilen sich auf verwaiste Skriptroutinen (*Dead Code*), verworfene Frühfassungen von Übersetzungen und Test-Fallen:

### 3.1 Verworfene Boss-Szene & Frühfassung „Feuerauge“ (Text-IDs 646–656)
* **Verwaistes Skript:** `$95B7E8` (in Bank `$95`, Datei-Offset `0x15B7E8`)
* **Hintergrund:** Ein vollständig programmierter, aber im fertigen Spiel unaufgerufener Dialogablauf vor dem Vulkan-Bosskampf (*Magmarock / Lavapiranya*). 
* **Besonderheit Lokalisierung:** Hier wird Zora Zottelzopf noch wörtlich nach der englischen Fassung als **„Feuerauge“** (*Fire Eyes*) bezeichnet – ein einmaliges Dokument der frühesten Übersetzungsphase vor ihrer Umbenennung!
* **Textlaut der Sequenz:**
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

### 3.2 Verworfener Alchemist für „Säureregen“ (Text-IDs 550–552)
* **Verwaistes Skript:** `$94B240` (in Bank `$94`, Datei-Offset `0x14B240`)
* **Hintergrund:** Ein früher Alchemisten-Dialog in der Prähistorie, der die Formel *Säureregen* sowie Starterzutaten vergab. Im fertigen Spiel wird die Formel an anderer Stelle überreicht.
  * **ID 550:** `Du siehst irgendwie fertig aus! Wahrscheinlich machen Dir die Insekten da draußen zu schaffen.`
  * **ID 551:** `Das stimmt!` (Antwort des Jungen)
  * **ID 552:** `Hier hast Du etwas, das Dir helfen wird! Die Formel heißt Säureregen! 3 Tropfen Wasser und etwas Asche erzeugen einen ätzenden Säureregen.`

### 3.3 Verwaister Fallgruben-Zähler & Vierte-Wand-Gag (Text-IDs 1945–1948)
* **Verwaistes Skript:** `$989296` (in Bank `$98`, Datei-Offset `0x189296`)
* **Hintergrund:** Ein 4-stufiger Reaktions-Zähler für Stürze in Gruben und Stachelfallen über `TEMP[0x0005]`:
  * **1. Sturz (ID 1945):** `Fast hätten die Stacheln uns zermalmt. Glück gehabt!`
  * **2. Sturz (ID 1946):** `Cool, [Dog]! Unser Schwerkraftexperiment scheint gelungen zu sein.`
  * **3. Sturz (ID 1947):** `Wir sollten damit aufhören, ständig in Gruben zu stürzen!`
  * **12. Sturz (ID 1948 - Easter Egg):** `Ähm, sorry! Ja, Du bist gemeint! Du da draußen! Könntest Du bitte dafür sorgen, daß wir nicht andauernd abstürzen? Das wäre nett!`
  *(Im finalen Spiel teleportieren Fallgruben den Spieler direkt ohne Zähleraufruf, wodurch dieser Zähler ungenutzt blieb).*

### 3.4 Verworfene Raketenteile-Kombinationen bei Dr. Gallenstein (Text-IDs 2444–2449)
* **Verwaistes Skript:** `$9A8B38` (in Bank `$9A`, Datei-Offset `0x1A8B38`)
* **Hintergrund:** Gallenstein zählte in `$9A8910` die drei Bauteile (*Ventil*, *Wagenrad*, *Diamantenaugen*). Die detaillierten Dialoge für jede unvollständige 2er- und 1er-Kombination blieben unaufgerufen:
  * **ID 2444:** `Jetzt fehlt mir nur noch ein Ventil, und die Sache ist perfekt.`
  * **ID 2445:** `Jetzt fehlt mir nur noch das Wagenrad, um meine Erfindung fertigzustellen.`
  * **ID 2446:** `Nun fehlen nur noch die Diamantenaugen, und die Erfindung ist fertig.`
  * **ID 2447:** `Nun fehlen nur noch die Diamantenaugen und das Wagenrad.`
  * **ID 2448:** `Nun fehlen nur noch die Diamantenaugen und das Ventil.`
  * **ID 2449:** `Nun fehlen nur noch das Wagenrad und das Ventil.`

### 3.5 Verwaiste Warnungen & Assertion-Fallen (Text-IDs 1633, 2016, 2041, 2042, 3)
* **ID 1633 (`$97D270`):** `Warte, [Dog]!` (Verwaiste Hunde-Verfolgungssequenz in Antika).
* **ID 2016 (`$98BEA5`):** `Sollte nicht gesehen werden!` (Grenz-Assertion-Falle).
* **ID 2041–2042 (`$998C70`):** Gruben-Warnungen in Gotika (`Hmmm_ Das sieht gefährlich aus. Ich bin besser vorsichtig.` / `Hey, [Dog]! Geh weg von dem Loch!`).
* **ID 3 (`$91:8054`):** `gain item: unknown armor [Val2]` (Einziger ungenutzter Fallback-String der universellen Item-Tabelle).

---

## 4. Verworfene Alchemie: Frühfassungen, Cut-Zauber & Testzauber (Bank $C5)

Neben den Dialogtexten enthält die System- und Zauberbank `$C5` eine Reihe spektakulärer, bisher undokumentierter verworfener Lokalisierungen und Entwickler-Reste:

### 4.1 Vollständig verworfener Alchemie-Zauber („Doppelgänger-Kampf“)
* **SNES-Adresse:** `$C5:131C` (Datei-Offset `0x05131C`)
* **Deutscher Text:** `Ziel bekämpft seinen Doppelgänger.`
* **Kontext:** Dieser Zauberbeschreibungstext liegt direkt im Textblock der Formelbeschreibungen zwischen Zauber 31 (*Turboantrieb*) und Zauber 32 (*Bienenattacke*). Er wurde von der Zeigertabelle bei `$C5:03B7` übersprungen und existiert fertig übersetzt, aber unreferenziert im ROM!
* **Wirkung:** Entspricht einem Verwirrungs- oder Klon-Zauber, bei dem das gegnerische Ziel gegen ein Duplikat seiner selbst kämpfen sollte.

### 4.2 Verworfene frühe deutsche Zaubernamen
In Bank `$C5` blieben frühe deutsche Übersetzungsfassungen erhalten, die vor dem finalen Text-Lock durch andere Namen ersetzt wurden:

| SNES-Adresse | Datei-Offset | Verworfener deutscher Name | Finaler Ingame-Name | US-Originalname | Rationale / Anmerkung |
| :---: | :---: | :--- | :--- | :--- | :--- |
| `$C5:0E60` | `0x050E60` | **`Kraftmeierei`** | **`Arnold`** | *Atlas* | Die wörtliche Übersetzung *Kraftmeierei* wurde zugunsten des Popkultur-Gags *„Arnold“* (Arnold Schwarzenegger) verworfen. |
| `$C5:0EB3` | `0x050EB3` | **`Lehmgranaten`** | **`Schlammbombe`** | *Hard Ball* | Frühere Übersetzung für die Lehm-Angriffsformel. |
| `$C5:0F1D` | `0x0F1D` | **`Zauberwand`** | **`Superschild`** | *Barrier* | Ursprünglicher Name für die Schutzbarriere. |
| `$C5:0F28` | `0x0F28` | **`Splitter`** | *(Verworfen)* | *Shrapnel* | Überbleibsel eines experimentellen Schadenszaubers. |

### 4.3 Verworfene frühe deutsche Wirkungsbeschreibungen
Ebenso blieben alternative Übersetzungen der Formel-Erklärungen im ROM unreferenziert liegen:

| SNES-Adresse | Datei-Offset | Verworfener Text im ROM | Finaler Text im Spiel | Zugehöriger Zauber |
| :---: | :---: | :--- | :--- | :--- |
| `$C5:1140` | `0x051140` | `Hebt & bewegt schwere Gegenstände.` | `Räumt Felsen aus dem Weg.` | **Telekinese** (*Levitate*) |
| `$C5:11FE` | `0x0511FE` | `Ziel wird heftig vollgeschlammt.` | `Gegner werden vollgeschlammt.` | **Schlammbombe** (*Hard Ball*) |
| `$C5:1300` | `0x051300` | `Schützt vor Zaubersprüchen.` | `Reflektiert Zaubersprüche.` | **Zauberspiegel** (*Reflect*) |

### 4.4 Formel 20 (Laserinferno)
* **ROM-Formel-Record:** Bank `$C5` bei `$C5:0E86` (Offset `0x050E86`)
* **Beschreibungstext:** `$C5:1196` (Offset `0x051196`)
* **Deutscher Beschreibungstext:** `Halbiert die KP des Gegners.`
* **Zutaten-Kombination:** 1x Wachs (`$7E:22FF`), 2x Essig (`$7E:2302`)
* **Schadensroutine / Animation:** Eigener Partikeleffekt-Handler bei `$8C:A910`
* **Ursache des Wegfalls:** Vollständig programmiert, aber kein Alchemist vergibt sie im Spielverlauf.

### 4.5 Testzauber der US-Entwickler (Bank $C5)
Direkt vor den Zaubernamen hinterließ das Square-Entwicklerteam 5 interne Testzauber-Bezeichnungen:

| SNES-Adresse | Datei-Offset | Testzauber-String | Zweck / Entsprechung |
| :---: | :---: | :--- | :--- |
| `$C5:0CCE` | `0x050CCE` | `Magic: Orb3Missile` | Debug-Projektiltest für dreifache Orb-Partikel. |
| `$C5:0CE1` | `0x050CE1` | `Magic: Shak'em to DEATH!` | Erdbeben-/Schüttel-Effekttest. |
| `$C5:0CFA` | `0x050CFA` | `Magic: Beam me up Scotty` | Teleport-/Flucht-Testzauber (Star Trek Referenz). |
| `$C5:0D13` | `0x050D13` | `Magic: Thud Vortex` | Wirbelsturm- und Schwerkrafttest. |
| `$C5:0D26` | `0x050D26` | `Magic: High Voltage` | Blitz-/Elektroeffekttest (Vorläufer von Hagelsturm/Stromschock). |

---

## 5. Verworfene Gegnernamen, Status- & Kampfmeldungen (Bank $C5)

In Bank `$C5` existieren weitere isolierte, ungenutzte deutsche Begriffe:

* **Verworfener Gegnername `Rotorschädel` (`$C5:15F4`):**  
  Liegt in der Namensliste unmittelbar zwischen *Flatterschädel* (`$C5:15E5`) und *Schädelgeier* (`$C5:1601`). Für die fertige deutsche Fassung wurden beide Ausprägungen des Gegners einheitlich als *Flatterschädel* benannt; der Name *Rotorschädel* blieb unreferenziert im ROM zurück.
* **Verworfene Kampfmeldung `Vergiß es, Junge!` (`$C5:1F96`):**  
  Ein vollständig übersetzter deutscher Kampf-Popup-String (*„Forget it, kid!“*). War für Aktionen gedacht, bei denen der Gegner immun gegen physische oder magische Angriffe des Jungen war.
* **Generischer Entity-Name `Person` (`$C5:1575`):**  
  Unbenutzter Platzhaltername für namenlose NSCs.

---

## 6. Fremdsprachige Relikte & Grenz-Strings im deutschen ROM

Bei der Lokalisierung blieben nicht nur deutsche Frühfassungen ungenutzt, sondern auch spanische und englische Fragmente aktiv im Code bzw. unübersetzt zurück:

### 6.1 Die drei spanischen Relikte (Item-Pickup-Handler `$93:B114`)
Das universelle Item-Skript `$93:B114` enthält drei Textaufrufe, die versehentlich aus der spanischen Code-Basis übernommen wurden:

| Text-ID | Hex-ID | Textinhalt | Aufrufstelle | Auslöser |
| :---: | :---: | :--- | :---: | :--- |
| **0023** | `0x0017` | `Encontró unknown item [Val2]` | `$93:B263` | Fallback bei unbekanntem Item-Typ und gesetztem Flag `0x049B`. |
| **0068** | `0x0044` | `Encontró unknown ingredient [Val2]` | `$93:B4FC` | Fallback bei unbekannter Zutat und gesetztem Flag `0x049B`. |
| **0216** | `0x00D8` | `No puedes llevar objetos desconocidos [Val2]` | `$93:BE8D` | Meldung bei vollem Inventar für einen unbekannten Gegenstand. |

### 6.2 Englische Grenz- und Debug-Assertionen
Entwickler-Meldungen, die in aktiven Skripten verblieben:
* **Text 1609 (`$97B636`):** `We've got to go to the city square. That guy with the Diamond Eyes is probably placing them in the statue right now!` (Aktiv beim Betreten des Marktes von Allelachema).
* **Text 1942 (`ScriptTable #2176`):** `should not see this` (Fallen-Assertion).
* **Texte 2486–2488 (Map 34 `$9A921B`):** Step-On Trigger an den Ausgängen des Schattenwald-Labyrinths:
  * `you shouldn't see this map 1 north`
  * `you shouldn't see this map 2 north`
  * `you shouldn't see this map 4 South`
* **Text 2016 (`$98BEA5`):** `Sollte nicht gesehen werden!` (Die deutsche Übersetzung derselben Grenz-Assertion).

---

## 7. Ungenutztes US-Entwickler-Debug-Menü (Bank $C5)

Zwischen `$C5:0BBE` und `$C5:0C96` befindet sich ein vollständig ungenutztes englisches Debug-Menü der Square-Programmierer:

| SNES-Adresse | Datei-Offset | Menü-String | Funktion im Debug-Build |
| :---: | :---: | :--- | :--- |
| `$C5:0BBE` | `0x050BBE` | `Debug: Show thud balls on path` | Zeigt Kollisions- und Pfad-Wegpunkte an. |
| `$C5:0BDD` | `0x050BDD` | `Debug: Turn off both backgrounds` | Schaltet BG1 und BG2 ab (nur Sprites sichtbar). |
| `$C5:0BFE` | `0x050BFE` | `Debug: Show background 1 only` | Isoliert Hintergrund-Layer 1. |
| `$C5:0C1C` | `0x050C1C` | `Debug: Show background 2 only` | Isoliert Hintergrund-Layer 2. |
| `$C5:0C57` | `0x050C57` | `Debug: Create a monster` | Monster-Spawner / Entity-Testmenü. |
| `$C5:0C6F` | `0x050C6F` | `Debug: Select map` | Level-/Raum-Auswahlmenü (Warp). |
| `$C5:0C81` | `0x050C81` | `Debug: Mode 7 Flight` | Sofortiger Flugmodus mit Flugsaurier / Gleiter. |
| `$C5:0C96` | `0x050C96` | `Debug: Heel` | Zwingt den Hund, sofort bei Fuß zu gehen. |
| `$C5:0D3A` | `0x050D3A` | `ROM Creation Date` | Header für das Anzeige-Overlay des Build-Datums. |

---

## 8. Entwickler- & Engine-Strings außerhalb der Textbank

Im Binärcode des Interpreters (Bank `$8C`), der Sound-Engine und den Kartendefinitionen befinden sich weitere interne ASCII-Strings:

### 8.1 Skript-Engine-Fehlermeldungen (Bank `$8C`)
| SNES-Adresse | Datei-Offset | ASCII-Inhalt | Funktion |
| :--- | :--- | :--- | :--- |
| `$8C:DDBE` | `0x0CDDBE` | `error: null life ptr used in script cmd` | Assertion im Entity-Lebenspunkte-Handler (Opcode `0x52` / `0x95`). |
| `$8C:8F14` | `0x0C8F14` | `HP: Attack: Defend: Hit %: Evade %: I can only talk about one life at a time!` | Debug-Monitor-Ausgabe für Entity-Statuswerte. |
| `$8C:A431` | `0x0CA431` | `player 3` | Überbleibsel des 3-Spieler-Codes aus der *Secret of Mana*-Enginebasis. |
| `$8C:A459` | `0x0CA459` | `player 4` | Überbleibsel des 4-Spieler-Multi-Tap-Codes. |

### 8.2 Interne Entwickler-Kartennamen (Bank `$AD` / Offset `0x2D8000`)
Die Entwickler führten in Bank `$AD` eine interne Tabelle mit 92 englischen Kartennamen, die für Debug-Builds und Level-Auswahlmenüs genutzt wurden:

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

### 8.3 Build-Metadaten & Sound-Engine
* **Build-Zeitstempel (`$80:B75F`):** `11/22/95 9:35:11 AM` – Exakter Kompilierzeitpunkt des finalen deutschen PAL-ROM-Masters.
* **Audio-Engine (`$81:807E`):** `MK3  TEST ML` – Sound-Treiber-Identifikator aus der Sculptured Software / Williams Sound-Engine (stammt aus der *Mortal Kombat 3* SNES-Entwicklung).
