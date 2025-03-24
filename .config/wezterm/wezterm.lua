local wezterm = require("wezterm")

local config = {
  color_scheme = 'tokyonight_night',
  --font = wezterm.font('JetBrainsMono Nerd Font'),
  --font = wezterm.font('MesloLGS Nerd Font Mono'),
  font = wezterm.font_with_fallback({
    --"JetBrainsMono Nerd Font", -- <built-in>, BuiltIn
    "MesloLGS Nerd Font Mono",
  }, { weight = "Bold", italic = false }),

  font_rules= {
    {
      italic = true,
      font = wezterm.font("MesloLGS Nerd Font Mono", {italic=true}),
    },

    {
      italic = true,
      intensity = "Bold",
      font = wezterm.font("MesloLGS Nerd Font Mono", {bold=true,italic=true}),
    },

    {
      intensity = "Bold",
      font = wezterm.font("MesloLGS Nerd Font Mono", {bold=true}),
    },
  },

  foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 0.8,  -- default is 1.0
  },

  audible_bell = 'Disabled',
  pane_focus_follows_mouse = true,
  scrollback_lines = 100000,
  font_size = 13.0,
  line_height = 1.111,
  --front_end = 'OpenGL',

  --freetype_load_target = 'Light',
  freetype_load_target = 'HorizontalLcd',

  --freetype_render_target = 'HorizontalLcd',

  cell_width = 0.9,

  -- integrate the tabs into the window title bar
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",

  --custom_block_glyphs = true,

  freetype_load_flags = 'NO_HINTING|NO_AUTOHINT',
  --freetype_load_flags = 'NO_HINTING|NO_BITMAP',

  front_end = "WebGpu",
  webgpu_power_preference = "HighPerformance",
  bold_brightens_ansi_colors = true,

  hide_tab_bar_if_only_one_tab = true,

  keys = {
    {
      key = 'd',
      mods = 'CMD',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'd',
      mods = 'CMD|SHIFT',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {
      key="LeftArrow",
      mods="OPT",
      action=wezterm.action{SendString="\x1bb"}
    },
    -- Make Option-Right equivalent to Alt-f; forward-word
    {
      key="RightArrow",
      mods="OPT",
      action=wezterm.action{SendString="\x1bf"}
    },
    -- Select next tab with cmd-opt-left/right arrow
    {
      key = 'LeftArrow',
      mods = 'CMD|OPT',
      action = wezterm.action.ActivateTabRelative(-1)
    },
    {
      key = 'RightArrow',
      mods = 'CMD|OPT',
      action = wezterm.action.ActivateTabRelative(1)
    },
    -- Select next pane with cmd-left/right arrow
    {
      key = 'LeftArrow',
      mods = 'CMD',
      action = wezterm.action{ActivatePaneDirection='Prev'},
    },
    {
      key = 'RightArrow',
      mods = 'CMD',
      action = wezterm.action{ActivatePaneDirection='Next'},
    },
    -- on cmd-s, send esc, then ':w<enter>'. This makes cmd-s trigger a save action in neovim
    {
      key="s",
      mods="CMD",
      action = wezterm.action{SendString="\x1b:w\n"}
    },
  },
  mouse_bindings = {
    {
      event = { Down = { streak = 1, button = 'Left' } },
      mods = 'CMD|ALT',
      action = wezterm.action.SelectTextAtMouseCursor 'Block',
      alt_screen='Any'
    },
    {
      event = { Down = { streak = 4, button = 'Left' } },
      action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
      mods = 'NONE',
    },
  }
}

return config
