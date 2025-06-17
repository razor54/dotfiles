local M = {}

-- Catppuccin Mocha custom colors (matching your catppuccin.lua overrides)
local c_catppuccin_mocha = {
  base = "#000000",
  mantle = "#000000",
  crust = "#000000",
  text = "#cdd6f4",
  subtext1 = "#bac2de",
  subtext0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay0 = "#6c7086",
  surface2 = "#585b70",
  surface1 = "#45475a",
  surface0 = "#313244",
  blue = "#89b4fa",
  lavender = "#b4befe",
  sapphire = "#74c7ec",
  sky = "#89dceb",
  teal = "#94e2d5",
  green = "#a6e3a1",
  yellow = "#f9e2af",
  peach = "#fab387",
  maroon = "#eba0ac",
  red = "#f38ba8",
  mauve = "#cba6f7",
  pink = "#f5c2e7",
  flamingo = "#f2cdcd",
  rosewater = "#f5e0dc",
}

local catppuccin_mocha_custom = {
  normal = {
    a = { bg = c_catppuccin_mocha.mauve, fg = c_catppuccin_mocha.base, gui = "bold" },
    b = { bg = c_catppuccin_mocha.surface0, fg = c_catppuccin_mocha.text },
    c = { bg = c_catppuccin_mocha.base, fg = c_catppuccin_mocha.subtext1 },
  },
  insert = {
    a = { bg = c_catppuccin_mocha.blue, fg = c_catppuccin_mocha.base, gui = "bold" },
    b = { bg = c_catppuccin_mocha.surface0, fg = c_catppuccin_mocha.blue },
    c = { bg = c_catppuccin_mocha.base, fg = c_catppuccin_mocha.subtext1 },
  },
  visual = {
    a = { bg = c_catppuccin_mocha.pink, fg = c_catppuccin_mocha.base, gui = "bold" },
    b = { bg = c_catppuccin_mocha.surface0, fg = c_catppuccin_mocha.pink },
    c = { bg = c_catppuccin_mocha.base, fg = c_catppuccin_mocha.subtext1 },
  },
  replace = {
    a = { bg = c_catppuccin_mocha.red, fg = c_catppuccin_mocha.base, gui = "bold" },
    b = { bg = c_catppuccin_mocha.surface0, fg = c_catppuccin_mocha.red },
    c = { bg = c_catppuccin_mocha.base, fg = c_catppuccin_mocha.subtext1 },
  },
  command = {
    a = { bg = c_catppuccin_mocha.peach, fg = c_catppuccin_mocha.base, gui = "bold" },
    b = { bg = c_catppuccin_mocha.surface0, fg = c_catppuccin_mocha.peach },
    c = { bg = c_catppuccin_mocha.base, fg = c_catppuccin_mocha.subtext1 },
  },
  inactive = {
    a = { bg = c_catppuccin_mocha.base, fg = c_catppuccin_mocha.overlay0, gui = "bold" },
    b = { bg = c_catppuccin_mocha.base, fg = c_catppuccin_mocha.overlay0 },
    c = { bg = c_catppuccin_mocha.base, fg = c_catppuccin_mocha.overlay0 },
  },
}

M.theme = {
  ["catppuccin"] = catppuccin_mocha_custom,
  ["catppuccin-mocha"] = catppuccin_mocha_custom,
}

return M
