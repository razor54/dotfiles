return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { { "williamboman/mason.nvim", lazy = true, cmd = { "Mason" } } },
    lazy = true,
    opts = {},
    config = true,
  },
  {
    "williamboman/mason.nvim",
    lazy = true,
    cmd = { "Mason", "MasonUpdate", "MasonInstall", "MasonUninstall", "MasonLog" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
    },
    config = function()
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "gopls", -- Go
          "jdtls", -- Java (requires manual setup, see below)
          "ts_ls", -- TypeScript/JavaScript
          "terraformls", -- Terraform
          "lua_ls", -- Lua
          "bashls", -- Bash
          "texlab", -- LaTeX
        },
        automatic_installation = true,
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local disabled_servers = {
        "jdtls",
        --"ts_ls",
      }

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          for _, name in pairs(disabled_servers) do
            if name == server_name then
              return
            end
          end

          require("lspconfig")[server_name].setup({ capabilities = capabilities })
        end,
        --
        -- Custom handlers for specific LSPs
        ["terraformls"] = function()
          require("lspconfig").terraformls.setup({
            capabilities = capabilities,
            filetypes = { "terraform", "tf", "hcl" },
          })
        end,

        ["ts_ls"] = function()
          require("lspconfig").ts_ls.setup({
            capabilities = capabilities,
            init_options = {
              preferences = {
                importModuleSpecifierPreference = "relative",
              },
            },
          })
        end,

        ["gopls"] = function()
          require("lspconfig").gopls.setup({
            capabilities = capabilities,
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
              },
            },
          })
        end,
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT", -- Use LuaJIT
                  path = vim.split(package.path, ";"), -- Inherit Neovim's Lua paths
                },
                diagnostics = {
                  globals = { "vim" }, -- Recognize Neovim global vars like `vim.api`
                },
                workspace = {
                  library = {
                    -- Make Neovim runtime accessible to Lua LSP
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim")] = true,
                  },
                  checkThirdParty = false, -- Disable "third party library" warnings
                },
                telemetry = { enable = false },
              },
            },
          })
        end,
      })

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
          },
        },
        virtual_text = true,
      })
    end,
    opts = {
      registries = {
        "github:nvim-java/mason-registry",
        "github:mason-org/mason-registry",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    --lazy = true,
    event = "VeryLazy",
    setup = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = { typeCheckingMode = "standard" },
            },
          },
        },
      },
    },
    config = function()
      -- LSP config
      vim.api.nvim_exec_autocmds("FileType", {})
    end,
  },
}
