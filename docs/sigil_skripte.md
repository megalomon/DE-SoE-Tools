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
   8C:D416: 41 D4  ; Status 8: Dialog-/State-Wait -> $8C:D441 (Wartet auf WRAM-Zustand $7E:2429 == $0005,Y)
   8C:D418: 6B D4  ; Status 10: Entity-/Animations-Wait -> $8C:D46B (Wartet auf Animations-/Bewegungsende von Entity X = $0005,Y an $1080,X)
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
- **28 Handler** (u. a. `0x52 SHOW_TEXT_MODAL`, `0x7E EXCHANGE_MONEY`, `0x7F SHOW_NAMING_SCREEN`, `0x8A OPEN_SHOP_MENU`, `0x8C OPEN_SAVE_MENU`) sowie das Expression-Token `0x2C` (`dialog_response()`) kehren während ihrer Ausführung **nicht sofort zum Scheduler zurück**.
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

### Vollständige Tabelle aller Sub-Opcodes (`0x01` bis `0x6F`)

| Sub-Opcode (`sub`) | Mnemonic / Funktion | Folgende Bytes | Beschreibung |
| :---: | :--- | :---: | :--- |
| `0x30` – `0x3F` | **Inline-Konstante 0..15** | *keine* | Lädt direkt den Wert `sub - 0x30` (`0` bis `15`) in `$02`. |
| `0x60` – `0x6F` | **Inline-Konstante 16..31**| *keine* | Lädt direkt den Wert `sub - 0x60 + 16` (`16` bis `31`). |
| `0x01` | **Negative Byte-Konstante** | `b: u8` | Liest Byte `b`, setzt High-Word auf `$FFFF` und Low-Word auf `$FF00 \| b`. Wert ist immer `-256 + b` (`-256` bis `-1`). |
| `0x02` | **Unsigned Byte** | `val: u8` | 8-Bit Integer ohne Vorzeichen (`0` bis `255`). |
| `0x03` | **32-Bit Konstante ($FFFF High)** | `val: u16` | Liest 16-Bit-Word `w` in `$02` und setzt `$04` bedingungslos auf `$FFFF` (Wert `-65536 + w`, wird im ROM nie benutzt). |
| `0x04` | **Unsigned Word** | `val: u16` | 16-Bit Integer ohne Vorzeichen (`0` bis `65535`, Little-Endian). |
| `0x05` | **Read RAM Flag** | `id: u16` | Liest Bit `FLAG[id]` aus dem persistenten WRAM ab `$7E2258`. |
| `0x0A` | **Read Temp Flag** | `id: u16` | Liest Bit `TEMP_FLAG[id]` aus dem Scratchpad ab `$7E2834`. |
| `0x06` | **Read Signed RAM Byte** | `addr: u16` | Liest `(i8) RAM[$7E2258 + addr]`. |
| `0x07` | **Read Unsigned RAM Byte** | `addr: u16` | Liest `(u8) RAM[$7E2258 + addr]`. |
| `0x08` | **Read Signed RAM Word** | `addr: u16` | Liest `(i16) RAM_WORD[$7E2258 + addr]`. |
| `0x09` | **Read Unsigned RAM Word** | `addr: u16` | Liest `(u16) RAM_WORD[$7E2258 + addr]`. |
| `0x0B` | **Read Signed Temp Byte** | `addr: u16` | Liest `(i8) TEMP[$7E2834 + addr]`. |
| `0x0C` | **Read Unsigned Temp Byte** | `addr: u16` | Liest `(u8) TEMP[$7E2834 + addr]`. |
| `0x0D` | **Read Signed Temp Word** | `addr: u16` | Liest `(i16) TEMP_WORD[$7E2834 + addr]`. |
| `0x0E` | **Read Unsigned Temp Word** | `addr: u16` | Liest `(u16) TEMP_WORD[$7E2834 + addr]`. |
| `0x0F` | **Test Script Arg Bit** | `bit: u8` | Prüft Bit in Subroutinen-Argument. |
| `0x10` | **Read Signed Arg Byte** | `arg: u8` | Liest Byte-Argument. |
| `0x11` | **Read Unsigned Arg Byte** | `arg: u8` | Liest Byte-Argument. |
| `0x12` | **Read Signed Arg Word** | `arg: u8` | Liest Word-Argument. |
| `0x13` | **Read Unsigned Arg Word** | `arg: u8` | Liest Word-Argument. |

### Unäre & Binäre Operatoren

| Sub-Opcode | Mnemonic | Syntax | Beschreibung |
| :---: | :---: | :---: | :--- |
| `0x14` | **NOT** | `!expr` | Logisches NOT (`0` wird `1`, alles andere `0`). |
| `0x15` | **BIT_NOT** | `~expr` | Bitweises Einerkomplement. |
| `0x16` | **NEG** | `-expr` | Vorzeichenumkehr (Zweierkomplement). |
| `0x29` | **PUSH** | — | Schiebt DP `$02` auf den 65816 CPU-Stack. |
| `0x17` | **MUL** | `a * b` | 16-Bit Multiplikation. |
| `0x18` | **DIV** | `a / b` | Ganzzahlige Division. |
| `0x1A` | **ADD** | `a + b` | 16-Bit Addition (`CLC; ADC`). |
| `0x1B` | **SUB** | `a - b` | 16-Bit Subtraktion (`SEC; SBC`). |
| `0x1C` | **SHL** | `a << b`| Bitweiser Linksshift. |
| `0x1D` | **SHR** | `a >> b`| Bitweiser Rechtsshift. |
| `0x1E` | **LT** | `a < b` | Kleiner als (signed). |
| `0x1F` | **GT** | `a > b` | Größer als (signed). |
| `0x20` | **LE** | `a <= b`| Kleiner oder gleich (signed). |
| `0x21` | **GE** | `a >= b`| Größer oder gleich (signed). |
| `0x22` | **EQ** | `a == b`| Gleichheit (`1` wenn gleich, sonst `0`). |
| `0x23` | **NE** | `a != b`| Ungleichheit (`1` wenn ungleich, sonst `0`). |
| `0x24` | **BIT_AND** | `a & b` | Bitweises UND. |
| `0x25` | **BIT_OR** | `a \| b`| Bitweises ODER. |
| `0x26` | **BIT_XOR** | `a ^ b` | Bitweises Exklusiv-ODER. |
| `0x27` | **LOG_OR** | `a \|\| b`| Logisches ODER (`1` wenn mindestens ein Operand ungleich 0). |
| `0x28` | **LOG_AND** | `a && b`| Logisches UND (`1` wenn beide Operanden ungleich 0). |

