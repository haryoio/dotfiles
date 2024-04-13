return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "robitx/gp.nvim",
    cmd = {
      "GpChatNew",
      "GpChatPaste",
      "GpChatToggle",
      "GpChatFinder"
    },
    config = function()
      require("gp").setup({
        openai_api_key = os.getenv("OPENAI_API_KEY"),
 	      openai_api_endpoint = "https://api.openai.com/v1/chat/completions",
        cmd_prefix = "Gp",
        agents = {
 	  	    {
 	  	    	name = "ChatGPT4",
 	  	    	chat = true,
 	  	    	command = true,
 	  	    	model = { model = "gpt-4-turbo", temperature = 1.1, top_p = 1 },
 	  	    },
        },
      })
    end,
  },
  {
    "Bryley/neoai.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    cmd = {
        "NeoAI",
        "NeoAIOpen",
        "NeoAIClose",
        "NeoAIToggle",
        "NeoAIContext",
        "NeoAIContextOpen",
        "NeoAIContextClose",
        "NeoAIInject",
        "NeoAIInjectCode",
        "NeoAIInjectContext",
        "NeoAIInjectContextCode",
    },
    config = function()
        require("neoai").setup({
            ui = {
              output_popup_text = "CHAT",
              input_popup_text = "Prompt",
              width = 20,
              output_popup_height = 80,
              submit = "<Enter>",
            },
            models = {
              {
                name = "openai",
                model = "gpt-4-turbo",
                params = nil,
              },
            },
        })
    end,
  }
}
