local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.font_size = 14.0
config.color_scheme = 'Everforest Dark (Gogh)'
config.window_decorations = 'RESIZE'
config.scrollback_lines = 100000
config.initial_rows = 40
config.initial_cols = 120

-- Tabs

config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 32

config.colors = {
  tab_bar = {
    background = '#343f44',
    active_tab = {
      bg_color = '#a7c080',
      fg_color = '#425047',
    },
    inactive_tab = {
      bg_color = '#3d484d',
      fg_color = '#9da9a0',
    },
  },
}

wezterm.on(
  'format-tab-title',
  function(tab, _tabs, _panes, _config, _hover, _max_width)
    local title = tab.active_pane.title
    if #tab.tab_title > 0 then
      title = tab.tab_title
    end
    return ' ' .. title .. ' '
  end
)

-- Dim inactive panes

config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.7,
}

-- Keymap
config.disable_default_key_bindings = true

config.leader = { key = 'Space', mods = 'ALT|CMD' }

config.keys = {
  { key = 'n',         mods = 'SUPER',            action = act.SpawnWindow },
  { key = 't',         mods = 'SUPER',            action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w',         mods = 'SUPER',            action = act.CloseCurrentTab { confirm = true } },
  { key = 'q',         mods = 'SHIFT|CTRL',       action = act.QuitApplication },
  { key = '[',         mods = 'SHIFT|SUPER',      action = act.ActivateTabRelative(-1) },
  { key = ']',         mods = 'SHIFT|SUPER',      action = act.ActivateTabRelative(1) },
  { key = '[',         mods = 'CTRL|SHIFT|SUPER', action = act.MoveTabRelative(-1) },
  { key = ']',         mods = 'CTRL|SHIFT|SUPER', action = act.MoveTabRelative(1) },
  { key = 'f',         mods = 'SUPER',            action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 'c',         mods = 'SUPER',            action = act.CopyTo 'Clipboard' },
  { key = 'v',         mods = 'SUPER',            action = act.PasteFrom 'Clipboard' },
  { key = 'k',         mods = 'SUPER',            action = act.ClearScrollback 'ScrollbackAndViewport' },
  { key = 'Enter',     mods = 'SHIFT',            action = wezterm.action.SendString("\x1b\r"), },

  { key = 'UpArrow',   mods = 'ALT',              action = act.ScrollByPage(-1) },
  { key = 'DownArrow', mods = 'ALT',              action = act.ScrollByPage(1) },
  { key = 'UpArrow',   mods = 'SUPER',            action = act.ScrollToTop },
  { key = 'DownArrow', mods = 'SUPER',            action = act.ScrollToBottom },

  { key = 'Space',     mods = 'LEADER',           action = act.ActivateCommandPalette },

  { key = 's',         mods = 'LEADER',           action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'v',         mods = 'LEADER',           action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'h',         mods = 'LEADER',           action = act.EmitEvent('activate-pane-left') },
  { key = 'l',         mods = 'LEADER',           action = act.EmitEvent('activate-pane-right') },
  { key = 'k',         mods = 'LEADER',           action = act.EmitEvent('activate-pane-up') },
  { key = 'j',         mods = 'LEADER',           action = act.EmitEvent('activate-pane-down') },
  { key = 'z',         mods = 'LEADER',           action = act.TogglePaneZoomState },
  { key = 'p',         mods = 'LEADER',           action = act.PaneSelect { alphabet = 'sdfjkl' } },
  { key = '+',         mods = 'SUPER',            action = act.IncreaseFontSize },
  { key = '-',         mods = 'SUPER',            action = act.DecreaseFontSize },
  { key = '0',         mods = 'SUPER',            action = act.ResetFontSize },
  { key = 'e',         mods = 'LEADER',           action = act.EmitEvent('back-to-helix') }
}

local function is_tab_zoomed(tab)
  for _, item in ipairs(tab:panes_with_info()) do
    if item.is_active then
      return item.is_zoomed
    end
  end
end

local function activate_pane_direction_keeping_zoom(pane, direction)
  local is_zoomed = is_tab_zoomed(pane:tab())
  local left_pane = pane:tab():get_pane_direction(direction)
  if left_pane ~= nil then
    if is_zoomed then
      pane:tab():set_zoomed(false)
    end
    left_pane:activate()
    if is_zoomed then
      left_pane:tab():set_zoomed(true)
    end
  end
end

wezterm.on('activate-pane-left', function(window, pane) activate_pane_direction_keeping_zoom(pane, 'Left') end)
wezterm.on('activate-pane-right', function(window, pane) activate_pane_direction_keeping_zoom(pane, 'Right') end)
wezterm.on('activate-pane-up', function(window, pane) activate_pane_direction_keeping_zoom(pane, 'Up') end)
wezterm.on('activate-pane-down', function(window, pane) activate_pane_direction_keeping_zoom(pane, 'Down') end)

return config
