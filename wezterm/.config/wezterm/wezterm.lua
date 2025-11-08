-- ============================================================================
-- WezTerm Configuration (Corrected Version)
-- Minimalistic, robust setup with strict separation between full themes and
-- font color schemes. Uses EXACT color specifications without modification.
-- ============================================================================

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ============================================================================
-- STATE MANAGEMENT
-- Store current indices in cache directory for persistence across sessions
-- ============================================================================

local state_dir = wezterm.home_dir .. "/.cache/wezterm"
local theme_state_file = state_dir .. "/current_theme_index"
local font_state_file = state_dir .. "/current_font_index"
local opacity_state_file = state_dir .. "/current_opacity"
local nvim_palette_file = state_dir .. "/current_font_palette.json"

-- Ensure cache directory exists
local function ensure_state_dir()
	local success, _, _ = os.execute('mkdir -p "' .. state_dir .. '"')
	return success
end

-- Read state from file, return default if file doesn't exist or is invalid
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

-- Write state to file
local function write_state(file, value)
	ensure_state_dir()
	local f = io.open(file, "w")
	if f then
		f:write(tostring(value))
		f:close()
	end
end

-- ============================================================================
-- FULL THEME DEFINITIONS
-- Complete terminal themes ONLY - these are holistic color schemes for the
-- entire terminal. Using exact color values as specified - no modifications.
-- ============================================================================

local themes = {
	{
		name = "Root Loops",
		-- Primary full theme; earthy/circuit-inspired
		-- Using exact colors as provided - no changes allowed
		colors = {
			foreground = "#cdd6f4",
			background = "#1e1e2e",
			cursor_bg = "#89b4fa",
			cursor_fg = "#1e1e2e",
			cursor_border = "#89b4fa",
			selection_bg = "#45475a",
			selection_fg = "#cdd6f4",
			ansi = {
				"#1e1e2e", -- black
				"#f38ba8", -- red
				"#a6e3a1", -- green
				"#f9e2af", -- yellow
				"#89b4fa", -- blue
				"#cba6f7", -- magenta
				"#94e2d5", -- cyan
				"#cdd6f4", -- white
			},
			brights = {
				"#45475a", -- bright black
				"#f38ba8", -- bright red
				"#a6e3a1", -- bright green
				"#f9e2af", -- bright yellow
				"#89b4fa", -- bright blue
				"#cba6f7", -- bright magenta
				"#94e2d5", -- bright cyan
				"#f5e0dc", -- bright white
			},
		},
		backdrop = nil, -- No backdrop; do not add one
	},
	{
		name = "Arctic Frost",
		-- Full theme with cool blues/whites
		-- Using exact colors as provided - no changes allowed
		colors = {
			foreground = "#c7d0d5",
			background = "#0f1419",
			cursor_bg = "#ffffff",
			cursor_fg = "#0f1419",
			cursor_border = "#ffffff",
			selection_bg = "#264f78",
			selection_fg = "#c7d0d5",
			ansi = {
				"#0f1419", -- black
				"#ee5396", -- red
				"#33c692", -- green
				"#f47c3c", -- yellow
				"#3c4c72", -- blue
				"#c53f4d", -- magenta
				"#52e3b7", -- cyan
				"#c7d0d5", -- white
			},
			brights = {
				"#264f78", -- bright black
				"#ee5396", -- bright red
				"#33c692", -- bright green
				"#f47c3c", -- bright yellow
				"#5a7aa0", -- bright blue
				"#c53f4d", -- bright magenta
				"#52e3b7", -- bright cyan
				"#e0e8ef", -- bright white
			},
		},
		backdrop = nil, -- No backdrop; do not add one
	},
}

-- ============================================================================
-- FONT COLOR SCHEME DEFINITIONS
-- Text-only overlays that apply on top of any full theme. These adjust ONLY
-- text-related colors (foreground, cursor_fg, selection_fg, specific ANSI text
-- indices). They do NOT affect background, cursor_bg, or full ANSI palettes.
-- These are NOT full themes - they are overlays.
-- ============================================================================

