return {
  "mfussenegger/nvim-lint",
  enabled = true,
  lazy = true,
  event = {
    "InsertLeave",
    "InsertEnter",
  },
  config = function()
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        if vim.api.nvim_buf_get_name(0) == "" or vim.bo.buftype ~= "" then
          return
        end
        local ft = vim.bo.filetype
        local linters = require("lint").linters_by_ft[ft]
        if linters ~= nil and #linters > 0 then
          require("lint").try_lint()
        end
      end,
    })
  end,
  opts = {
    linters_by_ft = {
      python = { "pylint" },
      py = { "pylint" },
      javascript = { "quick-lint-js" },
      typescript = { "quick-lint-js" },
      javascriptreact = { "quick-lint-js" },
      typescriptreact = { "quick-lint-js" },
      lua = { "selene" },
      luau = { "selene" },
      bash = { "shellcheck" },
      sh = { "shellcheck" },
      zsh = { "shellcheck" },
      tf = { "tflint" },
      go = { "golangci_lint_ls" },
      xml = { "xmllint" },
    },
  },
  keys = {
    {
      "<leader>ml",
      function()
        require("lint").try_lint()
      end,
      mode = "n",
      desc = "Trigger linting for current file",
    },
  },
}
