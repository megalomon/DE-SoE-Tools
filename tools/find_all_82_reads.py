ROM_PATH = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc"
with open(ROM_PATH, "rb") as f:
    rom = f.read()

def snes2off(addr):
    bank = (addr >> 16) & 0x3F
    low = addr & 0xFFFF
    return bank * 0x10000 + low

bank8c_start = snes2off(0x8C0000)
bank8c_end = snes2off(0x8D0000)
bank8c = rom[bank8c_start:bank8c_end]

# Find all A7 82 and 67 82
reads = []
for p in range(len(bank8c)-1):
    if (bank8c[p] == 0xA7 or bank8c[p] == 0x67) and bank8c[p+1] == 0x82:
        reads.append((0x8C0000 + p, "LDA" if bank8c[p] == 0xA7 else "ADC"))

print(f"Total reads of [$82] in Bank $8C: {len(reads)}")
for addr, typ in reads:
    # Print context
    off = snes2off(addr)
    ctx = " ".join(f"{b:02X}" for b in rom[off:off+10])
    print(f"${addr:06X} ({typ}): {ctx}")
