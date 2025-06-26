return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason" },
    opts = {
      registries = {
        "github:nvim-java/mason-registry",
        "github:mason-org/mason-registry",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "gopls",
        "ts_ls",
        "terraformls",
        "lua_ls",
        "bashls",
        "texlab",
        "yamlls",
        "dockerls",
        "jsonls",
        "csharp_ls",
      },
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
        ensure_installed = { "java-debug-adapter", "java-test", "delve", "lombok-nightly", "go-debug-adapter", "delve" },
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
