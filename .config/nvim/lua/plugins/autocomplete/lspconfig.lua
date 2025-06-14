return {
  {
    "neovim/nvim-lspconfig",
    opts = { inlay_hints = { enabled = true } },
    --event = "BufEnter",
    event = "BufReadPost",
    config = function()
      --require("nvim-highlight-colors").turnOn()
    end,
    dependencies = {
      "mason-org/mason-lspconfig.nvim",

      {
        "linrongbin16/lsp-progress.nvim",
        opts = {
          max_size = 50,
          spinner = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" },
          -- client_format = function(client_name, spinner, series_messages)
          client_format = function(_, spinner, series_messages)
            return #series_messages > 0
                -- and (spinner .. " [" .. client_name .. "] " .. table.concat(series_messages, ", "))
                -- and (spinner .. " (LSP) " .. table.concat(series_messages, ", "))
                and (spinner .. " LSP")
              or nil
          end,
          format = function(client_messages)
            if #client_messages > 0 then
              return table.concat(client_messages, " ")
            end
            return ""
          end,
        },
      },
      --"hrsh7th/cmp-nvim-lsp",
      --{ -- install ufo for better code folding support
      --  "kevinhwang91/nvim-ufo",
      --  lazy = false,
      --  dependencies = {
      --    "kevinhwang91/promise-async",
      --    { "luukvbaal/statuscol.nvim", lazy = false, config = true },
      --  },
      --},
      --{
      --  "brenoprata10/nvim-highlight-colors",
      --  config = true,
      --  opts = {
      --    render = "background",
      --    enable_hex = true,
      --    enable_hsl = true,
      --    enable_rgb = true,
      --    enable_tailwind = true,
      --    enable_var_usage = true,
      --    enable_short_hex = true,
      --    enable_named_colors = true,
      --    virtual_symbol = "■",
      --    virtual_symbol_prefix = "",
      --    virtual_symbol_suffix = " ",
      --    virtual_symbol_position = "inline",
      --  },
      --},
    },
  },
  -- Lsp notifications
  {
    "j-hui/fidget.nvim",
    event = "BufReadPre",
    opts = {},
  },
  -- LuaLS configuration for vim
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
