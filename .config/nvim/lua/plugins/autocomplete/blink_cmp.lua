return {
  "saghen/blink.cmp",
  lazy = true,
  --event = { "InsertEnter" },
  event = { "LspAttach" },
  --optional = true, -- todo: maybe just remove this
  dependencies = {
    { "L3MON4D3/LuaSnip", version = "v2.*" },
    --"rafamadriz/friendly-snippets",
    "saghen/blink.compat",
    -- copilot
    {
      "giuxtaposition/blink-cmp-copilot",
    },
    --"supermaven-nvim",
    --"huijiro/blink-cmp-supermaven",
    --{
    --  "supermaven-inc/supermaven-nvim",
    --  opts = {
    --    disable_inline_completion = true,
    --    disable_keymaps = true,
    --  },
    --},
    --"hrsh7th/nvim-cmp", -- Required
    --"hrsh7th/cmp-nvim-lsp", -- add this for LSP capabilities support
  },
  version = "1.*",
  opts = {
    completion = {
      ghost_text = { enabled = true, show_with_menu = true },
      menu = { auto_show = true },
      list = { selection = { preselect = true, auto_insert = true } },
      trigger = { prefetch_on_insert = false },
    },
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      --["<Tab>"] = { "snippet_forward", "fallback" },
      --["<S-Tab>"] = { "snippet_backward", "fallback" },
      --["<Up>"] = { "select_prev", "fallback" },
      --["<Down>"] = { "select_next", "fallback" },
      -- ["<Tab>"] = { "select_next", "snippet_forward", "fallback" }, -- Use Tab for Blink’s selections
      -- ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      -- ["<CR>"] = { "accept", "fallback" }, -- Enter to accept Blink’s suggestion
      ["<C-p>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<C-n>"] = { "select_next", "snippet_forward", "fallback" },
      ["<A-k>"] = { "select_next", "snippet_forward", "fallback" },
      ["<A-j>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    -- win = {
    --   documentation = { border = "rounded" },
    --   completion = { border = "rounded", max_height = 20, max_width = 50 },
    -- },
    appearance = {
      nerd_font_variant = "mono",
    },
    sources = {
      --compat = { "supermaven" },
      --default = { "supermaven", "lazydev", "lsp", "path", "snippets", "buffer" },
      --default = { "minuet", "lazydev", "lsp", "path", "snippets", "buffer" },
      default = { "copilot", "lazydev", "lsp", "path", "snippets", "buffer" },

      providers = {
        --supermaven = {
        --  -- kind = "Supermaven",
        --  name = "supermaven",
        --  --module = "blink.compat.source",
        --  module = "blink-cmp-supermaven",
        --  score_offset = 100,
        --  async = true,
        --},
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 75,
        },
        lsp = {
          name = "lsp",
          enabled = true,
          module = "blink.cmp.sources.lsp",
          score_offset = 50,
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 25,
          fallbacks = { "snippets", "buffer" },
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context)
              return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
            end,
            show_hidden_files_by_default = true,
          },
        },
        buffer = {
          name = "Buffer",
          enabled = true,
          max_items = 3,
          module = "blink.cmp.sources.buffer",
          min_keyword_length = 4,
          score_offset = 15,
        },
        snippets = {
          name = "snippets",
          enabled = true,
          min_keyword_length = 2,
          module = "blink.cmp.sources.snippets",
          score_offset = 85,
        },
        minuet = {
          name = "minuet",
          module = "minuet.blink",
          async = true,
          timeout_ms = 3000,
          score_offset = 50,
        },
      },
    },
    snippets = { preset = "luasnip" },
  },
  opts_extend = { "sources.default" },
}
