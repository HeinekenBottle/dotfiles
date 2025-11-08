-- ============================================================================
-- WezTerm Configuration - PROPERLY IMPLEMENTED
-- Using ACTUAL themes from your old config with vibrant, punchy colors
-- ============================================================================

local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- ============================================================================
-- STATE MANAGEMENT
-- ============================================================================

local state_dir = wezterm.home_dir .. "/.cache/wezterm"
local theme_state_file = state_dir .. "/current_theme_index"
local font_state_file = state_dir .. "/current_font_index"
local opacity_state_file = state_dir .. "/current_opacity"
local background_enabled_file = state_dir .. "/background_enabled"
local background_index_file = state_dir .. "/current_background_index"
local background_brightness_file = state_dir .. "/background_brightness"
local bold_mode_file = state_dir .. "/bold_mode_enabled"
local nvim_palette_file = state_dir .. "/current_font_palette.json"

local function ensure_state_dir()
	os.execute('mkdir -p "' .. state_dir .. '"')
end

local function read_state(file, default)
	local f = io.open(file, "r")
	if not f then
		return default
	end
	local content = f:read("*all")
	f:close()
	local num = tonumber(content)
	return num or default
end

local function write_state(file, value)
	ensure_state_dir()
	local f = io.open(file, "w")
	if f then
		f:write(tostring(value))
		f:close()
	end
end

local function read_bool_state(file, default)
	local val = read_state(file, default and 1 or 0)
	return val == 1
end

local function write_bool_state(file, value)
	write_state(file, value and 1 or 0)
end

-- ============================================================================
-- FULL THEME DEFINITIONS - ACTUAL THEMES FROM YOUR OLD CONFIG
-- These are vibrant, colorful, punchy themes with proper contrast
-- ============================================================================

local themes = {
	{
		name = "Neon Glass",
		colors = {
			foreground = "#00ffff",
			background = "#000011",
			cursor_bg = "#ff00ff",
			cursor_fg = "#000000",
			cursor_border = "#ff00ff",
			selection_fg = "#000000",
			selection_bg = "#00ffff",
			ansi = {
				"#001122", -- black (very dark)
				"#ff0066", -- red (hot pink)
				"#00ff88", -- green (neon green)
				"#ffff00", -- yellow (electric yellow)
				"#0088ff", -- blue (electric blue)
				"#ff00ff", -- magenta (neon magenta)
				"#00ffff", -- cyan (electric cyan)
				"#ffffff", -- white (pure white)
			},
			brights = {
				"#444466", -- bright black (slate)
				"#ff3399", -- bright red (bright pink)
				"#33ff99", -- bright green (bright mint)
				"#ffff66", -- bright yellow (bright yellow)
				"#3399ff", -- bright blue (bright blue)
				"#ff33ff", -- bright magenta (bright magenta)
				"#33ffff", -- bright cyan (bright cyan)
				"#ffffff", -- bright white
			},
		},
	},
	{
		name = "Petrol Dark",
		colors = {
			foreground = "#B3D9FF",
			background = "#0B4E53",
			cursor_bg = "#FF6B9D",
			cursor_fg = "#0B4E53",
			cursor_border = "#FF6B9D",
			selection_fg = "#0B4E53",
			selection_bg = "#FF6B9D",
			ansi = {
				"#0a3a3f", -- black (deep petrol)
				"#ff6b9d", -- red (warm pink)
				"#5cb200", -- green
				"#cc8a00", -- yellow
				"#4699ff", -- blue
				"#d057ff", -- magenta
				"#00afaf", -- cyan
				"#B3D9FF", -- white (light blue)
			},
			brights = {
				"#1A2B4A", -- bright black (dark blue)
				"#ff828f", -- bright red (lighter pink)
				"#6aca00", -- bright green
				"#e79d00", -- bright yellow
				"#73b1ff", -- bright blue
				"#da84ff", -- bright magenta
				"#00c7c7", -- bright cyan
				"#ffffff", -- bright white
			},
		},
	},
	{
		name = "Root Loops",
		-- ACTUAL Root Loops from https://rootloops.sh
		colors = {
			foreground = "#d9efff",
			background = "#00253b",
			cursor_bg = "#8ccfff",
			cursor_border = "#eff8ff",
			cursor_fg = "#00253b",
			selection_bg = "#d9efff",
			selection_fg = "#00253b",
			ansi = {
				"#003e5f", -- black
				"#ff506e", -- red
				"#5cb200", -- green
				"#cc8a00", -- yellow
				"#4699ff", -- blue
				"#d057ff", -- magenta
				"#00afaf", -- cyan
				"#8ccfff", -- white
			},
			brights = {
				"#0072a8", -- bright black
				"#ff828f", -- bright red
				"#6aca00", -- bright green
				"#e79d00", -- bright yellow
				"#73b1ff", -- bright blue
				"#da84ff", -- bright magenta
				"#00c7c7", -- bright cyan
				"#eff8ff", -- bright white
			},
		},
	},
	{
		name = "Ocean Gold",
		colors = {
			foreground = "#ffffff",
			background = "#3979bc",
			cursor_bg = "#ffd700",
			cursor_fg = "#3979bc",
			cursor_border = "#ffd700",
			selection_fg = "#3979bc",
			selection_bg = "#ffd700",
			ansi = {
				"#1a1a1a", -- black
				"#ff6b47", -- red
				"#00ff7f", -- green
				"#ffd700", -- yellow
				"#87ceeb", -- blue
				"#dda0dd", -- magenta
				"#00ced1", -- cyan
				"#f0f0f0", -- white
			},
			brights = {
				"#555555", -- bright black
				"#ff4500", -- bright red
				"#32cd32", -- bright green
				"#ffff00", -- bright yellow
				"#add8e6", -- bright blue
				"#ff69b4", -- bright magenta
				"#40e0d0", -- bright cyan
				"#ffffff", -- bright white
			},
		},
	},
	{
		name = "Coolnight",
		colors = {
			foreground = "#CBE0F0",
			background = "#011423",
			cursor_bg = "#47FF9C",
			cursor_border = "#47FF9C",
			cursor_fg = "#011423",
			selection_bg = "#033259",
			selection_fg = "#CBE0F0",
			ansi = {
				"#214969",
				"#E52E2E",
				"#44FFB1",
				"#FFE073",
				"#0FC5ED",
				"#a277ff",
				"#24EAF7",
				"#24EAF7",
			},
			brights = {
				"#214969",
				"#E52E2E",
				"#44FFB1",
				"#FFE073",
				"#A277FF",
				"#a277ff",
				"#24EAF7",
				"#24EAF7",
			},
		},
	},
}

