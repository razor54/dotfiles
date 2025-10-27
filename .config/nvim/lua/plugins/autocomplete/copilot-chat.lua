return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = false,
    dependencies = {
      --{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
      { "Davidyz/VectorCode" }, -- Ensure VectorCode loads first
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- https://docs.github.com/en/copilot/using-github-copilot/ai-models/choosing-the-right-ai-model-for-your-task
      -- model = "claude-3.5-sonnet",
      model = "gpt-4.1",
      question_header = "  User ",
      answer_header = "  Copilot ",
      error_header = "  Error ",
      mappings = {
        complete = { insert = "<Tab>" },
        close = { normal = "q", insert = "<C-c>" },
        -- reset = { normal = "<C-r>", insert = "<C-r>" },
        reset = { normal = "<leader>cr", insert = "<C-r>" },
        submit_prompt = { normal = "<CR>", insert = "<C-s>" },
        toggle_sticky = { normal = "grr" },
        clear_stickies = { normal = "grx" },
        accept_diff = { normal = "<C-y>", insert = "<C-y>" },
        jump_to_diff = { normal = "gj" },
        quickfix_answers = { normal = "gqa" },
        quickfix_diffs = { normal = "gqd" },
        yank_diff = { normal = "gy", register = '"' },
        show_diff = { normal = "gd", full_diff = false },
        show_info = { normal = "gi" },
        show_context = { normal = "gc" },
        show_help = { normal = "gh" },
      },
      contexts = {}, -- Will be filled in config
      prompts = {
        Explain = {
          prompt = "Explain the following code in detail:\n$input",
          context = { "selection", "vectorcode" }, -- Add vectorcode to the context
        },
        -- Other prompts...
      },
      sticky = {
        "Using the model $claude-3.7-sonnet-thought",
        "#vectorcode", -- Automatically includes repository context in every conversation
      },
    },
    config = function(_, opts)
      -- Setup VectorCode context provider and inject into opts
      local ok, vectorcode = pcall(require, "vectorcode.integrations.copilotchat")
      if ok and vectorcode then
        opts.contexts.vectorcode = vectorcode.make_context_provider({
          prompt_header = "Here are relevant files from the repository:", -- Customize header text
          prompt_footer = "\nConsider this context when answering:", -- Customize footer text
          skip_empty = true, -- Skip adding context when no files are retrieved
        })
      else
        vim.notify("VectorCode integration not found!", vim.log.levels.WARN)
      end
      require("CopilotChat").setup(opts)
    end,
    keys = {
      -- { "<leader>cc", "<cmd>CopilotChat<cr>", desc = "Copilot Chat" },
      { "<leader>co", "<cmd>CopilotChatOpen<cr>", desc = "Copilot Chat Open" },
      -- { "<leader>cq", "<cmd>CopilotChatClose<cr>", desc = "Copilot Chat Close" },
      -- { "<leader>ct", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat Toggle" },
      -- { "<leader>cs", "<cmd>CopilotChatStop<cr>", desc = "Copilot Chat Stop" },
      { "<leader>cr", "<cmd>CopilotChatReset<cr>", desc = "Copilot Chat Reset" },
      -- { "<leader>cS", "<cmd>CopilotChatSave<cr>", desc = "Copilot Chat Save" },
      -- { "<leader>cL", "<cmd>CopilotChatLoad<cr>", desc = "Copilot Chat Load" },
      -- { "<leader>cp", "<cmd>CopilotChatPrompts<cr>", desc = "Copilot Chat Prompts" },
      -- { "<leader>cm", "<cmd>CopilotChatModels<cr>", desc = "Copilot Chat Models" },
      -- { "<leader>ca", "<cmd>CopilotChatAgents<cr>", desc = "Copilot Chat Agents" },
    },
    -- See Commands section for default commands if you want to lazy load on them
    --
    --Commands are used to control the chat interface:
    -- Command 	Description
    -- :CopilotChat <input>? 	Open chat with optional input
    -- :CopilotChatOpen 	Open chat window
    -- :CopilotChatClose 	Close chat window
    -- :CopilotChatToggle 	Toggle chat window
    -- :CopilotChatStop 	Stop current output
    -- :CopilotChatReset 	Reset chat window
    -- :CopilotChatSave <name>? 	Save chat history
    -- :CopilotChatLoad <name>? 	Load chat history
    -- :CopilotChatPrompts 	View/select prompt templates
    -- :CopilotChatModels 	View/select available models
    -- :CopilotChatAgents 	View/select available agents
    -- :CopilotChat<PromptName> 	Use specific prompt template
  },
}
