return {
    {
        'folke/styler.nvim',
        event = 'VeryLazy',
        config = function()
            require('styler').setup({
                themes = {
                    markdown = { colorscheme = 'gruvbox' },
                    help = { colorscheme = 'gruvbox' },
                },
            })
        end,
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            local tokyonight = require('tokyonight')
            tokyonight.setup({ style = 'storm' })
        end,
    },
    {
        'catppuccin/nvim',
        lazy = false,
        priority = 1000,
        name = 'catppuccin',
        config = function()
            require('catppuccin').setup({
                flavour = 'macchiato',
                show_end_of_buffer = true, -- show the '~' characters after the end of buffers
            })
            vim.cmd([[ colorscheme catppuccin ]])
        end,
    },
    {
        'ellisonleao/gruvbox.nvim',
        lazy = false,
        config = function()
            require('gruvbox').setup()
        end,
    },
}
