#!/usr/bin/env python3
"""
Secret of Evermore: Casual Run -- Deutscher PAL Build & Patcher
--------------------------------------------------------------
Erzeugt die deutsche 4-MiB-Version von Secret of Evermore: Casual Run
direkt aus der offiziellen deutschen PAL-ROM ("Secret of Evermore (Germany).sfc").

Funktionen:
- Prüft die Integrität der deutschen Basis-ROM (SHA-256 & Dateigröße).
- Erweitert die ROM sauber von 3 MiB auf 4 MiB (HiROM Expansion $F00000-$FFFFFF).
- Wendet die portierten 65816-Patches und Rebalances aus Secret_of_Evermore_Casual_Run_German.asm an:
  * Modul 1: Waffen- & Gegenstands-Rebalance (Bank $C4)
  * Modul 2: Halbierte EXP-Kurve (Level 1-99) & Status-Wachstumstabellen (Bank $CC)
  * Modul 3: Gegner- & Boss-Rebalance (Bank $8E, 89 Bosse/Gegner mit reduzierten HP & 2x Kill-Gold)
  * Modul 4: Auto-Run / Default Dash (Laufen als Standard, Halten von B zum Gehen & schnellen Aufladen)
  * Modul 5: Geteilte Waffen-Erfahrung (Shared Weapon Experience in $F0, Hook an deutscher Routine $8F:9714)
  * Modul 6: Karten- & Dungeon-Fixes (Pyramide in $F01000, Hunde-Labyrinth in $FF3000)
- Berechnet die SNES HiROM-Prüfsumme neu.
- Erzeugt die gepatchte ROM (.sfc) und einen eigenständigen IPS-Patch (.ips).
"""

from pathlib import Path
import argparse
import hashlib
import re
import sys

BASE_SHA256 = "c341668847170d36fa5cfb720568b0b1ecbb24fc426a821f665f1d3853a46a6d"
BASE_SIZE = 3145728
EXPANDED_SIZE = 4194304

ORG_RE = re.compile(r"^\s*org\s+\$([0-9A-Fa-f]{6})\s*$")
DB_RE = re.compile(r"^\s*db\s+(.+?)\s*$")
BYTE_RE = re.compile(r"\$([0-9A-Fa-f]{2})")


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def cpu_to_pc(addr: int) -> int:
    """Konvertiert SNES HiROM CPU-Adressen ($80-$BF:$8000-$FFFF und $C0-$FF:$0000-$FFFF) in PC-Datei-Offsets."""
    bank = addr >> 16
    offset = addr & 0xFFFF
    if 0xC0 <= bank <= 0xFF:
        return addr - 0xC00000
    elif 0x80 <= bank <= 0xBF:
        if offset < 0x8000:
            raise ValueError(f"Ungültige HiROM-Adresse im unteren Spiegelbereich: ${addr:06X}")
        return ((bank - 0x80) * 0x10000) + (offset - 0x8000)
    else:
        raise ValueError(f"Erwartete HiROM CPU-Adresse ($800000-$FFFFFF), erhalten: ${addr:06X}")


def apply_source(rom: bytearray, source_text: str) -> int:
    pc = None
    bytes_written = 0
    for lineno, raw in enumerate(source_text.splitlines(), 1):
        line = raw.split(";", 1)[0].strip()
        if not line or line.endswith(":") or line in {"arch 65816", "hirom"}:
            continue
        m = ORG_RE.match(line)
        if m:
            pc = cpu_to_pc(int(m.group(1), 16))
            continue
        m = DB_RE.match(line)
        if m:
            if pc is None:
                raise ValueError(f"Zeile {lineno}: db erscheint vor org")
            vals = [int(x, 16) for x in BYTE_RE.findall(m.group(1))]
            if not vals:
                raise ValueError(f"Zeile {lineno}: fehlerhaftes db: {raw}")
            end = pc + len(vals)
            if end > len(rom):
                raise ValueError(f"Zeile {lineno}: Schreibzugriff hinter ROM-Ende ({end} > {len(rom)})")
            rom[pc:end] = bytes(vals)
            bytes_written += len(vals)
            pc = end
            continue
        raise ValueError(f"Zeile {lineno}: nicht unterstützte Syntax: {raw}")
    return bytes_written


