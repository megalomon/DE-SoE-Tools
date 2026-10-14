// crates/soe-tiles/src/export.rs
use image::{ImageBuffer, Rgba};
use soe_core::gfx::Palette;
use std::path::Path;

pub fn export_tile_to_png<P: AsRef<Path>>(
    pixels: &[u8],
    width: u32,
    height: u32,
    palette: &Palette,
    path: P,
) -> Result<(), Box<dyn std::error::Error>> {
    let mut img = ImageBuffer::<Rgba<u8>, _>::new(width, height);

    for y in 0..height {
        for x in 0..width {
            let idx = (y * width + x) as usize;
            let color_idx = if idx < pixels.len() { pixels[idx] as usize } else { 0 };
            let c = palette.colors[color_idx & 0x0F];
            img.put_pixel(x, y, Rgba([c.r, c.g, c.b, c.a]));
        }
    }

    img.save(path)?;
    Ok(())
}

pub fn export_sheet_to_png<P: AsRef<Path>>(
    tiles: &[Vec<u8>],
    tile_size: u32,
    columns: u32,
    palette: &Palette,
    path: P,
) -> Result<(), Box<dyn std::error::Error>> {
    if tiles.is_empty() || columns == 0 {
        return Ok(());
    }

    let rows = (tiles.len() as u32 + columns - 1) / columns;
    let img_width = columns * tile_size;
    let img_height = rows * tile_size;
    let mut img = ImageBuffer::<Rgba<u8>, _>::new(img_width, img_height);

    for (t_idx, tile) in tiles.iter().enumerate() {
        let col = (t_idx as u32) % columns;
        let row = (t_idx as u32) / columns;
        let start_x = col * tile_size;
        let start_y = row * tile_size;

        for y in 0..tile_size {
            for x in 0..tile_size {
                let p_idx = (y * tile_size + x) as usize;
                let color_idx = if p_idx < tile.len() { tile[p_idx] as usize } else { 0 };
                let c = palette.colors[color_idx & 0x0F];
                img.put_pixel(start_x + x, start_y + y, Rgba([c.r, c.g, c.b, c.a]));
            }
        }
    }

    img.save(path)?;
    Ok(())
}
