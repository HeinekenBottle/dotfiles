# WezTerm Background Backdrops (Optional)

This directory is for optional background images for WezTerm themes.

**Currently**: All themes have `backdrop = nil` (no background images are used).

## How to Add Backdrops

If you want to add background images to your themes:

1. **Place your wallpaper images in this directory**
   - Supported formats: PNG, JPG, JPEG
   - Recommended resolution: 1920x1080 or higher

2. **Edit `wezterm.lua` to reference the image**
   - Find the theme in the `themes` table (lines 55-126)
   - Change `backdrop = nil` to `backdrop = "backdrops/your-image.png"`

   Example:
   ```lua
   {
       name = "Root Loops",
       colors = { ... },
       backdrop = "backdrops/abstract-pattern.png",  -- Add this line
   },
   ```

3. **Restart WezTerm**
   - The backdrop will appear with 30% brightness (darkened for text readability)
   - Opacity adjusts with `Ctrl+Shift+Up/Down` hotkeys

## Image Suggestions

Good backdrop choices:
- **Abstract patterns**: Geometric shapes, gradients, tech grids
- **Nature scenes**: Mountains, forests, oceans (with low saturation)
- **Minimalist**: Simple textures, subtle patterns
- **Dark themes**: Work best when images are naturally dark or will be darkened

## Technical Details

- Images are automatically scaled to fit terminal window
- Brightness is set to 30% in config (editable in `wezterm.lua` line 291)
- If an image file is missing, WezTerm will skip the backdrop (no errors)
- Backdrops inherit global opacity adjustments from hotkeys

## Current Status

**No backdrops are currently configured**. Both themes (Root Loops, Arctic Frost) have `backdrop = nil` as specified in the original requirements. This directory exists for future customization if you choose to add background images.
