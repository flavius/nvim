return {
    {
      "frankroeder/parrot.nvim",
      dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim", "rcarriga/nvim-notify" },
      -- opts = {},
      config = function()
          local parrot = require("parrot")
          parrot.setup({
              providers = {
                  anthropic = {
                      api_key = os.getenv "ANTHROPIC_API_KEY",
                      topic_prompt = "You only respond with 3 to 4 words to summarize the past conversation.",
                      topic = {
                          model = "claude-3-5-haiku-latest",
                          params = { max_tokens = 32 },
                      },
                      -- default parameters for the actual model
                      params = {
                          chat = { max_tokens = 4096 },
                          command = { max_tokens = 4096 },
                      },
                  },
                  -- chat_conceal_model_params = false,
                  -- online_model_selection = true,
              },
              hooks = {
                  SelfCheck = function(prt, params)
                      local template = [[
                      This is just a test to check the connectivity. Just reply with "Hello there" and nothing further
                      ]]
                      local model_obj = prt.get_model "command"
                      prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
                  end,
              },
          })
      end
    },
}
