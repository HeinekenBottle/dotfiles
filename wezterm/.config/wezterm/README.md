# WezTerm Configuration (Corrected)

A minimalistic terminal configuration with strict separation between full themes and font color schemes. Uses exact color specifications without modifications.

## Features

### 🎨 Theme Cycling (2 Full Themes)
- **Root Loops**: Earthy, circuit-inspired design (Catppuccin-based)
- **Arctic Frost**: Cool blues and whites for a crisp, clean look
- **Hotkey**: `Ctrl+Shift+T` to cycle between the 2 full themes
- Themes persist across sessions
- Background opacity adjustable independently (see below)

### 🔤 Font Color Schemes (4 Text-Only Overlays)
Independent overlays that modify ONLY text colors (foreground, cursor_fg, selection_fg, specific ANSI text indices):
- **Default (Theme Native)**: Uses the base theme's original text colors
- **Arctic Frost Font**: Cool text tones (separate from full Arctic Frost theme)
- **Chroma Contrast Font**: High-contrast pure colors for maximum visibility
- **Android AI Font**: Tech greens and grays for text

**Important**: Font schemes are NOT full themes—they overlay on top of any active theme without affecting backgrounds, cursor_bg, or complete ANSI palettes.

- **Hotkey**: `Ctrl+Shift+C` to cycle through font overlays

### 🔆 Opacity Control
- **Hotkeys**:
  - `Ctrl+Shift+Up`: Increase opacity by 5% (up to 100%)
  - `Ctrl+Shift+Down`: Decrease opacity by 5% (down to 50%)
- Only affects background transparency (text remains opaque)
- Settings persist across sessions

### 🔗 NeoVim Integration
- **Hotkey**: `Ctrl+Shift+N` to export current colors to NeoVim
- Writes merged colors (theme + font overlay) to `~/.cache/wezterm/current_font_palette.json`
- Integrates with existing NeoVim `font_sync.lua` module
- Syncs foreground, cursor, and ANSI colors automatically

### 🌅 Background Backdrops (Optional)
- Infrastructure exists for optional background images
- Currently all themes have `backdrop = nil` (no images)
- To add: Place images in `backdrops/` and set `backdrop = "backdrops/your-image.png"` in theme definition
- See `backdrops/README.md` for setup guide

## Hotkey Reference

| Hotkey | Action |
|--------|--------|
| `Ctrl+Shift+T` | Cycle to next theme (2 themes) |
| `Ctrl+Shift+C` | Cycle to next font color scheme (4 overlays) |
| `Ctrl+Shift+Up` | Increase background opacity |
| `Ctrl+Shift+Down` | Decrease background opacity |
| `Ctrl+Shift+N` | Export colors to NeoVim |
| `Shift+Enter` | Send explicit newline |
| `Cmd+V` | Paste from clipboard |

## Architecture

### Full Themes vs. Font Schemes

**Full Themes** (2 total):
- Complete, holistic color schemes for the entire terminal
- Include: background, foreground, cursor_bg, cursor_fg, cursor_border, selection_bg, selection_fg, ansi (8 colors), brights (8 colors)
- Stand alone without overlays
- Exact color values from original specifications (no modifications)

**Font Color Schemes** (4 total):
- Text-only overlays that apply on top of any full theme
- Modify ONLY: foreground, cursor_fg, selection_fg, specific ANSI text indices
- Do NOT affect: background, cursor_bg, cursor_border, selection_bg, or complete ANSI palettes
- Use `nil` in override arrays to preserve base theme colors

### Example: How It Works

1. Select "Root Loops" theme (Ctrl+Shift+T) → Sets complete terminal palette
2. Select "Chroma Contrast Font" (Ctrl+Shift+C) → Overlays high-contrast text colors
3. Result: Root Loops background + Chroma Contrast text = custom combination

## State Persistence

Configuration state stored in `~/.cache/wezterm/`:
- `current_theme_index` - Active theme (1-2)
- `current_font_index` - Active font scheme (1-4)
- `current_opacity` - Background opacity (0.5-1.0)
- `current_font_palette.json` - NeoVim color sync file

## Color Specifications

### Root Loops (Primary Full Theme)
Exact colors from original specification:
- Background: `#1e1e2e`
- Foreground: `#cdd6f4`
- Cursor: `#89b4fa` on `#1e1e2e`
- Selection: `#cdd6f4` on `#45475a`
- ANSI: 8 colors from black `#1e1e2e` to white `#cdd6f4`
- Brights: 8 colors from bright black `#45475a` to bright white `#f5e0dc`

### Arctic Frost (Secondary Full Theme)
Exact colors from original specification:
- Background: `#0f1419`
- Foreground: `#c7d0d5`
- Cursor: `#ffffff` on `#0f1419`
- Selection: `#c7d0d5` on `#264f78`
- ANSI: 8 colors from black `#0f1419` to white `#c7d0d5`
- Brights: 8 colors from bright black `#264f78` to bright white `#e0e8ef`

## Customization

### Adding a New Full Theme

Edit `wezterm.lua` and add to the `themes` table (lines 55-126):

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
    backdrop = nil,  -- or "backdrops/your-image.png"
},
```

### Adding a New Font Scheme

Edit `wezterm.lua` and add to the `font_schemes` table (lines 136-199):

```lua
{
    name = "Your Font Scheme",
    overrides = {
        foreground = "#ffffff",
        cursor_fg = "#000000",
        selection_fg = "#ffffff",
        ansi = {
            "#000000",  -- Override black
            nil,        -- Keep theme's red
            nil,        -- Keep theme's green
            -- ... etc (use nil to preserve base theme colors)
        },
    },
},
```

**Important**: Use `nil` in the `ansi` array to preserve the base theme's color for that slot. Only override text-related properties.

## Implementation Details

- **Single file config**: Everything in `wezterm.lua` for simplicity
- **No external dependencies**: Pure Lua with WezTerm APIs only
- **Robust error handling**: Indices clamped, graceful degradation
- **Minimal performance impact**: State cached, cycling is instant
- **Strict separation**: Full themes vs. font overlays clearly distinguished

## Integration with Dotfiles

This config works with GNU Stow:
```bash
cd ~/dotfiles
stow wezterm
```

The config will be symlinked to `~/.config/wezterm/wezterm.lua`.

## Troubleshooting

### Themes not changing
- Check `~/.cache/wezterm/` permissions
- Verify state files are writable
- Restart WezTerm

### Font overlays not applying
- Ensure you're cycling with `Ctrl+Shift+C` (not `Ctrl+Shift+T`)
- Check that the font scheme name appears in notification
- Try "Default (Theme Native)" to reset to base theme

### NeoVim sync not working
- Confirm `~/.cache/wezterm/current_font_palette.json` exists
- Check NeoVim's `font_sync.lua` is loading the palette
- Reload NeoVim after pressing `Ctrl+Shift+N`

## Key Corrections from Previous Version

This corrected version fixes several errors:
1. **Removed invented themes**: "Coolnight Classic" and "Sunset Vibrant" were NOT part of original setup
2. **No invented backdrops**: Both themes have `backdrop = nil` (no images unless explicitly added)
3. **Exact color values**: Root Loops and Arctic Frost use exact specifications without modifications
4. **Clear separation**: Font schemes are text-only overlays, NOT full themes
5. **Minimal theme count**: Only 2 full themes as specified (Root Loops, Arctic Frost)

## Resources

- [WezTerm Documentation](https://wezfurlong.org/wezterm/)
- [Lua Quick Reference](https://www.lua.org/manual/5.4/)
