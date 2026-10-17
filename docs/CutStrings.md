# Cut Content & Forensischer Text-Audit (Secret of Evermore – Deutsche PAL-Version)

Dieses Dokument bietet eine lückenlose, forensische Gesamtanalyse aller **3.082 Texteinträge** sowie der internen Entwickler-Strings der deutschen Version von *Secret of Evermore* (`Secret of Evermore (Germany).sfc`, SHA-1 `5E5C2082526690D05F962C3FFBD7E080C681BFA4`).

Die Daten basieren auf einer vollständigen Call-Graph-Traversierung aller 128 Maps, 1.187 Step-On-Trigger, 1.065 B-Trigger, aller 2.344 Skript-Wurzeln der Pointertabelle `$93:8294`, der 16 Engine-Skripte in Bank `$9C` sowie der rekursiven Auflösung aller Verzweigungen (`Call`, `Fork`, `CallParams`, `ForkParams`, `CallRelative`, `CallTableByte`, `CallTableWord` und `AttachScript`).

---

## 1. Gesamtergebnis des Text-Audits (Alle 3.082 Texte)

Die Text-Pointertabelle liegt bei `$92:8000` bis `$92:A41B` (Datei-Offset `0x128000`). Jeder Eintrag ist ein 24-Bit-Zeiger in Bank `$91` bzw. `$92`. Die Skriptbefehle `0x50` (`ShowWindowText`), `0x51` (`ShowText`), `0x52` (`ShowTextEnd`) und `0x8C` (`ShowMessage`) übergeben als 16-Bit-Operand den Tabellen-Byteoffset (`3 * Text_ID`).

| Status | Anzahl Texte | Prozent | Beschreibung |
| :--- | :--- | :--- | :--- |
| **Aktiv im Spiel verwendet (USED)** | **2.424** | **78,65 %** | Nachweisbar durch Map-Enter-, Trigger-, Dialog- oder Zwischensequenz-Skripte aufgerufen. |
| **Genuin ungenutzt / Cut (UNREFERENCED)** | **658** | **21,35 %** | Von keinem regulären Skript aufgerufen (inkl. Item-Pickup-Slots, Credits-Rolls & Tauschwaren). |
| **Gesamt** | **3.082** | **100,00 %** | Vollständiger Textdatenbestand der deutschen Lokalisierung. |

### Zusammensetzung der 658 unreferenzierten Texteinträge
1. **Item-Pickup-Engine (IDs 0–270):** 1 unreferenzierter Slot (ID 3: `gain item: unknown armor [Val2]`), während 270 Slots aktiv durch das universelle Pickup-Skript `$93B114` bedient werden.
2. **Markt- und Tauschsystem (IDs 306–370):** 65 ungenutzte Textfragmente (Gegenstandsnamen und ungenutzte Hunde-Abweisungen).
3. **Echte verworfene Dialoge, Debug-Strings & Zensur-Reste:** 592 Texte, die von keinem Skript mehr referenziert werden.

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
| **2389** (`0x0955`) | `Bevor Du gehst, solltest Du mit Gallenstein sprechen. Sicher kann er Dir helfen.` | **USED** | Gotika - Chaosturm | `$99EF65` | Wächter-Hinweis im Chaosturm vor dem Aufbruch. |
| **2560** (`0x0A00`) | `Ich bin Rattus, der König der Ratten! Wer wagt es, mein Reich zu betreten?` | **USED** | Gotika - Chaosturm Thronsaal (Map 94) | `$9AEF4A` (Step-On Trigger) | Bosskampf-Einleitung gegen Rattus. |
| **2617** (`0x0A39`) | `Laß mich raten, Du bist eine Mischung aus Pudel und Schwein. Bist Du etwa ein Schwudel?` | **USED** | Gotika - Chaosturm / Rennbahn | `$9B9347` | Regulärer Zuschauerkommentar beim Schweinerennen. |
| **2620** (`0x0A3C`) | `Ich stehe auf Schweinereien! Deshalb gehe ich zum Schweinerennen.` | **USED** | Gotika - Chaosturm / Rennbahn | `$9B9347` | Regulärer Stadtbewohner-Dialog vor der Rennbahn. |
| **2783** (`0x0ADF`) | `Hm, ich glaube es wäre besser gewesen, wenn wir ein Schwein als Pudel verkleidet hätten.` | **USED** | Gotika - Terrorfels Planwagen (Innen) | `$9BAC11` (B-Trigger) | Witz des Jungen im Zigeunerwagen über die Schweinetarnung. |
| **2889** (`0x0B49`) | `DB: Access Code is [Val1],[Val2],[Val3].` | **USED** | Assitopia - Kontrollraum (Map 67) | `$9C8210` (B-Trigger) | Computerterminal-Untersuchung (Debug-String absichtlich als Konsolentext aktiv gelassen). |
| **2890** (`0x0B4A`) | `DB: Secret door code is [Val1],[Val2],[Val3].` | **USED** | Assitopia - Kontrollraum (Map 67) | `$9C8210` (B-Trigger) | Zweiter Code am selben Terminal. |
| **1609** (`0x0649`) | `We've got to go to the city square. That guy with the Diamond Eyes is probably placing them in the statue right now!` | **USED** | Antika - Allelachema Markt (Map 10) | `$97B636` (Map Enter Script) | **Aktiver Lokalisierungsfehler:** Komplett unübersetzter englischer Satz, der dem Spieler beim Betreten des Marktes regulär angezeigt wird! |
| **0023** (`0x0017`) | `Encontró unknown item [Val2]` | **USED** | Universelles Item-Skript | `$93B114` @ `$93B263` | **Aktives spanisches Relikt:** Wird getriggert, wenn ein unbekanntes Item aufgehoben wird und `FLAG[0x049B]` gesetzt ist. |
| **0068** (`0x0044`) | `Encontró unknown ingredient [Val2]` | **USED** | Universelles Item-Skript | `$93B114` @ `$93B4FC` | Zweites aktives spanisches Relikt für unbekannte Zutaten. |

