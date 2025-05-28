local wezterm = require("wezterm")

--local kanagawa = require("themes/kanagawa")
--local kanso = require("colors/kanso")

-- Colors customization
-- customize zenbones_dark's background
local schemeZenbonesDark = wezterm.get_builtin_color_schemes()["zenbones_dark"]
-- schemeZenbonesDark.background = "#171210"
-- schemeZenbonesDark.background = "#181616"
schemeZenbonesDark.cursor_bg = "#F34B00"
-- customize zenbones_light's background
local schemeZenbonesLight = wezterm.get_builtin_color_schemes()["zenbones_light"]
schemeZenbonesLight.background = "#F8F6F5"
schemeZenbonesLight.cursor_bg = "#9775FA"
-- customize GithubLight
local schemeGithubLight = wezterm.get_builtin_color_schemes()["Github (base16)"]
-- schemeGithubLight.background = "#F4F4F4"
-- schemeGithubLight.cursor_fg = "#24292F"
schemeGithubLight.cursor_bg = "#9775FA"
schemeGithubLight.cursor_border = "#9775FA"
-- customize Monokai-pro
local schemeMonokaiPro = wezterm.get_builtin_color_schemes()["Monokai (base16)"]
schemeMonokaiPro.background = "#2D2A2E"
-- schemeMonokaiPro.cursor_fg = "#2D2A2E"
-- schemeMonokaiPro.cursor_bg = "#FFC22D"
-- customize OneDark
local schemeOneDark = wezterm.get_builtin_color_schemes()["OneDark (base16)"]
-- schemeOneDark.background = "#1E222A"
schemeOneDark.ansi = {
  "#1E2127",
  "#E06C75",
  "#98C379",
  "#E5C07B",
  "#61AFEF",
  "#C678DD",
  "#56B6C2",
  "#ABB2BF",
}
-- schemeOneDark.cursor_fg = "#1F2329"
-- schemeOneDark.cursor_fg = "#E1E1E1"
schemeOneDark.cursor_bg = "#74ADE8"
-- schemeOneDark.cursor_bg = "#C8D3F5"
local schemeWind = wezterm.get_builtin_color_schemes()["OneDark (base16)"]
schemeWind.background = "#002635"
schemeWind.cursor_bg = "#F34B00"
schemeWind.cursor_border = "#F34B00"
schemeWind.cursor_fg = "#282C34"
local schemeGruvbox = wezterm.get_builtin_color_schemes()["Gruvbox Material (Gogh)"]
schemeGruvbox.cursor_fg = "#282828"
local catppuccinMacchiato = wezterm.get_builtin_color_schemes()["Catppuccin Macchiato"]
catppuccinMacchiato.split = "#000000"
catppuccinMacchiato.tab_bar.background = catppuccinMacchiato.background
catppuccinMacchiato.tab_bar.inactive_tab.bg_color = catppuccinMacchiato.background
catppuccinMacchiato.tab_bar.inactive_tab.fg_color = catppuccinMacchiato.brights[8]
catppuccinMacchiato.tab_bar.active_tab.bg_color = catppuccinMacchiato.background
catppuccinMacchiato.tab_bar.active_tab.fg_color = catppuccinMacchiato.ansi[6]
catppuccinMacchiato.tab_bar.active_tab.intensity = "Bold"

local catppuccinCustom = wezterm.get_builtin_color_schemes()["Catppuccin Macchiato"]
catppuccinCustom.split = "#000000"
catppuccinCustom.tab_bar.background = "#000000"
catppuccinCustom.background = "#000000"
catppuccinCustom.tab_bar.inactive_tab.bg_color = "#000000"
catppuccinCustom.tab_bar.inactive_tab.fg_color = catppuccinMacchiato.brights[8]
catppuccinCustom.tab_bar.active_tab.bg_color = catppuccinMacchiato.background
catppuccinCustom.tab_bar.active_tab.fg_color = catppuccinMacchiato.ansi[6]
catppuccinCustom.tab_bar.active_tab.intensity = "Bold"
catppuccinCustom.tab_bar.new_tab.bg_color = "#000000"

