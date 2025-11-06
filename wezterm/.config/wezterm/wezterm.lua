-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Josean's coolnight colorscheme:
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 14

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
-- config.window_background_opacity = 0.8
-- config.macos_window_background_blur = 10

-- Key bindings
config.keys = {
	-- Shift+Enter: Send explicit newline
	{ key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\n") },

	-- Cmd+C: Copy selection to clipboard (main copy mechanism)
	{ key = "c", mods = "CMD", action = wezterm.action.CopyTo("Clipboard") },

	-- Cmd+V: Paste from clipboard
	{ key = "v", mods = "CMD", action = wezterm.action.PasteFrom("Clipboard") },

	-- Optional: Activate copy mode with Cmd+Shift+C for vim-style selection
	{ key = "C", mods = "CMD|SHIFT", action = wezterm.action.ActivateCopyMode },
}

-- Return the configuration to wezterm
return config
