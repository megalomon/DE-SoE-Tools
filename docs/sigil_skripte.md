# SIGIL Script-Engine & Bytecode-Referenz (Secret of Evermore – Deutsche PAL ROM)

Die Skripte in *Secret of Evermore* werden von einer virtuellen Bytecode-Maschine namens **SIGIL** (Square Inter-Game Interface Language) interpretiert. Diese Dokumentation beschreibt die vollständige Architektur der virtuellen Maschine, den Task-Scheduler für kooperatives Multitasking, den 195-Opcode-Befehlssatz, das **Sub-Opcode-Ausdrucks- & Hardware-Stack-System**, die 15-Bit-gepackte Bank-Adressierung, Text-Steuerzeichen sowie die Einbindung in das Map- und Trigger-System der **deutschen Version** (`Secret of Evermore (Germany).sfc`).

---

## 1. Engine-Architektur & Virtual Machine

Im 65816-Binärcode der deutschen PAL-Version befindet sich der SIGIL-Interpreter vollständig in Bank `$8C`:

- **Befehls-Dispatcher (`$8C:D480`):**  
  Liest den aktuellen Opcode über den 24-Bit Skript-Befehlszähler `[$82]`, inkrementiert den Zeiger, multipliziert das Byte mit 2 und springt indirekt über die Opcode-Sprungtabelle:
  ```65816
  8C:D48A: B9 00 00     LDA $0000, Y    ; 24-Bit Skriptzeiger aus aktuellem Task laden
  8C:D48D: 85 82        STA $82         ; DP $82/$83 = Byte 0 & 1
  8C:D48F: B9 01 00     LDA $0001, Y
  8C:D492: 85 83        STA $83         ; DP $83/$84 = Byte 1 & 2
  8C:D494: A7 82        LDA [$82]       ; Opcode-Byte aus Skript-ROM laden
  8C:D496: E6 82        INC $82         ; Program Counter inkrementieren
  8C:D498: 29 FF 00     AND #$00FF      ; Auf 8-Bit Opcode maskieren
  8C:D49B: 0A           ASL A           ; Opcode * 2 (16-Bit Tabellen-Offset)
  8C:D49C: AA           TAX
  8C:D49D: FC BE EC     JSR ($ECBE, X)  ; Ausführung via Sprungtabelle $8C:ECBE
  8C:D4A0: B0 F2        BCS $D494       ; Carry gesetzt: Nächsten Befehl im selben Frame ausführen!
  ```
- **Das Carry-Flag-Ausführungsprotokoll:**  
  - Ist nach der Befehlsausführung das **Carry-Flag gesetzt (`SEC`)**, bleibt der Interpreter in der Schleife und führt den nächsten Bytecode-Befehl ohne Verzögerung im selben Video-Frame aus.
  - Ist das **Carry-Flag gelöscht (`CLC`)**, pausiert das Skript (Yield, Sleep oder Wait) oder terminiert. Der aktuelle Program Counter `$82..$84` wird zurück in die Task-Struktur geschrieben und die Kontrolle an die Game-Engine zurückgegeben.
- **Primäre Opcode-Sprungtabelle:** `$8C:ECBE` (`0x0CECBE`)  
  Umfasst exakt **195 Einträge** (`0x00` bis `0xC2`). Ungenutzte Opcodes verweisen auf die `STP`-Trap-Sequenz (`$DB`) bei `$8C:ECB6`–`$8C:ECBD`.
- **Sekundäre Sub-Opcode-Sprungtabelle (Expression Engine):** `$8C:F442` (`0x0CF442`)  
  Einsprung bei `$8C:EE44`. Wertet Bedingungen, Berechnungen und Stack-Operationen aus.
- **Entity-Ziel-Evaluator (`$8C:F08F`):**  
  Wertet Entity-Ausdrücke aus und schreibt den Ziel-Entity-Zeiger in Direct Page `$4C`.
- **Skript-Bytecode-Speicher:** Banks `$93:8000` bis `$9C:FFFF` (`0x138000` bis `0x1CFFFF`).

---

## 2. Der Task-Scheduler & Kooperatives Multitasking

Secret of Evermore führt Skripte nicht blockierend aus, sondern besitzt einen kooperativen Multitasking-Scheduler in Bank `$8C`, der jeden Frame aufgerufen wird:

### Der Scheduler-Loop (`$8C:D3EC`)
1. **Reentrancy-Guard:** `$7E:1438` sperrt den Scheduler gegen Mehrfachaufrufe während Interrupts ab.
2. **Aktive Task-Liste (`$7E:2F28`):** Ein Null-terminiertes Array von 16-Bit-Zeigern im WRAM auf alle aktuell laufenden Skript-Tasks.
3. **Task-Status-Sprungtabelle (`$8C:D40E`):**
   ```65816
   8C:D40E: BD EC  ; Status 0: Unbenutzt / Trap -> $8C:ECBD
   8C:D410: 81 D4  ; Status 2: Bereit (Ready) -> $8C:D481 (Ausführung starten/fortsetzen)
   8C:D412: 1C D4  ; Status 4: Timer-Wait -> $8C:D41C (Wartet auf 32-Bit Frame-Timer $7E:0B19)
   8C:D414: 2F D4  ; Status 6: Task-Sync / Event-Flag-Wait -> $8C:D42F (Prüft und quittiert Bitmaske $0005,Y & $0009,Y)
   8C:D416: 41 D4  ; Status 8: Dialog-/State-Wait -> $8C:D441 (Setzt Ausführung fort, sobald WRAM $7E:2429 != $0005,Y via BNE $D475)
   8C:D418: 6B D4  ; Status 10: Animated-Tile-Wait -> $8C:D46B (Wartet auf animierte Kachelgruppen, vergleicht $1080,X mit $10D0,X)
   8C:D41A: 4A D4  ; Status 12: Scroll-/Position-Wait -> $8C:D44A (Überwacht Scroll-/Positionsregister $BF/$C1)
   ```

### Aufbau einer Task-Struktur im WRAM (Register `Y`)

| Offset | Typ | Beschreibung |
| :---: | :---: | :--- |
| `+0x00`..`+0x02` | `u24` | **Program Counter (PC):** Aktuelle 24-Bit-ROM-Adresse des interpretierten Bytecodes. |
| `+0x03` | `u16` | **Task-Status:** Index in die Scheduler-Tabelle `2, 4, 6, 8, 10, 12` (Status 2 = Ready, Status 4 = Timer-Wait). |
| `+0x05`..`+0x08` | `u32` | **Status-Parameter:** Zielzeit des Frame-Timers (`$7E:0B19`), Sleep-Ticks oder Entity-Index. |
| `+0x0B` | `u16` | **Parent-Task-Link:** Zeiger auf die aufrufende Task-Struktur (bei `CALL` `0x29`). |
| `+0x0D` | `u16` | **Task-Referenz-Zähler.** |

> [!NOTE]
> **Duale Funktion von `0x00` (`END`):**  
> Wenn ein Skript den Opcode `0x00` ausführt, prüft die Routine `$8C:D6CA` den Parent-Link `+0x0B`:  
> - Ist ein Caller-Link vorhanden, fungiert der Befehl als **`RETURN`** und stellt den Zustand des Aufrufers wieder her.  
> - Ist kein Caller-Link vorhanden (`0`), fungiert der Befehl als **`TERMINATE`** und entfernt den Task-Slot aus `$7E:2F28`.

### Verschachtelte Logic-Ticks & Modale Handler (`$8E:E3EF`)

Ein zentraler Architektur-Aspekt von SIGIL ist die Behandlung von modalen Dialogen und Menüs:
- **28 Handler** (u. a. `0x52 SHOW_TEXT_MODAL`, `0x7F SHOW_NAMING_SCREEN`, `0x8A OPEN_SHOP_MENU`, `0x8C SHOW_TEXT_ALT`) sowie das Expression-Token `0x2C` (`dialog_response()`) kehren während ihrer Ausführung **nicht sofort zum Scheduler zurück** (im Gegensatz zu `0x7E`, das reine Arithmetik ohne Rekursion ausführt: `nests = false`).
- Stattdessen rufen sie in einer internen modalen Eingabeschleife rekursiv die Engine-Tick-Routine bei `$8E:E3EF` auf.
- **Folge:** Der aufrufende Handler blockiert auf dem SNES-Aufrufstack („der Handler kehrt nicht zurück“), während die Game-Engine über verschachtelte Logic-Ticks weitergetrieben wird. Dies erklärt das Verhalten „kein Skript-Fortschritt bei offenem Textfenster“, während Controller-Abfragen und Hintergrund-Animationen aktiv bleiben.

---

## 3. 15-Bit Gepackte Skript-Adressierung (Packed Banking)

Da der SNES HiROM-Modus in jeder Bank nur die oberen 32 KB (`$8000` bis `$FFFF`) für ROM-Daten einblendet, verwendet die SIGIL-Engine eine proprietäre **15-Bit gepackte 24-Bit-Adressierung**, um Sprünge (`CALL`, `ASYNC_CALL`, Map-Trigger) speichereffizient ohne das höchstwertige Bank-Bit abzubilden:

### Umrechnungsformeln

- **Von SNES-ROM-Adresse zu gepackter 24-Bit Skript-Adresse:**
  $$\text{addr} = (\text{rom\_addr} \ \& \ \sim\!\text{0x8000}) - (\$938000 \ \& \ \sim\!\text{0x8000})$$
  $$\text{script\_addr} = (\text{addr} \ \& \ \text{0x7FFF}) + ((\text{addr} \ \& \ \text{0x1FF0000}) \gg 1)$$

- **Von gepackter Skript-Adresse zurück zu SNES-ROM-Adresse:**
  $$\text{rom\_addr} = \$938000 + (\text{script\_addr} \ \& \ \text{0x7FFF}) + ((\text{script\_addr} \ \& \ \text{0xFF8000}) \ll 1)$$

### Adress-Referenztabelle

| SNES-ROM-Adresse | Datei-Offset (No-Header) | Gepackte Skript-Adresse | Verwendung / Kontext |
| :---: | :---: | :---: | :--- |
| `$93:8000` | `0x138000` | `0x000000` | Basisadresse der Skripte / Map-Enter-Tabelle |
| `$93:82AF` | `0x1382AF` | `0x0002AF` | Töpfer-Skript auf Markt von Allelachema |
| `$94:8000` | `0x148000` | `0x008000` | Start von Skript-Bank 94 |
| `$95:9274` | `0x159274` | `0x011274` | Pyramiden-Schalter-Event |
| `$97:82AF` | `0x1782AF` | `0x0202AF` | Markt-Handelsroutine |
| `$9C:8FB2` | `0x1C8FB2` | `0x048FB2` | Omnitopia-Endgame-Event |

---

## 4. Speicherbereiche & Register in SIGIL

Skripte können auf fünf primäre Speicher- und Registerbereiche zugreifen:

