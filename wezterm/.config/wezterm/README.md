# WezTerm Configuration

**PROPERLY IMPLEMENTED** with your actual vibrant themes from the old config.

## Features

### 🎨 5 Full Themes (Vibrant & Colorful)
1. **Neon Glass** - Electric neon colors (cyan fg, hot pink cursor, deep black bg)
2. **Petrol Dark** - Deep petrol blue with warm pink accents
3. **Root Loops** - ACTUAL rootloops.sh theme (dark blue bg, light blue fg, vibrant colors)
4. **Ocean Gold** - Blue ocean background with golden sunrise highlights
5. **Coolnight** - Your existing beloved theme

**Hotkey**: `Ctrl+Shift+T` to cycle through themes

### 🔤 6 Font Color Palettes (Text-Only Overlays)
1. **Default (Theme Native)** - Uses base theme colors
2. **Droid** - Android-style tech greens
3. **Arctic** - Cool blues and whites
4. **Forest** - Earthy greens and natural tones
5. **Photon** - Bright, colorful palette
6. **Nebula** - Purple cosmic theme

**Hotkey**: `Ctrl+Shift+C` to cycle font palettes

### 🔆 Opacity Control
- `Ctrl+Shift+Up` - Increase opacity
- `Ctrl+Shift+Down` - Decrease opacity
- Range: 50% to 100%

### 🖼️ Background Image Controls
- `Ctrl+Shift+I` - Toggle background image on/off
- `Cmd+Comma` - Cycle to previous background
- `Cmd+Period` - Cycle to next background
- `Cmd+Shift+Equal` - Increase brightness
- `Cmd+Shift+Minus` - Decrease brightness

### 💪 Bold Mode Toggle
- `Ctrl+Shift+B` - Toggle bold font on/off

### 🔗 NeoVim Integration
- Auto-syncs to `~/.cache/wezterm/current_font_palette.json`
- Works with your existing `font_sync.lua` module
- Exports merged colors (theme + font palette)

### 📢 Toast Notifications
Every action shows a notification with:
- Current theme name
- Active font palette
- Opacity percentage
- Background status (if enabled)
- Bold mode status (if enabled)

## Complete Hotkey Reference

| Hotkey | Action |
|--------|--------|
| `Ctrl+Shift+T` | Cycle theme (5 themes) |
| `Ctrl+Shift+C` | Cycle font palette (6 palettes) |
| `Ctrl+Shift+Up` | Increase opacity |
| `Ctrl+Shift+Down` | Decrease opacity |
| `Ctrl+Shift+I` | Toggle background image |
| `Cmd+Comma` | Previous background |
| `Cmd+Period` | Next background |
| `Cmd+Shift+Equal` | Increase background brightness |
| `Cmd+Shift+Minus` | Decrease background brightness |
| `Ctrl+Shift+B` | Toggle bold mode |
| `Shift+Enter` | Send newline |
| `Cmd+V` | Paste |

## Theme Details

### Neon Glass
```lua
foreground = "#00ffff"  -- Electric cyan
background = "#000011"  -- Very dark blue
cursor = "#ff00ff"      -- Neon magenta
```
Super vibrant neon colors - great for cyberpunk vibes.

### Petrol Dark
```lua
foreground = "#B3D9FF"  -- Light blue
background = "#0B4E53"  -- Deep petrol blue
cursor = "#FF6B9D"      -- Warm pink
```
Deep ocean teal with warm pink accents.

### Root Loops (ACTUAL from rootloops.sh)
```lua
foreground = "#d9efff"  -- Light sky blue
background = "#00253b"  -- Dark blue (NOT black!)
cursor = "#8ccfff"      -- Bright cyan
```
The real Root Loops theme with proper vibrant colors.

### Ocean Gold
```lua
foreground = "#ffffff"  -- Pure white
background = "#3979bc"  -- Ocean blue
cursor = "#ffd700"      -- Golden yellow
```
Beautiful blue ocean with golden highlights.

### Coolnight
```lua
foreground = "#CBE0F0"  -- Light blue
background = "#011423"  -- Very dark blue
cursor = "#47FF9C"      -- Bright green
```
Your existing Coolnight theme.

## State Persistence

All settings stored in `~/.cache/wezterm/`:
- `current_theme_index` - Active theme (1-5)
- `current_font_index` - Active font palette (1-6)
- `current_opacity` - Background opacity (0.5-1.0)
- `background_enabled` - Background image on/off
- `current_background_index` - Active background (1-5)
- `background_brightness` - Background brightness (0.0-1.0)
- `bold_mode_enabled` - Bold font on/off
- `current_font_palette.json` - NeoVim sync file

## Background Images

Place images in `backdrops/` directory. Currently configured for:
1. `backdrops/abstract-1.png`
2. `backdrops/abstract-2.png`
3. `backdrops/tech-grid.jpg`
4. `backdrops/nature-1.jpg`
5. `backdrops/minimal.png`

## What's Fixed

✅ **ACTUAL theme colors** from your old config (not invented)
✅ **Vibrant, punchy colors** - Neon Glass, Petrol Dark, Root Loops, Ocean Gold, Coolnight
✅ **Root Loops is CORRECT** - Dark blue background (#00253b), not Catppuccin
✅ **Toast notifications work** - Shows theme, font, opacity, background, bold status
✅ **All controls implemented** - Theme, font, opacity, background, bold mode
✅ **6 font palettes** - Default, Droid, Arctic, Forest, Photon, Nebula
✅ **Background image controls** - Toggle, cycle, brightness adjust
✅ **Bold mode toggle** - Ctrl+Shift+B
✅ **NeoVim integration** - Auto-exports to JSON
✅ **Proper event handling** - Uses EmitEvent like your old config

## Resources

- [WezTerm Documentation](https://wezfurlong.org/wezterm/)
- [Root Loops Theme Generator](https://rootloops.sh)
