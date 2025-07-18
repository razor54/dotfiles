return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  dependencies = {
    "AndreM222/copilot-lualine",
  },
  keys = {
    -- {
    --   "<leader>cp",
    --   function()
    --     vim.cmd("Copilot toggle")
    --   end,
    --   desc = "Copilot Toggle",
    -- },
  },
  opts = {
    panel = {
      enabled = false,
      -- auto_refresh = true,
    },
    suggestion = {
      enabled = false,
      auto_trigger = false,
      -- keymap = {
      --   accept = "<C-c>",
      --   accept_word = false,
      --   accept_line = false,
      --   next = "<C-n>",
      --   prev = "<C-p>",
      --   dismiss = "<C-]>",
      -- },
    },
  },
}
