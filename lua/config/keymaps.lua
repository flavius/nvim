local vim = vim
local keymap = vim.keymap.set

keymap("n", "<leader>w", ":w<CR>")    -- Save file
keymap("n", "<leader>q", ":q<CR>")    -- Quit Neovim
keymap("n", "<leader>e", ":e<CR>")    -- Open file
keymap("n", "<leader>f", ":Telescope find_files<CR>") -- Find files
keymap("n", "<leader>g", ":Telescope live_grep<CR>")  -- Live grep
keymap("v", "<localleader>p", ":'<,'>PrtPair<CR>")  -- Pair program with AI as prompted by TODOs in code