local font_schemes = {
	{
		name = "Default (Theme Native)",
		-- No overrides - uses the base theme's text colors as-is
		overrides = {},
	},
	{
		name = "Arctic Frost Font",
		-- Text-only overlay for cool tones (separate from full Arctic Frost theme)
		overrides = {
			foreground = "#c7d0d5",
			cursor_fg = "#0f1419",
			selection_fg = "#c7d0d5",
			ansi = {
				nil, -- Keep theme's black
				nil, -- Keep theme's red
				nil, -- Keep theme's green
				nil, -- Keep theme's yellow
				nil, -- Keep theme's blue
				nil, -- Keep theme's magenta
				nil, -- Keep theme's cyan
				"#c7d0d5", -- Override only white for text
			},
		},
	},
	{
		name = "Chroma Contrast Font",
		-- High-contrast text only; NOT a full theme
		overrides = {
			foreground = "#ffffff",
			cursor_fg = "#000000",
			selection_fg = "#000000",
			ansi = {
				"#000000", -- black text
				"#ff0000", -- red text
				"#00ff00", -- green text
				"#ffff00", -- yellow text
				"#0000ff", -- blue text
				"#ff00ff", -- magenta text
				"#00ffff", -- cyan text
				"#ffffff", -- white text
			},
		},
	},
	{
		name = "Android AI Font",
		-- Tech greens for text only; NOT a full theme
		overrides = {
			foreground = "#e0e0e0",
			cursor_fg = "#121212",
			selection_fg = "#e0e0e0",
			ansi = {
				"#121212", -- black
				nil, -- Keep theme's red
				"#4caf50", -- green text
				nil, -- Keep theme's yellow
				nil, -- Keep theme's blue
				nil, -- Keep theme's magenta
				"#00bcd4", -- cyan text
				"#e0e0e0", -- white
			},
		},
	},
}

-- ============================================================================
-- HELPER FUNCTIONS
-- Core logic for theme application, opacity control, and cycling
-- ============================================================================

-- Apply font scheme overrides to base theme colors
-- Merges text-only overrides onto the full theme without affecting backgrounds
local function apply_font_scheme(base_colors, scheme_overrides)
	local result = {}
	-- Deep copy all base colors first
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
	-- Apply overrides (text-only: foreground, cursor_fg, selection_fg, ansi text)
	for k, v in pairs(scheme_overrides) do
		if k == "ansi" or k == "brights" then
			-- For ANSI arrays, only override non-nil values
			for i, color in ipairs(v) do
				if color ~= nil then
					result[k][i] = color
				end
			end
		elseif k == "foreground" or k == "cursor_fg" or k == "selection_fg" then
			-- Text-related colors only
			result[k] = v
		end
		-- Ignore any background, cursor_bg, or other non-text overrides
	end
	return result
end

-- Clamp a value between min and max
local function clamp(value, min, max)
	if value < min then
		return min
	end
	if value > max then
		return max
	end
	return value
end

-- Get current theme index (1-based)
local function get_theme_index()
	return read_state(theme_state_file, 1)
end

-- Get current font scheme index (1-based)
local function get_font_index()
	return read_state(font_state_file, 1)
end

-- Get current opacity (0.5 to 1.0)
local function get_opacity()
	return read_state(opacity_state_file, 1.0)
end