---

## 3. Tatsächlich ungenutzte Texte & Debug-Relikte (Forensisch bestätigt)

Folgende Texte sind im ROM-Textblock komprimiert vorhanden, werden jedoch durch **keinen einzigen Skript-Aufruf** im gesamten Spiel erreicht:

### 3.1 Level-Grenz-Assertionen & Debug-Fallen
Diese Zeilen dienten den Spieletestern als sichtbare Alarme, falls der Spieler durch Clipping-Fehler über Map-Grenzen hinaus teleportiert wurde:

| Text-ID | SNES-Pointer / Offset | Originaler Textlaut im ROM | Zweck / Analyse |
| :--- | :--- | :--- | :--- |
| **1942** (`0x0796`) | `$91:D456` (`0x11D456`) | `should not see this` | Englische Level-Grenzfalle. |
| **2016** (`0x07E0`) | `$91:DC38` (`0x11DC38`) | `Sollte nicht gesehen werden!` | Deutsche Übersetzung der Grenzfalle. |
| **2486** (`0x09B6`) | `$92:918C` (`0x12918C`) | `you shouldn't see this map 1 north` | Bereichsfalle: Nördliche Kartengrenze Map 1. |
| **2487** (`0x09B7`) | `$92:91B0` (`0x1291B0`) | `you shouldn't see this map 2 north` | Bereichsfalle: Nördliche Kartengrenze Map 2. |
| **2488** (`0x09B8`) | `$92:91D4` (`0x1291D4`) | `you shouldn't see this map 4 South` | Bereichsfalle: Südliche Kartengrenze Map 4. |

### 3.2 Verworfener Vierte-Wand-Gag (Absturz-Witz)
| Text-ID | SNES-Pointer / Offset | Originaler Textlaut im ROM | Analyse |
| :--- | :--- | :--- | :--- |
| **1948** (`0x079C`) | `$91:D520` (`0x11D520`) | `[TypewriterOn]Ähm, sorry![Pause:30] Ja,[Pause:30] Du bist gemeint![Pause:30] Du da draußen![Pause:30] Könntest Du bitte dafür sorgen, daß wir nicht andauernd abstürzen?[Wait]` | Ein klassischer Claude-Moyse-Metascherz, in dem die Spielfigur den realen Spieler vor dem SNES anspricht und sich über Spielabstürze beschwert. Im finalen Skript nicht verknüpft. |

### 3.3 Verworfene NPC-Dialoge & Namensentwürfe
| Text-ID | SNES-Pointer / Offset | Originaler Textlaut im ROM | Analyse |
| :--- | :--- | :--- | :--- |
| **2309** (`0x0905`) | `$92:8D89` (`0x128D89`) | `[TypewriterOn]Großostheim? Was für ein seltsamer Name.[Wait]Ist Dir mein Name bekannt? Mein Name ist Snofla. Kennst Du mein...` | Wortspiel mit rückwärts gelesenem Namen (*Snofla* = Alfons). Der Bürger wundert sich über die Heimatstadt des Jungen. |
| **0003** (`0x0003`) | `$91:8054` (`0x118054`) | `gain item: unknown armor [Val2]` | Einziger ungenutzter Fallback-String der Item-Pickup-Tabelle (Rüstungs-Fallback). |

