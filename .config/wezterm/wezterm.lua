local wezterm = require("wezterm")

-- Catppuccin Custom Theme
local catppuccinCustom = wezterm.get_builtin_color_schemes()["Catppuccin Macchiato"]
catppuccinCustom.split = "#000000"
catppuccinCustom.tab_bar = catppuccinCustom.tab_bar or {}
catppuccinCustom.tab_bar.background = "#000000"
catppuccinCustom.background = "#000000"
catppuccinCustom.tab_bar.inactive_tab = catppuccinCustom.tab_bar.inactive_tab or {}
catppuccinCustom.tab_bar.inactive_tab.bg_color = "#000000"
catppuccinCustom.tab_bar.inactive_tab.fg_color = catppuccinCustom.brights[8]
catppuccinCustom.tab_bar.active_tab = catppuccinCustom.tab_bar.active_tab or {}
catppuccinCustom.tab_bar.active_tab.bg_color = catppuccinCustom.background
catppuccinCustom.tab_bar.active_tab.fg_color = catppuccinCustom.ansi[6]
catppuccinCustom.tab_bar.active_tab.intensity = "Bold"
catppuccinCustom.tab_bar.new_tab = catppuccinCustom.tab_bar.new_tab or {}
catppuccinCustom.tab_bar.new_tab.bg_color = "#000000"

local config = {
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = false,
  enable_scroll_bar = false,
  window_padding = {
    left = 0,
    right = 0,
    top = "0.2cell",
    bottom = 0,
  },
  window_frame = {
    border_left_width = 0,
    border_right_width = 0,
    border_bottom_height = 0,
    border_top_height = 0,
    border_left_color = "#C093B7",
    border_right_color = "#C093B7",
    border_bottom_color = "#C093B7",
    border_top_color = "#C093B7",
  },
  initial_rows = 26,
  initial_cols = 110,
  inactive_pane_hsb = {},
  send_composed_key_when_left_alt_is_pressed = false,
  send_composed_key_when_right_alt_is_pressed = false,
  cursor_blink_rate = 0,
  font = wezterm.font_with_fallback({
    "JetBrainsMono Nerd Font",
  }, { weight = "Medium", italic = false }),
  foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 1.0,
  },
  audible_bell = "Disabled",
  pane_focus_follows_mouse = true,
  scrollback_lines = 100000,
  font_size = 13.0,
  line_height = 1.111,
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  freetype_load_flags = "NO_HINTING|NO_AUTOHINT",
  front_end = "WebGpu",
  webgpu_power_preference = "HighPerformance",
  bold_brightens_ansi_colors = true,
  keys = {
    {
      key = "d",
      mods = "CMD",
      action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "d",
      mods = "CMD|SHIFT",
      action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "e",
      mods = "CMD",
      action = wezterm.action.SplitPane({
        direction = "Down",
        size = { Percent = 15 },
      }),
    },
    {
      key = "LeftArrow",
      mods = "OPT",
      action = wezterm.action({ SendString = "\x1bb" }),
    },
    {
      key = "RightArrow",
      mods = "OPT",
      action = wezterm.action({ SendString = "\x1bf" }),
    },
    {
      key = "LeftArrow",
      mods = "CMD|OPT",
      action = wezterm.action.ActivateTabRelative(-1),
    },
    {
      key = "RightArrow",
      mods = "CMD|OPT",
      action = wezterm.action.ActivateTabRelative(1),
    },
    {
      key = "LeftArrow",
      mods = "CMD",
      action = wezterm.action({ ActivatePaneDirection = "Prev" }),
    },
    {
      key = "RightArrow",
      mods = "CMD",
      action = wezterm.action({ ActivatePaneDirection = "Next" }),
    },
    {
      key = "s",
      mods = "CMD",
      action = wezterm.action({ SendString = "\x1b:w\n" }),
    },
  },
  mouse_bindings = {
    {
      event = { Down = { streak = 1, button = "Left" } },
      mods = "CMD|ALT",
      action = wezterm.action.SelectTextAtMouseCursor("Block"),
      alt_screen = "Any",
    },
    {
      event = { Down = { streak = 4, button = "Left" } },
      action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
      mods = "NONE",
    },
  },
  color_schemes = {
    ["Catppuccin Custom"] = catppuccinCustom,
  },
  color_scheme = "Catppuccin Custom",
  harfbuzz_features = { "zero", "ss04", "cv16", "cv14" },
}

return config
