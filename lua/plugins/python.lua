return {
    -- LSP (Language Server Protocol) Support
    { "neovim/nvim-lspconfig", config = function()
        local lspconfig = require("lspconfig")
        lspconfig.pyright.setup({})  -- Python language server
    end },

    -- Auto-completion
    { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp" }, config = function()
        local cmp = require("cmp")
        cmp.setup({
            mapping = {
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            },
            sources = {
                { name = "nvim_lsp" },
            },
        })
    end },

    -- Snippet Support
    { "L3MON4D3/LuaSnip", config = function()
        require("luasnip").setup({})
    end },
    { "saadparwaiz1/cmp_luasnip" }, -- Snippet completions

    -- Python Virtual Environment Support
    { "mfussenegger/nvim-dap-python", config = function()
        local dap_python = require("dap-python")
        dap_python.setup("~/.virtualenvs/debugpy/bin/python")
    end },
}
