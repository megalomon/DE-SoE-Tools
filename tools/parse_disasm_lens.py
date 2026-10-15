import re

ROM_PATH = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc"
with open(ROM_PATH, "rb") as f:
    rom = f.read()

def snes2off(addr):
    bank = (addr >> 16) & 0x3F
    low = addr & 0xFFFF
    return bank * 0x10000 + low

from tools.disasm_65816 import trace_routine

# Parse disasm.rs
with open("crates/soe-script/src/disasm.rs") as f:
    lines = f.readlines()

# Let us map opcode to disasm behavior by inspecting disassemble_instruction
# We can check which opcodes read what
# Let us write a python mock of disasm.rs based on lines 110-665
tbl_off = snes2off(0x8CECBE)

print("Comparing all 195 opcodes: ROM vs disasm.rs")
# Let us check the known payload lens in get_known_payload_len:
# lines 636 to 665
payload_lens = {}
# default 0
for op in range(195):
    payload_lens[op] = 0

# Check get_known_payload_len ranges
with open("crates/soe-script/src/disasm.rs") as f:
    content = f.read()

m = re.search(r"fn get_known_payload_len\(opcode: u8\) -> usize \{(.*?)\}", content, re.DOTALL)
if m:
    body = m.group(1)
    for line in body.splitlines():
        line = line.strip()
        if "=>" in line:
            parts = line.split("=>")
            val = int(parts[1].replace(",", "").strip())
            lhs = parts[0].strip()
            # parse lhs: e.g. 0x04 | 0x05 | 0x4C | 0x8D | 0xA7
            subparts = [p.strip() for p in lhs.split("|")]
            for sp in subparts:
                if "..=" in sp:
                    rparts = sp.split("..=")
                    rstart = int(rparts[0].strip(), 16)
                    rend = int(rparts[1].strip(), 16)
                    for x in range(rstart, rend + 1):
                        payload_lens[x] = val
                elif sp.startswith("0x"):
                    x = int(sp, 16)
                    payload_lens[x] = val

print("Payload lengths parsed from get_known_payload_len for fallback opcodes.")
