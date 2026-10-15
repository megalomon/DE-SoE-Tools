import re
from tools.verify_all_195_handlers_vs_disasm import rom_specs

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

print(f"Total opcodes parsed from doc: {len(docs)}")

# Let us verify each opcode description and operands in docs
operand_mismatches = []
for op in range(195):
    d = docs.get(op)
    if not d:
        operand_mismatches.append(f"0x{op:02X}: missing in docs")
        continue
    spec = rom_specs[op]
    # Check if doc operands describe what rom reads
    ops_str = d["operands"].lower()
    
    # Check STP
    if spec["is_stp"]:
        if "stp" not in d["status"].lower() and "trap" not in d["desc"].lower() and op != 0xAB: # 0xAB is soft reset terminal
            operand_mismatches.append(f"0x{op:02X} (${spec['addr']:06X}): ROM is STP but doc says '{d['status']}'")
        continue

    # Check zero operands
    if spec["direct_bytes"] == 0 and spec["expr_cnt"] == 0 and spec["entity_cnt"] == 0 and not spec["params"]:
        if "keine" not in ops_str and ops_str != "—":
            operand_mismatches.append(f"0x{op:02X} (${spec['addr']:06X}): ROM has 0 operands but doc says '{d['operands']}'")
    else:
        if "keine" in ops_str or ops_str == "—":
            operand_mismatches.append(f"0x{op:02X} (${spec['addr']:06X}): ROM has operands ({spec['reads']}) but doc says '{d['operands']}'")

print(f"Opcode operand / status mismatches in docs: {len(operand_mismatches)}")
for m in operand_mismatches:
    print(" ", m)