### Funktionen & Entity-Ziel-Selektoren

| Sub-Opcode | Mnemonic | Beschreibung |
| :---: | :--- | :--- |
| `0x2A` | **`rand()`** | Liefert 16-Bit Pseudozufallszahl aus RNG-Register. |
| `0x2B` | **`rand(max)`** | Liefert Zufallszahl im Intervall `[0, max - 1]`. |
| `0x2C` | **`dialog_response()`**| Liefert Spieler-Auswahl im `[Marker]`-Dialogmenü (`0`, `1`, etc.). |
| `0x50` / `0xD0`| **`PLAYER_BOY`** | Adressiert den Jungen als Entity-Ziel. |
| `0x51` / `0xD1`| **`PLAYER_DOG`** | Adressiert den Hund als Entity-Ziel. |
| `0x52` / `0xD2`| **`CONTROLLED`** | Adressiert die aktuell vom Spieler gelenkte Spielfigur. |
| `0x53` / `0xD3`| **`NON_CONTROLLED`** | Adressiert den KI-gesteuerten Begleiter. |
| `0xAD` | **`LAST_ENTITY`** | Zuletzt interagierter NPC oder auslösendes Sprite. |
| `0xAE` | **`ATTACHED_ENTITY`**| An das Skript gebundenes Objekt. |

---

## 6. Master-Tabelle aller 195 Opcodes (`0x00` bis `0xC2`)

Die primäre Sprungtabelle liegt bei `$8C:ECBE` (`0x0CECBE`) und umfasst exakt **195 Einträge**. Jeder einzelne Opcode ist im Folgenden auf Basis der 65816-Binärroutinen der deutschen ROM dokumentiert:

