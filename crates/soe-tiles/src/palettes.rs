// crates/soe-tiles/src/palettes.rs
use soe_core::gfx::Palette;

pub struct NamedPalette {
    pub name: &'static str,
    pub words: [u16; 16],
}

pub const BOY_PALETTE: NamedPalette = NamedPalette {
    name: "Boy",
    words: [
        0, 0x7FBC, 0x4EDF, 0x2DBA, 0x1913, 0x1489, 0x7EAA, 0x7923, 0x5465, 0x02BF, 0x059C,
        0x08F6, 0x07EA, 0x0287, 0x1885, 0x0000,
    ],
};

pub const ACT0_DOG_PALETTE: NamedPalette = NamedPalette {
    name: "Act0 Dog",
    words: [
        0, 0x7FDE, 0x52D8, 0x4253, 0x35F0, 0x298D, 0x62F7, 0x4E73, 0x4210, 0x35AC, 0x4A10,
        0x39AC, 0x2D29, 0x1CC6, 0x14A5, 0x0000,
    ],
};

pub const PODUNK_1_PALETTE: NamedPalette = NamedPalette {
    name: "Podunk 1",
    words: [
        0, 0x1464, 0x1485, 0x18A7, 0x24E8, 0x312A, 0x3D6C, 0x2D6D, 0x31AF, 0x3A12, 0x3E55,
        0x4297, 0x4B3B, 0x57FF, 0x000A, 0x0005,
    ],
};

pub const JUNGLE_1_PALETTE: NamedPalette = NamedPalette {
    name: "Jungle 1",
    words: [
        0, 0x19EF, 0x15AC, 0x116A, 0x1127, 0x0CE5, 0x08A3, 0x0481, 0x0040, 0x08A8, 0x0485,
        0x0064, 0x0022, 0x10A6, 0x0864, 0x0443,
    ],
};

pub const TITLE_SKY_PALETTE: NamedPalette = NamedPalette {
    name: "Title Sky",
    words: [
        0, 0x4587, 0x4166, 0x3D46, 0x3925, 0x3125, 0x2D04, 0x28E4, 0x24C3, 0x20A3, 0x1C82,
        0x1482, 0x1061, 0x0C41, 0x0820, 0x0400,
    ],
};

pub const DEFAULT_PALETTES: &[NamedPalette] = &[
    BOY_PALETTE,
    ACT0_DOG_PALETTE,
    PODUNK_1_PALETTE,
    JUNGLE_1_PALETTE,
    TITLE_SKY_PALETTE,
];

pub fn get_palette_by_name(name: &str) -> Palette {
    for p in DEFAULT_PALETTES {
        if p.name.eq_ignore_ascii_case(name) {
            return Palette::from_snes_words(&p.words, true);
        }
    }
    // Fallback: Graustufen-Palette
    let mut words = [0u16; 16];
    for i in 0..16 {
        let v = (i * 2) as u16;
        words[i] = v | (v << 5) | (v << 10);
    }
    Palette::from_snes_words(&words, true)
}
