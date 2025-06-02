return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = false,
    dependencies = {
      --{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
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