| Opcode | Handler | Status | Argumente | Mnemonic / Funktion |
| :---: | :---: | :---: | :--- | :--- |
| `0x00` | `$8C:D6CA` | Aktiv | *keine* | **`END` / `RETURN`** – Subroutinen-Rücksprung (falls Caller-Link aktiv) oder Task-Terminierung. |
| `0x01` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzter Opcode (verweist auf 65816-CPU-Halt `STP`). |
| `0x02` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzter Opcode (verweist auf 65816-CPU-Halt `STP`). |
| `0x03` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzter Opcode (verweist auf 65816-CPU-Halt `STP`). |
| `0x04` | `$8C:D81D` | Aktiv | off: i16 | **`SKIP`** – Relativer Sprung im Skript um 16-Bit-Word. |
| `0x05` | `$8C:D811` | Aktiv | off: u8 | **`SKIP_BACK`** – Relativer Rückwärtssprung um `256 - off` Bytes (Zieladresse: `stmt_start - 256 + off`). Terminal-Befehl am Schleifenende. |
| `0x06` | `$8C:ECB6` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (verweist auf 65816-CPU-Halt `STP`). |
| `0x07` | `$8C:D7E9` | Aktiv | addr: u24 | **`ASYNC_CALL`** – Startet Subskript asynchron in neuem Task-Slot ($7E:2F28). |
| `0x08` | `$8C:D84E` | Aktiv | cond: expr, off: i16 | **`IF`** – Verzweigt um `off`, falls Bedingung `cond` wahr (ungleich 0) ist. |
| `0x09` | `$8C:D85D` | Aktiv | cond: expr, off: i16 | **`IFNOT`** – Verzweigt um `off`, falls Bedingung `cond` falsch (gleich 0) ist. |
| `0x0A` | `$8C:D87A` | Aktiv | cur: expr, amt: u24, off: i16 | **`IF_MONEY_GE`** – Verzweigt, wenn Währung `cur >= amt`. |
| `0x0B` | `$8C:D8B9` | Aktiv | cur: expr, amt: u24, off: i16 | **`IF_MONEY_LT`** – Verzweigt, wenn Währung `cur < amt`. |
| `0x0C` | `$8C:DC27` | Aktiv | bit: u16, val: expr | **`SET_RAM_FLAG`** – Schreibt Ergebnis von `val` in Story-Bitfield `FLAG[bit]`. |
| `0x0D` | `$8C:DC17` | Aktiv | bit: u16, val: expr | **`SET_TEMP_FLAG`** – Schreibt Ergebnis in Scratchpad-Bitfield `TEMP_FLAG[bit]`. |
| `0x0E` | `$8C:DC05` | Aktiv | bit: u8, val: expr | **`SET_ARG_BIT`** – Schreibt Ergebnis in ein Bit eines Subroutinen-Arguments. |
| `0x0F` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x10` | `$8C:DBED` | Aktiv | addr: u16, val: expr | **`WRITE_RAM_BYTE`** – Schreibt 8-Bit-Wert in `$7E:2258 + addr`. |
| `0x11` | `$8C:DBE8` | Aktiv | addr: u16, val: expr | **`WRITE_TEMP_BYTE`** – Schreibt 8-Bit-Wert in Scratchpad `$7E:2834 + addr`. |
| `0x12` | `$8C:DBCF` | Aktiv | arg: u8, val: expr | **`WRITE_ARG_BYTE`** – Schreibt 8-Bit-Wert in Subroutinen-Argument `arg`. |
| `0x13` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x14` | `$8C:DBED` | *Alias* | addr: u16, val: expr | **`WRITE_RAM_BYTE`** – Alias zu Opcode 0x10. |
| `0x15` | `$8C:DBE8` | *Alias* | addr: u16, val: expr | **`WRITE_TEMP_BYTE`** – Alias zu Opcode 0x11. |
| `0x16` | `$8C:DBCF` | *Alias* | arg: u8, val: expr | **`WRITE_ARG_BYTE`** – Alias zu Opcode 0x12. |
| `0x17` | `$8C:DB86` | Aktiv | addr: u16, val: u16 | **`WRITE_VAR_FAST`** – Schnelles Word-Schreiben direkt in WRAM ohne Expression-Engine. |
| `0x18` | `$8C:DBBA` | Aktiv | addr: u16, val: expr | **`WRITE_RAM_WORD`** – Schreibt 16-Bit-Word in `$7E:2258 + addr`. |
| `0x19` | `$8C:DBB5` | Aktiv | addr: u16, val: expr | **`WRITE_TEMP_WORD`** – Schreibt 16-Bit-Word in Scratchpad `$7E:2834 + addr`. |
| `0x1A` | `$8C:DB9C` | Aktiv | arg: u8, val: expr | **`WRITE_ARG_WORD`** – Schreibt 16-Bit-Word in Subroutinen-Argument `arg`. |
| `0x1B` | `$8C:DB54` | Aktiv | w1: u16, w2: u16, b1: u8, b2: u8 | **`COPY_RAM_WORDS` / `SET_RAM_PAIRS_X8`** – Liest 6 Bytes (`w1: u16, w2: u16, b1: u8, b2: u8`) und schreibt `b1*8` nach `$2258+w1` sowie `b2*8` nach `$2258+w2` (6 Bytes; in Tools historisch als 3 Words `src, dst, len` notiert). |
| `0x1C` | `$8C:DBBA` | *Alias* | addr: u16, val: expr | **`WRITE_RAM_WORD`** – Alias zu Opcode 0x18. |
| `0x1D` | `$8C:DBB5` | *Alias* | addr: u16, val: expr | **`WRITE_TEMP_WORD`** – Alias zu Opcode 0x19. |
| `0x1E` | `$8C:DB9C` | *Alias* | arg: u8, val: expr | **`WRITE_ARG_WORD`** – Alias zu Opcode 0x1A. |
| `0x1F` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x20` | `$8C:DFD9` | Aktiv | x: u8, y: u8 | **`SET_CAMERA_BOUNDS`** – Setzt Kamera-Scrolling-Grenzen (Multiplikation mit 8 in DP $46/$48). |
| `0x21` | `$8C:DFA2` | Aktiv | x: u8, y: u8 | **`CAMERA_FOLLOW`** – Bindet Kamera-Fokus an Koordinaten (Terminal-Befehl). |
| `0x22` | `$8C:DF5A` | Aktiv | x: u8, y: u8, map: u16 | **`CHANGE_MAP`** – Teleportiert Spielfigur in neuen Raum `map` an Position `(x, y)` (Terminal-Befehl). |
| `0x23` | `$8C:E806` | Aktiv | scroll: u16 | **`SET_MAP_SCROLL`** – Manueller Scroll-Offset für Kachelkarten in WRAM `$0E70`. |
| `0x24` | `$8C:ECB7` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x25` | `$8C:ECB8` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x26` | `$8C:E007` | Aktiv | *keine* | **`FADE_IN`** – Hellt den Bildschirm aus Schwarz auf Normalhelligkeit auf (Helligkeit auf `$0F`). |
| `0x27` | `$8C:DFF9` | Aktiv | *keine* | **`FADE_OUT`** – Dunkelt den Bildschirm schrittweise bis Schwarz ab (Forced Blanking `$80`). |
| `0x28` | `$8C:ECB9` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x29` | `$8C:D7B2` | Aktiv | addr: u24 | **`CALL`** – Synchroner Subroutinen-Aufruf (speichert Rückkehr-Link in `+0x0B`). |
| `0x2A` | `$8C:DF50` | Aktiv | target: entity | **`FREEZE_ENTITY`** – Friert Aktionen und Bewegungen einer Figur ein. |
| `0x2B` | `$8C:DEFA` | Aktiv | target: entity | **`UNFREEZE_ENTITY`** – Gibt eingefrorene Spielfigur/NPC wieder frei. |
| `0x2C` | `$8C:DF13` | Aktiv | flags: u8 | **`LOCK_PLAYER`** – Sperrt Controller-Eingaben für Dialoge und Zwischensequenzen. |
| `0x2D` | `$8C:DEBD` | Aktiv | flags: u8 | **`UNLOCK_PLAYER`** – Hebt Eingabespalte auf und gibt Kontrolle an Spieler zurück. |
| `0x2E` | `$8C:D62D` | Aktiv | cond: expr | **`WAIT_UNTIL`** – Pausiert den Skript-Task, bis Bedingung `cond` wahr wird. |
| `0x2F` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x30` | `$8C:DA90` | Aktiv | sfx_id: u8 | **`PLAY_SFX_1`** – Spielt Soundeffekt auf Kanal 1 (`sfx_id` ist Byte-Index in ROM-Tabelle `$8C:8700`, Aufruf `$8C:8662`). |
| `0x31` | `$8C:DA90` | Aktiv | sfx_id: u8 | **`PLAY_SFX_2`** – Spielt Soundeffekt auf Kanal 2 (`sfx_id` ist Byte-Index in ROM-Tabelle `$8C:8700`, Aufruf `$8C:8662`). |
| `0x32` | `$8C:DA90` | Aktiv | sfx_id: u8 | **`PLAY_SFX_3`** – Spielt Soundeffekt auf Kanal 3 (`sfx_id` ist Byte-Index in ROM-Tabelle `$8C:8700`, Aufruf `$8C:8662`). |
| `0x33` | `$8C:DABF` | Aktiv | track_id: u8 | **`PLAY_BGM`** – Wechselt Hintergrundmusik (`track_id` ist gerader Byte-Offset `0x02`, `0x04`, `0x5C`, `0x78` etc. in 16-Bit-BGM-Tabelle `$8C:87E0`, Aufruf `$8C:84F1`). |
| `0x34` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x35` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x36` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x37` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x38` | `$8C:D5F6` | Aktiv | *keine* | **`YIELD`** – Gibt CPU für den aktuellen Frame an die Game-Engine ab (`CLC; RTS`). |
| `0x39` | `$8C:D609` | Aktiv | frames: expr | **`SLEEP_SUB`** – Pausiert Task für dynamisch berechnete Anzahl Frames. |
| `0x3A` | `$8C:D5F6` | *Alias* | *keine* | **`YIELD`** – Alias zu Opcode 0x38. |
| `0x3B` | `$8C:D609` | *Alias* | frames: expr | **`SLEEP_SUB`** – Alias zu Opcode 0x39. |
| `0x3C` | `$8C:E0ED` | Aktiv | type: u16, param: u16, x: u8, y: u8 | **`SPAWN_NPC_PARAM`** – Erzeugt NPC über Tabelle `$8E:B55A` mit 16-Bit Zusatzparameter. |
| `0x3D` | `$8C:E14C` | Aktiv | ent: expr, val: u16 | **`SET_NPC_TALK_SCRIPT`** – Weist NPC Script/Param zu (`E w`). |
| `0x3E` | `$8C:ECBC` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x3F` | `$8C:E161` | Aktiv | expr: expr, w1: u16, w2: u16 | **`SET_NPC_SCRIPT`** – Startet Verhaltensskript auf NPC (`E w w`). |
| `0x40` | `$8C:ECBB` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x41` | `$8C:ECBA` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x42` | `$8C:E3EF` | Aktiv | target: entity, x: u8, y: u8 | **`TELEPORT_ENTITY`** – Setzt Position einer Entity auf feste Kachel-Koordinaten. |
| `0x43` | `$8C:E40E` | Aktiv | target: expr, x: expr, y: expr | **`TELEPORT_ENTITY_EXPR`** – Setzt Position anhand dynamisch berechneter Koordinaten (`E E E`). |
| `0x44` | `$8C:DC79` | Aktiv | win: u8, x: u8, y: u8, w: u8, h: u8 | **`SET_WINDOW_0_SIZE`** – Setzt Fenster-ID, Position und Maße für Textfenster 0 via `$8C:DD50` (5 Bytes). |
| `0x45` | `$8C:DC79` | Aktiv | win: u8, x: u8, y: u8, w: u8, h: u8 | **`SET_WINDOW_1_SIZE`** – Setzt Fenster-ID, Position und Maße für Textfenster 1 via `$8C:DD50` (5 Bytes). |
| `0x46` | `$8C:DC79` | Aktiv | win: u8, x: u8, y: u8, w: u8, h: u8 | **`SET_WINDOW_2_SIZE`** – Setzt Fenster-ID, Position und Maße für Textfenster 2 via `$8C:DD50` (5 Bytes). |
| `0x47` | `$8C:DC79` | Aktiv | win: u8, x: u8, y: u8, w: u8, h: u8 | **`SET_WINDOW_3_SIZE`** – Setzt Fenster-ID, Position und Maße für Textfenster 3 via `$8C:DD50` (5 Bytes). |
| `0x48` | `$8C:DCE7` | Aktiv | *keine* | **`RESET_WINDOW_0_DEFAULT`** – Setzt Textfenster 0 auf Standardmaße (2, 2, 28, 10). |
| `0x49` | `$8C:DCE7` | Aktiv | *keine* | **`RESET_WINDOW_1_DEFAULT`** – Setzt Textfenster 1 auf Standardmaße. |
| `0x4A` | `$8C:DCE7` | Aktiv | *keine* | **`RESET_WINDOW_2_DEFAULT`** – Setzt Textfenster 2 auf Standardmaße. |
| `0x4B` | `$8C:DCE7` | Aktiv | *keine* | **`RESET_WINDOW_3_DEFAULT`** – Setzt Textfenster 3 auf Standardmaße. |
| `0x4C` | `$8C:DC65` | Aktiv | dummy: u8 | **`NOP_SKIP_BYTE`** – Überspringt 1 Byte im Skript und fährt sofort fort (`SEC; RTS`). |
| `0x4D` | `$8C:DC67` | Aktiv | *keine* | **`NOP`** – Keine Operation; sofortige Fortsetzung im selben Frame. |
| `0x4E` | `$8C:E1B1` | Aktiv | target: entity | **`DESPAWN_ENTITY`** – Entfernt Sprite/NPC vollständig von der Map. |
| `0x4F` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x50` | `$8C:DDE6` | Aktiv | vram: u8, text_id: u16 | **`SHOW_TEXT_VRAM`** – Lädt Text mit expliziter VRAM-Layer-Zuweisung. |
| `0x51` | `$8C:DDF3` | Aktiv | text_id: u16 | **`SHOW_TEXT`** – Öffnet Textbox und startet Huffman-Dekomprimierung aus Bank $92. |
| `0x52` | `$8C:DD87` | Aktiv | text_id: u16 | **`SHOW_TEXT_MODAL`** – Trägt Text in Message-Queue (`$8C:D0F6`) ein, ruft `$8C:C8E4` auf und kehrt mit gesetztem Carry zurück. |
| `0x53` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x54` | `$8C:DD65` | Aktiv | vram: u8 | **`HIDE_TEXT_VRAM`** – Schließt Textfenster in spezifischem VRAM-Layer. |
| `0x55` | `$8C:DD71` | Aktiv | *keine* | **`HIDE_TEXT`** – Schließt die aktive Textbox sofort. |
| `0x56` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x57` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x58` | `$8C:E088` | Aktiv | *keine* | **`FADE_IN_MUSIC`** – Blendet Musiklautstärke allmählich ein (keine Operanden). |
| `0x59` | `$8C:E075` | Aktiv | *keine* | **`FADE_OUT_MUSIC`** – Blendet Musiklautstärke allmählich aus (keine Operanden). |
| `0x5A` | `$8C:E290` | Aktiv | *keine* | **`DISABLE_INTERRUPTS`** – Sperrt NMI- und Interrupt-Trigger für kritische Skriptsequenzen. |
| `0x5B` | `$8C:E296` | Aktiv | *keine* | **`ENABLE_INTERRUPTS`** – Gibt NMI- und Interrupt-Trigger wieder frei. |
| `0x5C` | `$8C:E1CC` | Aktiv | obj: expr, state: expr | **`SET_OBJECT_STATE`** – Setzt Schalter-, Truhen- oder Kachel-Status auf expliziten Wert (`E E`). |
| `0x5D` | `$8C:E200` | Aktiv | obj: expr, flag: u16 | **`CONDITIONAL_UNLOAD`** – Entfernt Sprite/Kachel, falls Story-Flag aktiv ist (`E w`). |
| `0x5E` | `$8C:E22F` | Aktiv | obj: expr, flag: u16 | **`UNLOAD_IF_FLAG_CLEAR`** – Entfernt Sprite/Kachel, falls Story-Flag inaktiv ist (`E w`). |
| `0x5F` | `$8C:E278` | Aktiv | obj: expr, delta: u16 | **`ADD_OBJECT_STATE`** – Addiert Delta-Wert auf Kachel-Status (`E w`). |
| `0x60` | `$8C:E1DC` | Aktiv | obj: expr | **`INC_OBJECT_STATE`** – Inkrementiert Kachel-Status um 1 (z. B. Schalter weiterdrehen). |
| `0x61` | `$8C:E1EE` | Aktiv | obj: expr | **`DEC_OBJECT_STATE`** – Dekrementiert Kachel-Status um 1. |
| `0x62` | `$8C:E3D0` | Aktiv | id: u8, x: u16, y: u16 | **`SET_AMBIENT_ACTOR_POS`** – Weist Ambient-/Projektil-Slot `$507D` Zielkoordinaten zu via `$90A2A7`. |
| `0x63` | `$8C:E376` | Aktiv | *keine* | **`WAIT_PATH_END`** – Wartet, bis die Entity das Ende des Kachelpfads erreicht hat. |
| `0x64` | `$8C:E29C` | Aktiv | speed: expr | **`SET_BG1_SCROLL_SPEED`** – Setzt Scrollgeschwindigkeit für Hintergrund-Layer BG1. |
| `0x65` | `$8C:E2B5` | Aktiv | *keine* | **`ENABLE_BG1`** – Aktiviert Rendering von Hintergrund-Layer BG1. |
| `0x66` | `$8C:E2AC` | Aktiv | *keine* | **`DISABLE_BG1`** – Deaktiviert Rendering von Hintergrund-Layer BG1. |
| `0x67` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x68` | `$8C:E2BE` | Aktiv | speed: expr | **`SET_BG2_SCROLL_SPEED`** – Setzt Scrollgeschwindigkeit für Hintergrund-Layer BG2. |
| `0x69` | `$8C:E2D7` | Aktiv | *keine* | **`ENABLE_BG2`** – Aktiviert Rendering von Hintergrund-Layer BG2. |
| `0x6A` | `$8C:E2CE` | Aktiv | *keine* | **`DISABLE_BG2`** – Deaktiviert Rendering von Hintergrund-Layer BG2. |
| `0x6B` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x6C` | `$8C:DE50` | Aktiv | target: entity, dx: i8, dy: i8 | **`MOVE_ENTITY_REL`** – Relative Bewegung einer Entity um Pixel-Deltas. |
| `0x6D` | `$8C:DE18` | Aktiv | target: expr, dx: expr, dy: expr | **`STOP_ENTITY_MOVE`** – Stoppt laufende Pixelbewegung einer Entity (`E E E`). |
| `0x6E` | `$8C:DE49` | Aktiv | target: entity, dx: i8, dy: i8 | **`MOVE_ENTITY_FAST`** – Schnelle relative Bewegung (Sprint/Dash). |
| `0x6F` | `$8C:DE11` | Aktiv | target: expr, dx: expr, dy: expr | **`STOP_ENTITY_FAST`** – Stoppt schnelle Bewegung einer Entity (`E E E`). |
| `0x70` | `$8C:E30E` | Aktiv | a: expr, b: expr | **`ENTITY_FACE_ENTITY`** – Dreht Figur `a` in Blickrichtung von Figur `b` (`E E`). |
| `0x71` | `$8C:E31E` | Aktiv | a: expr, b: expr | **`FACE_EACH_OTHER`** – Dreht Figuren `a` und `b` gegenseitig zueinander (`E E`). |
| `0x72` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x73` | `$8C:DE76` | Aktiv | target: expr, x: expr, y: expr | **`MOVE_ENTITY_ABS`** – Lässt Spielfigur linear zu Koordinaten laufen (`E E E`). |
| `0x74` | `$8C:E2E0` | Aktiv | target: entity | **`CLEAR_ENTITY_FLAGS`** – Löscht Kollisions- und Transparenz-Sonderflags an `+$22`. |
| `0x75` | `$8C:E2F6` | Aktiv | target: entity | **`SET_ENTITY_NOCLIP`** – Setzt Noclip-Flag `$08` (ignoriert Hindernisse und Kachelkollision). |
| `0x76` | `$8C:E302` | Aktiv | target: entity | **`SET_ENTITY_TRANSPARENT_NOCLIP`** – Aktiviert Halbtransparenz und Noclip (Flags `$0C`). |
| `0x77` | `$8C:E2EA` | Aktiv | target: entity | **`SET_ENTITY_TRANSPARENT`** – Aktiviert Halbtransparenz (Flag `$04`, z. B. Geistereffekt). |
| `0x78` | `$8C:E4B1` | Aktiv | target: entity, anim: u16, speed: expr | **`SET_ANIMATION`** – Weist Entity Animationssequenz `anim` mit Tempo `speed` zu. |
| `0x79` | `$8C:E557` | Aktiv | target: entity, anim: u16, speed: expr | **`SET_ANIMATION_WAIT`** – Startet Animationssequenz via `$8C:E4B1` und pausiert Task bis zum Abschluss (Status 6). |
| `0x7A` | `$8C:E48F` | Aktiv | target: expr, val: expr | **`WRITE_DEREF`** – 16-Bit Word via Zeiger schreiben (`*(u16*)target = val`). |
| `0x7B` | `$8C:E49E` | Aktiv | target: expr, val: expr | **`WRITE_DEREF_BYTE`** – 8-Bit Byte via Zeiger schreiben (`*(u8*)target = val`). |
| `0x7C` | `$8C:D940` | Aktiv | cur: expr, amt: u24 | **`GIVE_MONEY`** – Addiert 24-Bit-Betrag `amt` zur gewählten Währung `cur`. |
| `0x7D` | `$8C:D8EA` | Aktiv | cur: expr, amt: u24 | **`TAKE_MONEY`** – Zieht 24-Bit-Betrag `amt` von der gewählten Währung `cur` ab. |
| `0x7E` | `$8C:D993` | Aktiv | a: expr, b: expr, c: expr | **`EXCHANGE_MONEY`** – Geldwechsel/Arithmetik mit 3 Ausdrücken (`E E E`). |
| `0x7F` | `$8C:E57B` | Aktiv | target: u16 | **`SHOW_NAMING_SCREEN`** – Öffnet Namenseingabe-Bildschirm (im ROM `target = 3` für Hund). |
| `0x80` | `$8C:E604` | Aktiv | *keine* | **`SHOW_HUD_ALL`** – Blendet HP- und Ring-Menü-HUD vollständig ein. |
| `0x81` | `$8C:E60A` | Aktiv | *keine* | **`HIDE_HUD_ALL`** – Blendet gesamtes HUD für Zwischensequenzen aus. |
| `0x82` | `$8C:E610` | Aktiv | *keine* | **`RESTORE_MAIN_SCREEN_LAYERS`** – Kopiert `$7E:235B..235E` in PPU-Register `$212C..$2131`. |
| `0x83` | `$8C:E648` | Aktiv | *keine* | **`SET_SUB_SCREEN_LAYERS`** – Kopiert `$0F82..0F85` in Sub-Screen PPU-Register. |
| `0x84` | `$8C:D971` | Aktiv | currency: expr, amount: expr | **`GIVE_MONEY_EXPR`** – Geldüberweisung mit dynamisch berechnetem Betrag (`E E`). |
| `0x85` | `$8C:D91B` | Aktiv | currency: expr, amount: expr | **`TAKE_MONEY_EXPR`** – Geldabzug mit dynamisch berechnetem Betrag (`E E`). |
| `0x86` | `$8C:E67C` | Aktiv | val: expr | **`APU_SOUND_CMD_28`** – Sendet Sound-/Musik-Kommando `$28` mit Parameter an APU-Port `$2142`. |
| `0x87` | `$8C:E696` | Aktiv | val: expr | **`APU_SOUND_CMD_2A`** – Sendet Sound-/Musik-Kommando `$2A` mit Parameter an APU-Port `$2142`. |
| `0x88` | `$8C:E6AB` | Aktiv | *keine* | **`CLEAR_SHOP_MENU`** – Leert den Händler-Warenpuffer an `$0B97`. |
| `0x89` | `$8C:E6B6` | Aktiv | item: expr, count: expr | **`ADD_SHOP_ITEM`** – Fügt Gegenstand zum Händler-Puffer `$0B97` hinzu (`E E`). |
| `0x8A` | `$8C:E758` | Aktiv | shop_id: expr | **`OPEN_SHOP_MENU`** – Öffnet Händler-Ringmenü (Expression-Operand via Evaluator `$8C:EE44`). |
| `0x8B` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0x8C` | `$8C:E79B` | Aktiv | point_id: u16 | **`OPEN_SAVE_MENU`** – Öffnet das Speicherbuch-Menü (16-Bit Word Operand). |
| `0x8D` | `$8C:E786` | Aktiv | intensity: u8 | **`SCREEN_SHAKE`** – Startet Bildschütteln (`intensity > 0`) oder stoppt es (`0`). |
| `0x8E` | `$8C:D86C` | Aktiv | a: expr, b: expr, off: i16 | **`IF_EQUAL`** – Verzweigt um `off`, falls Ausdruck `a == b` ist. |
| `0x8F` | `$8C:D8AB` | Aktiv | a: expr, b: expr, off: i16 | **`IF_NOT_EQUAL`** – Verzweigt um `off`, falls Ausdruck `a != b` ist. |
| `0x90` | `$8C:E02A` | Aktiv | level: expr | **`SET_BRIGHTNESS_EXPR`** – Setzt Bildschirm-Helligkeit (0..15) anhand dynamischen Ausdrucks. |
| `0x91` | `$8C:E051` | Aktiv | level: expr | **`SET_BRIGHTNESS_ALT`** – Setzt Bildschirm-Helligkeit (0..15) an `$0106`/`$0B8B` anhand dynamischen Ausdrucks. |
| `0x92` | `$8C:E831` | Aktiv | target: entity, focus: expr | **`SET_ENTITY_TARGET`** – Setzt AI-Kampf- und Verfolgungsfokus an `Entity+$46`. |
| `0x93` | `$8C:E887` | Aktiv | target: entity, amount: expr | **`DAMAGE_ENTITY`** – Fügt Entity Schaden zu via `$8F:C0C7` (addiert auf Schadenspuffer `Entity+$76`, setzt Flag `$0008` in `+$12`). |
| `0x94` | `$8C:E811` | Aktiv | target: entity, amount: expr | **`HEAL_ENTITY`** – Heilt Entity mit grünem Zahlen-Popup via `$8F:C02F` (Popup `$90:D87B`, `ADC Entity+$2A` gedeckelt auf Max-HP). |
| `0x95` | `$8C:E821` | Aktiv | target: entity, hp: expr | **`SET_ENTITY_HP`** / **`HEAL_SILENT`** – Stille Heilung via `$8F:C03A` (`ADC Entity+$2A` ohne Popup). Hinweis: ROM besitzt keinen Opcode zum absoluten Setzen von HP. |
| `0x96` | `$8C:E89E` | Aktiv | x: expr, y: expr | **`SET_CAMERA_BASE`** – Verschiebt die Basis-Kamerakoordinaten via `$90A006`. |
| `0x97` | `$8C:E8B2` | Aktiv | args: expr... (7x) | **`SHAKE_SCREEN_COMPLEX`** – Komplexer Erdbebeneffekt via `$90A370` (Richtung, Frequenz, Amplitude, Dämpfung). |
| `0x98` | `$8C:E9A2` | Aktiv | target: expr | **`SWITCH_CHARACTER`** – Wechselt aktive Spielfigur zwischen Junge (`0`) und Hund (`1`). |
| `0x99` | `$8C:EA70` | Aktiv | a, b, c, d, e, f: expr... | **`ENTER_MODE7_MAP`** – Startet Mode-7-Szene (liest 6 Ausdrücke). |
| `0x9A` | `$8C:EAD0` | Aktiv | pitch: expr | **`MODE7_SET_CAMERA_PITCH`** – Setzt Kamera-Neigungswinkel für Mode-7-Flug in Bank `$C4`. |
| `0x9B` | `$8C:E134` | Aktiv | target: entity | **`ATTACH_CAMERA_TO_ENTITY`** – Koppelt Kamera fest an Figur/NPC. |
| `0x9C` | `$8C:E142` | Aktiv | target: entity | **`DETACH_CAMERA_FROM_ENTITY`** – Löst Kamera von Figur für statische Kameraszenen. |
| `0x9D` | `$8C:DE71` | Aktiv | target: entity, x: expr, y: expr | **`MOVE_ENTITY_ABS_EXPR`** – Absolute Bewegung zu dynamisch berechneten Zielkoordinaten. |
| `0x9E` | `$8C:D4B5` | Aktiv | target: expr, spell: expr, level: expr, extra: expr... | **`CAST_ALCHEMY`** – Löst Alchemiezauber aus (Ausdrücke bis Terminierungs-0). |
| `0x9F` | `$8C:E9B1` | Aktiv | *keine* | **`SHOW_CURRENCY_HUD`** – Blendet Währungsanzeige oben rechts im Bildschirm ein. |
| `0xA0` | `$8C:EA29` | Aktiv | *keine* | **`UPDATE_CURRENCY_HUD`** – Aktualisiert Ziffern der Währungsanzeige via `$8C:B2F2`. |
| `0xA1` | `$8C:EA60` | Aktiv | *keine* | **`HIDE_CURRENCY_HUD`** – Blendet Währungsanzeige oben rechts aus via `$8C:B1AC`. |
| `0xA2` | `$8C:E09B` | Aktiv | type: u16, param: u16, x: expr, y: expr | **`SPAWN_NPC`** – Erzeugt neues Sprite auf der Map über Tabelle `$8E:B55A`. |
| `0xA3` | `$8C:D789` | Aktiv | idx: u8 | **`CALL_INDEXED_BYTE`** – Subroutinenaufruf über 8-Bit-Offset in Sprungtabelle `$93:8000`. |
| `0xA4` | `$8C:D77E` | Aktiv | idx: u16 | **`CALL_INDEXED_WORD`** – Subroutinenaufruf über 16-Bit-Offset in Sprungtabelle `$93:8000`. |
| `0xA5` | `$8C:D745` | Aktiv | off: i8 | **`CALL_RELATIVE_BYTE`** – Relativer Subroutinen-Aufruf (8-Bit Offset) mit Caller-Link in `+0x0B`. |
| `0xA6` | `$8C:D729` | Aktiv | off: i16 | **`CALL_RELATIVE_WORD`** – Relativer Subroutinen-Aufruf (16-Bit Offset) mit Caller-Link in `+0x0B`. |
| `0xA7` | `$8C:D600` | Aktiv | frames: u8 | **`SLEEP_SHORT`** – Pausiert Task für 8-Bit Frame-Zähler (bis 255 Ticks) via Status 4. |
| `0xA8` | `$8C:D5F8` | Aktiv | frames: u16 | **`SLEEP_ALIGNED`** – Pausiert Task für `frames` Ticks mit VBlank-Ausrichtung. |
| `0xA9` | `$8C:EAEB` | Aktiv | target: entity, act: expr | **`TRIGGER_ENTITY_ACTION`** – Löst Entity-Aktion aus (Tabelle `$8C:EAF9`: Hüpfen, Treffer, etc.). |
| `0xAA` | `$8C:EBF0` | Aktiv | *keine* | **`SET_CANINE_AI_TARGETING`** – Schaltet Hund-AI-Such- und Schnüffelmodus an `$7E:23C7` via `$91B896` (keine Operanden). |
| `0xAB` | `$8C:ECB2` | Aktiv | *keine* | **`RESET_GAME_STATE`** – Führt Soft-Reset zu Spielstart aus (`JMP $8084C9`, Terminal-Befehl). |
| `0xAC` | `$8C:D4A8` | Aktiv | target: expr, spell: expr, level: expr, extra: expr... | **`CAST_ALCHEMY_CHECK_DOG`** – Löst Alchemiezauber aus (prüft inaktiven Hund `$3BC1`). |
| `0xAD` | `$8C:DB3B` | Aktiv | w1: u16, w2: u16, b1: u8, b2: u8 | **`SET_TEMP_PAIRS_X8`** – Setzt `$7E:2834+w1 = b1*8` und `$7E:2834+w2 = b2*8` (6 Bytes). |
| `0xAE` | `$8C:DB08` | Aktiv | arg1: u8, arg2: u8, b1: u8, b2: u8 | **`SET_ARG_PAIRS_X8`** – Setzt `Arg[arg1] = b1*8` und `Arg[arg2] = b2*8` (4 Bytes). |
| `0xAF` | `$8C:D7AF` | Aktiv | count: u8, params: expr[count], addr: u24 | **`CALL_PARAMS`** – Subroutinenaufruf mit Parameterzähler `count` und Parametern auf dem Stack. |
| `0xB0` | `$8C:D786` | Aktiv | count: u8, params: expr[count], idx: u8 | **`CALL_INDEXED_BYTE_PARAMS`** – Tabellensprung über `$93:8000` mit Zähler `count` und Stack-Parametern. |
| `0xB1` | `$8C:D77B` | Aktiv | count: u8, params: expr[count], idx: u16 | **`CALL_INDEXED_WORD_PARAMS`** – 16-Bit-Tabellensprung mit Zähler `count` und Stack-Parametern. |
| `0xB2` | `$8C:D735` | Aktiv | count: u8, params: expr[count], off: i8 | **`CALL_RELATIVE_BYTE_PARAMS`** – Relativer Subroutinenaufruf mit Zähler `count` und Stack-Parametern. |
| `0xB3` | `$8C:D71A` | Aktiv | count: u8, params: expr[count], off: i16 | **`CALL_RELATIVE_WORD_PARAMS`** – Relativer Subroutinenaufruf (16-Bit) mit Zähler `count` und Stack-Parametern. |
| `0xB4` | `$8C:D7E6` | Aktiv | count: u8, params: expr[count], addr: u24 | **`ASYNC_CALL_PARAMS`** – Asynchroner Task-Start mit Zähler `count` und Stack-Parametern. |
| `0xB5` | `$8C:EC1C` | Aktiv | args: expr... (8x) | **`PALETTE_FADE_CUSTOM`** – Benutzerdefinierter Farbpaletten-Fade (8 Ausdrücke). |
| `0xB6` | `$8C:EC5E` | Aktiv | args: expr... (4x) | **`START_PALETTE_CYCLE`** – Aktiviert animierten Kachel-Farbzyklus in CGRAM via `$8CEC9A` (4 Ausdrücke). |
| `0xB7` | `$8C:EC8B` | Aktiv | args: expr | **`STOP_PALETTE_CYCLE`** – Beendet Kachel-Farbzyklus in CGRAM via `$8CEC9A`. |
| `0xB8` | `$8C:ECBD` | *STP-Trap* | — | `TRAP_UNIMPLEMENTED` – Unbenutzt (CPU-Halt `STP`). |
| `0xB9` | `$8C:E441` | Aktiv | target: expr, dx: expr, dy: expr | **`TELEPORT_REL`** – Relative Teleportation um berechnete Deltas (`E E E`). |
| `0xBA` | `$8C:E0DA` | Aktiv | type: u8, x: u8, y: u8 | **`SPAWN_NPC_FAST`** – Schneller NPC-Spawn mit festen Byte-Koordinaten. |
| `0xBB` | `$8C:E868` | Aktiv | target: expr, val: expr | **`DAMAGE_ENTITY_2`** – Sekundärer Schadensbefehl via `$8F:C103` (prüft Statusbit `$1000` an `Entity+$10`, addiert auf `Entity+$76`, setzt Flag `$0018` in `+$12`). |
| `0xBC` | `$8C:DF04` | Aktiv | *keine* | **`FACE_NORTH`** – Dreht Spielfigur/NPC nach oben (Norden). |
| `0xBD` | `$8C:DEAE` | Aktiv | *keine* | **`FACE_NORTH_WAIT`** – Dreht Figur nach oben und wartet auf Animations-Tick. |
| `0xBE` | `$8C:DF09` | Aktiv | *keine* | **`FACE_SOUTH`** – Dreht Spielfigur/NPC nach unten (Süden). |
| `0xBF` | `$8C:DEB3` | Aktiv | *keine* | **`FACE_SOUTH_WAIT`** – Dreht Figur nach unten und wartet auf Animations-Tick. |
| `0xC0` | `$8C:DF0E` | Aktiv | *keine* | **`FACE_WEST`** – Dreht Spielfigur/NPC nach links (Westen). |
| `0xC1` | `$8C:DEB8` | Aktiv | *keine* | **`FACE_EAST`** – Dreht Spielfigur/NPC nach rechts (Osten). |
| `0xC2` | `$8C:E0C4` | Aktiv | type: u8, x: u8, y: u8 | **`SPAWN_NPC_FLAGGED`** – Erzeugt NPC über `$8E:B55A` mit gesetztem `$8000`-Zustandsflag. |

