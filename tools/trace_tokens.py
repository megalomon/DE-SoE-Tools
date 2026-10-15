import os

ROM_PATH = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc"
with open(ROM_PATH, "rb") as f:
    rom = f.read()

def snes2off(addr):
    bank = (addr >> 16) & 0x3F
    low = addr & 0xFFFF
    return bank * 0x10000 + low

from tools.disasm_65816 import trace_routine

tbl_off = snes2off(0x8CF442)
tokens = []
for i in range(0x70):
    w = rom[tbl_off + i*2] | (rom[tbl_off + i*2 + 1] << 8)
    tokens.append((i, 0x8C0000 | w))

print("Tracing expression tokens 0x00 to 0x6F:")
for i, addr in tokens:
    tr = trace_routine(addr, 40)
    reads = []
    for pc, op, l, txt, cat, m, x in tr:
        if op == 0xA7 and rom[snes2off(pc)+1] == 0x82:
            reads.append("LDA [$82]")
        elif op == 0x67 and rom[snes2off(pc)+1] == 0x82:
            reads.append("ADC [$82]")
        elif op == 0xE6 and rom[snes2off(pc)+1] == 0x82:
            reads.append("INC $82")
        elif "JSL" in txt:
            reads.append(txt)
    print(f"Token 0x{i:02X} (${addr:06X}): {reads}")
