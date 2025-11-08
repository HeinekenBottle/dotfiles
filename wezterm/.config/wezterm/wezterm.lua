-- ============================================================================
-- WezTerm Comprehensive Configuration
-- A minimalistic, robust terminal setup with theme cycling, opacity control,
-- font color schemes, NeoVim integration, and background backdrops
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
-- Complete terminal themes with all color properties and optional backdrops
-- Each theme includes background, foreground, cursor, selection, and ANSI colors
-- ============================================================================

local themes = {
	{
		name = "Root Loops",
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
		backdrop = nil, -- No backdrop for this theme
	},
	{
		name = "Arctic Frost",
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
		backdrop = "backdrops/arctic-blue.png",
	},
	{
		name = "Android AI",
		colors = {
			foreground = "#e0e0e0",
			background = "#121212",
			cursor_bg = "#00ff88",
			cursor_fg = "#121212",
			cursor_border = "#00ff88",
			selection_bg = "#1e1e1e",
			selection_fg = "#e0e0e0",
			ansi = {
				"#121212", -- black
				"#f44336", -- red
				"#4caf50", -- green
				"#ffeb3b", -- yellow
				"#2196f3", -- blue
				"#9c27b0", -- magenta
				"#00bcd4", -- cyan
				"#e0e0e0", -- white
			},
			brights = {
				"#1e1e1e", -- bright black
				"#f44336", -- bright red
				"#4caf50", -- bright green
				"#ffeb3b", -- bright yellow
				"#2196f3", -- bright blue
				"#9c27b0", -- bright magenta
				"#00bcd4", -- bright cyan
				"#ffffff", -- bright white
			},
		},
		backdrop = "backdrops/tech-grid.jpg",
	},
	{
		name = "Coolnight Classic",
		colors = {
			foreground = "#CBE0F0",
			background = "#011423",
			cursor_bg = "#47FF9C",
			cursor_fg = "#011423",
			cursor_border = "#47FF9C",
			selection_bg = "#033259",
			selection_fg = "#CBE0F0",
			ansi = {
				"#214969", -- black
				"#E52E2E", -- red
				"#44FFB1", -- green
				"#FFE073", -- yellow
				"#0FC5ED", -- blue
				"#a277ff", -- magenta
				"#24EAF7", -- cyan
				"#24EAF7", -- white
			},
			brights = {
				"#214969", -- bright black
				"#E52E2E", -- bright red
				"#44FFB1", -- bright green
				"#FFE073", -- bright yellow
				"#A277FF", -- bright blue
				"#a277ff", -- bright magenta
				"#24EAF7", -- bright cyan
				"#24EAF7", -- bright white
			},
		},
		backdrop = nil,
	},
	{
		name = "Sunset Vibrant",
		colors = {
			foreground = "#f0e7d5",
			background = "#1a0f0a",
			cursor_bg = "#ff6b35",
			cursor_fg = "#1a0f0a",
			cursor_border = "#ff6b35",
			selection_bg = "#4a2f1f",
			selection_fg = "#f0e7d5",
			ansi = {
				"#1a0f0a", -- black
				"#ff6b35", -- red
				"#f7931e", -- green (orange-gold)
				"#fdc830", -- yellow
				"#f37335", -- blue (orange)
				"#c44569", -- magenta
				"#ed6663", -- cyan (coral)
				"#f0e7d5", -- white
			},
			brights = {
				"#4a2f1f", -- bright black
				"#ff6b35", -- bright red
				"#f7931e", -- bright green
				"#fdc830", -- bright yellow
				"#f37335", -- bright blue
				"#c44569", -- bright magenta
				"#ed6663", -- bright cyan
				"#fff8e7", -- bright white
			},
		},
		backdrop = "backdrops/sunset-abstract.png",
	},
}

-- ============================================================================
-- FONT COLOR SCHEME DEFINITIONS
-- Independent font overlays that can be applied on top of any main theme
-- These adjust only text-related colors (foreground, cursor, ANSI text colors)
-- ============================================================================

local font_schemes = {
	{
		name = "Default (Theme Native)",
		-- No overrides - uses the base theme colors as-is
		overrides = {},
	},
	{
		name = "Arctic Frost Font",
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
				"#c7d0d5", -- Override white for text
			},
		},
	},
	{
		name = "Chroma Contrast Font",
		overrides = {
			foreground = "#ffffff",
			cursor_fg = "#000000",
			selection_fg = "#000000",
			ansi = {
				"#000000", -- High contrast black
				"#ff0000", -- Pure red
				"#00ff00", -- Pure green
				"#ffff00", -- Pure yellow
				"#0000ff", -- Pure blue
				"#ff00ff", -- Pure magenta
				"#00ffff", -- Pure cyan
				"#ffffff", -- Pure white
			},
		},
	},
	{
		name = "Android AI Font",
		overrides = {
			foreground = "#e0e0e0",
			cursor_fg = "#121212",
			selection_fg = "#e0e0e0",
			ansi = {
				"#121212",
				nil, -- Keep theme's red
				"#4caf50", -- Android green for text
				nil, -- Keep theme's yellow
				nil, -- Keep theme's blue
				nil, -- Keep theme's magenta
				"#00bcd4", -- Tech cyan
				"#e0e0e0",
			},
		},
	},
}

-- ============================================================================
-- HELPER FUNCTIONS
-- Core logic for theme application, opacity control, and cycling
-- ============================================================================

-- Apply font scheme overrides to base theme colors
local function apply_font_scheme(base_colors, scheme_overrides)
	local result = {}
	-- Copy all base colors
	for k, v in pairs(base_colors) do
		result[k] = v
	end
	-- Apply overrides
	for k, v in pairs(scheme_overrides) do
		if k == "ansi" or k == "brights" then
			-- For ANSI arrays, only override non-nil values
			if not result[k] then
				result[k] = {}
			end
			for i, color in ipairs(v) do
				if color ~= nil then
					result[k][i] = color
				end
			end
		else
			result[k] = v
		end
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

	-- Apply font scheme on top of theme
	local final_colors = apply_font_scheme(theme.colors, font_scheme.overrides)

	-- Set window overrides
	local overrides = window:get_config_overrides() or {}
	overrides.colors = final_colors
	overrides.window_background_opacity = opacity

	-- Apply backdrop if theme has one
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
		string.format(
			"Theme: %s | Font: %s | Opacity: %.2f",
			theme.name,
			font_scheme.name,
			opacity
		),
		nil,
		2000
	)
end

-- Export current colors to NeoVim palette file (JSON format)
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
		bold_fg = final_colors.foreground, -- Could be customized per theme
		cursor = final_colors.cursor_bg,
		ansi = final_colors.ansi,
		brights = final_colors.brights,
	}

	-- Write JSON
	ensure_state_dir()
	local f = io.open(nvim_palette_file, "w")
	if f then
		-- Simple JSON encoding (no external dependencies)
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
-- Respond to WezTerm events for dynamic configuration
-- ============================================================================

-- Apply theme on new window creation
wezterm.on("window-config-reloaded", function(window, _pane)
	apply_current_theme(window)
end)

-- ============================================================================
-- KEY BINDINGS
-- Hotkeys for theme cycling, opacity control, font schemes, and NeoVim sync
-- ============================================================================

config.keys = {
	-- ========== Theme Cycling: Ctrl+Shift+T ==========
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

	-- ========== Existing Keybindings (preserved from original config) ==========
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

-- Apply initial backdrop if present
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
