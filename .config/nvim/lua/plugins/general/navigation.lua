-- Default Plugin Keybindings (for reference)
--
-- Telescope:
--   Custom:
--     <leader>ff : Find files
--     <leader>fg : Live grep
--     <leader>fb : Find buffers
--     <leader>fh : Help tags
--   Defaults (inside Telescope prompt):
--     <C-n> / <Down>    : Next item
--     <C-p> / <Up>      : Previous item
--     <C-c>             : Close
--     <CR>              : Select
--     <C-x>             : Select horizontal split
--     <C-v>             : Select vertical split
--     <C-t>             : Select in new tab
--     <C-u>             : Scroll up preview
--     <C-d>             : Scroll down preview
--     <PageUp>          : Scroll up results
--     <PageDown>        : Scroll down results
--     <Tab>             : Toggle selection + move down
--     <S-Tab>           : Toggle selection + move up
--
-- Harpoon:
--   Custom:
--     <leader>ha : Add file to harpoon
--     <C-e>      : Toggle harpoon menu
--   Defaults (Harpoon menu):
--     <C-v>      : Open file in vertical split
--     <C-x>      : Open file in horizontal split
--     <C-t>      : Open file in new tab
--     <C-d>      : Remove file from list
--     <Up>/<Down>: Navigate list
--
-- Oil:
--   Custom:
--     -        : Open parent directory
--   Defaults (Oil buffer):
--     <CR>     : Open file/directory
--     <C-v>    : Open in vertical split
--     <C-x>    : Open in horizontal split
--     <C-t>    : Open in new tab
--     ..       : Go up directory
--     q        : Quit Oil
--     g?       : Show help

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    event = "VeryLazy",
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          path_display = { "truncate" },
          file_ignore_patterns = { "node_modules", ".git/" },
        },
      })
      telescope.load_extension("fzf")

      -- Keymaps
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", function()
        require("telescope.builtin").find_files({ hidden = true })
      end, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():add()
      end, { desc = "Add file to harpoon" })
      vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Toggle harpoon menu" })

      vim.keymap.set("n", "<C-h>", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<C-t>", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<C-n>", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<C-s>", function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<C-S-P>", function()
        harpoon:list():prev()
      end)
      vim.keymap.set("n", "<C-S-N>", function()
        harpoon:list():next()
      end)

      -- basic telescope configuration
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end

      vim.keymap.set("n", "<C-e>", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Open harpoon window" })
    end,
  },
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      columns = {
        "icon",
        "size",
        "mtime",
      },
    },
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },
  },
}
