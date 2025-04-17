lua << EOF
-- NOTE: GUI Options
-------------
-- Nvim-qt --
-------------

if vim.g.GuiLoaded then
  local font_name = "JetBrainsMono Nerd Font"
  local font_size = 11
  local not_transparent = false

  vim.cmd [[
  GuiTabline 0
  GuiPopupmenu 0
  ]]
  vim.cmd("GuiFont! " .. font_name .. ":h" .. font_size)
end

EOF
