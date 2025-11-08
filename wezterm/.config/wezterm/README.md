# WezTerm Configuration

A comprehensive, minimalistic terminal configuration with dynamic theme cycling, opacity control, font color schemes, and NeoVim integration.

## Features

### 🎨 Theme Cycling
- **5 full terminal themes** with complete color schemes:
  - **Root Loops**: Earthy, cohesive design with balanced colors (Catppuccin-inspired)
  - **Arctic Frost**: Cool blues and whites for a crisp, clean look
  - **Android AI**: Modern tech-inspired greens and grays
  - **Coolnight Classic**: Your original beloved color scheme
  - **Sunset Vibrant**: Warm oranges and corals for a cozy feel
- **Hotkey**: `Ctrl+Shift+T` to cycle through themes
- Themes persist across sessions

### 🔤 Independent Font Color Schemes
- **4 font overlays** that can be applied to any theme:
  - **Default (Theme Native)**: Uses the theme's original colors
  - **Arctic Frost Font**: Cool text tones for readability
  - **Chroma Contrast Font**: High-contrast pure colors for maximum visibility
  - **Android AI Font**: Subtle tech greens and grays
- **Hotkey**: `Ctrl+Shift+C` to cycle font schemes
- Overlays only affect text colors, not backgrounds

### 🌅 Background Backdrops
- Optional background images synced with themes
- Images are automatically darkened (30% brightness) for text readability
- Inherits global opacity adjustments
- See `backdrops/README.md` for setup instructions

### 🔆 Opacity Control
- **Hotkeys**:
  - `Ctrl+Shift+Up`: Increase opacity by 5% (up to 100%)
  - `Ctrl+Shift+Down`: Decrease opacity by 5% (down to 50%)
- Only affects background transparency (text remains opaque)
- Settings persist across sessions

### 🔗 NeoVim Integration
- **Hotkey**: `Ctrl+Shift+N` to export current colors to NeoVim
- Writes palette to `~/.cache/wezterm/current_font_palette.json`
- Integrates with your existing NeoVim `font_sync.lua` module
- Syncs foreground, cursor, and ANSI colors automatically

## Hotkey Reference

| Hotkey | Action |
|--------|--------|
| `Ctrl+Shift+T` | Cycle to next theme |
| `Ctrl+Shift+C` | Cycle to next font color scheme |
| `Ctrl+Shift+Up` | Increase background opacity |
| `Ctrl+Shift+Down` | Decrease background opacity |
| `Ctrl+Shift+N` | Export colors to NeoVim |
| `Shift+Enter` | Send explicit newline |
| `Cmd+V` | Paste from clipboard |

## State Persistence

Configuration state is stored in `~/.cache/wezterm/`:
- `current_theme_index` - Active theme (1-5)
- `current_font_index` - Active font scheme (1-4)
- `current_opacity` - Background opacity (0.5-1.0)
- `current_font_palette.json` - NeoVim color sync file

## Customization

### Adding a New Theme

Edit `wezterm.lua` and add to the `themes` table:

```lua
{
    name = "Your Theme Name",
    colors = {
        foreground = "#ffffff",
        background = "#000000",
        cursor_bg = "#00ff00",
        cursor_fg = "#000000",
        cursor_border = "#00ff00",
        selection_bg = "#333333",
        selection_fg = "#ffffff",
        ansi = {
            "#000000", "#ff0000", "#00ff00", "#ffff00",
            "#0000ff", "#ff00ff", "#00ffff", "#ffffff"
        },
        brights = {
            "#808080", "#ff8080", "#80ff80", "#ffff80",
            "#8080ff", "#ff80ff", "#80ffff", "#ffffff"
        },
    },
    backdrop = "backdrops/your-image.png", -- or nil
},
```

### Adding a Font Scheme

Edit `wezterm.lua` and add to the `font_schemes` table:

```lua
{
    name = "Your Font Scheme",
    overrides = {
        foreground = "#ffffff",
        cursor_fg = "#000000",
        selection_fg = "#ffffff",
        ansi = {
            "#000000", -- Override black
            nil,       -- Keep theme's red
            -- ... etc
        },
    },
},
```

Use `nil` in the `ansi` array to preserve the base theme's color for that slot.

## Implementation Details

- **Single file config**: Everything is in `wezterm.lua` for simplicity
- **No external dependencies**: Pure Lua with WezTerm APIs only
- **Robust error handling**: Indices are clamped, files are checked before reading
- **Minimal performance impact**: State reads are cached, cycling is instant
- **Graceful degradation**: Missing backdrop images are silently ignored

## Integration with Dotfiles

This config is designed to work with GNU Stow:
```bash
cd ~/dotfiles
stow wezterm
```

The config will be symlinked to `~/.config/wezterm/wezterm.lua`.

## Troubleshooting

### Themes not changing
- Check `~/.cache/wezterm/` permissions
- Verify state files are writable
- Reload WezTerm with `Ctrl+Shift+R` (if you add this binding)

### Backdrops not showing
- Ensure image files exist in `backdrops/` directory
- Check file paths are relative to config directory
- Verify image format is PNG/JPG

### NeoVim sync not working
- Confirm `~/.cache/wezterm/current_font_palette.json` exists
- Check NeoVim's `font_sync.lua` is loading the palette
- Reload NeoVim after pressing `Ctrl+Shift+N`

## Resources

- [WezTerm Documentation](https://wezfurlong.org/wezterm/)
- [WezTerm Color Schemes](https://wezfurlong.org/wezterm/colorschemes/)
- [Lua Quick Reference](https://www.lua.org/manual/5.4/)
