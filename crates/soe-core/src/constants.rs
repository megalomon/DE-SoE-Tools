// crates/soe-core/src/constants.rs

/// SNES-Adressen der Kern-Routinen und Sprungtabellen im deutschen ROM
pub const DE_SCRIPT_OPCODES_TABLE: u32 = 0x8CECBE;
pub const DE_SCRIPT_SUBINSTR_TABLE: u32 = 0x8CF442;
pub const DE_PRNG_ROUTINE: u32 = 0x80859B;
pub const DE_TEXT_POINTER_TABLE: u32 = 0x928000;
pub const DE_TEXT_MARKOV_TABLE: u32 = 0x92A41E;
pub const DE_SCRIPTS_START_ADDR: u32 = 0x938000;
pub const DE_MAP_LIST_ADDR: u32 = 0xA0FDE5;
pub const MAX_MAPS: usize = 127;

/// Grafik- und Tile-Pointer-Tabellen im deutschen ROM
pub const DE_MAP_TILES_PTR_TABLE: u32 = 0xEF0000;
pub const DE_SPRITE_BLOCKS_16_PTR_TABLE: u32 = 0xEE0000;
pub const DE_SPRITE_BLOCKS_8_PTR_TABLE: u32 = 0xD90000;
pub const DE_SPRITE_INFO_START_ADDR: u32 = 0xCA0003;
pub const DE_CHARACTER_DATA_BASE_ADDR: u32 = 0x8EB678;

/// WRAM-Basisadressen
pub const WRAM_FLAGS_BASE: u32 = 0x7E2258;
pub const WRAM_TEMP_BASE: u32 = 0x7E2834;

/// WRAM-Adressen der Handelswaren (Trade Goods)
pub const WRAM_GOODS_POTS: u32 = 0x7E241B; // Keramiktöpfe ($2258 + 0x01C3)
pub const WRAM_GOODS_RICE: u32 = 0x7E2427; // Reis ($2258 + 0x01CF)

/// WRAM-Adressen der Amulette / Charms
pub const WRAM_CHARM_CHOCOBO_EGG: u32 = 0x7E243D; // Chocobo-Ei ($2258 + 0x01E5)
pub const WRAM_CHARM_MAGIC_GOURD: u32 = 0x7E243F; // Magischer Kürbis ($2258 + 0x01E7)

/// Event-Flags
pub const FLAG_CHOCOBO_EGG_ACQUIRED: u16 = 0x004E; // Bit 6 von $7E2261
pub const FLAG_MAGIC_GOURD_TRADED: u16 = 0x0052;   // Bit 2 von $7E2262

/// Liste der Handelswaren (Trade Goods) in der deutschen ROM (Offset 0x051A00)
#[repr(u8)]
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum TradeGood {
    Dekuchen = 0,
    Fluegel = 1,
    Elixier = 2,
    Elfenstaub = 3,
    Zauberperle = 4,
    Beutel = 5,
    Muelleimer = 6,
    Schappschapp = 7,
    AmulettDesKaron = 8,
    Perle = 9,
    Keramiktopf = 10,
    Huhn = 11,
    Schakalfigur = 12,
    Juwelenskarabaeus = 13,
    Kalksteintafel = 14,
    Rosenwasser = 15,
    Reis = 16,
    Gewuerz = 17,
    Silberloeffel = 18,
    Seide = 19,
    Eintrittskarte = 20,
    ArmorUltra = 21,
    ChocoboEi = 22,
    Insektengift = 23,
    Jadereif = 24,
    Jaguarring = 25,
    Mythenschaerpe = 26,
    Moxastab = 27,
    Orakelknochen = 28,
    Rubinherz = 29,
    Schleifstab = 30,
    Lebenszepter = 31,
    Sonnenstein = 32,
    Teufelskutte = 33,
    Drachenmuenze = 34,
    Diamantenauge = 35,
    Diamantenaugen = 36,
    Energie = 37,
    Ventil = 38,
    Koenigsschluessel = 39,
    Wagenrad = 40,
}

impl TradeGood {
    pub fn german_name(&self) -> &'static str {
        match self {
            Self::Dekuchen => "Dekuchen",
            Self::Fluegel => "Flügel",
            Self::Elixier => "Elixier",
            Self::Elfenstaub => "Elfenstaub",
            Self::Zauberperle => "Zauberperle",
            Self::Beutel => "Beutel",
            Self::Muelleimer => "Mülleimer",
            Self::Schappschapp => "Schappschapp",
            Self::AmulettDesKaron => "Amulett des Karon",
            Self::Perle => "Perle",
            Self::Keramiktopf => "Keramiktopf",
            Self::Huhn => "Huhn",
            Self::Schakalfigur => "Schakalfigur",
            Self::Juwelenskarabaeus => "Juwelenskarabäus",
            Self::Kalksteintafel => "Kalksteintafel",
            Self::Rosenwasser => "Rosenwasser",
            Self::Reis => "Reis",
            Self::Gewuerz => "Gewürz",
            Self::Silberloeffel => "Silberlöffel",
            Self::Seide => "Seide",
            Self::Eintrittskarte => "Eintrittskarte",
            Self::ArmorUltra => "Armor Ultra",
            Self::ChocoboEi => "Chocobo Ei",
            Self::Insektengift => "Insektengift",
            Self::Jadereif => "Jadereif",
            Self::Jaguarring => "Jaguarring",
            Self::Mythenschaerpe => "Mythenschärpe",
            Self::Moxastab => "Moxastab",
            Self::Orakelknochen => "Orakelknochen",
            Self::Rubinherz => "Rubinherz",
            Self::Schleifstab => "Schleifstab",
            Self::Lebenszepter => "Lebenszepter",
            Self::Sonnenstein => "Sonnenstein",
            Self::Teufelskutte => "Teufelskutte",
            Self::Drachenmuenze => "Drachenmünze",
            Self::Diamantenauge => "Diamantenauge",
            Self::Diamantenaugen => "Diamantenaugen",
            Self::Energie => "Energie",
            Self::Ventil => "Ventil",
            Self::Koenigsschluessel => "Königsschlüssel",
            Self::Wagenrad => "Wagenrad",
        }
    }

    pub fn from_id(id: u8) -> Option<Self> {
        if id <= 40 {
            // Safety: Enum is repr 0..=40
            Some(unsafe { std::mem::transmute(id) })
        } else {
            None
        }
    }
}
