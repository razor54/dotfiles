local java_mason_install_intent = {
  lsp = { "jdtls" },
  runtime = { "java-debug-adapter", "java-test", "lombok-nightly" },
}

local mason_lsp_servers = vim.tbl_filter(function(server_name)
  return server_name ~= "jdtls"
end, vim.deepcopy(java_mason_install_intent.lsp))

vim.g.java_mason_install_intent = vim.deepcopy(java_mason_install_intent)

return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason" },
    opts = {
      registries = {
        "github:nvim-java/mason-registry",
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = vim.list_extend(mason_lsp_servers, {
        "gopls",
        "ts_ls",
        "terraformls",
        "lua_ls",
        "bashls",
        "texlab",
        "yamlls",
        "dockerls",
        "jsonls",
        -- "csharp_ls",
        -- "roslyn", -- Apparently we have to install this manually:w
      }),
      automatic_enable = {
        exclude = { "jdtls" }, -- Exclude servers you want manual control
      },
    },
  },
  -- mason nvim dap utilizes mason to automatically ensure debug adapters you want installed are installed, mason-lspconfig will not automatically install debug adapters for us
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- TODO: Clean up
    --event = "BufReadPost",
    config = function()
      -- ensure the java debug adapter is installed
      require("mason-nvim-dap").setup({
        -- TODO: Apparently this is not installing automatically
        ensure_installed = vim.list_extend(vim.deepcopy(java_mason_install_intent.runtime), { "delve", "go-debug-adapter" }),
        automatic_installation = true,
        handlers = {
          --java = function(source_name)
          --  -- Explicit handler for Java adapter
          --  require("mason-nvim-dap").default_setup(source_name)
          --end,
          java = function() end, -- Disable Java handler completely
        },
      })
    end,
  },
}
