# WezTerm Background Backdrops

This directory contains optional background images for WezTerm themes.

## Required Images

The following images are referenced by themes in `wezterm.lua`:

1. **arctic-blue.png** - Cool blue/white abstract wallpaper (Arctic Frost theme)
2. **tech-grid.jpg** - Modern tech-inspired grid pattern (Android AI theme)
3. **sunset-abstract.png** - Warm sunset/vibrant abstract (Sunset Vibrant theme)

## Adding Your Own Images

1. Place your wallpaper images in this directory
2. Supported formats: PNG, JPG, JPEG
3. Recommended resolution: 1920x1080 or higher
4. Images will be automatically scaled to fit your terminal window

## Customization

To change which backdrop a theme uses:
- Edit `wezterm.lua`
- Find the theme in the `themes` table
- Update the `backdrop` field to your image filename:
  ```lua
  backdrop = "backdrops/your-image.png"
  ```
- Set to `nil` to disable backdrop for that theme

## Image Suggestions

- **Abstract patterns**: Geometric shapes, gradients, tech grids
- **Nature scenes**: Mountains, forests, oceans (with low saturation)
- **Minimalist**: Simple textures, subtle patterns
- **Dark themes**: Images work best when darkened (brightness is set to 0.3 in config)

## Notes

- Backdrops are darkened to 30% brightness to keep text readable
- Opacity can be adjusted with `Ctrl+Shift+Up/Down` hotkeys
- If an image file is missing, WezTerm will simply skip the backdrop (no errors)