| Bereich im Skript | Basis im WRAM | Zugriff | Beschreibung |
| :--- | :--- | :---: | :--- |
| **`FLAG[id]`** | `$7E2258` | Bit | Persistente Story-Flags als Bitfield (`id >> 3`, Bit `id & 7`). Werden auf dem SRAM gespeichert. |
| **`RAM[offset]`** | `$7E2258` | Byte / Word | Direkte Variablen (z. B. Geld, Items, Timer, Kampfdialog-Status). |
| **`TEMP[offset]`** | `$7E2834` | Byte / Word | Temporärer Scratchpad-Speicher für Skripte (wird bei Raumwechsel zurückgesetzt). |
| **`TEMP_FLAG[id]`**| `$7E2834` | Bit | Temporäre Bits für lokale Raumzustände. |
| **`ARG[idx]`** | Stackframe | Byte / Word | Argumente, die einer Subroutine via `CALL_PARAMS` übergeben wurden. |
| **`GAME_TIMER`** | `$7E0B19` | 32-Bit Word | Globaler Frame-Zähler (Low-Word `$7E:0B19`, High-Word `$7E:0B1B`). |

---

## 5. Die Sub-Opcode- & Expression-Engine (RPN-Stack ab `$8C:F442`)

In SIGIL sind Bedingungen und Zuweisungen dynamisch evaluierte Ausdrücke auf dem **nativen 65816-Hardware-Stack**:

### Die Auswertungslogik (`$8C:EE44`)
```65816
8C:EE44: E2 30        SEP #$30          ; 8-Bit A und X/Y
8C:EE46: 64 8A        STZ $8A           ; Done-Flag leeren
; Schleife:
8C:EE4A: E2 30        SEP #$30
8C:EE4C: A5 8A        LDA $8A           ; Wurde im vorherigen Sub-Opcode Bit 7 erkannt?
8C:EE4E: D0 11        BNE done          ; Ja -> Auswertung beendet!
8C:EE50: A7 82        LDA [$82]         ; Sub-Opcode-Byte laden
8C:EE52: E6 82        INC $82           ; PC inkrementieren
8C:EE54: D0 02        BNE no_carry
8C:EE56: E6 83        INC $83
no_carry:
8C:EE58: 0A           ASL A             ; Bit 7 ins Carry-Flag schieben!
8C:EE59: 26 8A        ROL $8A           ; Carry ins Done-Flag $8A rotieren!
8C:EE5B: AA           TAX               ; X = (sub & 0x7F) << 1 (Tabellenoffset)
8C:EE5C: C2 30        REP #$30          ; 16-Bit A und X/Y
8C:EE5E: 7C 42 F4     JMP ($F442, X)    ; Indirekter Sprung in Sub-Opcode-Tabelle!
done:
8C:EE61: C2 30        REP #$30
8C:EE63: A5 02        LDA $02           ; Endergebnis aus DP $02 in Akkumulator A laden!
8C:EE65: 6B           RTL               ; Rückkehr zum Statement-Opcode!
```

### Der Expression-Stack (Hardware-Stack via `PHA` / `PLA`)
- **Push (`0x29` / `$8C:F127`):** Schiebt den aktuellen Rechenwert aus DP `$02` und `$04` per `PHA` auf den CPU-Stack.
- **Binäre Operatoren (z. B. `0x1A ADD` / `$8C:EEFC`):** Holen den linken Operanden per `PLA` vom CPU-Stack und addieren ihn zum rechten Operanden in DP `$02`.

### Vollständige Tabelle aller 112 Sub-Opcodes (`0x00` bis `0x6F`)

Die Sprungtabelle für Expression-Sub-Opcodes liegt bei `$8C:F442` (`0x0CF442`) und umfasst **112 Einträge** (`0x00` bis `0x6F`). Das gesetzte Bit 7 (`sub | 0x80`) markiert das letzte Token eines Ausdrucks:

| Sub-Opcode (`sub`) | Handler | Mnemonic / Funktion | Folgende Bytes | Beschreibung |
| :---: | :---: | :--- | :---: | :--- |
| `0x00` | `$8C:EE63` | **`END_EXPR`** | *keine* | Lädt DP `$02` in `A` und kehrt sofort per `RTL` aus dem Evaluator zurück. |
| `0x01` | `$8C:EE8D` | **Negative Byte-Konstante** | `b: u8` | Liest Byte `b`, setzt `$04 = $FFFF` und `$02 = $FF00 \| b`. Wert ist `-256 + b` (`-256` bis `-1`). |
| `0x02` | `$8C:EE9E` | **Unsigned Byte** | `val: u8` | 8-Bit Integer ohne Vorzeichen (`$02 = val`, `$04 = 0`, Bereich `0` bis `255`). |
| `0x03` | `$8C:EEAC` | **Signed/Negative Word** | `val: u16` | Liest 16-Bit-Word `w` in `$02` und setzt `$04 = $FFFF` (vorzeichenbehaftetes 16-Bit-Word bzw. `-65536 + w`). |
| `0x04` | `$8C:EEBC` | **Unsigned Word** | `val: u16` | 16-Bit Integer ohne Vorzeichen (`$02 = val`, `$04 = 0`, Bereich `0` bis `65535`, Little-Endian). |
| `0x05` | `$8C:F152` | **Read RAM Flag** | `id: u16` | Prüft Bit `FLAG[id]` im persistenten WRAM ab `$7E:2258 + (id >> 3)` via Maskentabelle `$80:A87E,X` (`0` oder `1`). |
| `0x06` | `$8C:F198` | **Read Signed RAM Byte** | `addr: u16` | Liest `(i8) RAM[$7E:2258 + addr]` (Vorzeichenerweiterung auf 16/32 Bit, `$04 = $FFFF`). |
| `0x07` | `$8C:F1ED` | **Read Unsigned RAM Byte** | `addr: u16` | Liest `(u8) RAM[$7E:2258 + addr]` (`$04 = 0`). |
| `0x08` | `$8C:F239` | **Read Signed RAM Word** | `addr: u16` | Liest `(i16) RAM_WORD[$7E:2258 + addr]` (`$04 = $FFFF`). |
| `0x09` | `$8C:F235` | **Read Unsigned RAM Word** | `addr: u16` | Liest `(u16) RAM_WORD[$7E:2258 + addr]` (`$04 = 0`). |
| `0x0A` | `$8C:F142` | **Read Temp Flag** | `id: u16` | Prüft Bit `TEMP_FLAG[id]` im Scratchpad ab `$7E:2834 + (id >> 3)` (`0` oder `1`). |
| `0x0B` | `$8C:F18C` | **Read Signed Temp Byte** | `addr: u16` | Liest `(i8) TEMP[$7E:2834 + addr]` (Vorzeichenerweiterung, `$04 = $FFFF`). |
| `0x0C` | `$8C:F1D9` | **Read Unsigned Temp Byte** | `addr: u16` | Liest `(u8) TEMP[$7E:2834 + addr]` (`$04 = 0`). |
| `0x0D` | `$8C:F221` | **Read Signed Temp Word** | `addr: u16` | Liest `(i16) TEMP_WORD[$7E:2834 + addr]` (`$04 = $FFFF`). |
| `0x0E` | `$8C:F21D` | **Read Unsigned Temp Word** | `addr: u16` | Liest `(u16) TEMP_WORD[$7E:2834 + addr]` (`$04 = 0`). |
| `0x0F` | `$8C:F130` | **Test Script Arg Bit** | `bit: u8` | Prüft Bit `bit & 7` in `Task + $0F + (bit >> 3)` (`0` oder `1`). |
| `0x10` | `$8C:F17C` | **Read Signed Arg Byte** | `arg: u8` | Liest `(i8) Task[$0F + arg]` (Vorzeichenerweiterung, `$04 = $FFFF`). |
| `0x11` | `$8C:F1C1` | **Read Unsigned Arg Byte** | `arg: u8` | Liest `(u8) Task[$0F + arg]` (`$04 = 0`). |
| `0x12` | `$8C:F205` | **Read Signed Arg Word** | `arg: u8` | Liest `(i16) Task[$0F + arg]` (`$04 = $FFFF`). |
| `0x13` | `$8C:F201` | **Read Unsigned Arg Word** | `arg: u8` | Liest `(u16) Task[$0F + arg]` (`$04 = 0`). |

### Unäre & Binäre Operatoren

| Sub-Opcode | Handler | Mnemonic | Syntax | Beschreibung |
| :---: | :---: | :---: | :---: | :--- |
| `0x14` | `$8C:EEC9` | **NOT** | `!expr` | Logisches NOT (`0` wird `1`, alles andere `0`). |
| `0x15` | `$8C:EED8` | **BIT_NOT** | `~expr` | Bitweises Einerkomplement (`EOR #$FFFF`). |
| `0x16` | `$8C:EEE2` | **NEG** | `-expr` | Arithmetische Vorzeichenumkehr (`DEC; EOR #$FFFF`, setzt `$04 = $FFFF`). |
| `0x17` | `$8C:F24D` | **MUL** | `a * b` | 16-Bit Multiplikation via Hardware-Multiplizierer `$4202`/`$4203` (beachtet Vorzeichen über `$04`). |
| `0x18` | `$8C:F2C5` | **DIV** | `a / b` | 16-Bit Ganzzahldivision via Hardware-Dividierer `$4204`/`$4206` (beachtet Vorzeichen über `$04`). |
| `0x19` | `$8C:F440` | *Trap* | — | Endlosschleife (`BRA $8CF440`, unbenutzter Modulo-/Trap-Slot). |
| `0x1A` | `$8C:EEFC` | **ADD** | `a + b` | 16-Bit Addition (`PLA; PLA; CLC; ADC $02`). |
| `0x1B` | `$8C:EEF2` | **SUB** | `a - b` | 16-Bit Subtraktion (`PLA; PLA; SEC; SBC $02`). |
| `0x1C` | `$8C:EF06` | **SHL** | `a << b`| Bitweiser Linksshift (`ASL` in Schleife über `X = $02`). |
| `0x1D` | `$8C:EF17` | **SHR** | `a >> b`| Rechtsshift (logisch via `LSR`, bzw. arithmetisch mit Vorzeichenerhalt falls `$04 != 0` und `a < 0`). |
| `0x1E` | `$8C:EF6B` | **LT** | `a < b` | Kleiner als (beachtet Vorzeichen über `$04`). |
| `0x1F` | `$8C:EFB1` | **GT** | `a > b` | Größer als (beachtet Vorzeichen über `$04`). |
| `0x20` | `$8C:EFD6` | **LE** | `a <= b`| Kleiner oder gleich (beachtet Vorzeichen über `$04`). |
| `0x21` | `$8C:EF8E` | **GE** | `a >= b`| Größer oder gleich (beachtet Vorzeichen über `$04`). |
| `0x22` | `$8C:EF3D` | **EQ** | `a == b`| Gleichheit (`1` wenn gleich, sonst `0`). |
| `0x23` | `$8C:EF54` | **NE** | `a != b`| Ungleichheit (`1` wenn ungleich, sonst `0`). |
| `0x24` | `$8C:F004` | **BIT_AND** | `a & b` | Bitweises UND (`AND $02`). |
| `0x25` | `$8C:EFFB` | **BIT_OR** | `a \| b`| Bitweises ODER (`ORA $02`). |
| `0x26` | `$8C:F00D` | **BIT_XOR** | `a ^ b` | Bitweises Exklusiv-ODER (`EOR $02`). |
| `0x27` | `$8C:F016` | **LOG_OR** | `a \|\| b`| Logisches ODER (`1` wenn mindestens ein Operand $\neq 0$). |
| `0x28` | `$8C:F02B` | **LOG_AND** | `a && b`| Logisches UND (`1` wenn beide Operanden $\neq 0$). |
| `0x29` | `$8C:F127` | **PUSH** | — | Schiebt DP `$02` und `$04` per `PHA` auf den 65816 CPU-Stack. |

