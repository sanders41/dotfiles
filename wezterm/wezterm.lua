-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

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

local SOLID_LEFT_TRIANGLE = wezterm.nerdfonts.ple_upper_right_triangle
local SOLID_RIGHT_TRIANGLE = wezterm.nerdfonts.ple_upper_left_triangle

local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)-- luacheck: ignore
    local edge_background = '#15161e'
    local background = '#414868'
    local foreground = '#15161e'

    if tab.is_active then
      background = '#7aa2f7'
      foreground = '#15161e'
    elseif hover then
      background = '#16161e'
      foreground = '#7aa2f7'
    end

    local edge_foreground = background
    local title = tab_title(tab)

    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    if string.len(title) > (max_width - 2) then
      title = wezterm.truncate_left(title, max_width - 2)
    end

    return {
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_LEFT_TRIANGLE },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_RIGHT_TRIANGLE },
    }
  end
)

-- Check if wayland is being used and if so fall back to xorg because the toolbar doesn't render
-- correctly under wayland
if os.getenv("XDG_SESSION_TYPE") == "wayland" then
  config.enable_wayland = false
end

-- Key bindings
config.keys = {
  { key = 'Enter', mods = 'SHIFT|CTRL', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
  { key = '%', mods = 'SHIFT|CTRL', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
  { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.AdjustPaneSize{ 'Left', 1 } },
  { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.AdjustPaneSize{ 'Right', 1 } },
  { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.AdjustPaneSize{ 'Up', 1 } },
  { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.AdjustPaneSize{ 'Down', 1 } },
}

-- and finally, return the configuration to wezterm
return config
