import re

ROM_PATH = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc"
with open(ROM_PATH, "rb") as f:
    rom = f.read()

def snes2off(addr):
    bank = (addr >> 16) & 0x3F
    low = addr & 0xFFFF
    return bank * 0x10000 + low

from tools.disasm_65816 import trace_routine

# Step 1: Trace all 195 ROM handlers
tbl_off = snes2off(0x8CECBE)
rom_specs = {}

for op in range(195):
    h = rom[tbl_off + op*2] | (rom[tbl_off + op*2 + 1] << 8)
    addr = 0x8C0000 | h
    tr = trace_routine(addr, 100)
    
    expr_cnt = 0
    entity_cnt = 0
    params = False
    direct_bytes = 0
    is_stp = False
    reads = []
    
    for pc, op_b, l, txt, cat, m, x in tr:
        if "JSL $8CEE44" in txt:
            expr_cnt += 1
            reads.append("expr")
        elif "JSL $8CF08F" in txt:
            entity_cnt += 1
            reads.append("entity")
        elif "JMP/JSR $D6FE" in txt:
            params = True
            reads.append("params")
        elif "JMP/JSR $DD50" in txt:
            direct_bytes += 1
            reads.append("win_u8")
        elif op_b == 0xA7 and rom[snes2off(pc)+1] == 0x82:
            # check lookahead for inc $82
            off_next = snes2off(pc) + 2
            inc_cnt = 0
            while off_next < len(rom) and off_next < snes2off(pc) + 8:
                if rom[off_next] == 0xE6 and rom[off_next+1] == 0x82:
                    inc_cnt += 1
                    off_next += 2
                else:
                    break
            if inc_cnt >= 2:
                direct_bytes += 2
                reads.append("u16")
            elif inc_cnt == 1:
                direct_bytes += 1
                reads.append("u8")
            else:
                direct_bytes += 1
                reads.append("u8?")
        elif op_b == 0x67 and rom[snes2off(pc)+1] == 0x82: # ADC [$82]
            off_next = snes2off(pc) + 2
            inc_cnt = 0
            while off_next < len(rom) and off_next < snes2off(pc) + 8:
                if rom[off_next] == 0xE6 and rom[off_next+1] == 0x82:
                    inc_cnt += 1
                    off_next += 2
                else:
                    break
            if inc_cnt >= 2:
                direct_bytes += 2
                reads.append("u16_adc")
            else:
                direct_bytes += 1
                reads.append("u8_adc")
        elif op_b == 0xE6 and rom[snes2off(pc)+1] == 0x82: # INC $82 without LDA (e.g. 0x4C)
            # check if previous instruction was not LDA/ADC
            pass
        elif op_b == 0xDB:
            is_stp = True
            
    # Special fixes for known patterns:
    # 0x4C: INC $82; SEC; RTS (skips 1 byte)
    if op == 0x4C:
        direct_bytes = 1
        reads = ["skip_u8"]
    # 0x79: JSR $E4B1 (0x78) then wait (Status 6)
    elif op == 0x79:
        entity_cnt = 1
        direct_bytes = 2
        expr_cnt = 1
        reads = ["entity", "u16", "expr"]
        
    rom_specs[op] = {
        "addr": addr,
        "is_stp": is_stp,
        "expr_cnt": expr_cnt,
        "entity_cnt": entity_cnt,
        "params": params,
        "direct_bytes": direct_bytes,
        "reads": reads
    }

print("ROM specifications extracted for all 195 opcodes.")
for op in range(195):
    s = rom_specs[op]
    print(f"Opcode 0x{op:02X} (${s['addr']:06X}): bytes={s['direct_bytes']}, exprs={s['expr_cnt']}, entity={s['entity_cnt']}, params={s['params']}, stp={s['is_stp']} -> {s['reads']}")