local catppuccinFrappe = wezterm.get_builtin_color_schemes()["Catppuccin Frappe"]
catppuccinFrappe.split = "#000000"
catppuccinFrappe.tab_bar.background = catppuccinFrappe.background
catppuccinFrappe.tab_bar.inactive_tab.bg_color = catppuccinFrappe.background
catppuccinFrappe.tab_bar.inactive_tab.fg_color = catppuccinFrappe.brights[8]
catppuccinFrappe.tab_bar.active_tab.bg_color = catppuccinFrappe.background
catppuccinFrappe.tab_bar.active_tab.fg_color = catppuccinFrappe.ansi[6]
catppuccinFrappe.tab_bar.active_tab.intensity = "Bold"
local schemeGithubDark = wezterm.get_builtin_color_schemes()["GitHub Dark"]
schemeGithubDark.background = "#0D1117"
schemeGithubDark.cursor_bg = "#58a6ff"
-- schemeGithubDark.cursor_bg = "#ed6a43"
schemeGithubDark.split = "#282828"
local schemeTokyoNightMoon = wezterm.get_builtin_color_schemes()["tokyonight_moon"]
schemeTokyoNightMoon.split = "#3A3A3A"
schemeTokyoNightMoon.cursor_bg = "#BD93F9"
schemeTokyoNightMoon.cursor_border = "#BD93F9"
local schemeDracula = wezterm.get_builtin_color_schemes()["Dracula (Official)"]
-- schemeDracula.background = "#22212C"
schemeDracula.cursor_bg = "#BD93F9"
schemeDracula.cursor_border = "#BD93F9"
schemeDracula.split = "#394362"

local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    -- return "Catppuccin Frappe"
    -- return "Catppuccin Macchiato"
    -- return "Catppuccin Mocha"
    -- return "Dracula Custom"
    -- return "GitHub Dark Custom"
    -- return "Monokai (base16)"
    return "OneDark Custom"
    -- return "tokyonight_moon_custom"
  else
    -- return "Catppuccin Frappe"
    -- return "Catppuccin Macchiato"
    -- return "Catppuccin Mocha"
    -- return "Github Light"
    -- return "Monokai (base16)"
    -- return "OneDark Custom"
    -- return "tokyonight_moon_custom"
    return "Dracula Custom"
  end
end

local function autoThemeOptions()
  local appearance = wezterm.gui.get_appearance()
  if appearance:find("Dark") then
    return {
      win_opacity = 1,
      win_blur = 5,
      -- font = "Iosevka Custom Light Extended",
      -- font = "MonoLisa",
      -- font = "MonoLisa",
      font = "MonoLisa Nerd Font",
      -- font = "Operator Mono Lig",
      -- font_weight = "Light",
      font_weight = "Regular",
      border_color = "#C093B7",
      -- berder_width = "0.38cell",
      -- berder_height = "0.15cell",
      border_width = 0,
      border_height = 0,
    }
  else
    return {
      win_opacity = 1,
      win_blur = 5,
      -- font = "Iosevka Custom Extended",
      -- font = "MonoLisa",
      font = "MonoLisa Nerd Font",
      -- font = "Operator Mono Lig",
      font_weight = "Regular",
      -- font_weight = "Light",
      border_color = "#C093B7",
      border_width = 0,
    }
  end
end

-- A helper function for my fallback fonts
local function font_with_fallback(name, params)
  local names = { name, "Noto Color Emoji", "JetBrains Mono" }
  return wezterm.font_with_fallback(names, params)
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local cwd = pane.current_working_dir
  return {
    -- { Text = " " .. " hello " .. " " }, -- this works
    { Text = " " .. cwd .. " " }, -- this doesn't work
  }
end)

