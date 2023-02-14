return {
    {
        'jose-elias-alvarez/null-ls.nvim',
        event = 'VeryLazy',
        config = function(_, _)
            local nls = require('null-ls')
            local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

            nls.setup({
                sources = {
                    nls.builtins.formatting.stylua,
                    nls.builtins.code_actions.refactoring,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method('textDocument/formatting') then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr,
                        })
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({
                                    bufnr = bufnr,
                                    filter = function(c)
                                        return c.name == 'null-ls'
                                    end,
                                })
                            end,
                        })
                    end
                end,
            })
        end,
    },

    { 'nvim-lua/popup.nvim', event = 'VeryLazy' },

    {
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        config = function()
            require('Comment').setup()
        end,
    },

    { 'L3MON4D3/LuaSnip' },

    { 'mbbill/undotree', event = 'VeryLazy' },

    {
        'tpope/vim-surround',
        event = 'BufReadPre',
    },

    {
        'tpope/vim-fugitive',
        event = 'VeryLazy',
        cmd = {
            'G',
            'Git',
            'Gdiffsplit',
            'Gread',
            'Gwrite',
            'Ggrep',
            'GMove',
            'GDelete',
            'GBrowse',
            'GRemove',
            'GRename',
            'Glgrep',
            'Gedit',
        },
        ft = { 'fugitive' },
    },

    {
        'sindrets/diffview.nvim',
        event = 'VeryLazy',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },

    { 'rcarriga/nvim-notify', event = 'VeryLazy', config = true },
    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'VeryLazy',
        opts = {
            show_current_context = true,
            show_current_context_start = true,
            show_end_of_line = true,
        },
    },

    {
        'mfussenegger/nvim-jdtls',
        event = 'VeryLazy',
    },

    {
        'simrat39/symbols-outline.nvim',
        event = 'VeryLazy',
        config = true,
    },

    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    },

    { 'windwp/nvim-autopairs', config = true, event = 'VeryLazy' },

    {
        'echasnovski/mini.nvim',
        event = 'VeryLazy',
        config = function()
            require('mini.align').setup()
        end,
    },

    {
        'simrat39/inlay-hints.nvim',
        event = 'VeryLazy',
        config = function()
            require('inlay-hints').setup()
        end,
    },

    {
        'prichrd/netrw.nvim',
        event = 'VeryLazy',
        config = function()
            require('netrw').setup({
                _devicons = true,
            })
        end,
    },

    { 'tpope/vim-vinegar', event = 'VeryLazy' },

    { 'aduros/ai.vim' },

    {
        'Pocco81/true-zen.nvim',
        event = 'VeryLazy',
        config = true,
    },

    {
        'andymass/vim-matchup',
        event = 'VeryLazy',
        config = function(_, _)
            -- may set any options here
            vim.g.matchup_matchparen_offscreen = { method = 'popup' }
        end,
    },
}