### Inline-Konstanten, Funktionen & Entity-Selektoren

| Sub-Opcode | Handler | Mnemonic | Beschreibung |
| :---: | :---: | :--- | :--- |
| `0x2A` | `$8C:F057` | **`rand()`** | Liefert 16-Bit Pseudozufallszahl via `JSL $80859B` (`$04 = 0`). |
| `0x2B` | `$8C:F097` | **`rand_range(max)`** | Unärer Operator auf `$02`: Berechnet `($02 * rand16()) >> 16` via `$4202`/`$4203` (Zufallszahl in `[0, max - 1]`). |
| `0x2C` | `$8C:F040` | **`dialog_response()`**| Ruft `JSL $8CAB84` für Fenster `$034D` auf und liefert den gewählten `[Marker]`-Optionsindex (`0`, `1`, ...). |
| `0x2D` | `$8C:F062` | **`trigger_actor()`** | Lädt zuletzt gespawnte/referenzierte Entity aus `$0341` in `$02` und stellt sicher, dass `Entity+$3E >= 1` ist. |
| `0x2E` | `$8C:F315` | **`attached_entity()`**| Lädt die an den aktuellen Task gebundene Entity aus `Task+$0D` (`$7E + $000D`). |
| `0x2F` | `$8C:F440` | *Trap* | Endlosschleife (`BRA $8CF440`, unbenutzt). |
| `0x30` – `0x3F`| `$8C:EE74` | **Inline-Konstante `0..15`** | Lädt direkt `(sub - 0x30)` (`0` bis `15`) in `$02` (`$04 = 0`). |
| `0x40` – `0x4F`| `$8C:EE66` | **Inline-Konstante `-16..-1`**| Lädt direkt `$FFF0 \| (sub - 0x40)` (`-16` bis `-1`) in `$02` (`$04 = $FFFF`). |
| `0x50` | `$8C:F321` | **`PLAYER_BOY`** | Lädt Entity-Pointer des Jungen aus `$0F40` (`$4E89`). |
| `0x51` | `$8C:F32B` | **`PLAYER_DOG`** | Lädt Entity-Pointer des Hundes aus `$0F42` (`$4F37`). |
| `0x52` | `$8C:F335` | **`CONTROLLED`** | Lädt Entity-Pointer der aktuell vom Spieler gesteuerten Figur aus `$0F44`. |
| `0x53` | `$8C:F33F` | **`NON_CONTROLLED`** | Lädt Entity-Pointer des KI-gesteuerten Begleiters (`$0F44 ^ $4E89 ^ $4F37`, falls `$0F44 != 0`). |
| `0x54` | `$8C:F351` | **`task_word_09()`** | Lädt das Task-Parameter-Word `Task+$09` (`$7E + $0009`) in `$02`. |
| `0x55` | `$8C:F36E` | **`deref_w(addr)`** | Unärer Operator: Liest 16-Bit Word aus WRAM `$7E:0000 + $02` (`LDA $0000,X`, setzt `$04 = $FFFF`). |
| `0x56` | `$8C:F37D` | **`deref_b(addr)`** | Unärer Operator: Liest 8-Bit Byte aus WRAM `$7E:0000 + $02` (`LDA $0000,X; AND #$00FF`, setzt `$04 = $FFFF`). |
| `0x57` | `$8C:F35D` | **`is_partner_controlled()`**| Prüft `$0F44 == $0F42` (`1`, wenn aktuell der Hund gesteuert wird, sonst `0`). |
| `0x58` | `$8C:F38F` | **`frame_timer_lo()`** | Liest das untere 16-Bit-Word des globalen Frame-Timers `$0B19`. |
| `0x59` | `$8C:F399` | **`frame_timer_hi()`** | Liest das obere 16-Bit-Word des globalen Frame-Timers `$0B1B`. |
| `0x5A` | `$8C:F3A3` | **`query_status_a(cur)`**| Unärer Operator: Speichert `$02` (Währungsindex) in `$05A7`, öffnet das Kauf-Händlermenü (`JSL $8E9FA8`) und liefert `1` (`$05A9 & $20`), `2` (`$05A9 & $10`) oder `0`. |
| `0x5B` | `$8C:F3E7` | **`query_status_b(cur)`**| Unärer Operator: Speichert `$02` (Währungsindex) in `$05A7`, öffnet das Verkaufs-Händlermenü (`JSL $8E9EBE`) und liefert `1` (`$05A9 & $10`), `2` (`$05A9 & $20`), `3` (`$05A9 & $40`) oder `0`. |
| `0x5C` | `$8C:F075` | **`entity_stat_diff(ent)`**| Unärer Operator: Berechnet `max(0, Entity[+$2A] - Entity[+$76] - 1)` (effektive Rest-HP abzüglich ausstehendem Schaden). |
| `0x5D` – `0x5F`| `$8C:F440` | *Trap* | Endlosschleife (`BRA $8CF440`, unbenutzt). |
| `0x60` – `0x6F`| `$8C:EE7F` | **Inline-Konstante `16..31`**| Lädt direkt `(sub - 0x60) + 16` (`16` bis `31`) in `$02` (`$04 = 0`). |

> **Hinweis zum Entity-Target-Evaluator (`$8C:F08F`):** Viele Entity-bezogene Opcodes rufen statt `$8C:EE44` direkt `$8C:F08F` auf. Dieser setzt vorab `$8A = 1`, sodass **genau ein einzelnes Expression-Token** ausgewertet wird, und speichert das Ergebnis sowohl in `$02` als auch als Entity-Basispointer in `$4C` (und `Y`).

---

## 6. Master-Tabelle aller 195 Opcodes (`0x00` bis `0xC2`)

Die primäre Sprungtabelle liegt bei `$8C:ECBE` (`0x0CECBE`) und umfasst exakt **195 Einträge**. Jeder einzelne Opcode ist im Folgenden auf Basis der 65816-Binärroutinen der deutschen ROM dokumentiert:

