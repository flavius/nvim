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
                  },
              },
          })
      end
    },
}
