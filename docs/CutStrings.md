# Cut Content & Unbenutzte Texte (Secret of Evermore – Deutsche Version)

Dieses Dokument erfasst alle nicht im regulären Spielgeschehen verwendeten Texte, verworfenen Übersetzungsentwürfe, unübersetzten Fremdsprachenreste, Debug-Strings und internen Entwicklernotizen in der deutschen PAL-Version von *Secret of Evermore* (`Secret of Evermore (Germany).sfc`, SHA-1 `5E5C2082526690D05F962C3FFBD7E080C681BFA4`).

Die Daten basieren auf einem vollständigen Bit-für-Bit-Abgleich aller 3.082 komprimierten Dialog- und Texttabelleneinträge gegen sämtliche 2.778 Skripte und Trigger sowie auf Scans aller 48 ROM-Bänke (`$80` bis `$AF`).

---

## 1. Verworfene deutsche Übersetzungen & Lokalisierungs-Entwürfe

Die deutsche Übersetzung wurde 1995 unter der Leitung von Claude M. Moyse und Marcus Menold bei Nintendo of Europe in Großostheim angefertigt. In den Textdaten der ROM finden sich mehrere frühere Textfassungen, freche Entwürfe und verworfene Namensgebungen:

| Text-ID | SNES-Pointer / Offset | Originaler Textlaut im ROM | Analyse & Ursprünglicher Zweck |
| :--- | :--- | :--- | :--- |
| **3047** (`0x0BE7`) | `$92:A10A` (`0x12A10A`) | `Edgar hält sich in einem Raum im Zentrum von Assitopia auf. Du kannst ihn nur mit der Energieeinheit erreichen. Begib Dich...` | **Ursprünglicher Name von Omnitopia:** Claude Moyse benannte die Raumstation im ersten Entwurf salopp nach dem deutschen Umgangswort „Assi“ (*Assitopia*). Vor der Veröffentlichung wurde der Name im Spiel zu *Omnitopia* zensiert/angepasst; dieser String blieb als Relikt im Textblock erhalten. |
| **1069** (`0x042D`) | `$91:C2E4` (`0x11C2E4`) | `Ich bin Erwin, der Barbar. Ich bin stark, aber blöd!` | **Erwin (Tiny) Charakterisierung:** In der US-Version heißt der Muskelmann *Tiny*. In der deutschen Version wurde er *Erwin* getauft. Dieser selbstironische Satz wurde im finalen Skript nicht getriggert. |
| **1071** (`0x042F`) | `$91:C329` (`0x11C329`) | `Komisch, ich dachte immer, Barbaren haben andere Namen. 'Erwin' klingt ziemlich bescheuert!` | **Heldenkommentar zu „Erwin“:** Der Junge macht sich über den unpassenden deutschen Vornamen des Barbaren lustig. |
| **1986** (`0x07C2`) | `$91:D91F` (`0x11D91F`) | `Ich bin Erwin, der Papa_ äh, Barbar. Ich bin sehr stark.` | **Verhaspler-Entwurf:** Erwin verhaspelt sich („Papa“ statt „Barbar“). Eine verworfene Dialogvariante der Fluchtsequenz. |
| **1987** (`0x07C3`) | `$91:D952` (`0x11D952`) | `Ich bin stark, ich bin Erwin!` | Schnörkellose Alternativzeile für Erwins Krafteinsatz. |
| **2389** (`0x0955`) | `$92:8F62` (`0x128F62`) | `Bevor Du gehst, solltest Du mit Gallenstein sprechen. Sicher kann er Dir helfen.` | **Frühfassung von Dr. Gallenstein:** Älterer Textentwurf vor der finalen Version (`ID 2384` / `ID 2392`). Die finale Version ergänzte präzise: *„Er befindet sich im Raum östlich von hier / im Ostflügel.“* |
| **2617** (`0x0A39`) | `$92:955A` (`0x12955A`) | `Laß mich raten, Du bist eine Mischung aus Pudel und Schwein. Bist Du etwa ein Schwudel?` | **Wortschöpfung „Schwudel“:** Verworfenes Zuschauerzitat beim Schweinerennen in Gotika, wenn der Hund als Schwein verkleidet ist. |
| **2620** (`0x0A3C`) | `$92:95BC` (`0x1295BC`) | `Ich stehe auf Schweinereien! Deshalb gehe ich zum Schweinerennen.` | Zweideutiger Wortwitz für einen Stadtbewohner vor der Rennbahn. |
| **2783** (`0x0ADF`) | `$92:99E4` (`0x1299E4`) | `Hm, ich glaube es wäre besser gewesen, wenn wir ein Schwein als Pudel verkleidet hätten.` | Umkehr-Gag des Jungen über die missglückte Schweine-Tarnung des Hundes. |
| **2309** (`0x0905`) | `$92:8D89` (`0x128D89`) | `Großostheim? Was für ein seltsamer Name. Ist Dir mein Name bekannt? Mein Name ist Snofla. Kennst Du me...` | **Anspielung „Snofla“:** Vorwärts gelesen *Alfons*. Verworfenes NPC-Gespräch in Terrorfels über Heimatstädte. |

