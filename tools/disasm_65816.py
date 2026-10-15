import struct

ROM_PATH = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc"
with open(ROM_PATH, "rb") as f:
    rom = f.read()

def snes2off(addr):
    bank = (addr >> 16) & 0x3F
    low = addr & 0xFFFF
    return bank * 0x10000 + low

# 65816 instruction lengths
# M=0 (16-bit A), X=0 (16-bit X/Y) default when interpreter calls handler
# Let us verify if interpreter enters with REP #$30 (M=0, X=0) or SEP #$20
# In interpreter loop at $8CD48B:
# $8CD48F: 29 FF 00 (AND #$00FF -> 16-bit accumulator!)
# $8CD492: 0A (ASL)
# $8CD493: AA (TAX)
# $8CD494: FC BE EC (JSR ($ECBE, X))
# So entry state is: 16-bit Accumulator (M=0), 16-bit Index (X=0)!

def disasm_instruction(addr, m_flag=0, x_flag=0):
    off = snes2off(addr)
    if off >= len(rom):
        return 1, "DB", "???", m_flag, x_flag
    op = rom[off]

    # Special handlers for REP / SEP
    if op == 0xC2: # REP #imm
        imm = rom[off+1]
        new_m = m_flag if (imm & 0x20) == 0 else 0
        new_x = x_flag if (imm & 0x10) == 0 else 0
        return 2, f"REP #${imm:02X}", "REP", new_m, new_x
    if op == 0xE2: # SEP #imm
        imm = rom[off+1]
        new_m = m_flag if (imm & 0x20) == 0 else 1
        new_x = x_flag if (imm & 0x10) == 0 else 1
        return 2, f"SEP #${imm:02X}", "SEP", new_m, new_x

    # Immediate instructions depending on M
    # ADC, AND, BIT, CMP, EOR, LDA, ORA, SBC, CPY, CPX, LDX, LDY
    if op in [0x69, 0x29, 0x89, 0xC9, 0x49, 0xA9, 0x09, 0xE9]:
        # A immediate
        if m_flag == 1:
            val = rom[off+1]
            return 2, f"IMM8 #${val:02X} (op {op:02X})", "IMM_A", m_flag, x_flag
        else:
            val = rom[off+1] | (rom[off+2] << 8)
            return 3, f"IMM16 #${val:04X} (op {op:02X})", "IMM_A", m_flag, x_flag

    if op in [0xA0, 0xC0]: # LDY, CPY imm
        if x_flag == 1:
            val = rom[off+1]
            return 2, f"IMM8 #${val:02X} (op {op:02X})", "IMM_XY", m_flag, x_flag
        else:
            val = rom[off+1] | (rom[off+2] << 8)
            return 3, f"IMM16 #${val:04X} (op {op:02X})", "IMM_XY", m_flag, x_flag

    if op in [0xA2, 0xE0]: # LDX, CPX imm
        if x_flag == 1:
            val = rom[off+1]
            return 2, f"IMM8 #${val:02X} (op {op:02X})", "IMM_XY", m_flag, x_flag
        else:
            val = rom[off+1] | (rom[off+2] << 8)
            return 3, f"IMM16 #${val:04X} (op {op:02X})", "IMM_XY", m_flag, x_flag

    # 4-byte instructions: 22 (JSL), 5C (JMP long), and long addressing modes
    if op == 0x22:
        tgt = rom[off+1] | (rom[off+2] << 8) | (rom[off+3] << 16)
        return 4, f"JSL ${tgt:06X}", "JSL", m_flag, x_flag
    if op == 0x5C:
        tgt = rom[off+1] | (rom[off+2] << 8) | (rom[off+3] << 16)
        return 4, f"JMP ${tgt:06X}", "JMP_LONG", m_flag, x_flag
    if op in [0x0F, 0x2F, 0x4F, 0x6F, 0x8F, 0xAF, 0xCF, 0xEF]: # op long
        tgt = rom[off+1] | (rom[off+2] << 8) | (rom[off+3] << 16)
        return 4, f"LONG ${tgt:06X} (op {op:02X})", "LONG", m_flag, x_flag
    if op in [0x1F, 0x3F, 0x5F, 0x7F, 0x9F, 0xBF, 0xDF, 0xFF]: # op long, x
        tgt = rom[off+1] | (rom[off+2] << 8) | (rom[off+3] << 16)
        return 4, f"LONG,X ${tgt:06X} (op {op:02X})", "LONG_X", m_flag, x_flag

    # 3-byte instructions
    # JSR abs (20), JMP abs (4C), JMP (abs,X) (7C), JSR (abs,X) (FC)
    if op in [0x20, 0x4C, 0x7C, 0xFC]:
        tgt = rom[off+1] | (rom[off+2] << 8)
        return 3, f"JMP/JSR ${tgt:04X} (op {op:02X})", "BRANCH_ABS", m_flag, x_flag
    # Absolute and Absolute,X / Absolute,Y
    if op in [0x0C, 0x0D, 0x0E, 0x19, 0x1D, 0x1E, 0x2C, 0x2D, 0x2E, 0x39, 0x3D, 0x3E,
              0x4D, 0x4E, 0x59, 0x5D, 0x5E, 0x6D, 0x6E, 0x79, 0x7D, 0x7E, 0x8C, 0x8D,
              0x8E, 0x99, 0x9C, 0x9D, 0x9E, 0xAC, 0xAD, 0xAE, 0xB9, 0xBC, 0xBD, 0xBE,
              0xCC, 0xCD, 0xCE, 0xD9, 0xDD, 0xDE, 0xEC, 0xED, 0xEE, 0xF9, 0xFD, 0xFE]:
        tgt = rom[off+1] | (rom[off+2] << 8)
        return 3, f"ABS ${tgt:04X} (op {op:02X})", "ABS", m_flag, x_flag
    if op in [0xF4, 0x62]: # PEA, PER
        tgt = rom[off+1] | (rom[off+2] << 8)
        return 3, f"PEA/PER ${tgt:04X}", "PEA", m_flag, x_flag
    if op == 0x82: # BRL
        rel = rom[off+1] | (rom[off+2] << 8)
        if rel >= 0x8000: rel -= 0x10000
        return 3, f"BRL ${addr+3+rel:06X}", "BRL", m_flag, x_flag

    # 2-byte instructions
    # Direct Page, DP,X, DP,Y, (DP), [DP], etc.
    # Relative branches
    if op in [0x10, 0x30, 0x50, 0x70, 0x90, 0xB0, 0xD0, 0xF0, 0x80]: # Branch rel8
        rel = rom[off+1]
        if rel >= 0x80: rel -= 0x100
        return 2, f"Bcc ${addr+2+rel:06X} (op {op:02X})", "BCC", m_flag, x_flag
    if op in [0x00, 0x02]: # BRK, COP
        return 2, f"BRK/COP #{rom[off+1]:02X}", "BRK", m_flag, x_flag
    if op == 0x44 or op == 0x54: # MVP, MVN (block move)
        return 3, f"MVN/MVP", "MVN", m_flag, x_flag
    # All DP addressing
    if op in [0x01, 0x04, 0x05, 0x06, 0x07, 0x11, 0x12, 0x14, 0x15, 0x16, 0x17,
              0x21, 0x24, 0x25, 0x26, 0x27, 0x31, 0x32, 0x34, 0x35, 0x36, 0x37,
              0x41, 0x45, 0x46, 0x47, 0x51, 0x52, 0x55, 0x56, 0x57,
              0x61, 0x64, 0x65, 0x66, 0x67, 0x71, 0x72, 0x74, 0x75, 0x76, 0x77,
              0x81, 0x84, 0x85, 0x86, 0x87, 0x91, 0x92, 0x94, 0x95, 0x96, 0x97,
              0xA1, 0xA4, 0xA5, 0xA6, 0xA7, 0xB1, 0xB2, 0xB4, 0xB5, 0xB6, 0xB7,
              0xC1, 0xC4, 0xC5, 0xC6, 0xC7, 0xD1, 0xD2, 0xD4, 0xD5, 0xD6, 0xD7,
              0xE1, 0xE4, 0xE5, 0xE6, 0xE7, 0xF1, 0xF2, 0xF4, 0xF5, 0xF6, 0xF7,
              0xD4, 0x64, 0x74, 0x94, 0xB4]:
        dp = rom[off+1]
        return 2, f"DP ${dp:02X} (op {op:02X})", "DP", m_flag, x_flag
    if op in [0x03, 0x13, 0x23, 0x33, 0x43, 0x53, 0x63, 0x73, 0x83, 0x93, 0xA3, 0xB3, 0xC3, 0xD3, 0xE3, 0xF3]: # Stack rel
        sr = rom[off+1]
        return 2, f"SR ${sr:02X} (op {op:02X})", "SR", m_flag, x_flag

    # 1-byte instructions
    return 1, f"OP_{op:02X}", "1BYTE", m_flag, x_flag