local config = {
  -- debug_key_events = true,
  -- window config
  --window_decorations = "RESIZE",
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
    border_left_width = autoThemeOptions().border_width,
    border_right_width = autoThemeOptions().border_width,
    border_bottom_height = autoThemeOptions().border_height,
    border_top_height = autoThemeOptions().border_height,
    border_left_color = autoThemeOptions().border_color,
    border_right_color = autoThemeOptions().border_color,
    border_bottom_color = autoThemeOptions().border_color,
    border_top_color = autoThemeOptions().border_color,
  },
  initial_rows = 26,
  initial_cols = 110,
  -- window_close_confirmation = "NeverPrompt",
  -- window_background_opacity = autoThemeOptions().win_opacity,
  -- macos_window_background_blur = autoThemeOptions().win_blur,
  -- window_background_opacity = 0.90,
  -- macos_window_background_blur = 30,
  inactive_pane_hsb = {}, -- don't dim inactive panes
  send_composed_key_when_left_alt_is_pressed = false,
  send_composed_key_when_right_alt_is_pressed = false,
  cursor_blink_rate = 0,

  --colors = kanagawa.colors,
  --color_scheme = kanagawa,
  --color_scheme = "tokyonight_night",
  --font = wezterm.font('JetBrainsMono Nerd Font'),
  --font = wezterm.font('MesloLGS Nerd Font Mono'),
  font = wezterm.font_with_fallback({
    --"Akkurat-Mono",
    "JetBrainsMono Nerd Font", -- <built-in>, BuiltIn
    --"MesloLGS Nerd Font Mono",
  }, { weight = "Medium", italic = false }),

  --font_rules= {
  --  {
  --    italic = true,
  --    font = wezterm.font("MesloLGS Nerd Font Mono", {italic=true}),
  --  },

  --  {
  --    italic = true,
  --    intensity = "Bold",
  --    font = wezterm.font("MesloLGS Nerd Font Mono", {bold=true,italic=true}),
  --  },

  --  {
  --    intensity = "Bold",
  --    font = wezterm.font("MesloLGS Nerd Font Mono", {bold=true}),
  --  },
  --},

  foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 1.0, -- default is 1.0
  },

  audible_bell = "Disabled",
  pane_focus_follows_mouse = true,
  scrollback_lines = 100000,
  font_size = 13.0,
  line_height = 1.111,
  --front_end = 'OpenGL',

  --freetype_load_target = 'Light',
  --freetype_load_target = 'HorizontalLcd',

  --freetype_render_target = 'HorizontalLcd',

  --cell_width = 0.9,

  -- integrate the tabs into the window title bar
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",

  --custom_block_glyphs = true,

  freetype_load_flags = "NO_HINTING|NO_AUTOHINT",
  --freetype_load_flags = 'NO_HINTING|NO_BITMAP',

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
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {
      key = "LeftArrow",
      mods = "OPT",
      action = wezterm.action({ SendString = "\x1bb" }),
    },
    -- Make Option-Right equivalent to Alt-f; forward-word
    {
      key = "RightArrow",
      mods = "OPT",
      action = wezterm.action({ SendString = "\x1bf" }),
    },
    -- Select next tab with cmd-opt-left/right arrow
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
    -- Select next pane with cmd-left/right arrow
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
    -- on cmd-s, send esc, then ':w<enter>'. This makes cmd-s trigger a save action in neovim
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
    -- Override the builtin zenbones_dark scheme with our modification above.
    ["zenbones_dark custom"] = schemeZenbonesDark,
    ["zenbones_light custom"] = schemeZenbonesLight,
    ["Catppuccin Macchiato"] = catppuccinMacchiato,
    ["Catppuccin Frappe"] = catppuccinFrappe,
    ["Catppuccin Custom"] = catppuccinCustom,
    ["Github Light"] = schemeGithubLight,
    ["Monokai (base16)"] = schemeMonokaiPro,
    ["Gruvbox Material (Gogh)"] = schemeGruvbox,
    ["OneDark Custom"] = schemeOneDark,
    ["Wind"] = schemeWind,
    ["GitHub Dark Custom"] = schemeGithubDark,
    ["tokyonight_moon_custom"] = schemeTokyoNightMoon,
    ["Dracula Custom"] = schemeDracula,
  },
  --color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
  --color_scheme = "OneDark Custom",
  color_scheme = "Catppuccin Custom",
  --colors = kanso.colors,

  harfbuzz_features = { "zero", "ss04", "cv16", "cv14" },
}

-- Merge kanagawa theme settings
--for k, v in pairs(kanagawa) do
--  config[k] = v
--end

--return config

--local wezterm = require("wezterm")
return config