---

## 2. Vergessene Fremdsprachenreste (Englisch & Spanisch)

Bei der Lokalisierung blieben mehrere englische Originalzeilen sowie spanische Textfragmente unübersetzt im deutschen ROM-Abbild stehen:

| Text-ID | SNES-Pointer / Offset | Originaler Textlaut im ROM | Analyse & Ursache |
| :--- | :--- | :--- | :--- |
| **1609** (`0x0649`) | `$91:CF26` (`0x11CF26`) | `We've got to go to the city square. That guy with the Diamond Eyes is probably placing them in the statue right now!` | **Vollständig unübersetztes Englisch:** Dieser Dialog nach dem Diebstahl der Diamantenaugen in Antika wurde im deutschen Skript schlicht vergessen zu übersetzen. Im Spielverlauf wird stattdessen eine gekürzte Szene getriggert. |
| **0023** (`0x0017`) | `$91:806A` (`0x11806A`) | `Encontró unknown item [Val2]` | **Spanisches Relikt:** Ein versehentliches Copy-Paste-Überbleibsel aus der spanischen Lokalisierungsdatei direkt in die deutsche Item-Pickup-Tabelle. |
| **0068** (`0x0044`) | `$91:8150` (`0x118150`) | `Encontró unknown ingredient [Val2]` | Zweites spanisches Relikt für unbekannte Alchemiezutaten. |
| **0000** (`0x0000`) | `$91:8000` (`0x118000`) | `gain item: unknown misc. item [Val2]` | Interner englischer Fallback-String der Engine bei ungültigem Item-Typ. |
| **0001** (`0x0001`) | `$91:801E` (`0x11801E`) | `gain item: unknown item [Val2]` | Englischer Fallback-String bei undefinierter Verbrauchsgegenstands-ID. |
| **0002** (`0x0002`) | `$91:8037` (`0x118037`) | `gain item: unknown ingredient [Val2]` | Englischer Fallback-String bei ungültiger Zutaten-ID. |
| **0003** (`0x0003`) | `$91:8054` (`0x118054`) | `gain item: unknown armor [Val2]` | Englischer Fallback-String bei ungültiger Rüstungs-ID. |
| **0006** (`0x0006`) | `$91:8093` (`0x118093`) | `Found unknown misc. item [Val2]` | Englischer Text für Kistenfunde ohne zugeordnete ID. |
| **0119** (`0x0077`) | `$91:828C` (`0x11828C`) | `Received unknown item [Val2]` | Englischer Text für NSC-Geschenke ohne gültigen Datensatz. |

---

## 3. Entwickler-, Engine- & Debug-Texte

Im Maschinencode des Skript-Interpreters (Bank `$8C`) und in den Textdaten finden sich diverse Debugging-Meldungen:

