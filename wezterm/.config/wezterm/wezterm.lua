-- WezTerm Base Configuration
-- Phase 1: Basic functional setup

local wezterm = require 'wezterm'

-- Basic configuration
local config = {}

if wezterm.config_builder then
  config_builder = wezterm.config_builder()
  config = config_builder
end

-- Font configuration
config.font = wezterm.font('JetBrains Mono Nerd Font')
config.font_size = 12

-- Terminal settings
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false

-- Color scheme
config.color_scheme = 'Tomorrow Night'

-- Window settings
config.window_background_opacity = 0.9
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

-- Key bindings
config.keys = {
  -- Add basic key bindings here in Phase 2
}

return config
