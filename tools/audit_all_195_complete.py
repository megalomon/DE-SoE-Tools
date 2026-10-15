import re

ROM_PATH = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc"
with open(ROM_PATH, "rb") as f:
    rom = f.read()

def snes2off(addr):
    bank = (addr >> 16) & 0x3F
    low = addr & 0xFFFF
    return bank * 0x10000 + low

from tools.disasm_65816 import trace_routine

# 1. Parse docs/sigil_skripte.md
with open("docs/sigil_skripte.md", "r", encoding="utf-8") as f:
    doc_lines = f.readlines()

docs = {}
for line in doc_lines:
    m = re.match(r"^\|\s*`0x([0-9A-Fa-f]{2})`\s*\|\s*`\$([0-9A-Fa-f]{2}):([0-9A-Fa-f]{4})`\s*\|\s*([^|]+)\|\s*([^|]+)\|\s*(.*)", line)
    if m:
        op = int(m.group(1), 16)
        bank = int(m.group(2), 16)
        addr = int(m.group(3), 16)
        status = m.group(4).strip()
        operands = m.group(5).strip()
        desc = m.group(6).strip()
        docs[op] = {
            "snes": (bank << 16) | addr,
            "status": status,
            "operands": operands,
            "desc": desc
        }

print(f"Total opcodes parsed from docs: {len(docs)}")

# 2. Check each opcode 0x00 to 0xC2 against ROM
tbl_off = snes2off(0x8CECBE)
addr_diffs = []
for op in range(195):
    h = rom[tbl_off + op*2] | (rom[tbl_off + op*2 + 1] << 8)
    rom_snes = 0x8C0000 | h
    
    doc = docs.get(op)
    if not doc:
        addr_diffs.append(f"Opcode 0x{op:02X} missing in docs!")
        continue
    if doc["snes"] != rom_snes:
        addr_diffs.append(f"Opcode 0x{op:02X}: ROM address ${rom_snes:06X} != Doc ${doc['snes']:06X}")

print(f"Docs address differences: {len(addr_diffs)}")
for d in addr_diffs:
    print(" ", d)
