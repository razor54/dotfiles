-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--

-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

vim.keymap.set("n", "<c-x>", function()
    vim.cmd.bd()
end)

-- open aerial
vim.keymap.set("n", "<leader>.", function()
    vim.cmd("Outline")
end)

-- open new terminal tab with tt
vim.keymap.set("n", "tt", ":term<cr>")

-- NeoAI bindings
vim.keymap.set("n", "<leader>nn", ":NeoAIToggle<cr>")
vim.keymap.set("v", "<leader>nc", ":NeoAIContext<cr>")
vim.keymap.set("n", "<leader>ni", ":NeoAI<CR>")

-- setup restnvim keybindings
vim.keymap.set("n", "<leader>xr", "<Plug>RestNvim")
vim.keymap.set("n", "<leader>xp", "<Plug>RestNvimPreview")
vim.keymap.set("n", "<leader>xl", "<Plug>RestNvimLast")

-- goto-preview
vim.keymap.set("n", "gp", function()
    require("goto-preview").goto_preview_definition()
end)

-- no neck pain single keybinding
vim.keymap.set({ "n", "v" }, "<Leader>np", "<Cmd>NoNeckPain<CR>", opts)

-- gen nvim mappings
vim.keymap.set({ "n", "v" }, "<Leader>]", ":Gen<CR>", opts)

-- overseer commands
-- override old c-o to c-a
vim.api.nvim_set_keymap("n", "<c-a>", "<c-o>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<c-o>", function()
    vim.cmd("OverseerRun")
end, opts)

--
vim.keymap.set({ "n", "v" }, "<c-t>", function()
    vim.cmd("OverseerToggle")
end, opts)

-- no neck pain
vim.keymap.set({ "n", "v" }, "<c-m>", function()
    vim.cmd("NoNeckPain")
end)

--- META
-- open config file
vim.keymap.set({ "n", "v" }, "<leader>rc", ":e $MYVIMRC<cr>", opts)

-- open keymap file
vim.keymap.set({ "n", "v" }, "<leader>kb", ":e ~/.config/nvim/lua/config/keymaps.lua<cr>", opts)