-- Apply theme and font scheme to window
local function apply_current_theme(window)
	local theme_idx = get_theme_index()
	local font_idx = get_font_index()
	local opacity = get_opacity()

	-- Validate and clamp indices
	theme_idx = clamp(theme_idx, 1, #themes)
	font_idx = clamp(font_idx, 1, #font_schemes)

	local theme = themes[theme_idx]
	local font_scheme = font_schemes[font_idx]

	-- Apply font scheme overlay on top of base theme
	local final_colors = apply_font_scheme(theme.colors, font_scheme.overrides)

	-- Set window overrides
	local overrides = window:get_config_overrides() or {}
	overrides.colors = final_colors
	overrides.window_background_opacity = opacity

	-- Apply backdrop if theme has one (currently all are nil)
	if theme.backdrop then
		local backdrop_path = wezterm.config_dir .. "/" .. theme.backdrop
		overrides.window_background_image = backdrop_path
		overrides.window_background_image_hsb = {
			brightness = 0.3, -- Darken backdrop to keep text readable
			hue = 1.0,
			saturation = 1.0,
		}
	else
		overrides.window_background_image = nil
	end

	window:set_config_overrides(overrides)

	-- Show notification
	window:toast_notification(
		"WezTerm",
		string.format("Theme: %s | Font: %s | Opacity: %.2f", theme.name, font_scheme.name, opacity),
		nil,
		2000
	)
end

-- Export current colors to NeoVim palette file (JSON format)
-- Captures final merged colors (theme + font overrides) for NeoVim sync
local function export_to_nvim()
	local theme_idx = get_theme_index()
	local font_idx = get_font_index()

	theme_idx = clamp(theme_idx, 1, #themes)
	font_idx = clamp(font_idx, 1, #font_schemes)

	local theme = themes[theme_idx]
	local font_scheme = font_schemes[font_idx]
	local final_colors = apply_font_scheme(theme.colors, font_scheme.overrides)

	-- Build JSON palette matching NeoVim's expected format
	local palette = {
		fg = final_colors.foreground,
		bold_fg = final_colors.foreground,
		cursor = final_colors.cursor_bg,
		ansi = final_colors.ansi,
		brights = final_colors.brights,
	}

	-- Write JSON (simple encoding without external dependencies)
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

-- ============================================================================
-- EVENT HANDLERS
-- Apply theme dynamically on window configuration reload
-- ============================================================================

wezterm.on("window-config-reloaded", function(window, _pane)
	apply_current_theme(window)
end)

-- ============================================================================
-- KEY BINDINGS
-- Hotkeys for theme cycling, opacity control, font schemes, and NeoVim sync
-- ============================================================================

config.keys = {
	-- ========== Theme Cycling: Ctrl+Shift+T ==========
	-- Cycles through the 2 full themes (Root Loops, Arctic Frost)
	{
		key = "T",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, _pane)
			local current = get_theme_index()
			local next = (current % #themes) + 1
			write_state(theme_state_file, next)
			apply_current_theme(window)
		end),
	},

	-- ========== Font Scheme Cycling: Ctrl+Shift+C ==========
	-- Cycles through 4 font overlays (Default, Arctic Frost Font, Chroma Contrast, Android AI)
	{
		key = "C",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, _pane)
			local current = get_font_index()
			local next = (current % #font_schemes) + 1
			write_state(font_state_file, next)
			apply_current_theme(window)
		end),
	},

	-- ========== Opacity Increase: Ctrl+Shift+Up ==========
	-- Increases background opacity by 0.05 (up to 1.0)
	{
		key = "UpArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, _pane)
			local current = get_opacity()
			local new_opacity = clamp(current + 0.05, 0.5, 1.0)
			write_state(opacity_state_file, new_opacity)
			apply_current_theme(window)
		end),
	},

	-- ========== Opacity Decrease: Ctrl+Shift+Down ==========
	-- Decreases background opacity by 0.05 (down to 0.5)
	{
		key = "DownArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, _pane)
			local current = get_opacity()
			local new_opacity = clamp(current - 0.05, 0.5, 1.0)
			write_state(opacity_state_file, new_opacity)
			apply_current_theme(window)
		end),
	},

	-- ========== NeoVim Sync: Ctrl+Shift+N ==========
	-- Exports current colors (theme + font overlays) to NeoVim palette JSON
	{
		key = "N",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, _pane)
			local success = export_to_nvim()
			if success then
				window:toast_notification(
					"WezTerm → NeoVim",
					"Palette exported to " .. nvim_palette_file .. "\nReload NeoVim to apply changes",
					nil,
					3000
				)
			else
				window:toast_notification("WezTerm → NeoVim", "Failed to export palette", nil, 2000)
			end
		end),
	},

	-- ========== Existing Keybindings ==========
	{ key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\n") },
	{ key = "v", mods = "CMD", action = wezterm.action.PasteFrom("Clipboard") },
}

-- ============================================================================
-- BASE CONFIGURATION
-- Core WezTerm settings (font, tabs, decorations, etc.)
-- ============================================================================

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 14

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

-- Initial theme application (will be overridden by window-config-reloaded)
local initial_theme_idx = get_theme_index()
local initial_font_idx = get_font_index()
local initial_opacity = get_opacity()

initial_theme_idx = clamp(initial_theme_idx, 1, #themes)
initial_font_idx = clamp(initial_font_idx, 1, #font_schemes)

local initial_theme = themes[initial_theme_idx]
local initial_font = font_schemes[initial_font_idx]
config.colors = apply_font_scheme(initial_theme.colors, initial_font.overrides)
config.window_background_opacity = initial_opacity

-- Apply initial backdrop if present (currently all themes have nil backdrops)
if initial_theme.backdrop then
	config.window_background_image = wezterm.config_dir .. "/" .. initial_theme.backdrop
	config.window_background_image_hsb = {
		brightness = 0.3,
		hue = 1.0,
		saturation = 1.0,
	}
end

-- Initialize NeoVim palette on startup
ensure_state_dir()
export_to_nvim()

return config