| Opcode | Handler | Status | Argumente | Mnemonic / Funktion |
| :---: | :---: | :---: | :--- | :--- |
| `0x00` | `$8C:D6CA` | Aktiv | *keine* | **`END` / `RETURN`** – Subroutinen-Rücksprung (falls Caller-Link `Task+$0B != 0`) oder Task-Terminierung (`$7E:2F28`). |
| `0x01` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzter Opcode (verweist auf 65816-CPU-Halt `STP`). |
| `0x02` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzter Opcode (verweist auf 65816-CPU-Halt `STP`). |
| `0x03` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzter Opcode (verweist auf 65816-CPU-Halt `STP`). |
| `0x04` | `$8C:D81D` | Aktiv | off: i16 | **`SKIP`** – Relativer Sprung im Skript um 16-Bit-Word (relativ zum Ende des Befehls, mit Bank-Übertrag auf `$84`). |
| `0x05` | `$8C:D811` | Aktiv | off: u8 | **`SKIP_BACK`** – Relativer Rückwärtssprung (`($FF00 \| off) - 2` relativ zum PC nach dem Operanden, d. h. `stmt_start - 256 + off`). Terminal-Befehl am Schleifenende. |
| `0x06` | `$8C:ECB6` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (verweist auf 65816-CPU-Halt `STP`). |
| `0x07` | `$8C:D7E9` | Aktiv | addr: u24 | **`ASYNC_CALL` / `FORK`** – Startet Subskript asynchron in neuem Task-Slot (`$8C:D2FD`, erbt `Task+$0D`, reiht via `$8C:D26B` ein). |
| `0x08` | `$8C:D84E` | Aktiv | cond: expr, off: i16 | **`IF`** – Springt um `off` Bytes weiter, falls `cond != 0` (`F0 03` überspringt den Sprung bei `cond == 0`). |
| `0x09` | `$8C:D85D` | Aktiv | cond: expr, off: i16 | **`IFNOT`** – Springt um `off` Bytes weiter, falls `cond == 0` (`D0 03` überspringt den Sprung bei `cond != 0`). |
| `0x0A` | `$8C:D87A` | Aktiv | cur: expr, amt: u24, off: i16 | **`IF_MONEY_GE`** – Prüft 24-Bit-Währung `$000AC6,X >= amt`; springt bei `>= amt` um `off` Bytes (bzw. überspringt Block bei `< amt` je nach Compiler-Konvention). |
| `0x0B` | `$8C:D8B9` | Aktiv | cur: expr, amt: u24, off: i16 | **`IF_MONEY_LT`** – Prüft 24-Bit-Währung `$000AC6,X < amt`; springt bei `< amt` um `off` Bytes. |
| `0x0C` | `$8C:DC27` | Aktiv | bit: u16, val: expr | **`SET_RAM_FLAG`** – Setzt (`val != 0`) oder löscht (`val == 0`) Bit `FLAG[bit]` in `$7E:2258 + (bit >> 3)`. |
| `0x0D` | `$8C:DC17` | Aktiv | bit: u16, val: expr | **`SET_TEMP_FLAG`** – Setzt oder löscht Bit `TEMP_FLAG[bit]` im Scratchpad `$7E:2834 + (bit >> 3)`. |
| `0x0E` | `$8C:DC05` | Aktiv | bit: u8, val: expr | **`SET_ARG_BIT`** – Setzt oder löscht Bit `bit & 7` in `Task + $0F + (bit >> 3)`. |
| `0x0F` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x10` | `$8C:DBED` | Aktiv | addr: u16, val: expr | **`WRITE_RAM_BYTE`** – Schreibt 8-Bit-Byte (`SEP #$21; STA $0000,X`) in `$7E:2258 + addr`. |
| `0x11` | `$8C:DBE8` | Aktiv | addr: u16, val: expr | **`WRITE_TEMP_BYTE`** – Schreibt 8-Bit-Byte in Scratchpad `$7E:2834 + addr`. |
| `0x12` | `$8C:DBCF` | Aktiv | arg: u8, val: expr | **`WRITE_ARG_BYTE`** – Schreibt 8-Bit-Byte in Subroutinen-Argument `Task + $0F + arg`. |
| `0x13` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x14` | `$8C:DBED` | *Alias* | addr: u16, val: expr | **`WRITE_RAM_BYTE`** – Exakter Alias zu Opcode `0x10` (`$8C:DBED`). |
| `0x15` | `$8C:DBE8` | *Alias* | addr: u16, val: expr | **`WRITE_TEMP_BYTE`** – Exakter Alias zu Opcode `0x11` (`$8C:DBE8`). |
| `0x16` | `$8C:DBCF` | *Alias* | arg: u8, val: expr | **`WRITE_ARG_BYTE`** – Exakter Alias zu Opcode `0x12` (`$8C:DBCF`). |
| `0x17` | `$8C:DB86` | Aktiv | addr: u16, val: u16 | **`WRITE_VAR_FAST`** – Schreibt konstantes 16-Bit-Word `val` direkt nach `$7E:2258 + addr` ohne Expression-Engine. |
| `0x18` | `$8C:DBBA` | Aktiv | addr: u16, val: expr | **`WRITE_RAM_WORD`** – Schreibt 16-Bit-Word (`STA $0000,X`) nach `$7E:2258 + addr`. |
| `0x19` | `$8C:DBB5` | Aktiv | addr: u16, val: expr | **`WRITE_TEMP_WORD`** – Schreibt 16-Bit-Word nach `$7E:2834 + addr`. |
| `0x1A` | `$8C:DB9C` | Aktiv | arg: u8, val: expr | **`WRITE_ARG_WORD`** – Schreibt 16-Bit-Word in Subroutinen-Argument `Task + $0F + arg`. |
| `0x1B` | `$8C:DB54` | Aktiv | w1: u16, w2: u16, b1: u8, b2: u8 | **`SET_RAM_PAIRS_X8`** – Liest 6 Bytes und schreibt `b1 * 8` nach `$7E:2258 + w1` sowie `b2 * 8` nach `$7E:2258 + w2`. |
| `0x1C` | `$8C:DBBA` | *Alias* | addr: u16, val: expr | **`WRITE_RAM_WORD`** – Exakter Alias zu Opcode `0x18` (`$8C:DBBA`, 16-Bit-Word!). |
| `0x1D` | `$8C:DBB5` | *Alias* | addr: u16, val: expr | **`WRITE_TEMP_WORD`** – Exakter Alias zu Opcode `0x19` (`$8C:DBB5`, 16-Bit-Word!). |
| `0x1E` | `$8C:DB9C` | *Alias* | arg: u8, val: expr | **`WRITE_ARG_WORD`** – Exakter Alias zu Opcode `0x1A` (`$8C:DB9C`, 16-Bit-Word!). |
| `0x1F` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x20` | `$8C:DFD9` | Aktiv | x: u8, y: u8 | **`SET_CAMERA_POS` / `TELEPORT_LOCAL`** – Setzt `$46 = x*8, $48 = y*8, $44 = 0` und ruft `$8F:B3E5` auf (setzt Kamera via `$90:981A` und positioniert aktive Spielerfiguren `$0F40`/`$0F42` auf derselben Karte um). |
| `0x21` | `$8C:DFA2` | Aktiv | x: u8, y: u8 | **`CAMERA_FOLLOW` / `RELOAD_MAP_AT`** – Setzt Task-Slots zurück (`$8C:D2CE`), initialisiert Entities (`$8F:B33F`), positioniert bei `(x*8, y*8)` (`$8F:B3E5`) und startet Map-Skript neu (`$8C:D27E`, Terminal-Befehl `CLC; RTS`). |
| `0x22` | `$8C:DF5A` | Aktiv | x: u8, y: u8, map: u16 | **`CHANGE_MAP`** – Lädt neue Karte `map` (`STA $0ADB; JSL $908E95`) an Position `(x*8, y*8)` und startet deren Map-Enter-Skript (Terminal-Befehl `CLC; RTS`). |
| `0x23` | `$8C:E806` | Aktiv | scroll: u16 | **`SET_MAP_SCROLL`** – Schreibt 16-Bit-Wert nach WRAM `$0E70`. |
| `0x24` | `$8C:ECB7` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x25` | `$8C:ECB8` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x26` | `$8C:E007` | Aktiv | *keine* | **`FADE_IN`** – Blendet den Bildschirm auf volle Helligkeit ein (`$0B8B = $000F`, `$0B83 = $800F`; beendet ggf. Forced Blank via `$80:85D8`/`$90:94B0`). |
| `0x27` | `$8C:DFF9` | Aktiv | *keine* | **`FADE_OUT`** – Blendet den Bildschirm schrittweise auf Schwarz ab (`$0B8B = $000F`, `$0B83 = $8000`). |
| `0x28` | `$8C:ECB9` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x29` | `$8C:D7B2` | Aktiv | addr: u24 | **`CALL`** – Synchroner Subroutinen-Aufruf (erzeugt Child-Task via `$8C:D2FD`, speichert Caller-Task in `Child+$0B` und ersetzt den aktuellen Slot in `$7E:2F28,Y`). |
| `0x2A` | `$8C:DF50` | Aktiv | target: entity | **`FREEZE_ENTITY` / `LOCK_ENTITY`** – Evaluiert `target` (`$8C:F08F`) und ruft `$8F:CD0D` auf (gibt Pfadknoten via `$8F:98AF` frei und setzt Skript-Lock-Bit `Entity+$10 \|= $0020`). |
| `0x2B` | `$8C:DEFA` | Aktiv | target: entity | **`UNFREEZE_ENTITY` / `UNLOCK_ENTITY`** – Evaluiert `target` (`$8C:F08F`) und ruft `$8F:CCE2` auf (löscht Skript-Lock-Bits `Entity+$10 &= $DFDE` und `Entity+$12 &= $FCFF`). |
| `0x2C` | `$8C:DF13` | Aktiv | mask: u8 | **`LOCK_PLAYER`** – Ruft `$8F:CD0D` (Skript-Lock `+$10 \|= $0020`) für alle in Bitmaske `mask` gesetzten Ziele auf (`$01` = Junge `$4E89`, `$02` = Hund `$4F37`, `$08` = `Task+$0D`). |
| `0x2D` | `$8C:DEBD` | Aktiv | mask: u8 | **`UNLOCK_PLAYER`** – Ruft `$8F:CCE2` (Skript-Unlock `+$10 &= $DFDE`) für alle in Bitmaske `mask` gesetzten Ziele auf (`$01` = Junge, `$02` = Hund, `$08` = `Task+$0D`). |
| `0x2E` | `$8C:D62D` | Aktiv | target: expr | **`WAIT_UNTIL` / `WAIT_ENTITY`** – Wartet auf Abschluss einer Bewegung/Aktion von Entity `target` (`>=$2000`: prüft Pfad/Task `$006C,Y` und `$006A,Y`; setzt Task-Status `+$03 = 6`). |
| `0x2F` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x30` | `$8C:DA90` | Aktiv | sfx_id: u8 | **`PLAY_SFX_1`** – Sendet ggf. Panning/Param `$243B` via Kommando `$30` (`$8C:84F1`) und spielt SFX `sfx_id` über Tabelle `$8C:8700` (`$8C:8662`). |
| `0x31` | `$8C:DA90` | *Alias* | sfx_id: u8 | **`PLAY_SFX_2`** – Exakter Alias zu Opcode `0x30` (`$8C:DA90`). |
| `0x32` | `$8C:DA90` | *Alias* | sfx_id: u8 | **`PLAY_SFX_3`** – Exakter Alias zu Opcode `0x30` (`$8C:DA90`). |
| `0x33` | `$8C:DABF` | Aktiv | track_id: u8 | **`PLAY_BGM`** – Lädt und startet Hintergrundmusik (`track_id` indiziert `$8C:87E0`, Aufruf `$8C:85E7`). |
| `0x34` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x35` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x36` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x37` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x38` | `$8C:D5F6` | Aktiv | *keine* | **`YIELD`** – Gibt CPU für den aktuellen Frame ab (`CLC; RTS`, PC bleibt auf dem nächsten Befehl). |
| `0x39` | `$8C:D609` | Aktiv | frames: expr | **`SLEEP_EXPR` / `WAIT_FRAME`** – Pausiert Task für `frames` Ticks (speichert Zielzeit `$0B19 + frames - 1` in `Task+$05..$07`, Status `Task+$03 = 4`). |
| `0x3A` | `$8C:D5F6` | *Alias* | *keine* | **`YIELD`** – Exakter Alias zu Opcode `0x38` (`$8C:D5F6`). |
| `0x3B` | `$8C:D609` | *Alias* | frames: expr | **`SLEEP_EXPR` / `WAIT_ANIM`** – Exakter Alias zu Opcode `0x39` (`$8C:D609`). |
| `0x3C` | `$8C:E0ED` | Aktiv | type: u16, flags: u16, x: u8, y: u8 | **`SPAWN_NPC_PARAM`** – Spawnt Entity (`$8E:B55A,X`) bei `(x*8, y*8)` mit Flags `flags` (`$8F:B045` falls Bit 15 = 0, sonst `$8F:B04A`; speichert neuen Entity-Pointer in `$0341`). |
| `0x3D` | `$8C:E14C` | Aktiv | ent: entity, script_id: u16 | **`SET_NPC_TALK_SCRIPT` / `ATTACH_SCRIPT`** – Schreibt `script_id` nach `Entity+$66` und Trigger-Flag `#$0040` nach `Entity+$68`. |
| `0x3E` | `$8C:ECBC` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x3F` | `$8C:E161` | Aktiv | ent: expr, flags: u16, script_id: u16 | **`SET_NPC_SCRIPT`** – Schreibt `flags` nach `Entity+$68` und `script_id` nach `Entity+$66`; falls `flags & $0400 != 0`, wird das Skript sofort via `$8C:D232` gestartet. |
| `0x40` | `$8C:ECBB` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x41` | `$8C:ECBA` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x42` | `$8C:E3EF` | Aktiv | target: entity, x: u8, y: u8 | **`TELEPORT_ENTITY`** – Teleportiert `target` auf Rasterkoordinaten `(x*8, y*8)` via `$8F:C266`/`$8F:C279` (2 Byte-Koordinaten, historisch in Tools teils als 16-Bit-Word geführt). |
| `0x43` | `$8C:E40E` | Aktiv | target: entity, x: expr, y: expr | **`TELEPORT_ENTITY_EXPR`** – Teleportiert `target` auf berechnete Pixelkoordinaten `(x, y)` via `$8F:C266`/`$8F:C279`. |
| `0x44` | `$8C:DC79` | Aktiv | win: u8, x: u8, y: u8, w: u8, h: u8 | **`SET_WINDOW_0_SIZE`** – Blendet HUD aus (`$8C:C906`), konfiguriert Fenster-Slot `$034D + win * $2C` (`$8C:DD50`) auf `(x, y, w, h)` und öffnet das Fenster (`$8C:B051`). |
| `0x45` | `$8C:DC79` | *Alias* | win: u8, x: u8, y: u8, w: u8, h: u8 | **`SET_WINDOW_1_SIZE`** – Exakter Alias zu Opcode `0x44` (`$8C:DC79`). |
| `0x46` | `$8C:DC79` | *Alias* | win: u8, x: u8, y: u8, w: u8, h: u8 | **`SET_WINDOW_2_SIZE`** – Exakter Alias zu Opcode `0x44` (`$8C:DC79`). |
| `0x47` | `$8C:DC79` | Aktiv | win: u8, x: u8, y: u8, w: u8, h: u8 | **`SET_WINDOW_3_SIZE`** – Wie `0x44`, erkennt aber `X == $008E` (Opcode `0x47`) und setzt abweichend VRAM-Basis `+$26 = $1F64`, `+$2A = 1` und Flag `+$12 \|= $0010`. |
| `0x48` | `$8C:DCE7` | Aktiv | *keine* | **`RESET_WINDOW_0_DEFAULT`** – Blendet HUD aus (`$8C:C906`) und öffnet Fenster 0 (`$034D`) mit Standardmaßen `(x=2, y=2, w=28, h=10)` via `$8C:B051`. |
| `0x49` | `$8C:DCE7` | *Alias* | *keine* | **`RESET_WINDOW_1_DEFAULT`** – Exakter Alias zu Opcode `0x48` (`$8C:DCE7`). |
| `0x4A` | `$8C:DCE7` | *Alias* | *keine* | **`RESET_WINDOW_2_DEFAULT`** – Exakter Alias zu Opcode `0x48` (`$8C:DCE7`). |
| `0x4B` | `$8C:DCE7` | *Alias* | *keine* | **`RESET_WINDOW_3_DEFAULT`** – Exakter Alias zu Opcode `0x48` (`$8C:DCE7`). |
| `0x4C` | `$8C:DC65` | Aktiv | dummy: u8 | **`NOP_SKIP_BYTE`** – Überspringt 1 Byte im Skript (`INC $82`) und fährt sofort fort (`SEC; RTS`). |
| `0x4D` | `$8C:DC67` | Aktiv | *keine* | **`NOP`** – Keine Operation; sofortige Fortsetzung im selben Frame (`SEC; RTS`). |
| `0x4E` | `$8C:E1B1` | Aktiv | target: entity | **`BIND_TASK_ENTITY` / `SCRIPT_CMD_4E`** – Bindet `target` als `Attached`-Entity (`Task+$0D`) an den aktuellen Skript-Task (dekrementiert Refcount `+$3E` der alten Entity und inkrementiert `+$3E` der neuen Entity). |
| `0x4F` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x50` | `$8C:DDE6` | Aktiv | win: u8, text_id: u16 | **`SHOW_WINDOW_TEXT`** – Wählt Fenster `$034D + win * $2C` (`$8C:DD50`), dekodiert `text_id` (`$8C:D0B8`) und gibt den Text im gewählten Fenster aus (`$8C:A198`). |
| `0x51` | `$8C:DDF3` | Aktiv | text_id: u16 | **`SHOW_TEXT`** – Dekodiert `text_id` (`$8C:D0B8`) und gibt den Text im Standard-Textfenster 0 (`$034D`) aus (`$8C:A198`). |
| `0x52` | `$8C:DD87` | Aktiv | text_id: u16 | **`SHOW_TEXT_MODAL` / `SHOW_TEXT_END`** – Schließt ggf. Status-HUD (`$8C:C8B9`), trägt `text_id` ein (`$8C:D0F6`) und führt die modale Textausgabe via `$8C:C8E4` aus. |
| `0x53` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x54` | `$8C:DD65` | Aktiv | win: u8 | **`HIDE_WINDOW_TEXT`** – Schließt Fenster `$034D + win * $2C` (`$8C:B1AC`) und stellt das Status-HUD wieder her (`$8C:C920`). |
| `0x55` | `$8C:DD71` | Aktiv | *keine* | **`HIDE_TEXT`** – Schließt das Standard-Textfenster 0 (`$034D`, `$8C:B1AC`) und stellt das Status-HUD wieder her (`$8C:C920`). |
| `0x56` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x57` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x58` | `$8C:E088` | Aktiv | *keine* | **`FADE_IN_MUSIC`** – Setzt `$9B = $10` und ruft `$8C:89B7` auf (Musik-Lautstärke einblenden). |
| `0x59` | `$8C:E075` | Aktiv | *keine* | **`FADE_OUT_MUSIC`** – Setzt `$9B = $F0` und ruft `$8C:89B7` auf (Musik-Lautstärke ausblenden). |
| `0x5A` | `$8C:E290` | Aktiv | *keine* | **`OPEN_SPEAKER_BAR` / `DISABLE_INTERRUPTS`** – Ruft `$8C:C9A5` auf: blendet HUD aus (`$8C:C906`), fährt den unteren Cinematic-/Sprecherbalken (`$011E`) ein und setzt `$0B79 \|= $0080`. |
| `0x5B` | `$8C:E296` | Aktiv | *keine* | **`CLOSE_SPEAKER_BAR` / `ENABLE_INTERRUPTS`** – Ruft `$8C:C9CC` auf: fährt den unteren Cinematic-/Sprecherbalken (`$011E`) wieder aus (`$0B79 \|= $0040`). |
| `0x5C` | `$8C:E1CC` | Aktiv | obj: expr, state: expr | **`SET_MAP_STATE` / `MAP_EFFECT_5C`** – Setzt den dynamischen Karten-Kachelstatus `$1080,X` für Objekt `obj` auf `state` via `$90:A372`. |
| `0x5D` | `$8C:E200` | Aktiv | obj: expr, flag: u16 | **`SET_MAP_STATE_FROM_FLAG`** – Prüft `FLAG[flag]`: setzt Karten-Kachelstatus `$1080,X` via `$90:A372` auf `$007F` (wenn gesetzt) bzw. `$0000` (wenn gelöscht). |
| `0x5E` | `$8C:E22F` | Aktiv | obj: expr, flag: u16 | **`SET_MAP_STATE_IF_FLAG_CLEAR`** – Prüft `FLAG[flag]`: falls gelöscht (`0`), wird Karten-Kachelstatus `$1080,X` via `$90:A372` auf `$007F` gesetzt. |
| `0x5F` | `$8C:E278` | Aktiv | obj: expr, delta: u16 | **`ADD_MAP_STATE` / `TILE_STATE`** – Addiert 16-Bit-Wert `delta` auf Karten-Kachelstatus `$1080,X` und aktualisiert die Kacheln via `$90:A372`. |
| `0x60` | `$8C:E1DC` | Aktiv | obj: expr | **`INC_MAP_STATE` / `BG_SCROLL_X`** – Inkrementiert Karten-Kachelstatus `$1080,X` um 1 und ruft `$90:A372` auf. |
| `0x61` | `$8C:E1EE` | Aktiv | obj: expr | **`DEC_MAP_STATE` / `BG_SCROLL_Y`** – Dekrementiert Karten-Kachelstatus `$1080,X` um 1 und ruft `$90:A372` auf. |
| `0x62` | `$8C:E3D0` | Aktiv | id: u8, p1: u16, p2: u16 | **`SET_AMBIENT_ACTOR_POS` / `CONFIG_TILE_ANIM`** – Konfiguriert Kachel-/Palettenanimations-Slot `id` in `$507D,X` (`$4FE6,X` und `$504A,X`) via `$90:A2A7`. |
| `0x63` | `$8C:E376` | Aktiv | *keine* | **`OPEN_ALCHEMY_MENU` / `WAIT_PATH_END`** – Öffnet das Bank-`$8D` Alchemie-Auswahlmenü (`$8D:B58D`/`$8D:B738`, prüft die 35 Formel-Flags ab `$7E:2258` via `$C5:02A1`) und lädt danach die Map-Grafik neu. |
| `0x64` | `$8C:E29C` | Aktiv | entity: expr | **`SHOW_LEFT_SPEAKER` / `BG_SCROLL_SPEED`** – Speichert Entity-Pointer in `$0B73` und blendet das linke Sprecher-Sprite bei `(24, 182)` via `$8C:C9EA` (`X=1`) ein. |
| `0x65` | `$8C:E2B5` | Aktiv | *keine* | **`SLIDE_IN_LEFT_SPEAKER` / `ENABLE_BG1`** – Blendet das bereits in `$0B73` gesetzte linke Sprecher-Sprite via `$8C:C9EA` (`X=1`) ein. |
| `0x66` | `$8C:E2AC` | Aktiv | *keine* | **`HIDE_LEFT_SPEAKER` / `DISABLE_BG1`** – Blendet das linke Sprecher-Sprite (`$0B73`) via `$8C:CA3F` (`X=1`) aus. |
| `0x67` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x68` | `$8C:E2BE` | Aktiv | entity: expr | **`SHOW_RIGHT_SPEAKER` / `BG2_SCROLL_SPEED`** – Speichert Entity-Pointer in `$0B75` und blendet das rechte Sprecher-Sprite bei `(198, 182)` via `$8C:C9EA` (`X=2`) ein. |
| `0x69` | `$8C:E2D7` | Aktiv | *keine* | **`SLIDE_IN_RIGHT_SPEAKER` / `ENABLE_BG2`** – Blendet das bereits in `$0B75` gesetzte rechte Sprecher-Sprite via `$8C:C9EA` (`X=2`) ein. |
| `0x6A` | `$8C:E2CE` | Aktiv | *keine* | **`HIDE_RIGHT_SPEAKER` / `DISABLE_BG2`** – Blendet das rechte Sprecher-Sprite (`$0B75`) via `$8C:CA3F` (`X=2`) aus. |
| `0x6B` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x6C` | `$8C:DE50` | Aktiv | target: entity, x: u8, y: u8 | **`WALK_TO_GRID` / `SET_ENTITY_POS_FAST`** – Bewegt `target` mit Pfadfindung (`$8F:AA33`, Modus 0) zu den absoluten Rasterkoordinaten `(x*8, y*8)`. |
| `0x6D` | `$8C:DE18` | Aktiv | target: entity, dx: expr, dy: expr | **`WALK_REL_TILES` / `SET_ENTITY_POS_REL_FAST`** – Bewegt `target` mit Pfadfindung (`$8F:AA33`, Modus 0) relativ um `(dx*16, dy*16)` Pixel (16x16-Kacheleinheiten). |
| `0x6E` | `$8C:DE49` | Aktiv | target: entity, x: u8, y: u8 | **`FORCE_WALK_TO_GRID`** – Bewegt `target` direkt/erzwungen (`$8F:AA84`, Modus 1, `$3C12 \|= $0230`) zu den absoluten Rasterkoordinaten `(x*8, y*8)`. |
| `0x6F` | `$8C:DE11` | Aktiv | target: entity, dx: expr, dy: expr | **`FORCE_WALK_REL_TILES`** – Bewegt `target` direkt/erzwungen (`$8F:AA84`, Modus 1, `$3C12 \|= $0230`) relativ um `(dx*16, dy*16)` Pixel. |
| `0x70` | `$8C:E30E` | Aktiv | a: entity, b: entity | **`ENTITY_FACE_ENTITY`** – Dreht Figur `a` (`+$22`) in Richtung von Figur `b` (`$8C:E334`). |
| `0x71` | `$8C:E31E` | Aktiv | a: entity, b: entity | **`FACE_EACH_OTHER`** – Dreht Figur `a` zu `b` (`$8C:E334`) und Figur `b` entgegengesetzt (`EOR #$0008; STA $0022,Y`) zu `a`. |
| `0x72` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x73` | `$8C:DE76` | Aktiv | target: entity, x: expr, y: expr | **`FORCE_WALK_TO_PIXELS` / `MOVE_ENTITY_TO`** – Bewegt `target` direkt/erzwungen (`$8F:AA84`, Modus 1) zu den absoluten Pixelkoordinaten `(x, y)`. |
| `0x74` | `$8C:E2E0` | Aktiv | target: entity | **`FACE_NORTH` / `ENTITY_ACT_74`** – Setzt Blickrichtung `Entity+$22` auf `$0000` (Norden / Oben). |
| `0x75` | `$8C:E2F6` | Aktiv | target: entity | **`FACE_SOUTH` / `ENTITY_ACT_75`** – Setzt Blickrichtung `Entity+$22` auf `$0008` (Süden / Unten). |
| `0x76` | `$8C:E302` | Aktiv | target: entity | **`FACE_WEST` / `ENTITY_ACT_76`** – Setzt Blickrichtung `Entity+$22` auf `$000C` (Westen / Links). |
| `0x77` | `$8C:E2EA` | Aktiv | target: entity | **`FACE_EAST` / `ENTITY_ACT_77`** – Setzt Blickrichtung `Entity+$22` auf `$0004` (Osten / Rechts). |
| `0x78` | `$8C:E4B1` | Aktiv | target: entity, anim: u16, mode: expr | **`PLAY_ENTITY_ANIM`** – Spielt Entity-Animation `anim` (Tabelle `$C4:42D2` falls positiv) im Modus `mode` (`$8C:E501`, Aufruf `$90:8124`). |
| `0x79` | `$8C:E557` | Aktiv | target: entity, anim: u16, mode: expr | **`PLAY_ENTITY_ANIM_WAIT`** – Startet Animation via `$8C:E4B1` und pausiert den Task bis zum Abschluss (`Entity+$88 = Task`, `Task+$03 = 6`). |
| `0x7A` | `$8C:E48F` | Aktiv | target: expr, val: expr | **`WRITE_WRAM_WORD`** – Schreibt 16-Bit-Word (`STA $0000,X`) an WRAM-Adresse `$7E:0000 + target`. |
| `0x7B` | `$8C:E49E` | Aktiv | target: expr, val: expr | **`WRITE_WRAM_BYTE`** – Schreibt 8-Bit-Byte (`SEP #$20; STA $0000,X`) an WRAM-Adresse `$7E:0000 + target`. |
| `0x7C` | `$8C:D940` | Aktiv | cur: expr, amt: u24 | **`GIVE_MONEY`** – Addiert 24-Bit-Konstante `amt` zur Währung `$000AC6,X`. |
| `0x7D` | `$8C:D8EA` | Aktiv | cur: expr, amt: u24 | **`TAKE_MONEY`** – Subtrahiert 24-Bit-Konstante `amt` von Währung `$000AC6,X`. |
| `0x7E` | `$8C:D993` | Aktiv | div: expr, src: expr, mul: expr, dst: expr | **`EXCHANGE_MONEY` / `SCRIPT_CMD_7E`** – Währungsumtausch: berechnet `p = MONEY[src] * mul`, speichert Rest `p % div` in `MONEY[src]` und addiert Quotient `p / div` auf `MONEY[dst]`. |
| `0x7F` | `$8C:E57B` | Aktiv | target: u16 | **`SHOW_NAMING_SCREEN`** – Öffnet den Namenseingabe-Bildschirm (`$8D:8000`/`$8D:824F`, Zieltabelle `$8C:E5FE,X`). |
| `0x80` | `$8C:E604` | Aktiv | *keine* | **`SHOW_HUD_ALL`** – Löscht Bit 15 in `$0B2B` und stellt das Status-HUD-Fenster (`$034D`) via `$8C:C920` wieder her. |
| `0x81` | `$8C:E60A` | Aktiv | *keine* | **`HIDE_HUD_ALL`** – Schließt das Status-HUD-Fenster (`$034D`) und setzt Bit 15 in `$0B2B` via `$8C:C906`. |
| `0x82` | `$8C:E610` | Aktiv | *keine* | **`RESTORE_MAIN_SCREEN_LAYERS`** – Kopiert `$7E:235B..235E` in die PPU-Register `$212C`, `$212D`, `$2131`, `$2130`. |
| `0x83` | `$8C:E648` | Aktiv | *keine* | **`SET_SUB_SCREEN_LAYERS`** – Kopiert die Karten-Standardwerte `$0F82..0F85` in die PPU-Register `$212C`, `$212D`, `$2131`, `$2130`. |
| `0x84` | `$8C:D971` | Aktiv | cur: expr, amt: expr | **`GIVE_MONEY_EXPR`** – Addiert dynamisch berechneten 16-Bit-Betrag `amt` zur 24-Bit-Währung `$000AC6,X`. |
| `0x85` | `$8C:D91B` | Aktiv | cur: expr, amt: expr | **`TAKE_MONEY_EXPR`** – Subtrahiert dynamisch berechneten 16-Bit-Betrag `amt` von der 24-Bit-Währung `$000AC6,X`. |
| `0x86` | `$8C:E67C` | Aktiv | val: expr | **`APU_SOUND_CMD_28`** – Speichert `val & $FF` in `$9A` und sendet APU-Kommando `$28` via `$8C:84F1`. |
| `0x87` | `$8C:E696` | Aktiv | val: expr | **`APU_SOUND_CMD_2A`** – Sendet APU-Kommando `$2A` mit Parameter `val` in `Y` via `$8C:84F1`. |
| `0x88` | `$8C:E6AB` | Aktiv | *keine* | **`CLEAR_SHOP_MENU`** – Leert die Händler-Warenliste (`$0B97 = $FFFF`, `$0E6E = 0`). |
| `0x89` | `$8C:E6B6` | Aktiv | item: expr, price: expr | **`ADD_SHOP_ITEM`** – Fügt Artikel `item` (Tabelle `$8C:E712`/`$8C:E742`) mit Preis/Anzahl `price` (`$0BC7,X`) zur Händlerliste `$0B97,X` hinzu und setzt Typ-Bits in `$0E6E`. |
| `0x8A` | `$8C:E758` | Aktiv | cur: expr | **`OPEN_SHOP_MENU`** – Speichert Währungsindex `cur` in `$05A7` und öffnet das Kauf-Händlermenü via `$8E:9FA8`. |
| `0x8B` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x8C` | `$8C:E79B` | Aktiv | text_id: u16 | **`OPEN_SAVE_MENU` / `SHOW_MESSAGE`** – Blendet Bildschirm aus, initialisiert das 4-Slot-Speichermenü (`$8D:CC49`), lädt den Ortsnamen `text_id` (`$8C:D0F6`), führt das Speichermenü (`$8D:D012`) aus und lädt danach die Map neu. |
| `0x8D` | `$8C:E786` | Aktiv | mode: u8 | **`SET_SCREEN_SHAKE` / `SET_MUSIC_VOLUME`** – Startet Kamerawackeln bei `mode != 0` (`$90:989C`: `INC $C3`, Amplitude `$2409/$240B = 4`) bzw. stoppt es bei `mode == 0` (`$90:9893`: `STZ $C3..$C9`). |
| `0x8E` | `$8C:D86C` | Aktiv | cur: expr, amt: expr, off: i16 | **`IF_MONEY_GE_EXPR` / `IF_EQUAL`** – Prüft dynamisch `MONEY[cur] >= amt` (setzt `$02 = amt, $04 = 0` und springt zu `0x0A`-Handler `$8C:D890`) und verzweigt um `off` Bytes. |
| `0x8F` | `$8C:D8AB` | Aktiv | cur: expr, amt: expr, off: i16 | **`IF_MONEY_LT_EXPR` / `IF_NOT_EQUAL`** – Prüft dynamisch `MONEY[cur] < amt` (setzt `$02 = amt, $04 = 0` und springt zu `0x0B`-Handler `$8C:D8CF`) und verzweigt um `off` Bytes. |
| `0x90` | `$8C:E02A` | Aktiv | speed: expr | **`FADE_OUT_SPEED` / `FLASH_SCREEN`** – Blendet Bildschirm mit Geschwindigkeit `speed & $0F` auf Schwarz ab (`$0B8B = speed & $0F`, `$0B83 = $8000 \| (speed & $0F)`). |
| `0x91` | `$8C:E051` | Aktiv | level: expr | **`SET_BRIGHTNESS_FAST`** – Setzt Bildschirm-Helligkeit (`$0106` und `$0B8B`) direkt auf `level & $0F`. |
| `0x92` | `$8C:E831` | Aktiv | target: entity, amount: expr | **`DAMAGE_ENTITY_MAIN` / `SET_ENTITY_TARGET`** – Fügt `target` Schaden zu via `$8F:C0B6` (`+$12 \|= $0038`: Schaden + Zahlen-Popup + Trefferreaktion; delegiert bei `$23D5 != 0` an `0xBB` und verrechnet bei `$23D7 != 0` Magieabwehr via `$8F:C002`). |
| `0x93` | `$8C:E887` | Aktiv | target: entity, amount: expr | **`DAMAGE_ENTITY` (Silent)** – Fügt `target` stillen Schaden zu via `$8F:C0C7` (`ADC Entity+$76`, setzt nur `Entity+$12 \|= $0008` ohne Zahlen-Popup und ohne Treffer-Animation). |
| `0x94` | `$8C:E811` | Aktiv | target: entity, amount: expr | **`HEAL_ENTITY`** – Heilt `target` mit grünem Zahlen-Popup via `$8F:C02F` (Popup `$90:D87B`, `ADC Entity+$2A` gedeckelt auf Max-HP `$8E:000F,X`). |
| `0x95` | `$8C:E821` | Aktiv | target: entity, hp: expr | **`SET_ENTITY_HP` / `HEAL_SILENT`** – Stille Heilung via `$8F:C03A` (`ADC Entity+$2A` gedeckelt auf Max-HP `$8E:000F,X`, ohne Zahlen-Popup). |
| `0x96` | `$8C:E89E` | Aktiv | dx: expr, dy: expr | **`SET_CAMERA_BASE`** – Verschiebt die Basis-Kamerakoordinaten (`$BF`/`$C1`, `$010E`/`$0110`) um `((dx & $7F) << 9, (dy & $7F) << 9)` via `$90:A006`. |
| `0x97` | `$8C:E8B2` | Aktiv | args: expr... (7x) | **`PALETTE_ADD_RGB` / `SHAKE_SCREEN_COMPLEX`** – Addiert vorzeichenbehaftete `(R, G, B)`-Deltas auf `count` Palettenfarben ab `start_color` in `$7E:6187`/`$7E:65F1` und überträgt sie per DMA (`$80:85FA`) ins CGRAM. |
| `0x98` | `$8C:E9A2` | Aktiv | target: expr | **`SWITCH_CHARACTER` / `SELECT_ENTITY`** – Vergleicht `target` mit der aktiven Spielerfigur `$0F44`; falls unterschiedlich, wird die Führung via `$8C:F5A8` gewechselt. |
| `0x99` | `$8C:EA70` | Aktiv | args: expr... (6x) | **`ENTER_MODE7_MAP`** – Schreibt 6 Parameter nach `$0E72` und `$0E76..$0E7B`, ruft die Spezial-/Mode-7-Sequenz `$80:BC00` auf und lädt anschließend die Karte neu (`$8E:E08B`). |
| `0x9A` | `$8C:EAD0` | Aktiv | font_idx: expr | **`SELECT_FONT` / `SET_PITCH`** – Lädt den Font-Offset aus `$8C:EAE7,X` (`0` $\rightarrow$ `$C4:0000`, `2` $\rightarrow$ `$C4:0FA2`) und initialisiert die VWF-Schriftart via `$8C:A144`. |
| `0x9B` | `$8C:E134` | Aktiv | target: entity | **`DESPAWN_ENTITY` / `ATTACH_CAMERA`** – Dekrementiert den Skript-Referenzzähler `Entity+$3E` und entfernt die Entity via `$8F:B28F` von der Karte. |
| `0x9C` | `$8C:E142` | Aktiv | target: entity | **`UNREF_ENTITY` / `CAMERA_ACTION_9C`** – Dekrementiert den Skript-Referenzzähler `Entity+$3E` (`DEC $003E,X`), ohne die Entity sofort zu despawnen. |
| `0x9D` | `$8C:DE71` | Aktiv | target: entity, x: expr, y: expr | **`WALK_TO_PIXELS` / `SET_ENTITY_POS`** – Bewegt `target` mit Pfadfindung (`$8F:AA33`, Modus 0) zu den absoluten Pixelkoordinaten `(x, y)`. |
| `0x9E` | `$8C:D4B5` | Aktiv | target: expr, spell: expr, level: expr, extra: expr... | **`CAST_ALCHEMY`** – Startet Alchemie-/Effekt-Animation (`$91:9759`) auf `target` mit nullterminierter Folgeliste von Ziel-Entities (`$3BC1 = 0`). |
| `0x9F` | `$8C:E9B1` | Aktiv | *keine* | **`SHOW_CURRENCY_HUD`** – Öffnet das Währungsfenster (`$0435`) via `$8C:B051` und spawnt das Währungs-Icon-Sprite (`$0DED`) via `$90:817B`. |
| `0xA0` | `$8C:EA29` | Aktiv | *keine* | **`UPDATE_CURRENCY_HUD`** – Aktualisiert den angezeigten Kontostand der aktuellen Währung (`$7E:2348` $\rightarrow$ `$0AC6,X`) im Fenster `$0435`. |
| `0xA1` | `$8C:EA60` | Aktiv | *keine* | **`HIDE_CURRENCY_HUD`** – Schließt das Währungsfenster (`$0435`) via `$8C:B1AC` (`STZ $0CB5`). |
| `0xA2` | `$8C:E09B` | Aktiv | type: u16, flags: u16, x: expr, y: expr | **`SPAWN_NPC`** – Spawnt Entity (`$8E:B55A,X`) mit `flags` an berechneten Pixelkoordinaten `(x, y)` (`$8F:B045`/`$8F:B04A`). |
| `0xA3` | `$8C:D789` | Aktiv | idx: u8 | **`CALL_INDEXED_BYTE`** – Synchroner Subroutinenaufruf über 8-Bit-Index in die globale Sprungtabelle (`$93:8000 + ($93:8000) + ($93:8008) + idx * 3`). |
| `0xA4` | `$8C:D77E` | Aktiv | off: u16 | **`CALL_INDEXED_WORD`** – Synchroner Subroutinenaufruf über 16-Bit-Byte-Offset in die globale Sprungtabelle (`$93:8000 + ($93:8000) + off`). |
| `0xA5` | `$8C:D745` | Aktiv | off: i8 | **`CALL_RELATIVE_BYTE`** – Synchroner Subroutinenaufruf an relative Adresse `stmt_start + (off \| $FF00)` (rückwärts). |
| `0xA6` | `$8C:D729` | Aktiv | off: i16 | **`CALL_RELATIVE_WORD`** – Synchroner Subroutinenaufruf an relative Adresse `stmt_start + off`. |
| `0xA7` | `$8C:D600` | Aktiv | frames: u8 | **`SLEEP` (Byte)** – Pausiert Task für `frames` Ticks (8-Bit, `Task+$03 = 4`). |
| `0xA8` | `$8C:D5F8` | Aktiv | frames: u16 | **`SLEEP_WORD`** – Pausiert Task für `frames` Ticks (16-Bit, `Task+$03 = 4`). |
| `0xA9` | `$8C:EAEB` | Aktiv | target: entity, act: expr | **`TRIGGER_ENTITY_ACTION`** – Führt Entity-Status-/Richtungsbefehl über Sprungtabelle `$8C:EAF9` aus (`0..14`: setzt Blickrichtung `+$22`; `16..54`: setzt/löscht Flags in `+$10`, `+$12`, `+$14`). |
| `0xAA` | `$8C:EBF0` | Aktiv | *keine* | **`SET_CANINE_AI_TARGETING`** – Ruft `$91:B896` für Junge (`$4E89`) und Hund (`$4F37`) auf (mit `SEC` falls `$23C7 == 0`, sonst `CLC` und `STZ $23C7`). |
| `0xAB` | `$8C:ECB2` | Aktiv | *keine* | **`RESET_GAME_STATE`** – Führt Soft-Reset zum Titelbildschirm aus (`JML $8084C9`, Terminal-Befehl). |
| `0xAC` | `$8C:D4A8` | Aktiv | target: expr, spell: expr, level: expr, extra: expr... | **`CAST_ALCHEMY_CHECK_DOG`** – Wie `0x9E`, setzt aber `$3BC1 = $4F37`, falls der Hund 0 HP (`$4F37+$2A == 0`) hat, um ihn aus der Zielliste auszublenden. |
| `0xAD` | `$8C:DB3B` | Aktiv | w1: u16, w2: u16, b1: u8, b2: u8 | **`SET_TEMP_PAIRS_X8`** – Schreibt `b1 * 8` nach `$7E:2834 + w1` und `b2 * 8` nach `$7E:2834 + w2` (6 Bytes). |
| `0xAE` | `$8C:DB08` | Aktiv | arg1: u8, arg2: u8, b1: u8, b2: u8 | **`SET_ARG_PAIRS_X8`** – Schreibt `b1 * 8` nach `Task + $0F + arg1` und `b2 * 8` nach `Task + $0F + arg2` (4 Bytes). |
| `0xAF` | `$8C:D7AF` | Aktiv | count: u8, params: expr[count], addr: u24 | **`CALL_PARAMS`** – Kopiert `count` Ausdrücke via `$8C:D6FE` in den neuen Task-Frame (`+$0F..`) und führt `CALL (0x29)` nach `addr` aus. |
| `0xB0` | `$8C:D786` | Aktiv | count: u8, params: expr[count], idx: u8 | **`CALL_INDEXED_BYTE_PARAMS`** – Evaluiert `count` Parameter via `$8C:D6FE` und führt `CALL_INDEXED_BYTE (0xA3)` aus. |
| `0xB1` | `$8C:D77B` | Aktiv | count: u8, params: expr[count], off: u16 | **`CALL_INDEXED_WORD_PARAMS`** – Evaluiert `count` Parameter via `$8C:D6FE` und führt `CALL_INDEXED_WORD (0xA4)` aus. |
| `0xB2` | `$8C:D735` | Aktiv | count: u8, params: expr[count], off: i8 | **`CALL_RELATIVE_BYTE_PARAMS`** – Evaluiert `count` Parameter via `$8C:D6FE` und führt `CALL_RELATIVE_BYTE (0xA5)` aus (`off` relativ zu `stmt_start`). |
| `0xB3` | `$8C:D71A` | Aktiv | count: u8, params: expr[count], off: i16 | **`CALL_RELATIVE_WORD_PARAMS`** – Evaluiert `count` Parameter via `$8C:D6FE` und führt `CALL_RELATIVE_WORD (0xA6)` aus (`off` relativ zu `stmt_start`). |
| `0xB4` | `$8C:D7E6` | Aktiv | count: u8, params: expr[count], addr: u24 | **`ASYNC_CALL_PARAMS` / `FORK_PARAMS`** – Evaluiert `count` Parameter via `$8C:D6FE` und startet asynchronen Task (`0x07`) bei `addr`. |
| `0xB5` | `$8C:EC1C` | Aktiv | args: expr... (8x) | **`LAUNCH_PROJECTILE_ARC` / `PALETTE_FADE_CUSTOM`** – Spawnt und startet ein Projektil-/Effekt-Objekt mit 8 Ausdrücken via `$90:DCE3` (Tabelle `$90:D9A9,X`). |
| `0xB6` | `$8C:EC5E` | Aktiv | pal: expr, first: expr, last: expr, speed: expr | **`START_PALETTE_CYCLE`** – Lädt ggf. Basispalette via `$8C:EC9A` und startet CGRAM-Farbrotation (`$1374,X..$13F4,X`) via `$90:D532`. |
| `0xB7` | `$8C:EC8B` | Aktiv | slot: expr | **`STOP_PALETTE_CYCLE`** – Setzt ggf. Basispalette via `$8C:EC9A` zurück und beendet CGRAM-Farbrotation (`STZ $13D4,X`). |
| `0xB8` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0xB9` | `$8C:E441` | Aktiv | target: entity, dx: expr, dy: expr | **`TRY_TELEPORT_REL` / `SET_ENTITY_POS_REL`** – Prüft Kollision bei `(Entity.x + dx, Entity.y + dy)` via `$8F:AEF9`; teleportiert falls frei (`$8F:C279`) und schreibt Erfolg (`1`/`0`) nach `$7E:23E3`. |
| `0xBA` | `$8C:E0DA` | Aktiv | type: u8, x: u8, y: u8 | **`SPAWN_NPC_FAST`** – Spawnt Entity (`$8E:B55A,X`) bei `(x*8, y*8)` mit Flags `$08 = $0000` (`$8F:B045`, speichert Entity in `$0341`). |
| `0xBB` | `$8C:E868` | Aktiv | target: entity, val: expr | **`DAMAGE_ENTITY_2` (No Flinch)** – Fügt `target` Schaden mit Zahlen-Popup zu via `$8F:C103` (`Entity+$12 \|= $0018`, ohne `$0020` Treffer-/Rückstoß-Animation; ignoriert unverwundbare Ziele mit `+$10 & $1000`). |
| `0xBC` | `$8C:DF04` | Aktiv | *keine* | **`LOCK_PLAYER_BOY_FAST`** – Sperrt den Jungen (`$4E89`) für Skriptsteuerung (`LDA #$0001; BRA $8CDF1A` $\rightarrow$ `JSL $8FCD0D`, setzt `Entity+$10 \|= $0020`). |
| `0xBD` | `$8C:DEAE` | Aktiv | *keine* | **`UNLOCK_PLAYER_BOY_FAST`** – Gibt den Jungen (`$4E89`) wieder frei (`LDA #$0001; BRA $8CDEC4` $\rightarrow$ `JSL $8FCCE2`, löscht `Entity+$10 &= $DFDE`). |
| `0xBE` | `$8C:DF09` | Aktiv | *keine* | **`LOCK_PLAYER_DOG_FAST`** – Sperrt den Hund (`$4F37`) für Skriptsteuerung (`LDA #$0002; BRA $8CDF1A` $\rightarrow$ `JSL $8FCD0D`). |
| `0xBF` | `$8C:DEB3` | Aktiv | *keine* | **`UNLOCK_PLAYER_DOG_FAST`** – Gibt den Hund (`$4F37`) wieder frei (`LDA #$0002; BRA $8CDEC4` $\rightarrow$ `JSL $8FCCE2`). |
| `0xC0` | `$8C:DF0E` | Aktiv | *keine* | **`LOCK_PLAYER_BOTH_FAST`** – Sperrt Junge (`$4E89`) und Hund (`$4F37`) (`LDA #$0003; BRA $8CDF1A` $\rightarrow$ `JSL $8FCD0D`). |
| `0xC1` | `$8C:DEB8` | Aktiv | *keine* | **`UNLOCK_PLAYER_BOTH_FAST`** – Gibt Junge (`$4E89`) und Hund (`$4F37`) wieder frei (`LDA #$0003; BRA $8CDEC4` $\rightarrow$ `JSL $8FCCE2`). |
| `0xC2` | `$8C:E0C4` | Aktiv | type: u8, x: u8, y: u8 | **`SPAWN_NPC_FLAGGED`** – Spawnt Entity (`$8E:B55A,X`) bei `(x*8, y*8)` mit gesetztem Flag `$08 = $8000` (`$8F:B04A`). |


