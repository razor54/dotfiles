return {
  "mfussenegger/nvim-jdtls",
  ft = "java", -- lazy load on java filetype
  module = "jdtls", -- also load when require("jdtls") is called
  dependencies = {
    "mfussenegger/nvim-dap",
  },
}