-- ============================================================================
-- FONT COLOR PALETTES - Text-only overlays
-- ============================================================================

local font_palettes = {
	{
		name = "Default (Theme Native)",
		overrides = {},
	},
	{
		name = "Droid",
		overrides = {
			foreground = "#e0e0e0",
			cursor_fg = "#121212",
			selection_fg = "#e0e0e0",
			ansi = {
				"#121212",
				nil,
				"#4caf50",
				nil,
				nil,
				nil,
				"#00bcd4",
				"#e0e0e0",
			},
		},
	},
	{
		name = "Arctic",
		overrides = {
			foreground = "#c7d0d5",
			cursor_fg = "#0f1419",
			selection_fg = "#c7d0d5",
			ansi = {
				nil,
				nil,
				nil,
				nil,
				nil,
				nil,
				nil,
				"#c7d0d5",
			},
		},
	},
	{
		name = "Forest",
		overrides = {
			foreground = "#a8cc8c",
			cursor_fg = "#1a1a1a",
			selection_fg = "#a8cc8c",
			ansi = {
				"#1a1a1a",
				"#e57373",
				"#81c784",
				"#ffb74d",
				"#64b5f6",
				"#ba68c8",
				"#4dd0e1",
				"#a8cc8c",
			},
		},
	},
	{
		name = "Photon",
		overrides = {
			foreground = "#f0f0f0",
			cursor_fg = "#000000",
			selection_fg = "#f0f0f0",
			ansi = {
				"#000000",
				"#ff6b6b",
				"#4ecdc4",
				"#ffe66d",
				"#5ca0ff",
				"#c77dff",
				"#4ecdc4",
				"#f0f0f0",
			},
		},
	},
	{
		name = "Nebula",
		overrides = {
			foreground = "#e0b0ff",
			cursor_fg = "#1a0033",
			selection_fg = "#e0b0ff",
			ansi = {
				"#1a0033",
				"#ff6ec7",
				"#39ff14",
				"#ffd700",
				"#00d4ff",
				"#bf00ff",
				"#00ffff",
				"#e0b0ff",
			},
		},
	},
}

-- ============================================================================
-- BACKGROUND IMAGES
-- ============================================================================

local backgrounds = {
	"backdrops/abstract-1.png",
	"backdrops/abstract-2.png",
	"backdrops/tech-grid.jpg",
	"backdrops/nature-1.jpg",
	"backdrops/minimal.png",
}

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

