return {
    -- File Explorer
    { "nvim-tree/nvim-tree.lua", config = function()
        require("nvim-tree").setup()
    end },

    -- Status Line
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function()
        require("lualine").setup()
    end },

    -- Syntax Highlighting with Treesitter
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function()
        require("nvim-treesitter.configs").setup({
            highlight = { enable = true },
            ensure_installed = { "lua", "vim", "bash", "python" },
        })
    end },

    -- Fuzzy Finder
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = function()
        require("telescope").setup()
    end },

    { import = "plugins.parrot" },
}
