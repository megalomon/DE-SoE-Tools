// crates/soe-tiles/tests/tiles_test.rs
use soe_core::gfx::{decode_4bpp_tile_16x16, decode_4bpp_tile_8x8, RgbaColor};
use soe_core::Rom;
use soe_tiles::palettes::{get_palette_by_name, DEFAULT_PALETTES};
use soe_tiles::TileLoader;

#[test]
fn test_bgr555_to_rgb888_scaling() {
    // Pure black: 0x0000
    let black = RgbaColor::from_snes_bgr555(0x0000, false);
    assert_eq!(black, RgbaColor { r: 0, g: 0, b: 0, a: 255 });

    // Pure white: 0x7FFF (r=31, g=31, b=31)
    let white = RgbaColor::from_snes_bgr555(0x7FFF, false);
    assert_eq!(white, RgbaColor { r: 255, g: 255, b: 255, a: 255 });

    // Transparent color
    let transparent = RgbaColor::from_snes_bgr555(0x7FFF, true);
    assert_eq!(transparent, RgbaColor::TRANSPARENT);

    // Pure red: 0x001F (r=31, g=0, b=0)
    let red = RgbaColor::from_snes_bgr555(0x001F, false);
    assert_eq!(red, RgbaColor { r: 255, g: 0, b: 0, a: 255 });

    // Pure green: 0x03E0 (r=0, g=31, b=0)
    let green = RgbaColor::from_snes_bgr555(0x03E0, false);
    assert_eq!(green, RgbaColor { r: 0, g: 255, b: 0, a: 255 });

    // Pure blue: 0x7C00 (r=0, g=0, b=31)
    let blue = RgbaColor::from_snes_bgr555(0x7C00, false);
    assert_eq!(blue, RgbaColor { r: 0, g: 0, b: 255, a: 255 });
}

#[test]
fn test_default_palettes() {
    assert_eq!(DEFAULT_PALETTES.len(), 5);

    let boy_pal = get_palette_by_name("Boy");
    assert_eq!(boy_pal.colors.len(), 16);
    // Index 0 should be transparent
    assert_eq!(boy_pal.colors[0], RgbaColor::TRANSPARENT);
    // Colors 1..16 should be opaque
    for i in 1..16 {
        assert_eq!(boy_pal.colors[i].a, 255);
    }
}

#[test]
fn test_decode_4bpp_planar() {
    // 32 bytes for 8x8 tile
    let mut planar8 = [0u8; 32];
    // Set first pixel of row 0: bit 7 of bp0, bp1, bp2, bp3
    planar8[0] = 0x80; // bp0
    planar8[1] = 0x80; // bp1
    planar8[16] = 0x80; // bp2
    planar8[17] = 0x80; // bp3
    let px8 = decode_4bpp_tile_8x8(&planar8);
    assert_eq!(px8[0], 15);
    assert_eq!(px8[1], 0);

    // 128 bytes for 16x16 tile
    let planar16 = [0u8; 128];
    let px16 = decode_4bpp_tile_16x16(&planar16);
    assert_eq!(px16.len(), 256);
}

#[test]
fn test_tile_loader_with_rom() {
    let rom_path = "/data/data/com.termux/files/home/dev/soeTAS/rom/Secret of Evermore (Germany).sfc";
    let rom = Rom::load(rom_path).expect("German ROM should load successfully");
    let loader = TileLoader::new(&rom);

    // 1. Test real 16x16 map tiles (0..5)
    for tile_idx in 0..5 {
        let pixels = loader.load_map_tile(tile_idx).unwrap_or_else(|e| {
            panic!("Failed to load map tile {}: {:?}", tile_idx, e);
        });
        assert_eq!(pixels.len(), 256, "16x16 tile must have 256 pixels");

        // Assert all pixel values are valid 4bpp indices (0..=15)
        for &px in &pixels {
            assert!(px <= 15, "Pixel value {} exceeds 4bpp limit 15 in tile {}", px, tile_idx);
        }
    }

    // 2. Test sprite blocks 16x16 (0..5)
    for sprite_idx in 0..5 {
        let pixels = loader.load_sprite_block(sprite_idx, true).unwrap_or_else(|e| {
            panic!("Failed to load 16x16 sprite block {}: {:?}", sprite_idx, e);
        });
        assert_eq!(pixels.len(), 256, "16x16 sprite block must have 256 pixels");

        for &px in &pixels {
            assert!(px <= 15, "Pixel value {} exceeds 15 in 16x16 sprite {}", px, sprite_idx);
        }
    }

    // 3. Test sprite blocks 8x8 (0..5)
    for sprite_idx in 0..5 {
        let pixels = loader.load_sprite_block(sprite_idx, false).unwrap_or_else(|e| {
            panic!("Failed to load 8x8 sprite block {}: {:?}", sprite_idx, e);
        });
        assert_eq!(pixels.len(), 64, "8x8 sprite block must have 64 pixels");

        for &px in &pixels {
            assert!(px <= 15, "Pixel value {} exceeds 15 in 8x8 sprite {}", px, sprite_idx);
        }
    }

    // 4. Test character stats (0..10)
    for char_idx in 0..10 {
        let stats = loader.load_character(char_idx).unwrap_or_else(|e| {
            panic!("Failed to load character stats {}: {:?}", char_idx, e);
        });
        assert_eq!(stats.id, char_idx);
        assert!(
            stats.snes_addr >= 0x800000 && stats.snes_addr <= 0xC00000,
            "Character {} snes_addr 0x{:06X} invalid",
            char_idx,
            stats.snes_addr
        );
        // Enemies and characters have non-zero HP
        assert!(stats.hp > 0, "Character {} has 0 HP", char_idx);
    }
}