local function clamp(value, min, max)
	if value < min then
		return min
	end
	if value > max then
		return max
	end
	return value
end

local function apply_font_palette(base_colors, palette_overrides)
	local result = {}
	for k, v in pairs(base_colors) do
		if type(v) == "table" then
			result[k] = {}
			for i, val in ipairs(v) do
				result[k][i] = val
			end
		else
			result[k] = v
		end
	end

	for k, v in pairs(palette_overrides) do
		if k == "ansi" or k == "brights" then
			for i, color in ipairs(v) do
				if color ~= nil then
					result[k][i] = color
				end
			end
		elseif k == "foreground" or k == "cursor_fg" or k == "selection_fg" then
			result[k] = v
		end
	end
	return result
end

local function get_theme_index()
	return read_state(theme_state_file, 1)
end

local function get_font_index()
	return read_state(font_state_file, 1)
end

local function get_opacity()
	return read_state(opacity_state_file, 1.0)
end

local function get_background_enabled()
	return read_bool_state(background_enabled_file, false)
end

local function get_background_index()
	return read_state(background_index_file, 1)
end

local function get_background_brightness()
	return read_state(background_brightness_file, 0.3)
end

local function get_bold_mode()
	return read_bool_state(bold_mode_file, false)
end

local function export_to_nvim()
	local theme_idx = clamp(get_theme_index(), 1, #themes)
	local font_idx = clamp(get_font_index(), 1, #font_palettes)

	local theme = themes[theme_idx]
	local font_palette = font_palettes[font_idx]
	local final_colors = apply_font_palette(theme.colors, font_palette.overrides)

	local palette = {
		fg = final_colors.foreground,
		bold_fg = final_colors.foreground,
		cursor = final_colors.cursor_bg,
		ansi = final_colors.ansi,
		brights = final_colors.brights,
	}

	ensure_state_dir()
	local f = io.open(nvim_palette_file, "w")
	if f then
		local json_parts = { '{\n  "fg": "' .. palette.fg .. '"' }
		table.insert(json_parts, ',\n  "bold_fg": "' .. palette.bold_fg .. '"')
		table.insert(json_parts, ',\n  "cursor": "' .. palette.cursor .. '"')

		table.insert(json_parts, ',\n  "ansi": [')
		for i, color in ipairs(palette.ansi) do
			table.insert(json_parts, '"' .. color .. '"')
			if i < #palette.ansi then
				table.insert(json_parts, ", ")
			end
		end
		table.insert(json_parts, "]")

		table.insert(json_parts, ',\n  "brights": [')
		for i, color in ipairs(palette.brights) do
			table.insert(json_parts, '"' .. color .. '"')
			if i < #palette.brights then
				table.insert(json_parts, ", ")
			end
		end
		table.insert(json_parts, "]\n}")

		f:write(table.concat(json_parts))
		f:close()
		return true
	end
	return false
end

local function apply_config(window)
	local theme_idx = clamp(get_theme_index(), 1, #themes)
	local font_idx = clamp(get_font_index(), 1, #font_palettes)
	local opacity = get_opacity()
	local bg_enabled = get_background_enabled()
	local bg_idx = clamp(get_background_index(), 1, #backgrounds)
	local bg_brightness = get_background_brightness()
	local bold_mode = get_bold_mode()

	local theme = themes[theme_idx]
	local font_palette = font_palettes[font_idx]
	local final_colors = apply_font_palette(theme.colors, font_palette.overrides)

	local overrides = window:get_config_overrides() or {}
	overrides.colors = final_colors
	overrides.window_background_opacity = opacity

	if bg_enabled then
		local bg_path = wezterm.config_dir .. "/" .. backgrounds[bg_idx]
		overrides.window_background_image = bg_path
		overrides.window_background_image_hsb = {
			brightness = bg_brightness,
			hue = 1.0,
			saturation = 1.0,
		}
	else
		overrides.window_background_image = nil
	end

	if bold_mode then
		overrides.font = wezterm.font("MesloLGS Nerd Font Mono", { weight = "Bold" })
	else
		overrides.font = wezterm.font("MesloLGS Nerd Font Mono")
	end

	window:set_config_overrides(overrides)

	-- PROPER toast notification that actually shows up
	window:toast_notification(
		"WezTerm Theme",
		string.format(
			"🎨 Theme: %s\n🔤 Font: %s\n🔆 Opacity: %.0f%%\n%s%s",
			theme.name,
			font_palette.name,
			opacity * 100,
			bg_enabled and string.format("🖼️ Background: %d/%d (%.0f%% brightness)\n", bg_idx, #backgrounds, bg_brightness * 100) or "",
			bold_mode and "💪 Bold Mode: ON" or ""
		),
		nil,
		4000
	)

	export_to_nvim()
end

-- ============================================================================
-- EVENT HANDLERS
-- ============================================================================

wezterm.on("cycle-theme", function(window, _pane)
	local current = get_theme_index()
	local next = (current % #themes) + 1
	write_state(theme_state_file, next)
	apply_config(window)
end)

wezterm.on("toggle-font-colors", function(window, _pane)
	local current = get_font_index()
	local next = (current % #font_palettes) + 1
	write_state(font_state_file, next)
	apply_config(window)
end)

wezterm.on("opacity-up", function(window, _pane)
	local current = get_opacity()
	local new_opacity = clamp(current + 0.05, 0.5, 1.0)
	write_state(opacity_state_file, new_opacity)
	apply_config(window)
end)

wezterm.on("opacity-down", function(window, _pane)
	local current = get_opacity()
	local new_opacity = clamp(current - 0.05, 0.5, 1.0)
	write_state(opacity_state_file, new_opacity)
	apply_config(window)
end)

wezterm.on("toggle-background", function(window, _pane)
	local enabled = get_background_enabled()
	write_bool_state(background_enabled_file, not enabled)
	apply_config(window)
end)

wezterm.on("cycle-background-next", function(window, _pane)
	local current = get_background_index()
	local next = (current % #backgrounds) + 1
	write_state(background_index_file, next)
	write_bool_state(background_enabled_file, true)
	apply_config(window)
end)

wezterm.on("cycle-background-prev", function(window, _pane)
	local current = get_background_index()
	local prev = current - 1
	if prev < 1 then
		prev = #backgrounds
	end
	write_state(background_index_file, prev)
	write_bool_state(background_enabled_file, true)
	apply_config(window)
end)

wezterm.on("background-brightness-up", function(window, _pane)
	local current = get_background_brightness()
	local new_brightness = clamp(current + 0.05, 0.0, 1.0)
	write_state(background_brightness_file, new_brightness)
	apply_config(window)
end)

wezterm.on("background-brightness-down", function(window, _pane)
	local current = get_background_brightness()
	local new_brightness = clamp(current - 0.05, 0.0, 1.0)
	write_state(background_brightness_file, new_brightness)
	apply_config(window)
end)

wezterm.on("toggle-bold-mode", function(window, _pane)
	local enabled = get_bold_mode()
	write_bool_state(bold_mode_file, not enabled)
	apply_config(window)
end)

wezterm.on("window-config-reloaded", function(window, _pane)
	apply_config(window)
end)

-- ============================================================================
-- KEY BINDINGS
-- ============================================================================

config.keys = {
	-- Theme cycling
	{ key = "T", mods = "CTRL|SHIFT", action = act.EmitEvent("cycle-theme") },

	-- Font color palette cycling
	{ key = "C", mods = "CTRL|SHIFT", action = act.EmitEvent("toggle-font-colors") },

	-- Opacity adjustments
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = act.EmitEvent("opacity-up") },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = act.EmitEvent("opacity-down") },

	-- Background image controls
	{ key = "I", mods = "CTRL|SHIFT", action = act.EmitEvent("toggle-background") },
	{ key = "Comma", mods = "CMD", action = act.EmitEvent("cycle-background-prev") },
	{ key = "Period", mods = "CMD", action = act.EmitEvent("cycle-background-next") },
	{ key = "Equal", mods = "CMD|SHIFT", action = act.EmitEvent("background-brightness-up") },
	{ key = "Minus", mods = "CMD|SHIFT", action = act.EmitEvent("background-brightness-down") },

	-- Bold font toggle
	{ key = "B", mods = "CTRL|SHIFT", action = act.EmitEvent("toggle-bold-mode") },

	-- Existing keybindings
	{ key = "Enter", mods = "SHIFT", action = act.SendString("\n") },
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
}

-- ============================================================================
-- BASE CONFIGURATION
-- ============================================================================

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 14
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

-- Initial theme setup
local initial_theme_idx = clamp(get_theme_index(), 1, #themes)
local initial_font_idx = clamp(get_font_index(), 1, #font_palettes)
local initial_theme = themes[initial_theme_idx]
local initial_font = font_palettes[initial_font_idx]
config.colors = apply_font_palette(initial_theme.colors, initial_font.overrides)
config.window_background_opacity = get_opacity()

-- Initialize state directory and NeoVim sync
ensure_state_dir()
export_to_nvim()

return config