def make_ips(base: bytes, target: bytes) -> bytes:
    """Erstellt einen Standard-IPS-Patch, der Unterschiede zwischen Basis-ROM und Ziel-ROM kodiert."""
    if len(target) > 0x1000000:
        raise ValueError("IPS 24-Bit-Offsets unterstützen keine Dateien > 16 MiB")
    padded = base + b"\x00" * max(0, len(target) - len(base))
    out = bytearray(b"PATCH")
    i = 0
    while i < len(target):
        if padded[i] == target[i]:
            i += 1
            continue
        start = i
        while i < len(target) and padded[i] != target[i] and i - start < 0xFFFF:
            i += 1
        payload = target[start:i]
        out += start.to_bytes(3, "big")
        out += len(payload).to_bytes(2, "big")
        out += payload
    out += b"EOF"
    if len(target) != len(base):
        out += len(target).to_bytes(3, "big")
    return bytes(out)


def recalculate_checksum(rom: bytearray) -> None:
    """Berechnet die SNES HiROM Prüfsumme und das Komplement neu."""
    # HiROM Header liegt bei 0x00FFB0..0x00FFFF
    rom[0xFFDC:0xFFE0] = bytes((0xFF, 0xFF, 0x00, 0x00))
    checksum = sum(rom) & 0xFFFF
    complement = checksum ^ 0xFFFF
    rom[0xFFDC:0xFFDE] = complement.to_bytes(2, "little")
    rom[0xFFDE:0xFFE0] = checksum.to_bytes(2, "little")


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Erzeugt Secret of Evermore: Casual Run für die deutsche PAL ROM."
    )
    parser.add_argument(
        "base_rom",
        nargs="?",
        default="/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc",
        help="Pfad zur deutschen Basis-ROM (Secret of Evermore (Germany).sfc)",
    )
    parser.add_argument(
        "output_rom",
        nargs="?",
        default=str(Path(__file__).resolve().parent / "Secret_of_Evermore_Casual_Run_German.sfc"),
        help="Pfad für die erzeugte 4-MiB-ROM",
    )
    parser.add_argument(
        "--source",
        default=str(Path(__file__).resolve().parent / "Secret_of_Evermore_Casual_Run_German.asm"),
        help="ASM-Patch-Datei für die deutsche ROM",
    )
    parser.add_argument(
        "--ips",
        default=str(Path(__file__).resolve().parent / "Secret_of_Evermore_Casual_Run_German.ips"),
        help="Pfad für den generierten IPS-Patch",
    )
    args = parser.parse_args()

    base_path = Path(args.base_rom)
    if not base_path.exists():
        raise SystemExit(f"Basis-ROM nicht gefunden: {base_path}")

    base = base_path.read_bytes()
    if len(base) != BASE_SIZE:
        raise SystemExit(f"Falsche ROM-Größe: {len(base)} Bytes; erwartet {BASE_SIZE} Bytes")

    got_hash = sha256(base)
    if got_hash != BASE_SHA256:
        raise SystemExit(
            f"Falscher SHA-256 Hash der Basis-ROM:\n  Gefunden: {got_hash}\n  Erwartet: {BASE_SHA256}"
        )

    print(f"Basis-ROM verifiziert: {base_path.name} (3.145.728 Bytes, PAL)")

    # 1. ROM auf 4 MiB erweitern
    rom = bytearray(base)
    rom.extend(b"\x00" * (EXPANDED_SIZE - len(rom)))
    print(f"ROM erweitert auf: {len(rom)} Bytes (4 MiB HiROM)")

    # 2. ASM-Patches anwenden
    source_file = Path(args.source)
    if not source_file.exists():
        raise SystemExit(f"ASM-Quelle nicht gefunden: {source_file}")

    print(f"Wende Patches an aus: {source_file.name}...")
    source_text = source_file.read_text(encoding="utf-8")
    bytes_written = apply_source(rom, source_text)
    print(f"Erfolgreich gepatcht: {bytes_written} Bytes modifiziert / hinzugefügt")

    # 3. Prüfsumme aktualisieren
    recalculate_checksum(rom)
    out_checksum = int.from_bytes(rom[0xFFDE:0xFFE0], "little")
    print(f"SNES HiROM Prüfsumme aktualisiert: 0x{out_checksum:04X}")

    # 4. Output-ROM schreiben
    out_rom_path = Path(args.output_rom)
    output_bytes = bytes(rom)
    out_rom_path.write_bytes(output_bytes)
    out_sha256 = sha256(output_bytes)
    print(f"ROM gespeichert: {out_rom_path}")
    print(f"  SHA-256: {out_sha256}")

    # 5. IPS-Patch schreiben
    if args.ips:
        ips_path = Path(args.ips)
        ips_data = make_ips(base, output_bytes)
        ips_path.write_bytes(ips_data)
        print(f"IPS-Patch gespeichert: {ips_path} ({len(ips_data)} Bytes)")

    print("\n[SUCCESS] Secret of Evermore: Casual Run (Deutsche PAL Version) erfolgreich gebaut!")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
