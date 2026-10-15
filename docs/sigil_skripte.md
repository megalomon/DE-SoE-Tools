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
   8C:D40E: 81 D4  ; Status 0: Bereit (Ready) -> $8C:D481 (Ausführung starten/fortsetzen)
   8C:D410: 1C D4  ; Status 2: Timer-Wait -> $8C:D41C (Wartet auf 32-Bit Frame-Timer $7E:0B19)
   8C:D412: 2F D4  ; Status 4: Tick-Sleep -> $8C:D42F (Dekrementiert Frame-Zähler)
   8C:D414: 41 D4  ; Status 6: Event-Wait -> $8C:D441 (Prüft WRAM-Bedingung an $7E:2429)
   8C:D416: 6B D4  ; Status 8: Animations-Wait -> $8C:D46B (Wartet auf Sprite-Animationsende)
   8C:D418: 4A D4  ; Status 10: Sprite-Wait -> $8C:D44A
   ```

### Aufbau einer Task-Struktur im WRAM (Register `Y`)

| Offset | Typ | Beschreibung |
| :---: | :---: | :--- |
| `+0x00`..`+0x02` | `u24` | **Program Counter (PC):** Aktuelle 24-Bit-ROM-Adresse des interpretierten Bytecodes. |
| `+0x03` | `u16` | **Task-Status:** Index in die Scheduler-Tabelle `0, 2, 4, 6, 8, 10`. |
| `+0x05`..`+0x08` | `u32` | **Status-Parameter:** Zielzeit des Frame-Timers (`$7E:0B19`), Sleep-Ticks oder Entity-Index. |
| `+0x0B` | `u16` | **Parent-Task-Link:** Zeiger auf die aufrufende Task-Struktur (bei `CALL` `0x29`). |
| `+0x0D` | `u16` | **Task-Referenz-Zähler.** |

> [!NOTE]
> **Duale Funktion von `0x00` (`END`):**  
> Wenn ein Skript den Opcode `0x00` ausführt, prüft die Routine `$8C:D6CA` den Parent-Link `+0x0B`:  
> - Ist ein Caller-Link vorhanden, fungiert der Befehl als **`RETURN`** und stellt den Zustand des Aufrufers wieder her.  
> - Ist kein Caller-Link vorhanden (`0`), fungiert der Befehl als **`TERMINATE`** und entfernt den Task-Slot aus `$7E:2F28`.

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
| `$94:8000` | `0x140000` | `0x008000` | Start von Skript-Bank 94 |
| `$95:9274` | `0x151274` | `0x011274` | Pyramiden-Schalter-Event |
| `$97:82AF` | `0x1702AF` | `0x0202AF` | Markt-Handelsroutine |
| `$9C:8FB2` | `0x1C0FB2` | `0x048FB2` | Omnitopia-Endgame-Event |

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
| `0x01` | **Signed Byte** | `val: i8` | 8-Bit Integer mit Vorzeichen (`-128` bis `127`). |
| `0x02` | **Unsigned Byte** | `val: u8` | 8-Bit Integer ohne Vorzeichen (`0` bis `255`). |
| `0x03` | **Signed Word** | `val: i16` | 16-Bit Integer mit Vorzeichen (Little-Endian). |
| `0x04` | **Unsigned Word** | `val: u16` | 16-Bit Integer ohne Vorzeichen (Little-Endian). |
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
| `0x2C` | **`dialog_response()`**| Liefert Spieler-Auswahl im `[Choice]`-Dialogmenü (`0`, `1`, etc.). |
| `0x50` / `0xD0`| **`PLAYER_BOY`** | Adressiert den Jungen als Entity-Ziel. |
| `0x51` / `0xD1`| **`PLAYER_DOG`** | Adressiert den Hund als Entity-Ziel. |
| `0x52` / `0xD2`| **`CONTROLLED`** | Adressiert die aktuell vom Spieler gelenkte Spielfigur. |
| `0x53` / `0xD3`| **`NON_CONTROLLED`** | Adressiert den KI-gesteuerten Begleiter. |
| `0xAD` | **`LAST_ENTITY`** | Zuletzt interagierter NPC oder auslösendes Sprite. |
| `0xAE` | **`ATTACHED_ENTITY`**| An das Skript gebundenes Objekt. |

---

## 6. Master-Tabelle aller 195 Opcodes (`0x00` bis `0xC2`)

Die primäre Sprungtabelle liegt bei `$8C:ECBE` (`0x0CECBE`) und umfasst exakt 195 Einträge:

| Opcode | Handler | Status | Argumente | Mnemonic / Funktion |
| :---: | :---: | :---: | :--- | :--- |
| `0x00` | `$8C:D6CA` | **Aktiv** | *keine* | **`END` / `RETURN`** – Subroutinen-Rücksprung (falls Caller-Link aktiv) oder Task-Terminierung. |
| `0x01` | `$8C:ECBD` | *STP-Trap* | — | Unbenutzt (verweist auf CPU-Trap `STP`). |
| `0x02` | `$8C:ECBD` | *STP-Trap* | — | Unbenutzt. |
| `0x03` | `$8C:ECBD` | *STP-Trap* | — | Unbenutzt. |
| `0x04` | `$8C:D81D` | **Aktiv** | `off: i16` | **`SKIP`** – Relativer Sprung um 16-Bit Word-Offset. |
| `0x05` | `$8C:D811` | **Aktiv** | `off: i8` | **`SKIP_SHORT`** – Kurzer relativer Sprung um 8-Bit Offset. |
| `0x06` | `$8C:ECB6` | *STP-Trap* | — | Unbenutzt. |
| `0x07` | `$8C:D7E9` | **Aktiv** | `addr: u24` | **`ASYNC_CALL`** – Startet Subskript asynchron in neuem Task-Slot. |
| `0x08` | `$8C:D84E` | **Aktiv** | `cond: expr, off: i16` | **`IF`** – Verzweigt um `off`, falls Ausdruck `cond` ungleich 0 ist. |
| `0x09` | `$8C:D85D` | **Aktiv** | `cond: expr, off: i16` | **`IFNOT`** – Verzweigt um `off`, falls Ausdruck `cond` gleich 0 ist. |
| `0x0A` | `$8C:D87A` | **Aktiv** | `cur: u8, amt: u24, off: i16` | **`IF_MONEY_GE`** – Verzweigt, wenn Währung `cur >= amt`. |
| `0x0B` | `$8C:D8B9` | **Aktiv** | `cur: u8, amt: u24, off: i16` | **`IF_MONEY_LT`** – Verzweigt, wenn Währung `cur < amt`. |
| `0x0C` | `$8C:DC27` | **Aktiv** | `bit: u16, val: expr` | **`SET_RAM_FLAG`** – Schreibt Ergebnis von `val` in `FLAG[bit]`. |
| `0x0D` | `$8C:DC17` | **Aktiv** | `bit: u16, val: expr` | **`SET_TEMP_FLAG`** – Schreibt Ergebnis in `TEMP_FLAG[bit]`. |
| `0x0E` | `$8C:DC05` | **Aktiv** | `bit: u8, val: expr` | **`SET_ARG_BIT`** – Schreibt Bit in Subroutinen-Argument. |
| `0x0F` | `$8C:ECBD` | *STP-Trap* | — | Unbenutzt. |
| `0x10` | `$8C:DBED` | **Aktiv** | `addr: u16, val: expr` | **`WRITE_RAM_BYTE`** – Schreibt 8-Bit-Wert in `RAM[addr]`. |
| `0x11` | `$8C:DBE8` | **Aktiv** | `addr: u16, val: expr` | **`WRITE_TEMP_BYTE`** – Schreibt 8-Bit-Wert in `TEMP[addr]`. |
| `0x12` | `$8C:DBCF` | **Aktiv** | `arg: u8, val: expr` | **`WRITE_ARG_BYTE`** – Schreibt 8-Bit-Wert in Argument `arg`. |
| `0x13` | `$8C:ECBD` | *STP-Trap* | — | Unbenutzt. |
| `0x14` | `$8C:DBED` | *Alias* | `addr: u16, val: expr` | Alias zu `0x10` (`WRITE_RAM_BYTE`). |
| `0x15` | `$8C:DBE8` | *Alias* | `addr: u16, val: expr` | Alias zu `0x11` (`WRITE_TEMP_BYTE`). |
| `0x16` | `$8C:DBCF` | *Alias* | `arg: u8, val: expr` | Alias zu `0x12` (`WRITE_ARG_BYTE`). |
| `0x17` | `$8C:DB86` | **Aktiv** | `addr: u16, val: u16` | **`WRITE_VAR_FAST`** – Schnelles Word-Schreiben ohne Expression-Overhead. |
| `0x18` | `$8C:DBBA` | **Aktiv** | `addr: u16, val: expr` | **`WRITE_RAM_WORD`** – Schreibt 16-Bit-Word in `RAM[addr]`. |
| `0x19` | `$8C:DBB5` | **Aktiv** | `addr: u16, val: expr` | **`WRITE_TEMP_WORD`** – Schreibt 16-Bit-Word in `TEMP[addr]`. |
| `0x1A` | `$8C:DB9C` | **Aktiv** | `arg: u8, val: expr` | **`WRITE_ARG_WORD`** – Schreibt 16-Bit-Word in Argument `arg`. |
| `0x1B` | `$8C:DB54` | **Aktiv** | `addr: u16, val: u16` | **`WRITE_RAM_WORD_CONST`** – Konstanten-Word in WRAM schreiben. |
| `0x1C` | `$8C:DBBA` | *Alias* | `addr: u16, val: expr` | Alias zu `0x18` (`WRITE_RAM_WORD`). |
| `0x1D` | `$8C:DBB5` | *Alias* | `addr: u16, val: expr` | Alias zu `0x19` (`WRITE_TEMP_WORD`). |
| `0x1E` | `$8C:DB9C` | *Alias* | `arg: u8, val: expr` | Alias zu `0x1A` (`WRITE_ARG_WORD`). |
| `0x1F` | `$8C:ECBD` | *STP-Trap* | — | Unbenutzt. |
| `0x20` | `$8C:DFD9` | **Aktiv** | `mode: u8` | **`SET_CAMERA_MODE`** – Kamera-Verfolgungsmodus einstellen. |
| `0x21` | `$8C:DFA2` | **Aktiv** | `target: entity` | **`CAMERA_FOLLOW`** – Kamera an Spielfigur/NPC binden. |
| `0x22` | `$8C:DF5A` | **Aktiv** | `map: u8, x: u8, y: u8` | **`CHANGE_MAP`** – Raumwechsel mit Zielkoordinaten. |
| `0x23` | `$8C:E806` | **Aktiv** | `x: u8, y: u8` | **`SET_MAP_SCROLL`** – Manueller Kartenscroll. |
| `0x24`..`0x25` | `$8C:ECB7` | *STP-Trap* | — | Unbenutzt. |
| `0x26` | `$8C:E007` | **Aktiv** | *keine* | **`FADE_TO_BLACK`** – Bildschirm schwarz abblenden. |
| `0x27` | `$8C:DFF9` | **Aktiv** | *keine* | **`FADE_FROM_BLACK`** – Bildschirm aufhellen. |
| `0x28` | `$8C:ECB9` | *STP-Trap* | — | Unbenutzt. |
| `0x29` | `$8C:D7B2` | **Aktiv** | `addr: u24` | **`CALL`** – Synchroner Subroutinen-Aufruf via Caller-Link. |
| `0x2A` | `$8C:DF50` | **Aktiv** | `target: entity` | **`FREEZE_ENTITY`** – Hält Figur/NPC an. |
| `0x2B` | `$8C:DEFA` | **Aktiv** | `target: entity` | **`UNFREEZE_ENTITY`** – Gibt eingefrorene Figur wieder frei. |
| `0x2C` | `$8C:DF13` | **Aktiv** | `flags: u8` | **`LOCK_PLAYER`** – Controller-Eingaben für Cutscenes sperren. |
| `0x2D` | `$8C:DEBD` | **Aktiv** | `flags: u8` | **`UNLOCK_PLAYER`** – Steuerung an Spieler zurückgeben. |
| `0x2E` | `$8C:D62D` | **Aktiv** | `cond: expr` | **`WAIT_UNTIL`** – Pausiert Task, bis Ausdruck wahr ist. |
| `0x2F` | `$8C:ECBD` | *STP-Trap* | — | Unbenutzt. |
| `0x30`..`0x32` | `$8C:DA90` | **Aktiv** | `sfx_id: u8` | **`PLAY_SFX`** – Soundeffekt über S-SMP abspielen. |
| `0x33` | `$8C:DABF` | **Aktiv** | `track_id: u8` | **`PLAY_BGM`** – Hintergrundmusik wechseln. |
| `0x34`..`0x37` | `$8C:ECBD` | *STP-Trap* | — | Unbenutzt. |
| `0x38` / `0x3A` | `$8C:D5F6` | **Aktiv** | *keine* | **`YIELD`** – Task gibt CPU für aktuellen Frame ab (`CLC; RTS`). |
| `0x39` / `0x3B` | `$8C:D609` | **Aktiv** | `frames: expr` | **`SLEEP_SUB`** – Pausiert dynamisch berechnete Anzahl Frames. |
| `0x3C` | `$8C:E0ED` | **Aktiv** | `raw: u32` | **`EXT_COMMAND_3C`** |
| `0x3D` | `$8C:E14C` | **Aktiv** | `npc: entity, script: u24` | **`SET_NPC_TALK_SCRIPT`** – Ansprech-Skript für B-Knopf binden. |
| `0x3E` | `$8C:ECBC` | *STP-Trap* | — | Unbenutzt. |
| `0x3F` | `$8C:E161` | **Aktiv** | `npc: entity, script: u24` | **`SET_NPC_SCRIPT`** – Verhaltens- und Bewegungsskript starten. |
| `0x40`..`0x41` | `$8C:ECBA` | *STP-Trap* | — | Unbenutzt. |
| `0x42` | `$8C:E3EF` | **Aktiv** | `target: entity, x: u8, y: u8`| **`TELEPORT_ENTITY`** – Setzt absolute Kachelposition. |
| `0x43` | `$8C:E40E` | **Aktiv** | `target: entity, x: expr, y: expr` | **`TELEPORT_ENTITY_EXPR`** – Koordinaten aus Ausdrücken. |
| `0x44`..`0x47` | `$8C:DC79` | **Aktiv** | `w: u8, h: u8` | **`SET_TEXT_WINDOW_SIZE`** – Abmessungen des Dialogfensters. |
| `0x48`..`0x4B` | `$8C:DCE7` | **Aktiv** | `x: u8, y: u8` | **`SET_TEXT_WINDOW_POS`** – Position des Dialogfensters. |
| `0x4C` | `$8C:DC65` | **Aktiv** | `arg: u16` | **`EXT_TEXT_4C`** |
| `0x4D` | `$8C:DC67` | **Aktiv** | *keine* | **`EXT_TEXT_4D`** |
| `0x4E` | `$8C:E1B1` | **Aktiv** | `target: entity` | **`DESPAWN_ENTITY`** – Entfernt Sprite von der Map. |
| `0x4F` | `$8C:ECBD` | *STP-Trap* | — | Unbenutzt. |
| `0x50` | `$8C:DDE6` | **Aktiv** | `vram: u8, text_id: u16`| **`SHOW_TEXT_VRAM`** – Lädt Text in bestimmtes VRAM-Layer. |
| `0x51` | `$8C:DDF3` | **Aktiv** | `text_id: u16` | **`SHOW_TEXT`** – Startet Textdekomprimierung aus Bank `$92`. |
| `0x52` | `$8C:DD87` | **Aktiv** | `text_id: u16` | **`SHOW_TEXT_END`** – Textbox öffnen und auf Bestätigung warten. |
| `0x53` | `$8C:ECBD` | *STP-Trap* | — | Unbenutzt. |
| `0x54` | `$8C:DD65` | **Aktiv** | `vram: u8` | **`HIDE_TEXT_VRAM`** – Spezifisches Textfenster schließen. |
| `0x55` | `$8C:DD71` | **Aktiv** | *keine* | **`HIDE_TEXT`** – Aktive Textbox sofort schließen. |
| `0x56`..`0x57` | `$8C:ECBD` | *STP-Trap* | — | Unbenutzt. |
| `0x58` | `$8C:E088` | **Aktiv** | `speed: u8` | **`FADE_IN_MUSIC`** – Musik allmählich einblenden. |
| `0x59` | `$8C:E075` | **Aktiv** | `speed: u8` | **`FADE_OUT_MUSIC`** – Musik allmählich ausblenden. |
| `0x5A`..`0x5B` | `$8C:E290` | **Aktiv** | *keine* | **`DISABLE_INTERRUPTS` / `ENABLE_INTERRUPTS`** |
| `0x5C` | `$8C:E1CC` | **Aktiv** | `obj: expr, state: expr`| **`SET_OBJECT_STATE`** – Truhen-, Schalter- oder Alchemiezustand. |
| `0x5D` | `$8C:E200` | **Aktiv** | `flag: u16, obj: expr` | **`CONDITIONAL_UNLOAD`** – Entfernt Sprite, wenn Flag aktiv. |
| `0x5E`..`0x61` | `$8C:E22F` | **Aktiv** | `obj: expr` | **`OBJECT_COLLISION_CTL`** – Objekt-Kollisionsflags manipulieren. |
| `0x62` | `$8C:E3D0` | **Aktiv** | `target: entity, p: u24`| **`SET_ENTITY_PATH`** – Weist Kachel-Bewegungspfad zu. |
| `0x63` | `$8C:E376` | **Aktiv** | *keine* | **`WAIT_PATH_END`** – Wartet auf Ende des Bewegungspfads. |
| `0x64`..`0x66` | `$8C:E29C` | **Aktiv** | *diverse* | **`LAYER_PRIORITY_CTL`** – BG-Grafiklayer-Prioritäten umschalten. |
| `0x67` | `$8C:ECBD` | *STP-Trap* | — | Unbenutzt. |
| `0x68`..`0x6A` | `$8C:E2BE` | **Aktiv** | *diverse* | **`PALETTE_ANIM_CTL`** – Farbpaletten-Effekte steuern. |
| `0x6B` | `$8C:ECBD` | *STP-Trap* | — | Unbenutzt. |
| `0x6C` | `$8C:DE50` | **Aktiv** | `target: entity, dx: i8, dy: i8` | **`MOVE_ENTITY_REL`** – Relative Pixelverschiebung. |
| `0x6D` | `$8C:DE18` | **Aktiv** | `target: entity` | **`STOP_ENTITY_MOVE`** – Stoppt laufende Verschiebung. |
| `0x6E` | `$8C:DE49` | **Aktiv** | `target: entity, dx: i8, dy: i8` | **`MOVE_ENTITY_FAST`** – Schnelle relative Verschiebung. |
| `0x6F` | `$8C:DE11` | **Aktiv** | `target: entity` | **`STOP_ENTITY_FAST`** |
| `0x70` | `$8C:E30E` | **Aktiv** | `a: entity, b: entity` | **`ENTITY_FACE_ENTITY`** – Figur `a` dreht sich zu Figur `b`. |
| `0x71` | `$8C:E31E` | **Aktiv** | `a: entity, b: entity` | **`FACE_EACH_OTHER`** – Beide Figuren blicken sich an. |
| `0x72` | `$8C:ECBD` | *STP-Trap* | — | Unbenutzt. |
| `0x73` | `$8C:DE76` | **Aktiv** | `target: entity, x: u8, y: u8`| **`MOVE_ENTITY_ABS`** – Spielfigur läuft linear zu `(x, y)`. |
| `0x74`..`0x77` | `$8C:E2E0` | **Aktiv** | `target: entity` | **`SET_ENTITY_FLAGS`** – Transparenz- und Kollisionsflags. |
| `0x78` | `$8C:E4B1` | **Aktiv** | `target: entity, anim: u16` | **`SET_ANIMATION`** – Startet Sprite-Animationssequenz. |
| `0x79` | `$8C:E557` | **Aktiv** | `target: entity, anim: u16` | **`SET_ANIMATION_WAIT`** – Startet Animation und wartet auf Ende (Status 8). |
| `0x7A` | `$8C:E48F` | **Aktiv** | `target: expr, val: expr` | **`WRITE_DEREF`** – Zeiger-Dereferenzierung (`*target = val`). |
| `0x7B` | `$8C:E49E` | **Aktiv** | `target: expr` | **`READ_DEREF`** |
| `0x7C` | `$8C:D940` | **Aktiv** | `amount: u16` | **`GIVE_MONEY`** – Addiert Währung der aktuellen Zeitzone. |
| `0x7D` | `$8C:D8EA` | **Aktiv** | `amount: u16` | **`TAKE_MONEY`** – Subtrahiert aktuelle Währung. |
| `0x7E` | `$8C:D993` | **Aktiv** | *keine* | **`EXCHANGE_MONEY`** – Öffnet Geldwechsler auf Markt Allelachema. |
| `0x7F` | `$8C:E57B` | **Aktiv** | *keine* | **`SHOW_NAMING_SCREEN`** – Namenseingabe (z. B. für den Hund). |
| `0x80`..`0x83` | `$8C:E604` | **Aktiv** | *diverse* | **`HUD_CONTROL`** – HP- und Ring-Menü-Grafik ein-/ausblenden. |
| `0x84` | `$8C:D971` | **Aktiv** | `amount: expr` | **`GIVE_MONEY_EXPR`** – Geldüberweisung via berechnetem Betrag. |
| `0x85` | `$8C:D91B` | **Aktiv** | `amount: expr` | **`TAKE_MONEY_EXPR`** – Geldabzug via berechnetem Betrag. |
| `0x86`..`0x87` | `$8C:E67C` | **Aktiv** | `item: expr` | **`ADD_INVENTORY_ITEM`** – Legt Item in Inventar ab. |
| `0x88` | `$8C:E6AB` | **Aktiv** | *keine* | **`CLEAR_SHOP_MENU`** – Löscht Händler-Warenpuffer. |
| `0x89` | `$8C:E6B6` | **Aktiv** | `item_id: u16` | **`ADD_SHOP_ITEM`** – Fügt Ware zum Händler-Ringmenü hinzu. |
| `0x8A` | `$8C:E758` | **Aktiv** | `npc: entity` | **`OPEN_SHOP_MENU`** – Startet Händler-Ringmenü an NPC-Position. |
| `0x8B` | `$8C:ECBD` | *STP-Trap* | — | Unbenutzt. |
| `0x8C` | `$8C:E79B` | **Aktiv** | *keine* | **`OPEN_SAVE_MENU`** – Öffnet Speicherbuch-Menü. |
| `0x8D` | `$8C:E786` | **Aktiv** | `intensity: u8` | **`SCREEN_SHAKE`** – Erdbebeneffekt starten/stoppen. |
| `0x8E`..`0x8F` | `$8C:D86C` | **Aktiv** | `cond: expr, off: i16` | **`IF_LESS` / `IF_GREATER`** |
| `0x90` | `$8C:E02A` | **Aktiv** | `level: u8` | **`FADE_BRIGHTNESS`** |
| `0x91` | `$8C:E051` | **Aktiv** | `level: u8` | **`SET_BRIGHTNESS`** – Display-Helligkeit (`0` = Schwarz, `15` = Normal). |
| `0x92`..`0x97` | `$8C:E831` | **Aktiv** | *diverse* | **`WEATHER_EFFECTS`** – Regen-, Asche- und Nebeleffekte. |
| `0x98` | `$8C:E9A2` | **Aktiv** | `target: u8` | **`SWITCH_CHARACTER`** – Wechselt aktive Spielfigur (Junge = `0`, Hund = `1`). |
| `0x99` | `$8C:EA70` | **Aktiv** | *keine* | **`ENTER_MODE7_MAP`** – Startet Mode-7-Oberweltflug auf Windwalker. |
| `0x9A`..`0x9D` | `$8C:EAD0` | **Aktiv** | *diverse* | **`MODE7_COORDINATES`** |
| `0x9E` | `$8C:D4B5` | **Aktiv** | `spell: u8, lvl: u8` | **`CAST_ALCHEMY`** – Löst Alchemiezauber per Skriptbefehl aus. |
| `0x9F` | `$8C:E9B1` | **Aktiv** | *keine* | **`SHOW_CURRENCY_HUD`** – Blendet Währungsanzeige oben rechts ein. |
| `0xA0` | `$8C:EA29` | **Aktiv** | *keine* | **`HIDE_CURRENCY_HUD`** – Blendet Währungsanzeige aus. |
| `0xA1` | `$8C:EA60` | **Aktiv** | *keine* | **`UPDATE_CURRENCY_HUD`** – Aktualisiert Währungs-Display. |
| `0xA2` | `$8C:E09B` | **Aktiv** | `type: u16, x: expr, y: expr` | **`SPAWN_NPC`** – Erzeugt neues NPC-Sprite auf der Map. |
| `0xA3`..`0xA6` | `$8C:D789` | **Aktiv** | *diverse* | **`EXT_TASK_CONTROL`** |
| `0xA7` | `$8C:D600` | **Aktiv** | `frames: u16` | **`SLEEP`** – Pausiert Task für feste Anzahl Frames (Status 4). |
| `0xA8` | `$8C:D5F8` | **Aktiv** | `frames: u16` | **`SLEEP_ALIGNED`** |
| `0xA9`..`0xAB` | `$8C:EAEB` | **Aktiv** | *diverse* | **`SCRIPT_DEBUG_HOOKS`** |
| `0xAC` | `$8C:D4A8` | **Aktiv** | `spell: expr, lvl: expr`| **`CAST_ALCHEMY_EXPR`** |
| `0xAD`..`0xAE` | `$8C:DB3B` | **Aktiv** | *diverse* | **`FAST_COPY_RAM`** – Schneller RAM-Blocktransfer. |
| `0xAF` | `$8C:D7AF` | **Aktiv** | `params: expr..., addr: u24` | **`CALL_PARAMS`** – Subroutinen-Aufruf mit Parametern auf dem Stack. |
| `0xB0`..`0xB3` | `$8C:D786` | **Aktiv** | *diverse* | **`EXT_CALL_VARIANTS`** |
| `0xB4` | `$8C:D7E6` | **Aktiv** | `params: expr..., addr: u24` | **`ASYNC_CALL_PARAMS`** – Asynchroner Subroutinen-Aufruf mit Parametern. |
| `0xB5` | `$8C:EC1C` | **Aktiv** | `args: expr...` | **`EXT_PALETTE_CYCLE`** |
| `0xB6` | `$8C:EC5E` | **Aktiv** | `args: expr...` | **`START_TILE_FLASH`** – Aktiviert animierte Farbzyklen für Kacheln. |
| `0xB7` | `$8C:EC8B` | **Aktiv** | `args: expr` | **`STOP_TILE_FLASH`** – Beendet Farbzyklus-Effekt. |
| `0xB8` | `$8C:ECBD` | *STP-Trap* | — | Unbenutzt. |
| `0xB9` | `$8C:E441` | **Aktiv** | `target: entity, dx: i8, dy: i8` | **`TELEPORT_REL`** – Relative Kachelteleportation. |
| `0xBA` | `$8C:E0DA` | **Aktiv** | `args: u32` | **`EXT_COMMAND_BA`** |
| `0xBB` | `$8C:E868` | **Aktiv** | `target: entity, dmg: u16` | **`SHOW_DAMAGE_NUM`** – Zeigt Schadens-/Heilungszahl über Entity an. |
| `0xBC` | `$8C:DF04` | **Aktiv** | `target: entity` | **`FACE_NORTH`** – Dreht Entity nach oben (Norden). |
| `0xBD` | `$8C:DEAE` | **Aktiv** | `target: entity` | **`FACE_NORTH_WAIT`** – Dreht Entity nach oben und wartet auf Frame. |
| `0xBE` | `$8C:DF09` | **Aktiv** | `target: entity` | **`FACE_SOUTH`** – Dreht Entity nach unten (Süden). |
| `0xBF` | `$8C:DEB3` | **Aktiv** | `target: entity` | **`FACE_SOUTH_WAIT`** – Dreht Entity nach unten und wartet. |
| `0xC0` | `$8C:DF0E` | **Aktiv** | `target: entity` | **`FACE_WEST`** – Dreht Entity nach links (Westen). |
| `0xC1` | `$8C:DEB8` | **Aktiv** | `target: entity` | **`FACE_EAST`** – Dreht Entity nach rechts (Osten). |
| `0xC2` | `$8C:E0C4` | **Aktiv** | `args: u24` | **`EXT_COMMAND_C2`** |

---

## 7. Text- & Dialog-Steuerzeichen (Verbindung von `0x51`/`0x52` zur Text-Engine)

Wenn ein Skript den Opcode `0x51` (`SHOW_TEXT`) oder `0x52` (`SHOW_TEXT_END`) ausführt, übergibt SIGIL die 16-Bit `text_id` an die Markov-Huffman-Dekomprimierungs-Engine in Bank `$8C:D147` / Bank `$92`.

Im dekodierten Textstrom werden spezielle Steuerbytes interpretiert, die direkt mit SIGIL und dem UI interagieren:

| Steuerbyte | Token in Tools | Auswirkung auf Textbox und Skript |
| :---: | :---: | :--- |
| `0x00` | *Terminator* | Beendet den Textstring. Schließt ggf. das Fenster oder gibt Steuerung an Skript zurück. |
| `0x0A` | `\n` | Zeilenumbruch innerhalb der Textbox. |
| `0x80` | `<S ...>` | **Dynamischer Variablen-Block:** Liest RAM-Werte aus und setzt Namen (Junge, Hund), Item-Namen oder Zahlen ein. |
| `0x86` | `[Delay]` | **Timed Pause:** Hält den Textaufbau für eine feste Frame-Anzahl an. |
| `0x87` | `[Choice]` | **Dialog-Auswahlmenü:** Öffnet interaktives Auswahlfenster. Die Spielerwahl wird im Register gespeichert und via Sub-Opcode `0x2C` (`dialog_response()`) abgefragt. |
| `0x96` | `[Box]` | Leert den aktuellen Textkasten für einen neuen Textabschnitt. |
| `0x97` | `[Page]` | **Seitenumbruch:** Hält den Text an und wartet auf Druck der A- oder B-Taste des Spielers, bevor weitergeblättert wird. |

### Deutsche Sonderzeichen im Zeichensatz
- `0xE3` = `ä`
- `0xEF` = `ö`
- `0xF3` = `ü`
- `0xC6` = `ß`
- `0xC4` = `Ä`
- `0xD6` = `Ö`
- `0xDC` = `Ü`

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
