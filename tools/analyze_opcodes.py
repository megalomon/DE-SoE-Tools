import os

ROM_PATH = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc"
with open(ROM_PATH, "rb") as f:
    rom = f.read()

def snes2off(addr):
    bank = (addr >> 16) & 0x3F
    low = addr & 0xFFFF
    return bank * 0x10000 + low

OPCODE_TBL_SNES = 0x8CECBE
tbl_off = snes2off(OPCODE_TBL_SNES)

handlers = []
for i in range(195):
    h = rom[tbl_off + i*2] | (rom[tbl_off + i*2 + 1] << 8)
    handlers.append((i, 0x8C0000 | h))

# Helper to disassemble a stretch of 65816 in Bank $8C
# We track calls to $8CEE44, $8CF08F, $8CD6FE, LDA [$82], etc.
def analyze_handler(opcode, start_addr):
    visited = set()
    queue = [start_addr]
    
    events = []
    
    # We trace instructions
    # If it is a STP trap:
    if start_addr in [0x8CECBD, 0x8CECB6, 0x8CECB7, 0x8CECB8, 0x8CECB9, 0x8CECBA, 0x8CECBB, 0x8CECBC]:
        return "STP_TRAP", []

    # Map of visited addresses to avoid loops
    steps = 0
    while queue and steps < 200:
        addr = queue.pop(0)
        if addr in visited:
            continue
        visited.add(addr)
        steps += 1
        
        off = snes2off(addr)
        if off >= len(rom):
            break
        b0 = rom[off]
        
        # Check calls / reads
        if b0 == 0x22: # JSL long
            target = rom[off+1] | (rom[off+2] << 8) | (rom[off+3] << 16)
            events.append((addr, "JSL", hex(target)))
            queue.append(addr + 4)
        elif b0 == 0x20: # JSR abs
            target = 0x8C0000 | (rom[off+1] | (rom[off+2] << 8))
            events.append((addr, "JSR", hex(target)))
            queue.append(addr + 3)
        elif b0 == 0xA7 and rom[off+1] == 0x82: # LDA [$82]
            events.append((addr, "LDA [$82]", None))
            queue.append(addr + 2)
        elif b0 == 0xE6 and rom[off+1] == 0x82: # INC $82
            events.append((addr, "INC $82", None))
            queue.append(addr + 2)
        elif b0 == 0xDB: # STP
            events.append((addr, "STP", None))
        elif b0 in [0x60, 0x6B]: # RTS / RTL
            events.append((addr, "RTS", None))
        elif b0 == 0x4C: # JMP abs
            target = 0x8C0000 | (rom[off+1] | (rom[off+2] << 8))
            events.append((addr, "JMP", hex(target)))
            queue.append(target)
        elif b0 == 0x80: # BRA rel
            rel = rom[off+1]
            if rel >= 0x80: rel -= 0x100
            target = addr + 2 + rel
            queue.append(target)
        elif b0 in [0xF0, 0xD0, 0x90, 0xB0, 0x30, 0x10, 0x50, 0x70]: # Bcc
            rel = rom[off+1]
            if rel >= 0x80: rel -= 0x100
            target = addr + 2 + rel
            queue.append(target)
            queue.append(addr + 2)
        else:
            # Step 1 byte or unknown instruction - to be safe in linear walk when simple
            # Better: use length table or just linear scan
            pass

    return "CODE", events

print("Dumping all 195 opcode targets:")
for op, addr in handlers:
    status, events = analyze_handler(op, addr)
    # Filter key events: calls to EE44, F08F, D6FE, LDA [$82]
    sig = []
    for pc, typ, arg in events:
        if typ == "JSL" and arg == "0x8cee44":
            sig.append("expr")
        elif typ == "JSL" and arg == "0x8cf08f":
            sig.append("entity")
        elif typ == "JSR" and arg == "0x8cd6fe":
            sig.append("params_list")
        elif typ == "LDA [$82]":
            sig.append("read_82")
        elif typ == "JMP":
            sig.append(f"jmp({arg})")
    print(f"0x{op:02X} (${addr:06X}): {sig}")