---

## 7. Text- & Dialog-Steuerzeichen (Verbindung von `0x51`/`0x52` zur Text-Engine)

Wenn ein Skript den Opcode `0x51` (`SHOW_TEXT`) oder `0x52` (`SHOW_TEXT_END`) ausführt, übergibt SIGIL die 16-Bit `text_id` an die Markov-Huffman-Dekomprimierungs-Engine in Bank `$8C:D147` / Bank `$92`.

Im dekodierten Textstrom werden spezielle Steuerbytes interpretiert, die direkt mit SIGIL und dem UI interagieren:

| Steuerbyte | Token in Tools | Auswirkung auf Textbox und Skript |
| :---: | :---: | :--- |
| `0x00` | *Terminator* | Beendet den Textstring. Schließt ggf. das Fenster oder gibt Steuerung an Skript zurück. |
| `0x0A` | `\n` | Zeilenumbruch innerhalb der Textbox. |
| `0x80 lo hi` | `[Pause:n]` | **Pause / Frame-Verzögerung:** Hält den Textaufbau für berechnete Frame-Anzahl (`((hi << 8 \| lo) >> 1) & 0x3FFF` Frames) an. |
| `0x81` | `[Boy]` | **Junge-Name:** Fügt den vom Spieler gewählten Namen des Jungen ein. |
| `0x82` | `[Dog]` | **Hund-Name:** Fügt den vom Spieler gewählten Namen des Hundes ein. |
| `0x86` | `[Wait]` | **Wartet auf Tastendruck & Leeren:** Hält Textausgabe an, bis A- oder B-Knopf gedrückt wird, und leert/schließt anschließend das Textfenster. |
| `0x87` | `[Clear]` | **Fenster sofort leeren:** Löscht sofort den gesamten bisherigen Textinhalt des Fensters. |
| `0x8B` | `[Marker]` | **Auswahlmarker / Menü-Einrückung:** Markiert eine auswählbare Option im Dialog. |
| `0x92` | `[Center]` | **Zentrierung:** Zentriert Textausgabe im Dialogfenster. |
| `0x93` | `[Left]` | **Linksbündig:** Richtet Textausgabe linksbündig aus. |
| `0x96` | `[TypewriterOn]` | **Schreibmaschinen-Effekt ein:** Aktiviert den schrittweisen zeichenweisen Aufbau. |
| `0x97` | `[TypewriterOff]` | **Schreibmaschinen-Effekt aus:** Deaktiviert Schreibmaschinen-Modus (Text sofort ganz darstellen). |
| `0xA1..0xA8` | `[Val1..8]` | **Dynamischer Variablen-Ersatz:** Fügt Zahlen aus `$7E:2535+` ein. |

