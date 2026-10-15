import os
import re

ROM_PATH = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc"
with open(ROM_PATH, "rb") as f:
    rom = f.read()

def snes2off(addr):
    bank = (addr >> 16) & 0x3F
    low = addr & 0xFFFF
    return bank * 0x10000 + low

from tools.disasm_65816 import trace_routine

# Analyze ROM handlers
rom_handlers = {}
tbl_off = snes2off(0x8CECBE)

for i in range(195):
    h = rom[tbl_off + i*2] | (rom[tbl_off + i*2 + 1] << 8)
    addr = 0x8C0000 | h
    tr = trace_routine(addr, 100)
    
    # Analyze trace:
    # Count: exprs (JSL $8CEE44), entities (JSL $8CF08F), params_list (JSR $8CD6FE)
    # direct reads of [$82]: count bytes!
    expr_count = 0
    entity_count = 0
    params_list = False
    read_bytes = 0
    is_stp = False
    
    # Track sequence of reads
    seq = []
    for pc, op, l, txt, cat, m, x in tr:
        if "JSL $8CEE44" in txt:
            expr_count += 1
            seq.append("expr")
        elif "JSL $8CF08F" in txt:
            entity_count += 1
            seq.append("entity")
        elif "JMP/JSR $D6FE" in txt:
            params_list = True
            seq.append("params_list")
        elif op == 0xA7 and rom[snes2off(pc)+1] == 0x82:
            # Check how much $82 is incremented nearby or M flag
            # Look ahead up to 4 instructions for INC $82
            off_next = snes2off(pc) + 2
            inc_count = 0
            while off_next < len(rom) and off_next < snes2off(pc) + 8:
                if rom[off_next] == 0xE6 and rom[off_next+1] == 0x82:
                    inc_count += 1
                    off_next += 2
                else:
                    break
            if inc_count >= 2:
                read_bytes += 2
                seq.append("u16")
            elif inc_count == 1:
                read_bytes += 1
                seq.append("u8")
            else:
                # default to 1 byte if not sure
                read_bytes += 1
                seq.append("u8?")
        elif op == 0x67 and rom[snes2off(pc)+1] == 0x82: # ADC [$82]
            # check inc count
            off_next = snes2off(pc) + 2
            inc_count = 0
            while off_next < len(rom) and off_next < snes2off(pc) + 8:
                if rom[off_next] == 0xE6 and rom[off_next+1] == 0x82:
                    inc_count += 1
                    off_next += 2
                else:
                    break
            if inc_count >= 2:
                read_bytes += 2
                seq.append("u16(adc)")
            elif inc_count == 1:
                read_bytes += 1
                seq.append("u8(adc)")
        elif op == 0xDB:
            is_stp = True
            
    rom_handlers[i] = {
        "addr": addr,
        "is_stp": is_stp,
        "seq": seq,
        "raw_trace": tr
    }

for i in range(195):
    h = rom_handlers[i]
    print(f"0x{i:02X} (${h['addr']:06X}): {h['seq']}")