### 3.4 Unbenutzte Hunde-Abweisungen auf dem Markt (IDs 306–311)
Wenn der Spieler versucht, den Hund als aktiven Charakter an Marktständen ansprechen zu lassen, greift die Engine auf generische Blockaden zurück. Sechs speziell dafür geschriebene Texte blieben ungenutzt:
- **ID 306:** `Wir handeln nicht mit Tieren! Das ist unsere Firmenphilosophie!`
- **ID 307:** `Tut mir leid, Hundchen! Ich habe nichts, das Du gebrauchen könntest.`
- **ID 308:** `Hunde werden hier nicht bedient. Noch nicht einmal Schoßhunde!`
- **ID 309:** `Verschwinde hier! Du vertreibst meine Kunden.`
- **ID 310:** `Ich mache keine Geschäfte mit Hunden!`
- **ID 311:** `Ich handle nur mit Zweibeinern!`

### 3.5 Wüstenschiff „Nekrotour“ Ticker-Fragmente (IDs 1836–1910)
In den Textdaten ab ID 1836 befindet sich eine komplette, wortweise zerlegte Reiseprospekt-Fahrt für das Wüstenschiff:
> *„Willkommen an Bord des Wüstenschiffs Nekrotour. Das Schiff fährt nonstop nach Krozkrübel. Die lasterhafteste, verruchteste, verkommenste Stadt in dieser Gegend. Treffpunkt von Schurken und Gaunern. Während Deines Aufenthalts in Krozkrübel erwarten Dich Piraten, Diebe, Abenteurer und vieles mehr. Du wirst also viel Spaß und Freude haben! Zu Deiner Rechten befindet sich der Höhepunkt dieser Tour, eine originale Wüstenbuschformation. Diese Büsche findest Du nicht überall. Es sind die Rosen dieser vertrockneten Wüste. Vielen Dank für Deinen Besuch an Bord! Sei bitte vorsichtig beim Aussteigen, sonst verletzt Du Dich...“*

---

## 4. Verworfene Alchemie: Formel 20 (Laserinferno)

In der Alchemie-Zaubertabelle der deutschen ROM existiert eine vollständig programmierte, aber im regulären Spielverlauf nicht erhältliche 20. Alchemieformel:

- **Interner Name:** `Laserinferno` (in US-Version `Laser Inferno`)
- **ROM-Formel-Record:** Bank `$C5` bei `$C5:0E86` (Offset `0x050E86`)
- **Beschreibungstext:** `$C5:1196` (Offset `0x051196`)
- **Deutscher Beschreibungstext:** `Halbiert die KP des Gegners.`
- **Zutaten-Kombination:** 1x Wachs (`$7E:22FF`), 2x Essig (`$7E:2302`)
- **Schadensroutine / Animation:** Eigener Partikeleffekt-Handler bei `$8C:A910`
- **Ursache des Wegfalls:** Kein Alchemist im Spielverlauf besitzt den Code, um diese Formel zu lehren. Das Freischalt-Bitfield `$7E:225A` Bit 4 bleibt im regulären Spielverlauf immer 0.

---

## 5. Entwickler- & Engine-Strings außerhalb der Textbank

Im Binärcode des Interpreters (Bank `$8C`), der Sound-Engine und den Kartendefinitionen befinden sich interne ASCII-Strings, die von den US-Entwicklern (Square Soft Redmond) stammen:

### 5.1 Skript-Engine-Fehlermeldungen (Bank `$8C`)
| SNES-Adresse | Datei-Offset | ASCII-Inhalt | Funktion |
| :--- | :--- | :--- | :--- |
| `$8C:DDBE` | `0x0CDDBE` | `error: null life ptr used in script cmd` | Assertion im Entity-Lebenspunkte-Handler (Opcode `0x52` / `0x95`). |
| `$8C:8F14` | `0x0C8F14` | `HP: Attack: Defend: Hit %: Evade %: I can only talk about one life at a time!` | Debug-Monitor-Ausgabe für Entity-Statuswerte. |
| `$8C:A431` | `0x0CA431` | `player 3` | Überbleibsel des 3-Spieler-Codes aus der *Secret of Mana*-Enginebasis. |
| `$8C:A459` | `0x0CA459` | `player 4` | Überbleibsel des 4-Spieler-Multi-Tap-Codes. |

### 5.2 Interne Entwickler-Kartennamen (Bank `$AD` / Offset `0x2D8000`)
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

### 5.3 Build-Metadaten & Sound-Engine
- **Build-Zeitstempel (`$80:B75F`):** `11/22/95 9:35:11 AM` – Exakter Kompilierzeitpunkt des finalen deutschen PAL-ROM-Masters.
- **Audio-Engine (`$81:807E`):** `MK3  TEST ML` – Sound-Treiber-Identifikator aus der Sculptured Software / Williams Sound-Engine (stammt aus der *Mortal Kombat 3* SNES-Entwicklung).
