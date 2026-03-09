-- Renders ```mermaid``` blocks as inline images at the block position.
-- Requires: mmdc (npm i -g @mermaid-js/mermaid-cli), image.nvim, ImageMagick CLI.
-- Behavior:
-- - Cursor inside a mermaid block: show source text, hide rendered image.
-- - Cursor outside a mermaid block: hide source text, show rendered image.

return {
  "3rd/image.nvim",
  ft = { "markdown" },
  opts = {
    backend = "kitty",        -- WezTerm supports the Kitty Graphics Protocol
    processor = "magick_cli", -- uses `magick` CLI; no Lua rock needed
    integrations = {
      -- Disable built-in markdown handling; we manage mermaid blocks manually
      markdown = { enabled = false },
    },
    max_width = 80,
    max_height = 20,
    max_height_window_percentage = 40,
    max_width_window_percentage = 80,
  },
  config = function(_, opts)
    local image = require("image")
    image.setup(opts)

    local ns_conceal = vim.api.nvim_create_namespace("MermaidRenderConceal")

    local EXTRA_SPACER_LINES = 1

    -- bufnr -> { [block_start_row] = { block = <table>, img = <image|nil>, image_visible = <bool>, conceal_ids = <ids[]>, spacer_id = <id|nil> } }
    local buf_blocks = {}

    -- sha256(content) -> png file path.  Avoids re-running mmdc for unchanged diagrams.
    local png_cache = {}

    -- Per-buffer render generation counter.
    -- Incremented at the start of every render cycle.  Async mmdc callbacks capture
    -- this value and abort if it has advanced, preventing stale images being placed.
    local render_gen = {}

    -- Returns all ```mermaid ... ``` blocks in the buffer as a list of:
    --   { start = <0-indexed row of opening fence>,
    --     finish = <0-indexed row of closing fence>,
    --     content = <diagram source as string> }
    local function find_mermaid_blocks(bufnr)
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local blocks = {}
      local i = 1
      while i <= #lines do
        if lines[i]:match("^%s*```mermaid") then
          local block_start = i - 1  -- lua lines are 1-indexed; nvim API is 0-indexed
          local content = {}
          i = i + 1
          while i <= #lines and not lines[i]:match("^%s*```%s*$") do
            table.insert(content, lines[i])
            i = i + 1
          end
          local block_finish = i - 1
          if #content > 0 then
            table.insert(blocks, {
              start   = block_start,
              finish  = block_finish,
              content = table.concat(content, "\n"),
            })
          end
        end
        i = i + 1
      end
      return blocks
    end

    local function clear_block_conceal(bufnr, entry)
      if not entry.conceal_ids then return end
      for _, id in ipairs(entry.conceal_ids) do
        pcall(vim.api.nvim_buf_del_extmark, bufnr, ns_conceal, id)
      end
      entry.conceal_ids = {}
      if entry.spacer_id then
        pcall(vim.api.nvim_buf_del_extmark, bufnr, ns_conceal, entry.spacer_id)
        entry.spacer_id = nil
      end
    end

    local function hide_block_source(bufnr, entry)
      if entry.conceal_ids and #entry.conceal_ids > 0 then return end
      entry.conceal_ids = {}

      for row = entry.block.start, entry.block.finish do
        local id = vim.api.nvim_buf_set_extmark(bufnr, ns_conceal, row, 0, {
          end_row = row + 1,
          end_col = 0,
          conceal = "",
        })
        table.insert(entry.conceal_ids, id)
      end

      if EXTRA_SPACER_LINES > 0 then
        local filler = {}
        for _ = 1, EXTRA_SPACER_LINES do
          filler[#filler + 1] = { { " ", "" } }
        end
        entry.spacer_id = vim.api.nvim_buf_set_extmark(bufnr, ns_conceal, entry.block.finish, 0, {
          virt_lines = filler,
          virt_lines_above = false,
        })
      end
    end

    local function clear_buf_state(bufnr)
      for _, entry in pairs(buf_blocks[bufnr] or {}) do
        if entry.img then pcall(function() entry.img:clear() end) end
        clear_block_conceal(bufnr, entry)
      end
      buf_blocks[bufnr] = {}
    end

    local function cursor_in_block(row0, block)
      return row0 >= block.start and row0 <= block.finish
    end

    local function show_image(bufnr, entry)
      if entry.image_visible then return end
      if entry.img then pcall(function() entry.img:render() end) end
      hide_block_source(bufnr, entry)
      entry.image_visible = true
    end

    local function show_source(bufnr, entry)
      if not entry.image_visible then
        clear_block_conceal(bufnr, entry)
        return
      end
      if entry.img then pcall(function() entry.img:clear() end) end
      clear_block_conceal(bufnr, entry)
      entry.image_visible = false
    end

    local function update_cursor_visibility(bufnr)
      if not vim.api.nvim_buf_is_valid(bufnr) then return end
      local winid = vim.api.nvim_get_current_win()
      if not vim.api.nvim_win_is_valid(winid) then return end
      if vim.api.nvim_win_get_buf(winid) ~= bufnr then return end

      vim.wo[winid].conceallevel = 2
      vim.wo[winid].concealcursor = "nc"

      local row0 = vim.api.nvim_win_get_cursor(winid)[1] - 1
      for _, entry in pairs(buf_blocks[bufnr] or {}) do
        if cursor_in_block(row0, entry.block) then
          show_source(bufnr, entry)
        else
          show_image(bufnr, entry)
        end
      end
    end

    -- Render one mermaid block and place the resulting image at the opening fence row.
    -- `gen` is the generation captured when this render cycle started; the function
    -- will abort silently at any point if the generation has since advanced.
    local function render_block(bufnr, winid, block, entry, gen)

      local function place_image(png_path)
        if render_gen[bufnr] ~= gen then return end               -- stale cycle
        if not vim.api.nvim_buf_is_valid(bufnr) then return end
        if not vim.api.nvim_win_is_valid(winid) then return end

        if entry.img then pcall(function() entry.img:clear() end) end

        local ok, img = pcall(image.from_file, png_path, {
          id     = string.format("mermaid_%d_%d", bufnr, block.start),
          window = winid,
          buffer = bufnr,
          y      = block.start,
          x      = 0,
          inline = true,
          with_virtual_padding = false,
        })
        if ok and img then
          entry.img = img
          entry.image_visible = false
          update_cursor_visibility(bufnr)
        end
      end

      -- Use the cached PNG if we've already rendered this exact diagram content
      local key    = vim.fn.sha256(block.content)
      local cached = png_cache[key]
      if cached and vim.fn.filereadable(cached) == 1 then
        place_image(cached)
        return
      end

      -- Otherwise run mmdc asynchronously (vim.system, Neovim 0.10+).
      -- Async keeps the UI responsive; the generation check prevents races.
      local mmd_file = vim.fn.tempname() .. ".mmd"
      local png_file = vim.fn.tempname() .. ".png"
      vim.fn.writefile(vim.split(block.content, "\n"), mmd_file)

      vim.system(
        { "mmdc", "-i", mmd_file, "-o", png_file, "--backgroundColor", "transparent" },
        {},
        function(result)
          if result.code ~= 0 then return end
          if render_gen[bufnr] ~= gen then return end  -- stale, discard result
          png_cache[key] = png_file
          -- vim.schedule: brings us back to the main Neovim event loop
          -- before touching any Neovim state (required for async callbacks)
          vim.schedule(function() place_image(png_file) end)
        end
      )
    end

    -- Full render pass: scan the buffer, bump the generation, clear old state,
    -- and kick off a render for each mermaid block found.
    local function render_buffer(bufnr, winid)
      if not vim.api.nvim_buf_is_valid(bufnr) then return end
      if not vim.api.nvim_win_is_valid(winid) then return end

      -- Advance generation so any in-flight async callbacks from the previous
      -- cycle will abort when they check render_gen[bufnr] != gen.
      render_gen[bufnr] = (render_gen[bufnr] or 0) + 1
      local gen = render_gen[bufnr]

      clear_buf_state(bufnr)
      buf_blocks[bufnr] = {}

      local blocks = find_mermaid_blocks(bufnr)
      for _, block in ipairs(blocks) do
        local entry = {
          block = block,
          img = nil,
          image_visible = false,
          conceal_ids = {},
          spacer_id = nil,
        }
        buf_blocks[bufnr][block.start] = entry
        render_block(bufnr, winid, block, entry, gen)
      end

      update_cursor_visibility(bufnr)
    end

    -- Lightweight debounce: coalesce multiple rapid events (e.g. several
    -- BufWritePost triggers) into a single render 300 ms after the last one.
    local timers = {}
    local function schedule_render(bufnr, winid)
      if timers[bufnr] then
        timers[bufnr]:stop()
        timers[bufnr] = nil
      end
      timers[bufnr] = vim.defer_fn(function()
        timers[bufnr] = nil
        if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_get_current_buf() == bufnr then
          render_buffer(bufnr, winid)
        end
      end, 300)
    end

    local group = vim.api.nvim_create_augroup("MermaidRender", { clear = true })

    -- Render when opening or saving a markdown file
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group   = group,
      pattern = { "*.md", "*.markdown" },
      callback = function(ev)
        schedule_render(ev.buf, vim.api.nvim_get_current_win())
      end,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group   = group,
      pattern = { "*.md", "*.markdown" },
      callback = function(ev)
        update_cursor_visibility(ev.buf)
      end,
    })

    -- Clear images when leaving the buffer.
    -- Also bumps the generation so any in-flight mmdc processes won't place
    -- images into a buffer the user has already left.
    vim.api.nvim_create_autocmd("BufLeave", {
      group   = group,
      pattern = { "*.md", "*.markdown" },
      callback = function(ev)
        render_gen[ev.buf] = (render_gen[ev.buf] or 0) + 1
        clear_buf_state(ev.buf)
      end,
    })
  end,
}