### Deutsche Sonderzeichen im Zeichensatz
- `0xE3` = `ä`
- `0xEF` = `ö`
- `0xF3` = `ü`
- `0xC6` = `ß`
- `0xCB` = `Ä`
- `0xDB` = `Ö`
- `0xDF` = `Ü`

---

## 8. Map- & Trigger-Integration

Die Ausführung von SIGIL-Skripten wird über drei primäre Mechanismen auf den Maps gestartet:

### A. Map-Enter-Skripte (`$93:801B`)
Jede Map (`0x00` bis `0x7E`) besitzt einen 5-Byte-Eintrag in der globalen Map-Initialisierungstabelle bei `$93:801B`:
```
Offset: $93:801B + (map_id * 5)
Format: [ Target_Script: u24 (gepackt) ] [ Flags: u16 ]
```
Dieses Skript wird beim Betreten des Raumes automatisch als Task 0 initialisiert (Initialisiert NPCs, Türen, Schalterzustände).

### B. Kachel-Trigger (Step-On- & B-Trigger)
Im Header jeder Map (siehe [`docs/maps.md`](maps.md)) sind zwei Trigger-Listen hinterlegt:
- **Step-On-Trigger:** Werden bei Betreten der Kachelkoordinaten gefeuert (Raumübergänge, Falltüren).
- **B-Trigger:** Werden gefeuert, wenn der Spieler vor dem Bereich steht und den B-Knopf drückt (Truhen, Schalter, Bücher).