---

## 7. Text- & Dialog-Steuerzeichen (Verbindung von `0x51`/`0x52` zur Text-Engine)

Wenn ein Skript den Opcode `0x51` (`SHOW_TEXT`) oder `0x52` (`SHOW_TEXT_END`) ausführt, übergibt SIGIL die 16-Bit `text_id` an die Markov-Huffman-Dekomprimierungs-Engine in Bank `$8C:D147` / Bank `$92`.

Im dekodierten Textstrom werden spezielle Steuerbytes interpretiert, die direkt mit SIGIL und dem UI interagieren:

| Steuerbyte | Token in Tools | Auswirkung auf Textbox und Skript |
| :---: | :---: | :--- |
| `0x00` | *Terminator* | Beendet den Textstring. Schließt ggf. das Fenster oder gibt Steuerung an Skript zurück. |
| `0x0A` | `\n` | Zeilenumbruch innerhalb der Textbox. |
| `0x80 lo hi` | `[Pause:n]` | **Pause / Frame-Verzögerung:** Hält den Textaufbau für 16-Bit Frame-Zähler (`lo \| (hi << 8)` Ticks) an. |
| `0x81` | `[Boy]` | **Junge-Name:** Fügt den vom Spieler gewählten Namen des Jungen ein. |
| `0x82` | `[Dog]` | **Hund-Name:** Fügt den vom Spieler gewählten Namen des Hundes ein. |
| `0x86` | `[Wait]` | **Wartet auf Tastendruck:** Hält Textausgabe an, bis A- oder B-Knopf gedrückt wird. |
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
        skip(6);
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
