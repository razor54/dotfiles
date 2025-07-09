---@diagnostic disable: undefined-global
return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  dependencies = {
    --"nvim-tree/nvim-web-devicons" -- For better icon compatibility
  },
  cmd = "Snacks",
  config = function()
    require("snacks").setup({
      words = { enabled = false },
      notifier = { enabled = true },

      bigfile = { enabled = true, disabled = { "latex", "markdown" } },
      quickfile = { enabled = true },
      gitbrowse = { enabled = true },
      indent = { enabled = true },
      scroll = { enabled = true },
      explorer = { enabled = true },
      picker = {
        sources = {
          explorer = {
            win = {
              list = {
                keys = {
                  ["o"] = "confirm",
                  --["<CR>"] = "open",
                  --["y"] = "copy_file_path",
                  --["s"] = "search_in_directory",
                  --["D"] = "diff",
                  --["o"] = false, -- this disables bind key
                },
              },
            },
            hidden = true,
            ignored = true,
            actions = {},
          },
          files = { hidden = true, ignored = false },
          grep = {
            hidden = true,
            ignored = false,
            show_context = true,
            search_dirs = {
              -- Search in git root or current directory
              function()
                local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
                return git_root or vim.fn.getcwd()
              end,
            },
            on_start = function(search_query, opts)
              local search_dir = opts.cwd or vim.fn.getcwd()
              vim.notify(string.format("Searching for '%s' in %s", search_query, search_dir), "info", {
                title = "Grep Search",
                timeout = 2000,
              })
            end,
          },
        },
      },

      terminal = {
        win = {
          keys = {
            term_normal = {
              "<esc><esc>",
              function()
                return "<C-\\><C-n>"
              end,
              mode = "t",
              expr = true,
              desc = "Double escape to normal mode",
            },
            q = "hide",
            ["<esc>"] = "hide",
          },
        },
      },

      styles = {
        terminal = {
          height = 15,
        },
      },

      statuscolumn = {
        enabled = true,
        left = { "mark", "sign" }, -- priority of signs on the left (high to low)
        right = { "git" }, -- priority of signs on the right (high to low)
        folds = {
          open = true, -- show open fold icons
          git_hl = true, -- use Git Signs hl for fold icons
        },
        git = {
          patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 200, -- refresh at most every 50ms
      },
      win = {
        show = true,
        relative = "editor",
        minimal = true,
        wo = {
          cursorcolumn = true,
          cursorline = true,
          cursorlineopt = "both",
          fillchars = "eob: ,lastline:…",
          list = false,
          listchars = "extends:…,tab:  ",
          number = false,
          relativenumber = false,
          signcolumn = "no",
          spell = false,
          winbar = "",
          winhighlight = "Normal:SnacksDashboardNormal,NormalFloat:SnacksDashboardNormal",
          statuscolumn = "",
          wrap = false,
          sidescrolloff = 0,
        },
        bo = {},
        keys = {
          q = "close",
          -- o = "confirm",
          --["o"] = "close",
        },
      },
      dashboard = {
        row = nil, -- dashboard position. nil for center
        col = nil, -- dashboard position. nil for center},
        preset = {
          --header = "                                                   oooooooo       .o   \n" ..
          --    "                                                  dP\"\"\"\"\"\"\"     .d88   \n" ..
          --    "oooo d8b  .oooo.     oooooooo  .ooooo.  oooo d8b d88888b.     .d'888   \n" ..
          --    "`888\"\"8P `P  )88b   d'\"\"7d8P  d88' `88b `888\"\"8P     `Y88b  .d'  888   \n" ..
          --    " 888      .oP\"888     .d8P'   888   888  888           ]88  88ooo888oo \n" ..
          --    " 888     d8(  888   .d8P'  .P 888   888  888     o.   .88P       888   \n" ..
          --    "d888b    `Y888\"\"8o d8888888P  `Y8bod8P' d888b    `8bd88P'       o888o  "
          --,
          header = "                          _____ _  _  \n"
            .. "                         | ____| || | \n"
            .. "  _ __ __ _ _______  _ __| |__ | || |_\n"
            .. " | '__/ _` |_  / _ \\| '__|___ \\|__   _|\n"
            .. " | | | (_| |/ / (_) | |   ___) |  | |  \n"
            .. " |_|  \\__,_/___\\___/|_|  |____/   |_|  ",

          keys = {
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            {
              icon = " ",
              key = "g",
              desc = "Find Text",
              action = ":lua Snacks.dashboard.pick('live_grep')",
            },
            {
              icon = " ",
              key = "r",
              desc = "Recent Files",
              action = ":lua Snacks.dashboard.pick('oldfiles')",
            },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
          },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        sections = {
          { section = "header" },
          {
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = vim.fn.isdirectory(".git") == 1,
            cmd = "git status --short --branch --renames",
            pane = 2,
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          {
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            pane = 2,
            indent = 2,
            padding = { 2, 2 },
          },
          { section = "keys", gap = 1, padding = 1 },
          { title = "Bookmarks", padding = 1, pane = 2 },
          { section = "startup", pane = 1 },
        },
      },
    })
  end,
  keys = {
    -- Top Pickers & Explorer
    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "File Explorer",
    },
    {
      "<leader>f",
      function()
        Snacks.explorer.reveal()
      end,
      desc = "File Explorer",
    },
    -- find
    {
      "<leader>b",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config File",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find Git Files",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Projects",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent",
    },
    -- git
    {
      "<leader>gb",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Git Branches",
    },
    {
      "<leader>gl",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Git Log",
    },
    {
      "<leader>gL",
      function()
        Snacks.picker.git_log_line()
      end,
      desc = "Git Log Line",
    },
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git Status",
    },
    {
      "<leader>gS",
      function()
        Snacks.picker.git_stash()
      end,
      desc = "Git Stash",
    },
    {
      "<leader>gD",
      function()
        Snacks.picker.git_diff()
      end,
      desc = "Git Diff (Hunks)",
    },
    {
      "<leader>gf",
      function()
        Snacks.picker.git_log_file()
      end,
      desc = "Git Log File",
    },
    -- Grep
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Grep current buffer lines",
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep Open Buffers",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },
    -- search
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>s/",
      function()
        Snacks.picker.search_history()
      end,
      desc = "Search History",
    },
    {
      "<leader>sa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "Autocmds",
    },
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>sC",
      function()
        Snacks.picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>sD",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Buffer Diagnostics",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help Pages",
    },
    {
      "<leader>sH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Highlights",
    },
    {
      "<leader>si",
      function()
        Snacks.picker.icons()
      end,
      desc = "Icons",
    },
    {
      "<leader>sj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "Jumps",
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>sl",
      function()
        Snacks.picker.loclist()
      end,
      desc = "Location List",
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.man()
      end,
      desc = "Man Pages",
    },
    {
      "<leader>sp",
      function()
        Snacks.picker.lazy()
      end,
      desc = "Search for Plugin Spec",
    },
    {
      "<leader>sq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Quickfix List",
    },
    {
      "<leader>sR",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },
    {
      "<leader>U",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo History",
    },
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    {
      "<leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>br",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
      mode = { "n", "v" },
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
    {
      "<c-/>",
      function()
        Snacks.terminal()
      end,
      desc = "Toggle Terminal",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },
  },
}
