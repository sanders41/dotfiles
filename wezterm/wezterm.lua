-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font 'JetBrains Mono'

-- Disable ligatures
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.scrollback_lines = 5000

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- and finally, return the configuration to wezterm
return config