def trace_routine(start_addr, max_instructions=80):
    addr = start_addr
    m = 0
    x = 0
    trace = []
    
    for _ in range(max_instructions):
        off = snes2off(addr)
        op = rom[off]
        length, text, cat, m, x = disasm_instruction(addr, m, x)
        trace.append((addr, op, length, text, cat, m, x))
        
        # Check end of routine
        if op in [0x60, 0x6B, 0xDB]: # RTS, RTL, STP
            break
        if op == 0x4C: # JMP abs
            target = 0x8C0000 | (rom[off+1] | (rom[off+2] << 8))
            # if jump to common exit/helper:
            trace.append((addr, op, length, f"-> JMP to ${target:06X}", "JMP", m, x))
            # Follow jump if within bank 8C
            if target < 0x8D0000:
                addr = target
                continue
            else:
                break
        if op == 0x80: # BRA
            rel = rom[off+1]
            if rel >= 0x80: rel -= 0x100
            addr = addr + 2 + rel
            continue
        
        addr += length
    return trace

if __name__ == "__main__":
    # Analyze all 195
    tbl_off = snes2off(0x8CECBE)
    for i in range(195):
        h = rom[tbl_off + i*2] | (rom[tbl_off + i*2 + 1] << 8)
        addr = 0x8C0000 | h
        tr = trace_routine(addr)
        
        # Analyze trace for reads:
        # JSL $8CEE44 -> expr
        # JSL $8CF08F -> entity
        # JSR $8CD6FE -> params_list
        # LDA [$82] -> read_82
        reads = []
        for pc, op, l, txt, cat, m_flag, x_flag in tr:
            if "JSL $8CEE44" in txt:
                reads.append("expr")
            elif "JSL $8CF08F" in txt:
                reads.append("entity")
            elif "JMP/JSR $D6FE" in txt:
                reads.append("params_list")
            elif op == 0xA7 and rom[snes2off(pc)+1] == 0x82:
                # check M flag at this point
                # if m_flag == 0 (before this inst): word read!
                # if m_flag == 1: byte read!
                # But note: m_flag is after inst, let us check previous
                reads.append("read_82")
            elif op == 0xDB:
                reads.append("STP")

        print(f"Opcode 0x{i:02X} (${addr:06X}): {reads}")
