local vim = vim

-- Basic Options
vim.opt.number = true                -- Show line numbers
vim.opt.relativenumber = true        -- Show relative numbers
vim.opt.tabstop = 4                  -- Tab size
vim.opt.shiftwidth = 4               -- Indentation size
vim.opt.expandtab = true             -- Use spaces instead of tabs
vim.opt.smartindent = true           -- Smart indentation
vim.opt.wrap = false                 -- Disable line wrapping
vim.opt.swapfile = false             -- No swap files
vim.opt.backup = false               -- No backups
vim.opt.undofile = true              -- Persistent undo
vim.opt.hlsearch = false             -- No search highlight
vim.opt.incsearch = true             -- Incremental search
vim.opt.termguicolors = true         -- True color support

-- Leader Key
vim.g.mapleader = " "                -- Set leader key to Space
vim.g.maplocalleader = ","          -- Set leader key to Comma
