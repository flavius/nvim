return {
    {
      "frankroeder/parrot.nvim",
      dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim", "rcarriga/nvim-notify" },
      config = function()
          local parrot = require("parrot")
          local plenary_path = require("plenary.path")
          local Job = require("plenary.job")

          function iso8601(timestamp)
            local integral = math.floor(timestamp)
            local microseconds = math.floor((timestamp - integral) * 1e6)
            return ("%s_%06dZ"):format(os.date("!%Y_%m_%dT%H_%M_%S", integral), microseconds)
          end
          function interp(s, tab)
              return (s:gsub('($%b{})', function(w) return tab[w:sub(3, -2)] or w end))
          end
          -- TODO: how to call the function iso8601?

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
                  -- TODO: you are an expert in prompt engineering and your task is to rewrite the template according to best practices.
                  Pair = function(prt, params)
                      local current_time = iso8601(os.time() + (os.clock() % 1))
                      local template = [[
                      You are an expert AI pair programmer focused on code improvement and collaboration. Your role adapts based on the context:
                  
                      ROLE DEFINITION:
                      1. Active Contributor (when TODO contains: write/implement/fix/refactor/change/rewrite)
                         - Implement new code solutions
                         - Refactor existing code to meet specifications
                         - Fix identified issues
                         - Maintain consistent code style and patterns
                  
                      2. Code Reviewer (when TODO asks for explanation/clarification)
                         - Provide detailed code comments
                         - Explain implementation decisions
                         - Clarify complex logic
                         - Document edge cases
                  
                      CONTEXT AWARENESS:
                      - Focus on the specific code selection
                      - Consider the entire codebase for consistency
                      - Respect existing patterns and conventions
                  
                      SELECTION CONTEXT:
                      ```{{filetype}}
                      {{selection}}
                      ```
                  
                      FILE LOCATION: {{filename}}
                  
                      FULL CODEBASE CONTEXT:
                      ```{{filetype}}
                      {{multifilecontent}}
                      ```
                  
                      RESPONSE FORMAT:
                      Active Role: 
                      - Clean code only, no formatting markers
                      - Start with: "-- BEGIN <ISO8601_TIMESTAMP>"
                      - End with: "-- END <ISO8601_TIMESTAMP>"
                  
                      Passive Role:
                      - Comments only, no code changes
                      - Focus on clarity and completeness

                      Further considerations:

                      - current time is: ${current_time}
                      - do not state in your response whether you act as passive or active
                      ]]
                      template = interp(template, {current_time = current_time})
                      local model_obj = prt.get_model "command"
                      prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
                  end
              },
          })
      end
    },
}