| Adresse / ID | Datei-Offset | Textinhalt | Zweck / Kontext |
| :--- | :--- | :--- | :--- |
| **ID 2889** (`0x0B49`) | `0x129DC2` | `DB: Access Code is [Val1],[Val2],[Val3].` | **Omnitopia-Türcode Debugger:** Entwicklerausgabe (`DB:` = Debug), um während des Testens die prozedural generierten Codes für die Sicherheitstüren sofort anzuzeigen. |
| **ID 2890** (`0x0B4A`) | `0x129DED` | `DB: Secret door code is [Val1],[Val2],[Val3].` | Debug-Meldung für den Geheimtürcode in der Raumstation. |
| **ID 2486** (`0x09B6`) | `0x129210` | `you shouldn't see this map 1 north` | **Level-Boundary Assertions:** Fehlermeldung, falls der Spieler über den nördlichen Rand von Karte 1 läuft. |
| **ID 2487** (`0x09B7`) | `0x129232` | `you shouldn't see this map 2 north` | Rand-Fehlermeldung für Karte 2 Nord. |
| **ID 2488** (`0x09B8`) | `0x129254` | `you shouldn't see this map 4 South` | Rand-Fehlermeldung für Karte 4 Süd. |
| `$8C:DDBE` | `0x0CDDBE` | `error: null life ptr used in script cmd` | **SIGIL Interpreter Assertion:** Fehlermeldung im 65816-Code, wenn ein Skript-Opcode (z.B. Schaden/Status) auf einen Null-Zeiger im Entity-Array zugreift. |
| `$8C:8F14` | `0x0C8F14` | `HP: \x00Attack: \x00Defend: \x00Hit %: \x00Evade %: \x00I can only talk about one life at a time!` | **Entity-Stat-Inspektor:** Unbenutzte Entwickler-Routine, die im laufenden Betrieb Kampfeigenschaften einer anvisierten Entity auf dem Bildschirm ausgab. |
| `$8C:A431` | `0x0CA431` | `player 3` | **4-Spieler-Reste:** Fallback-Namen im Namensparser für Spieler 3 und Spieler 4 (aus frühen Prototyp-Phasen mit Multi-Tap-Unterstützung). |
| `$8C:A459` | `0x0CA459` | `player 4` | Fallback-Name für Spieler 4. |
| `$8E:96DA` | `0x0E96DA` | `No spells in library` | Debug-Hinweis, wenn das Ringmenü geöffnet wird, ohne dass Formeln freigeschaltet sind. |
| `$8F:DE9A` | `0x0FDE9A` | `Error: too many monster generators!` | Konsolen-Warnung der Spawner-Engine bei Überlauf der aktiven Monster-Generatoren auf der Karte. |

---

## 4. Verworfene Quests, Bosse & Spielmechaniken

Mehrere Texte belegen Quests und Bosse, die während der Entwicklung gestrichen wurden:

### A. Boss-Kampf: Rattus, der König der Ratten
* **Text-ID:** `2560` (`0x0A00`) – `$92:9405` (`0x129405`)
```text
Ich bin Rattus, der König der Ratten!
Ich besetze diese Burg im Namen aller pestverbreitenden Nager auf Erden_
Macht Euer Testament!
```
* **Kontext:** In der Kanalisation unter Schloss Gotika bzw. im Schacht bekämpft der Held eine Riesenratte. Im fertigen Spiel beginnt der Kampf ohne Dialog. Dieser Text war die originale, theatralische Kampfeinleitung von Boss *Rattus*.

### B. Die Brunnen-Rettungsquest in Gotika
* **Text-IDs:** `2494` (`0x09BE`), `2793` (`0x0AE9`), `2794` (`0x0AEA`)
```text
[ID 2494]: Hi! Hi! Hi! Deine Güte ist bewundernswert.
Mich aus dem Brunnen zu retten, war eine gute Tat.
Du hättest mich dort auch verenden lassen können.
Nimm dieses Geschenk als Zeichen meiner Anerkennung.

[ID 2793]: Jetzt ist klar, warum der Brunnen ausgetrocknet ist.
Diese Kreatur muß der Grund dafür gewesen sein!
Gut, daß Du sie vernichtet hast...

[ID 2794]: Wie bist Du eigentlich auf den Grund des Brunnens gekommen?
```
* **Kontext:** In Gotika war eine eigenständige Nebenaufgabe geplant: Der Stadtbrunnen war ausgetrocknet. Der Spieler sollte auf den Grund des Brunnens hinabsteigen, dort ein Bossmonster besiegen (in der internen Map-Liste als `M.WELL BOSS` vermerkt) und einen gefangenen Bewohner befreien. Im fertigen Spiel ist der Brunnen nur Kulisse.

### C. Durchbrechen der vierten Wand (Flugabsturz-Klage)
* **Text-ID:** `1948` (`0x079C`) – `$91:D863` (`0x11D863`)
```text
Ähm, sorry! Ja, Du bist gemeint! Du da draußen!
Könntest Du bitte dafür sorgen, daß wir nicht andauernd abstürzen?
Das wäre nett!
```
* **Kontext:** Ein humorvoller Monolog des Jungen, der sich bei wiederholten Bruchlandungen mit der Flugmaschine direkt an den Spieler vor dem Fernseher wendet.

