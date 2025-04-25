-- knap for live PDF preview
return {
  --"frabjous/knap",
  --ft = { "tex" },
  --config = function()
  --  vim.g.knap_settings = {
  --    texoutputext = "pdf",
  --    textopdf = "latexmk -pdf %srcfile%",
  --    textopdfviewerlaunch = "zathura %outputfile%",
  --    textopdfviewerrefresh = "none", -- Zathura auto-refreshes on file change
  --    textopdfbufferasstdin = false,

  --    --texoutputext = "pdf",
  --    --textopdf = "latexmk -pdf %srcfile%",
  --    --textopdfviewerlaunch = "zathura %outputfile%",
  --    --textopdfviewerrefresh = "none", -- Zathura auto-refreshes on file change
  --    --textopdfbufferasstdin = false,
  --  }
  --  vim.api.nvim_create_autocmd("FileType", {
  --    pattern = { "tex" },
  --    callback = function()
  --      vim.keymap.set("n", "<leader>kt", function()
  --        require("knap").toggle_autopreviewing()
  --      end, { buffer = true, desc = "KNAP toggle auto-preview" })
  --    end,
  --  })
  --end,
}