#### 6-Byte Kachel-Trigger-Format:
```
[ Y1 ] [ X1 ] [ Y2 ] [ X2 ] [ Script_ID (16-Bit Little-Endian) ]
Byte 0  Byte 1  Byte 2  Byte 3  Byte 4..5
```
1. `Script_ID` dient als Offset in die globale Map-Skript-Tabelle ab `$93:8294` (`$93:8000 + Word($93:8000)`).
2. An diesem Offset liegt ein 3-Byte gepackter Zeiger auf den eigentlichen SIGIL-Bytecode.

### C. NPC-Verhaltens- & Ansprech-Skripte
- Über Opcode `0x3D` (`SET_NPC_TALK_SCRIPT`) wird einem NPC ein Skript zugewiesen, das beim Drücken von B ausgeführt wird.
- Über Opcode `0x3F` (`SET_NPC_SCRIPT`) wird ein eigenständiges asynchrones Task-Skript für Patrouillenrouten gestartet.

---

## 9. Detaillierte Bytecode-Zerlegung: Der Töpfer auf dem Markt von Allelachema

Auszug aus dem realen Skript des Keramiktopf-Händlers (Map `0x0A`, Script-Adresse `$97:82AF`):

```
Hex-Bytecode:
2C 08                               // [0000] LOCK_PLAYER 0x08
09 85 2B 00 06 00                   // [0002] IFNOT (FLAG[0x002B]) SKIP +6
51 B8 0E                            // [0008] SHOW_TEXT 0x0EB8 ("Willst Du handeln?")
1D 69 00 AC                         // [000B] TEMP[0x0069] = dialog_response()
09 0E 69 00 29 30 A2 12 00          // [000F] IFNOT (TEMP_WORD[0x0069] == 0) SKIP +18
...
```