### D. Unbenutzte Alchemie-Formel: Laserinferno (Laser)
* **Name im ROM:** `$C5:0E86` (`0x050E86`) -> `Laserinferno`
* **Beschreibung:** `$C5:1196` (`0x051196`) -> `Halbiert die KP des Gegners.`
* **Zutaten:** `$C5:06D5` -> 1x Wachs (`0x01`), 2x Essig (`0x02`), Kosten 40 Juwelen (`0x050216`).
* **Kontext:** Vollständig im Spielcode hinterlegte Formel 20 (nutzt Symbol `Levitate` und Animation `Säureregen`). Sie wird von keinem Alchemisten im Spiel gelehrt.

---

## 5. Deutsche Redaktions- und Popkultur-Gags (Moyse-Humor)

Das Übersetzungsteam baute zahlreiche Anspielungen auf die deutsche Medienlandschaft der 1990er Jahre ein, von denen einige im finalen Spielverlauf ungetriggert blieben:

| Text-ID | Textinhalt | Referenz & Hintergrund |
| :--- | :--- | :--- |
| **506** (`0x01FA`) | `Irgendwie hat mich der Zoowärter an Robbie von Fake That erinnert.` | **Take That / Robbie Williams:** Anspielung auf die damals populärste Boygroup *Take That* und Robbie Williams. |
| **2727** (`0x0AA7`) | `Ich habe gehört, daß hier Fake That ausgestellt werden.` | Zweite Erwähnung der Band *Fake That* als Kuriosität in der Freakshow. |
| **2230** (`0x08B6`) | `Warst Du schon in der Freakshow im Westen der Stadt? Die Show ist genial. Seit dem GWAR-Konzert das Beste, was ich bisher sah!` | **GWAR-Konzert:** Die US-Schock-Rockband *GWAR* war für ihre martialischen Monster-Kostüme und Kunstblut-Shows berühmt. |
| **2725** (`0x0AA5`) | `Hier sehen Sie mehr Freaks als beim Konzert der Nelly Family!` | **The Kelly Family:** Parodie auf die damals omnipräsente Folk-Pop-Familienband *The Kelly Family*. |
| **2324** (`0x0914`) | `Du hast unsere Stadt gerettet! Du bist ein toller Typ! Du solltest bei {Mann-O-Mann} mitspielen !` | **TV-Show Mann-o-Mann:** Sat.1-Flirtshow der 90er Jahre mit Peer Augustinski, bei der Männer in einen Swimmingpool gestoßen wurden. |
| **2631** (`0x0A47`) | `Hast Du die Freaks gesehen? Besser als die 'Volkstümliche Hitparade'!` | **Volkstümliche Hitparade:** Parodie auf die volkstümliche Musiksendung im ZDF mit Carolin Reiber. |
| **2811** (`0x0AFB`) | `Hallo! Ich bin Wolfi, der süßeste Boy in Terrorfels. Am liebsten spiele ich mit Puppen_` | **Wolfgang Ebert:** Selbstironischer Cameo-Gag auf Redakteur Wolfgang Ebert (*Club Nintendo* / Übersetzer). |
| **2826** (`0x0B0A`) | `Marc Nobelle soll die Burg eingerichtet haben. Überall diese edlen Seidenstoffe mit den Zeichnungen... Und Du solltest erst einmal die Toiletten im Ostflügel sehen. Selbst die Klobürsten haben ein fantastisches Design. Er ist begnadet! Ich muß ihm gratulieren!` | **Marc Nobelle & Klobürsten:** Hommage an den Square-Künstler Marc Nobelle, verbunden mit Moyses typischem Toiletten-Humor. |
| **2961** (`0x0B91`) | `Whoa! Das erinnert mich an den Monsterkampf in {Milchtütenmassaker}!` | Fiktiver B-Movie-Titel des Helden. |
| **3070** (`0x0BFE`) | `Was ist passiert? Du bist so metallisch! Du erinnerst mich an {Angriff der Riesentoaster}! Naja, wenigstens kann man Dich als Brotwärmer gebrauchen, wenn schon nicht als Wachhund!` | Anspielung auf US-Trash-Filme (*Attack of the Giant Toasters*). |
| **513** (`0x0201`) | `Ich frage mich, ob die Nähe zu Nintendo nicht doch meine Fantasie beflügelt hat.` | **Nintendo Großostheim:** Selbstreferenz auf die Europazentrale von Nintendo in Großostheim, wo der Junge wohnt. |
| **2213** (`0x08A5`) | `Großostheim! ... Klar, dort sitzt doch Nintendo!` | Direkte Bestätigung der Nintendo-Zentrale durch einen gotischen Bürger. |

