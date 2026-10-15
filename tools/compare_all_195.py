import re

ROM_PATH = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc"
with open(ROM_PATH, "rb") as f:
    rom = f.read()

def snes2off(addr):
    bank = (addr >> 16) & 0x3F
    low = addr & 0xFFFF
    return bank * 0x10000 + low

from tools.disasm_65816 import trace_routine

# Load disasm.rs
with open("crates/soe-script/src/disasm.rs") as f:
    disasm_code = f.read()

# Load docs/sigil_skripte.md
with open("docs/sigil_skripte.md", encoding="utf-8") as f:
    doc_text = f.read()

# Let us verify each opcode from 0x00 to 0xC2 in detail
tbl_off = snes2off(0x8CECBE)

print("Starting deep verification of all 195 opcodes...")
report = []

for op in range(195):
    h = rom[tbl_off + op*2] | (rom[tbl_off + op*2 + 1] << 8)
    addr = 0x8C0000 | h
    
    # Trace instructions of handler
    tr = trace_routine(addr, 100)
    
    # Filter reads
    calls_ee44 = 0
    calls_f08f = 0
    calls_d6fe = 0
    reads_82 = []
    is_stp = False
    
    for pc, opcode_byte, l, txt, cat, m, x in tr:
        if "JSL $8CEE44" in txt:
            calls_ee44 += 1
        elif "JSL $8CF08F" in txt:
            calls_f08f += 1
        elif "JMP/JSR $D6FE" in txt:
            calls_d6fe += 1
        elif opcode_byte == 0xA7 and rom[snes2off(pc)+1] == 0x82:
            # check M flag
            # look ahead for INC $82
            inc_cnt = 0
            cur_p = snes2off(pc) + 2
            while cur_p < snes2off(pc) + 8:
                if rom[cur_p] == 0xE6 and rom[cur_p+1] == 0x82:
                    inc_cnt += 1
                    cur_p += 2
                else:
                    break
            reads_82.append(("LDA", inc_cnt))
        elif opcode_byte == 0x67 and rom[snes2off(pc)+1] == 0x82:
            inc_cnt = 0
            cur_p = snes2off(pc) + 2
            while cur_p < snes2off(pc) + 8:
                if rom[cur_p] == 0xE6 and rom[cur_p+1] == 0x82:
                    inc_cnt += 1
                    cur_p += 2
                else:
                    break
            reads_82.append(("ADC", inc_cnt))
        elif opcode_byte == 0xDB:
            is_stp = True

    # Search in disasm.rs how op is handled
    # Check if mentioned explicitly as `0xXX =>` or in a range `0xXX..=0xYY`
    # Let us report
    report.append({
        "op": op,
        "addr": addr,
        "is_stp": is_stp,
        "ee44": calls_ee44,
        "f08f": calls_f08f,
        "d6fe": calls_d6fe,
        "reads_82": reads_82
    })

print(f"Processed all {len(report)} opcodes.")