### Schritt-für-Schritt-Analyse:
1. `2C 08`:
   - Opcode `0x2C` (`LOCK_PLAYER`), Argument `0x08` $\rightarrow$ Eingaben für Cutscene sperren.
2. `09 85 2B 00 06 00`:
   - Opcode `0x09` (`IFNOT`).
   - Sub-Opcode `0x85` = `0x05 | 0x80` (`Read RAM Flag` + Bit-7-Terminator `Done`).
   - Flag-Index `0x002B` (Markteinlass Allelachema).
   - Relativer Sprung `0x0006` $\rightarrow$ Wenn Einlass nicht gewährt, überspringe 6 Bytes.
3. `51 B8 0E`:
   - Opcode `0x51` (`SHOW_TEXT`), Text-ID `0x0EB8` aus Bank `$92`.
4. `1D 69 00 AC`:
   - Opcode `0x1D` (`WRITE_TEMP_WORD`), Zieladresse `$2834 + 0x0069`.
   - Sub-Opcode `0xAC` = `0x2C | 0x80` (`dialog_response()` + `Done`).
5. `09 0E 69 00 29 30 A2 12 00`:
   - Opcode `0x09` (`IFNOT`).
   - `0x0E 69 00`: Liest `TEMP_WORD[0x0069]`.
   - `0x29`: Push auf den Auswertungs-Stack.
   - `0x30`: Inline-Konstante `0`.
   - `0xA2` = `0x22 | 0x80` (Operator `==` + `Done`). Vergleicht: `TEMP_WORD[0x0069] == 0`.
   - Relativer Sprung `0x0012` $\rightarrow$ Wenn Bedingung nicht zutrifft, springe 18 Bytes weiter zur nächsten Option.

---

## 10. Kompilierung mit `everscript`

Mit dem projektintegrierten Tool [`everscript`](../crates/everscript) können lesbare `.evs`-Skripte direkt in validierten SIGIL-Bytecode assembliert und in ein deutsches ROM oder ein IPS-Patch geschrieben werden:

```c
enum FLAGS {
    MARKT_EINLASS = 0x002B,
    CHOCOBO_EI    = 0x004E,
}

fun pot_trader_dialog() = 0x9782AF {
    lock_player(0x08);
    if (!FLAG[FLAGS.MARKT_EINLASS]) {
        skip(7);
    }
    text(0x0EB8);
    TEMP[0x0069] = dialog_response();
    if (TEMP[0x0069] == 0) {
        text(0x0EC1);
        FLAG[FLAGS.CHOCOBO_EI] = 1;
        give_jewels(10);
    }
    text_hide();
    unlock_player(0x08);
    end();
}
```

Kompilierbefehl:
```bash
everscript compile script.evs --ips patch.ips
```