---

## 6. Interne Entwickler-Kartenliste (Bank `$AD` / `$2D`)

Im ROM-Bereich ab Offset `0x2D8000` (`$AD:8000`) ist die unkomprimierte englische Master-Liste aller Raumnamen der Square-Entwickler hinterlegt. Viele davon tragen Arbeits- oder Entwicklernamen:

```text
M.ALARM ROOM
m.Alchemist Hut/Boss2
M.Alias Mansion b/w
M.Alias Mansion color
M.ANCIENT CLEARING
M.ANCIENT PATH 1 / 2
m.Ancient/City Square
m.Ancient/Dog Trans.
m.Ancient/Palace Ext.
m.Ancient/Town Interiors
M.Black Castle (DiningRm, Dog Maze, Glass Hall, Queen, Sewer, Tinkerer)
M.Brian's Test Ground       <-- Testraum benannt nach Lead Programmer Brian Fehdrau
M.Bug maze 1 / 2
M.CHESS BOARD / M.Chessboard Interior
M.coliseum gate / M.Colosseum Holds
m.Dark Forest (Clearing1, Clearing2, Entry, Maze)
M.Dark Greek 2 / M.Dark Greek Temple
M.FE VILLAGE / M.FE VILLAGE SECRET
M.Grave Yard 2
M.Greek Down / Main / Minotaur Room / Temple Exterior
M.Hermit Cave
M.HISTORIAN CAMP
M.IN THIEF TOWN
M.Junk Towers
m.Legend/lil Swamp Path
M.METRO CLIMATE CONTROL / Metro Control / Metro Greenhouse / Metro storage / Metro Tunnels
M.metro.JUNK YARD / M.Metroplex Final Arena
M.oglin cave / M.SMALL OGLIN CAVE
m.Pig Race-Bazaar
M.Pyramid 1 / 2 / base / boss
M.QSAND FIELD / FIELD LEDGE / PATH
M.Rat boss / Ratboss 2 / Ratboss dark / Ratboss extra
M.Side show / Side Show interior
M.Waterfall Candy           <-- Entwickler-Codename für Bonusraum hinter dem Wasserfall
M.WELL BOSS                 <-- Bestätigung des gestrichenen Brunnen-Bosses
M.White Castle (DiningRm, Dog Balcony, Dog Maze I/II/III, Dungeon, Puppet Show, Queen, Sewer)
```

---

## 7. Technische Build-Metadaten & Soundtreiber-Reste

Außerhalb des Textsystems befinden sich historische Entwicklungs-Artefakte im ROM:

* **Build-Zeitstempel der deutschen Version:**
  * **Adresse:** `$80:B75F` (`0x00B75F`)
  * **Inhalt:** `11/22/95 9:35:11 AM`
  * **Bedeutung:** Das finale ROM-Mastering der deutschen PAL-Fassung wurde exakt am **22. November 1995 um 09:35:11 Uhr** abgeschlossen.

* **Mortal Kombat 3 Test-Reste:**
  * **Adresse:** `$81:807E` (`0x01807E`)
  * **Inhalt:** `MK3  TEST ML`
  * **Bedeutung:** Das US-Entwicklerstudio *Sculptured Software* entwickelte zeitgleich die SNES-Portierung von *Mortal Kombat 3*. Beim Einbinden der gemeinsamen Sound- und Dekompressionstools verblieb der String `MK3  TEST ML` im Quelltext.

* **SPC700 Source-Code-Fragment:**
  * **Adresse:** `$81:9876` (`0x019876`)
  * **Inhalt:** `mov NextExStereoMod,A \x00 ret`
  * **Bedeutung:** Fragment von 65816-/SPC700-Assemblerquellcode, das beim Assemblieren versehentlich in den Binärpuffer des Audiotreibers geriet.
