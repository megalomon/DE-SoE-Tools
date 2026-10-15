import re

ROM_PATH = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc"
with open(ROM_PATH, "rb") as f:
    rom = f.read()

def snes2off(addr):
    bank = (addr >> 16) & 0x3F
    low = addr & 0xFFFF
    return bank * 0x10000 + low

from tools.verify_all_195_handlers_vs_disasm import rom_specs

with open("crates/soe-script/src/disasm.rs") as f:
    disasm_code = f.read()

m = re.search(r"fn get_known_payload_len\(opcode: u8\) -> usize \{(.*?)\n\s*\}", disasm_code, re.DOTALL)
payload_lens = {}
for op in range(195):
    payload_lens[op] = 0

if m:
    body = m.group(1)
    # Split on commas or match arms
    # Join multiline arms
    arms = body.split("=>")
    # arms is [lhs0, val0 + lhs1, val1 + lhs2, ...]
    for i in range(len(arms) - 1):
        lhs = arms[i]
        rhs_full = arms[i+1]
        val_m = re.match(r"\s*(\d+)", rhs_full)
        if val_m:
            val = int(val_m.group(1))
            # parse lhs for opcodes and ranges
            for sp in re.findall(r"0x[0-9A-Fa-f]{2}(?:\.\.=0x[0-9A-Fa-f]{2})?", lhs):
                if "..=" in sp:
                    r1, r2 = sp.split("..=")
                    for x in range(int(r1.strip(), 16), int(r2.strip(), 16) + 1):
                        payload_lens[x] = val
                else:
                    payload_lens[int(sp, 16)] = val

expr_ops = {
    0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E,
    0x10, 0x11, 0x12, 0x14, 0x15, 0x16, 0x18, 0x19, 0x1A, 0x1C, 0x1D, 0x1E,
    0x2A, 0x2B, 0x2E, 0x39, 0x3B, 0x3D, 0x3F, 0x42, 0x43, 0x4E,
    0x5C, 0x5D, 0x5E, 0x5F, 0x60, 0x61, 0x64, 0x68,
    0x6C, 0x6D, 0x6E, 0x6F, 0x70, 0x71, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
    0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x84, 0x85, 0x86, 0x87, 0x89, 0x8A,
    0x8E, 0x8F, 0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99,
    0x9A, 0x9B, 0x9C, 0x9D, 0x9E, 0xA2, 0xA9, 0xAC,
    0xAF, 0xB0, 0xB1, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7, 0xB9, 0xBB
}

mismatches = []
for op in range(195):
    if op in expr_ops:
        continue
    spec = rom_specs[op]
    rom_bytes = spec["direct_bytes"]
    disasm_len = payload_lens[op]
    if rom_bytes != disasm_len:
        mismatches.append(f"Opcode 0x{op:02X} (${spec['addr']:06X}): ROM={rom_bytes} bytes vs disasm={disasm_len} bytes (reads: {spec['reads']})")

print(f"Non-expression opcodes: {195 - len(expr_ops)}")
print(f"Mismatches found: {len(mismatches)}")
for m in mismatches:
    print(" ", m)
