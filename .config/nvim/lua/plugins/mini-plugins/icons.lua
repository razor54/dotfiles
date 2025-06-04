return {
  "echasnovski/mini.icons",
  version = "*", -- Use latest version
  config = function()
    require("mini.icons").setup()
    MiniIcons.mock_nvim_web_devicons()
  end,
}
-- return {
--     "echasnovski/mini.icons",
--     -- enabled = false,
--     -- version = false,
--     version = "*", -- Use latest version
--     -- config = function()
--       -- require("mini.icons").setup()
--       -- MiniIcons.mock_nvim_web_devicons()
--
--     -- end,
-- },
