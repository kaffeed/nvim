return {

    { 'nvim-lua/popup.nvim', event = 'VeryLazy' },

    {
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        config = function()
            require('Comment').setup()
        end,
    },

    { 'mbbill/undotree', event = 'VeryLazy' },

    {
        'tpope/vim-surround',
        event = 'BufReadPre',
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
