# SIGIL Script-Engine & Bytecode-Referenz (Deutsche PAL ROM)

Die Skripte in *Secret of Evermore* werden von einer virtuellen Bytecode-Maschine namens **SIGIL** interpretiert. Diese Dokumentation beschreibt die Befehlssyntax, das Opcode-Format, Sprungtabellen und Variablenbereiche der **deutschen Version**.

---

## 1. Engine-Architektur & Sprungtabellen

Im deutschen ROM (`Secret of Evermore (Germany).sfc`) wird SIGIL über zwei zentrale 65816-Sprungtabellen in Bank `$8C` gesteuert:

- **Primäre Opcode-Sprungtabelle:** `$8C:ECBE` (`0x0CECBE`)  
  Behandelt fundamentale Kontrollfluss-, Speicher- und Textbefehle (`0x00` bis `0x6B`).
- **Sekundäre Sub-Opcode-Sprungtabelle:** `$8C:F442` (`0x0CF442`)  
  Behandelt Trigger-, Animations-, Kamera- und Audio-Befehle (`0x70` bis `0xFF`).
- **Skript-Bytecode-Bank:** `$93:8000` bis `$97:FFFF` (`0x138000` bis `0x17FFFF`).

---

## 2. Speicherbereiche & Register in SIGIL

Skripte können auf drei getrennte Speicherbereiche zugreifen:

| Bereich im Skript | Basis im WRAM | Beschreibung |
| :--- | :--- | :--- |
| **`FLAG[id]`** | `$7E2258` | Persistente Story-Flags als Bitfield (`id >> 3`, Bit `id & 7`). Bleiben beim Speichern auf dem SRAM erhalten. |
| **`RAM[offset]`** | `$7E2258` | Direkte Byte- oder Word-Variablen (z. B. Geld, Items, Timer). |
| **`TEMP[offset]`** | `$7E2834` | Temporärer Scratchpad-Speicher für Skripte (wird bei Raumwechsel zurückgesetzt). |

### Spezielle Rückgabewerte
- **`dialog_response()`:** Liefert die vom Spieler getroffene Auswahl in einem Dialogfenster (`0` = Erste Option / Ja, `1` = Zweite Option / Nein, `2` = Dritte Option). Wird in der Regel in `TEMP[0x0069]` gespeichert.

---

## 3. Kern-Befehlssatz (Opcodes)

### Kontrollfluss & Verzweigungen

| Opcode | Mnemonic | Argumente | Beschreibung |
| :---: | :--- | :--- | :--- |
| `0x00` | **`END`** | *keine* | Beendet die Skriptausführung und gibt die Kontrolle an die Engine zurück. |
| `0x04` | **`SKIP`** | `offset: u16` | Unbedingter Sprung um `offset` Bytes nach vorne (oder negativ). |
| `0x05` | **`SKIP_SHORT`** | `offset: u8` | Kurzer Vorwärtssprung um bis zu 255 Bytes. |
| `0x08` | **`IF`** | `cond, offset: u16` | Führt den Sprung aus, wenn die Bedingung `cond` **wahr** (ungleich 0) ist. |
| `0x09` | **`IFNOT`** | `cond, offset: u16` | Führt den Sprung aus, wenn die Bedingung `cond` **falsch** (gleich 0) ist. |
| `0x0A` | **`IF_MONEY`** | `type: u8, amount: u24, offset: u16` | Verzweigt, wenn der Spieler mindestens `amount` der Währung `type` besitzt. |
| `0x29` | **`CALL`** | `addr: u24` | Ruft eine Subroutine an der absoluten SNES-Adresse `addr` auf. |

### Text & Dialoge

| Opcode | Mnemonic | Argumente | Beschreibung |
| :---: | :--- | :--- | :--- |
| `0x51` | **`SHOW_TEXT`** | `text_id: u16` | Öffnet eine Textbox und beginnt mit der Dekomprimierung von Dialog `text_id`. |
| `0x52` | **`SHOW_TEXT_END`** | `text_id: u16` | Zeigt Text an und wartet auf Tastendruck des Spielers, bevor das Skript fortfährt. |
| `0x55` | **`HIDE_TEXT`** | *keine* | Schließt die aktive Textbox sofort. |

