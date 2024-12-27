return {
    {
      "frankroeder/parrot.nvim",
      dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim", "rcarriga/nvim-notify" },
      config = function()
          local parrot = require("parrot")
          local plenary_path = require("plenary.path")
          local Job = require("plenary.job")

          parrot.setup({
              providers = {
                  anthropic = {
                      api_key = os.getenv "ANTHROPIC_API_KEY",
                      topic_prompt = "You only respond with 3 to 4 words to summarize the past conversation.",
                      topic = {
                          model = "claude-3-5-haiku-latest",
                          params = { max_tokens = 32 },
                      },
                      params = {
                          chat = { max_tokens = 4096 },
                          command = { max_tokens = 4096 },
                      },
                  },
              },
              hooks = {
                  SelfCheck = function(prt, params)
                      local template = [[
                      This is just a test to check the connectivity. Just reply with "Hello there" and nothing further
                      ]]
                      local model_obj = prt.get_model "command"
                      prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
                  end,
                  CodeReview = function(prt, params)
                      prt.logger.debug("REVIEW with: " .. vim.inspect(params))
                  end,
                  CompleteMultiContext = function(prt, params)
                    local template = [[
                    You are a code completer.

                    I have the following code from {{filename}} and other related files:

                    ```{{filetype}}
                    {{multifilecontent}}
                    ```

                    Please look at the following section specifically:
                    ```{{filetype}}
                    {{selection}}
                    ```

                    Use the knowledge from your entire knowledge base to finish the code above carefully and logically.
                    Respond just with the snippet of code that should be inserted.
                    Do not put it between markdown code snippet markers and do not explain what the code does.
                    Before the snipped which you generate, add a one-line comment according to the language you write in,
                    which starts with the word "BEGIN" and the current time in GMT and ISO 9601, continuing with
                    describing in a very short sentence any tricky parts. If there are no tricky parts, do not add a description, just BEGIN and time.
                    After the snipped you generate, add a one-line comment saying "END" and the current time in UTC according to ISO 8601.
                    ]]
                    local model_obj = prt.get_model "command"
                    prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
                  end,
                  Pair = function(prt, params)
                      local template = [[
                      You are a pair programmer for the user. As a pair programmer, you can be passive or active.
                      Depending on your role in the pair programming session, you have the following tasks:

                      Active:
                      - resolve TODOs by writing code
                      - resolve TODOs by refactoring code according to the specification, if the code does not implement 

                      Passive:
                      - resolve TODOs by adding comments to the existing code

                      How to recognize if you're active or passive:

                      Active: the TODO can be resolved by writing code. The TODO uses words like "write", "implement", "fix", "make it such", "rewrite" or "refactor" or "change"

                      Passive: the TODO asks you to explain or clarify something

                      As a pair programmer, you act only as prompted by TODOs written in comments and nothing else.

                      You also focus specifically on the selected code, acting on TODOs within it, but you take into consideration the entire code base when structuring your code or understanding the code.

                      Here is the current selection:

                      ```{{filetype}}
                      {{selection}}
                      ```

                      The selection is in the file {{filename}}, and here are all files in full:

                      ```{{filetype}}
                      {{multifilecontent}}
                      ```

                      Further considerations:

                      - respond with just the code if you are an active pair programmer; do not use any backticks to highlight or format code: you should write valid {{filetype}} code
                      - respond by adding, removing or rewording comments if you are a passive pair programmer, without changing executable code
                      - if you are active, prepend to your answer a comment starting with "BEGIN" and the current time
                      - if you are active, append to your answer a comment starting with "END" and the current time

                      ]]
                      local model_obj = prt.get_model "command"
                      prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
                  end
              },
          })
      end
    },
}

