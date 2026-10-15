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
    content = f.read()

# Fallback lengths
payload_lens = {}
for op in range(195):
    payload_lens[op] = 0

m = re.search(r"fn get_known_payload_len\(opcode: u8\) -> usize \{(.*?)\}", content, re.DOTALL)
if m:
    body = m.group(1)
    for line in body.splitlines():
        line = line.strip()
        if "=>" in line:
            parts = line.split("=>")
            val = int(parts[1].replace(",", "").strip())
            lhs = parts[0].strip()
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

# Now let us find all explicit match arms in decode_instruction
m_arms = re.search(r"fn decode_instruction\([^)]*\)[^{]*\{(.*?)\n\s*fn parse_sub", content, re.DOTALL)
arms_code = m_arms.group(1) if m_arms else ""

# Map of opcode -> (fixed_bytes, expr_count, special_desc)
disasm_ops = {}
for op in range(195):
    disasm_ops[op] = {
        "fixed_bytes": payload_lens[op],
        "expr_count": 0,
        "special": "fallback"
    }

# Let us analyze individual arms in decode_instruction
# We can search for lines with `0xXX =>` or `0xXX | 0xYY =>` or `0xXX..=0xYY =>`
lines = arms_code.splitlines()
i = 0
while i < len(lines):
    line = lines[i].strip()
    if "=>" in line and not line.startswith("//"):
        # Match arm header
        lhs = line.split("=>")[0].strip()
        # Collect block until next arm or closing brace at same indent
        block = [line]
        if "{" in line and "}" not in line:
            i += 1
            brace_count = line.count("{") - line.count("}")
            while i < len(lines) and brace_count > 0:
                brace_count += lines[i].count("{") - lines[i].count("}")
                block.append(lines[i])
                i += 1
            i -= 1 # to counteract outer loop += 1
        block_text = "\n".join(block)
        
        # Parse opcodes in lhs
        target_ops = []
        for sp in lhs.split("|"):
            sp = sp.strip()
            if "..=" in sp:
                m_range = re.search(r"0x([0-9A-Fa-f]{2})\.\.=0x([0-9A-Fa-f]{2})", sp)
                if m_range:
                    for x in range(int(m_range.group(1), 16), int(m_range.group(2), 16) + 1):
                        target_ops.append(x)
            else:
                m_single = re.search(r"0x([0-9A-Fa-f]{2})", sp)
                if m_single:
                    target_ops.append(int(m_single.group(1), 16))
        
        # Analyze block_text
        fixed_bytes = 0
        expr_count = 0
        
        # read_u8, read_i8: 1 byte
        fixed_bytes += len(re.findall(r"read_[ui]8", block_text))
        # read_u16, read_i16: 2 bytes
        fixed_bytes += len(re.findall(r"read_[ui]16", block_text)) * 2
        # read_u24: 3 bytes
        fixed_bytes += len(re.findall(r"read_u24", block_text)) * 3
        # loops: for _ in 0..N { self.read_u8
        m_loop = re.findall(r"for _ in 0\.\.(\d+)\s*\{\s*self\.read_u8", block_text)
        for cnt in m_loop:
            fixed_bytes += int(cnt)
        
        # exprs: parse_sub
        expr_count += len(re.findall(r"parse_sub", block_text))
        m_sub_loop = re.findall(r"for _ in 0\.\.(\d+)\s*\{\s*self\.parse_sub", block_text)
        for cnt in m_sub_loop:
            expr_count += int(cnt)

        for top in target_ops:
            if top < 195:
                disasm_ops[top] = {
                    "fixed_bytes": fixed_bytes,
                    "expr_count": expr_count,
                    "special": "explicit"
                }
    i += 1

print(f"Parsed disasm behavior for all 195 opcodes.")

# Now compare with ROM
tbl_off = snes2off(0x8CECBE)
mismatches = []

for op in range(195):
    h = rom[tbl_off + op*2] | (rom[tbl_off + op*2 + 1] << 8)
    addr = 0x8C0000 | h
    
    tr = trace_routine(addr, 100)
    
    rom_ee44 = sum(1 for _, _, _, txt, _, _, _ in tr if "JSL $8CEE44" in txt)
    rom_f08f = sum(1 for _, _, _, txt, _, _, _ in tr if "JSL $8CF08F" in txt)
    rom_d6fe = sum(1 for _, _, _, txt, _, _, _ in tr if "JMP/JSR $D6FE" in txt)
    
    # Calculate bytes read from [$82]
    rom_read_bytes = 0
    for pc, op_b, l, txt, cat, m, x in tr:
        if op_b in [0xA7, 0x67] and rom[snes2off(pc)+1] == 0x82:
            # count incs
            inc_cnt = 0
            cur_p = snes2off(pc) + 2
            while cur_p < snes2off(pc) + 8:
                if rom[cur_p] == 0xE6 and rom[cur_p+1] == 0x82:
                    inc_cnt += 1
                    cur_p += 2
                else:
                    break
            rom_read_bytes += inc_cnt
            
    # For opcodes that branch/loop like 0x08, 0x09: they read 16-bit offset
    if op in [0x08, 0x09, 0x0A, 0x0B, 0x8E, 0x8F]:
        # They have 2 bytes offset (read at $8CD81D)
        pass # accounted in trace or branch

    # Compare disasm vs ROM
    d = disasm_ops[op]
    
    # Special cases:
    # 0x0A, 0x0B: 1 expr + 3 bytes amount + 2 bytes offset = 5 bytes + 1 expr
    # 0x04: 2 bytes offset
    # 0x05: 1 byte offset
    # 0x08, 0x09: 1 expr + 2 bytes offset
    # 0x8E, 0x8F: 2 exprs + 2 bytes offset
    # 0xAF..=0xB4: dynamic param list + address/offset
    # 0x9E, 0xAC: loop until zero
    
    # Let us check 0x44..=0x47 and 0x7F specifically
    if op in [0x44, 0x45, 0x46, 0x47]:
        if d["fixed_bytes"] != 4:
            mismatches.append(f"0x{op:02X} (${addr:06X}): disasm reads {d['fixed_bytes']} bytes, ROM reads 4 bytes!")
    elif op == 0x7F:
        if d["fixed_bytes"] != 2:
            mismatches.append(f"0x{op:02X} (${addr:06X}): disasm reads {d['fixed_bytes']} bytes, ROM reads 2 bytes (u16)!")

for m in mismatches:
    print("MISMATCH:", m)

if not mismatches:
    print("No mismatches found for 0x44..0x47 and 0x7F!")
