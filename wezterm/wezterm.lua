-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font 'JetBrains Mono'

-- Disable liigatures
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

-- and finally, return the configuration to wezterm
return config