### Speicher-Manipulation (RAM & Flags)

| Opcode | Mnemonic | Argumente | Beschreibung |
| :---: | :--- | :--- | :--- |
| `0x0C` | **`SET_RAM_FLAG`** | `flag: u16, expr` | Setzt oder löscht ein persistentes Story-Flag (`$7E2258 + flag`). |
| `0x0D` | **`SET_TEMP_FLAG`**| `flag: u16, expr` | Setzt oder löscht ein temporäres Flag (`$7E2834 + flag`). |
| `0x18` | **`SET_RAM_BYTE`** | `offset: u16, val: u8` | Schreibt einen 8-Bit-Wert direkt in den RAM. |
| `0x19` | **`SET_TEMP_BYTE`**| `offset: u16, val: u8` | Schreibt ein temporäres Byte. |
| `0x1C` | **`SET_RAM_WORD`** | `offset: u16, expr` | Schreibt ein 16-Bit Word in den RAM. |
| `0x1D` | **`SET_TEMP_WORD`**| `offset: u16, expr` | Schreibt ein temporäres 16-Bit Word. |

### Spieler- & Kamera-Steuerung

| Opcode | Mnemonic | Argumente | Beschreibung |
| :---: | :--- | :--- | :--- |
| `0x2C` | **`LOCK_PLAYER`** | `flags: u8` | Friert die Steuerung des Spielers ein (für Zwischensequenzen / Dialoge). |
| `0x2D` | **`UNLOCK_PLAYER`**| `flags: u8` | Gibt die Steuerung für den Spieler wieder frei. |
| `0x7A` | **`SET_ANIMATION`**| `actor: u8, anim: u16` | Weist einer Spielfigur oder einem NPC eine Animation zu. |

---

## 4. Beispiel: Disassembliertes Skript aus Nobilia (Markt)

Auszug aus dem B-Trigger des Töpfers (Map `0x0A`, Script ID `0x01D4` an `$97:82AF`), der das Chocobo-Ei vergibt:

```c
// B-Trigger bei X=[21..24], Y=[11..12]
[0000] $9782AF  LOCK_PLAYER 0x08
[000D] $9782BC  IFNOT (FLAG[0x002B]) SKIP +6 -> [0013]    // Markteinlass prüfen
[001E] $9782CD  SHOW_TEXT 0x0EB8                          // "Willst Du handeln?"
[0026] $9782D5  TEMP[0x0069] = dialog_response()           // Antwort erfassen
[0044] $9782F3  IFNOT (TEMP[0x0069] == 0) SKIP +7          // Wenn Antwort == 5 Töpfe
[004B] $9782FA  TEMP[0x0027] = 5
...
[008C] $97823B  CALL $93CDB3                              // Transaktion ausführen
[00C5] $978374  SHOW_TEXT 0x0EC1                          // "Hier bitte schön!"
[00CD] $97837C  HIDE_TEXT
[00CE] $97837D  UNLOCK_PLAYER 0x08
[00D0] $97837F  END
```

---

## 5. Kompilierung mit `everscript`

Mit dem Rust-Tool [`everscript`](../crates/everscript) können eigene `.evs`-Skripte geschrieben und direkt in SIGIL-Bytecode übersetzt werden:

```c
enum FLAGS {
    CHOCOBO_EGG = 0x004E,
}

fun my_custom_npc() = 0x978712 {
    lock_player();
    if (!FLAG[FLAGS.CHOCOBO_EGG]) {
        text(0x0F15);
        FLAG[FLAGS.CHOCOBO_EGG] = 1;
        give_jewels(50);
        text_end(0x0F27);
    } else {
        text_end(0x0F2A);
    }
    unlock_player();
    end();
}
```

Kompilierbefehl:
```bash
everscript compile script.evs --ips patch.ips
```
