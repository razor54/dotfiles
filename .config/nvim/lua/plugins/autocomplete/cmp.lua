-- lua/plugins/cmp.lua
return {
  {
    -- "hrsh7th/nvim-cmp",
    -- event = "InsertEnter",
    -- dependencies = {
    --   "hrsh7th/cmp-nvim-lsp", -- Required for LSP capabilities
    --   "saghen/blink.cmp", -- Your custom completion engine
    -- },
    -- config = function()
    --   -- Minimal nvim-cmp setup (even if using blink.cmp)
    --   require("cmp").setup({})
    -- end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      -- feed luasnip suggestions to cmp
      "saadparwaiz1/cmp_luasnip",
      -- provide vscode like snippets to cmp
      "rafamadriz/friendly-snippets",
    },
  },
}
