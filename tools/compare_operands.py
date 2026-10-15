import re

ROM_PATH = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc"
with open(ROM_PATH, "rb") as f:
    rom = f.read()

def snes2off(addr):
    bank = (addr >> 16) & 0x3F
    low = addr & 0xFFFF
    return bank * 0x10000 + low

from tools.disasm_65816 import trace_routine

# Parse docs/sigil_skripte.md table
with open("docs/sigil_skripte.md", "r", encoding="utf-8") as f:
    doc_lines = f.readlines()

doc_opcodes = {}
for line in doc_lines:
    m = re.match(r"^\|\s*`0x([0-9A-Fa-f]{2})`\s*\|\s*`\$([0-9A-Fa-f]{2}):([0-9A-Fa-f]{4})`\s*\|\s*([^|]+)\|\s*([^|]+)\|\s*(.*)", line)
    if m:
        op = int(m.group(1), 16)
        bank = int(m.group(2), 16)
        addr = int(m.group(3), 16)
        status = m.group(4).strip()
        operands = m.group(5).strip()
        desc = m.group(6).strip()
        doc_opcodes[op] = {
            "snes": (bank << 16) | addr,
            "status": status,
            "operands": operands,
            "desc": desc
        }

# Known discrepancies to check systematically:
# 1. 0x44..=0x47: disasm reads 5 bytes, doc says 5 bytes, ROM reads 4 bytes (x, y, w, h)!
# 2. 0x7F: disasm reads 1 byte (u8), doc says u8, ROM reads 2 bytes (u16)!
# 3. 0x91: doc says level: u8, ROM reads level: expr!
# 4. 0xA2: doc misses param: u16 (says type: u16, x: expr, y: expr; ROM reads type: u16, param: u16, x: expr, y: expr)!
# 5. 0xAA: doc says target: entity, ROM reads 0 operands!
# 6. 0xAC: doc misses extra: expr... (says target: entity, spell: expr, level: expr; ROM falls through to 0x9E with extra)!
# 7. 0xAE: doc says src: u8, dst: u8, len: u8 (3 bytes), ROM reads 4 bytes (arg1, arg2, b1, b2)!
# 8. 0xAD: doc says src: u16, dst: u16, len: u16 (in doc written as copy, real is 6 bytes: w1, w2, b1, b2)!
# 9. 0xB5: doc says 6 params (r, g, b, spd, pal, cnt), ROM reads 8 expressions!
# 10. 0xBC..=0xC1: doc says target: entity, ROM reads 0 operands!
# 11. 0xC2: doc says args: u24 | EXT_COMMAND_C2, ROM reads type: u8, x: u8, y: u8 (fast spawn with param 0x8000)!
# 12. 0x9A: in disasm.rs line 598 mapped to AttachCamera, in ROM 0x9B is AttachCamera!

print("Done setting up comparison.")
