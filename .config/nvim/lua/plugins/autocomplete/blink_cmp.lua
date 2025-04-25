return {
  "saghen/blink.cmp",
  lazy = true,
  event = { "InsertEnter" },
  optional = true, -- todo: maybe just remove this
  dependencies = {
    "rafamadriz/friendly-snippets",
    "saghen/blink.compat",
    --"supermaven-nvim",
    "huijiro/blink-cmp-supermaven",
    {
      "supermaven-inc/supermaven-nvim",
      opts = {
        disable_inline_completion = true,
        disable_keymaps = true,
      },
    },
  },
  version = "*",
  opts = {
    completion = {
      ghost_text = { enabled = true, show_with_menu = false },
      menu = { auto_show = false },
      list = { selection = { preselect = true, auto_insert = true } },
    },
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      --["<Tab>"] = { "snippet_forward", "fallback" },
      --["<S-Tab>"] = { "snippet_backward", "fallback" },
      --["<Up>"] = { "select_prev", "fallback" },
      --["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<A-k>"] = { "select_next", "fallback" },
      ["<A-j>"] = { "select_prev", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    sources = {
      --compat = { "supermaven" },
      default = { "supermaven", "lsp", "path", "snippets", "buffer" },
      providers = {
        supermaven = {
          -- kind = "Supermaven",
          name = "supermaven",
          --module = "blink.compat.source",
          module = "blink-cmp-supermaven",
          score_offset = 100,
          async = true,
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
      },
    },
  },
  opts_extend = { "sources.default" },
}
