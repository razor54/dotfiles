return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = false,
    dependencies = {
      --{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "zbirenbaum/copilot.lua" },

      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
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
        complete = {
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-r>",
          insert = "<C-r>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        toggle_sticky = {
          normal = "grr",
        },
        clear_stickies = {
          normal = "grx",
        },
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        jump_to_diff = {
          normal = "gj",
        },
        quickfix_answers = {
          normal = "gqa",
        },
        quickfix_diffs = {
          normal = "gqd",
        },
        yank_diff = {
          normal = "gy",
          register = '"', -- Default register to use for yanking
        },
        show_diff = {
          normal = "gd",
          full_diff = false, -- Show full diff instead of unified diff when showing diff window
        },
        show_info = {
          normal = "gi",
        },
        show_context = {
          normal = "gc",
        },
        show_help = {
          normal = "gh",
        },
      },
    },
    config = function(_, opts)
      local vectorcode_ctx = require("vectorcode.integrations.copilotchat").make_context_provider({
        prompt_header = "Here are relevant files from the repository:", -- Customize header text
        prompt_footer = "\nConsider this context when answering:", -- Customize footer text
        skip_empty = true, -- Skip adding context when no files are retrieved
      })

      require("CopilotChat").setup({
        -- Your other CopilotChat options...

        contexts = {
          -- Add the VectorCode context provider
          vectorcode = vectorcode_ctx,
        },

        -- Enable VectorCode context in your prompts
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
      })
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
