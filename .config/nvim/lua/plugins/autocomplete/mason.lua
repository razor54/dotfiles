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
      },
      automatic_enable = {
        exclude = { "jdtls" }, -- Exclude servers you want manual control
      },
    },
  },
}
