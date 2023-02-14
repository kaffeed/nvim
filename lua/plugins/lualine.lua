return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
            'SmiteshP/nvim-navic',
        },
        event = 'VeryLazy',
        config = function(_, _)
            local navic = require('nvim-navic')
            require('lualine').setup({
                options = {
                    theme = 'catppuccin',
                },
                tabline = {
                    lualine_b = { 'branch' },
                    lualine_c = { 'filename' },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = { 'tabs' },
                },
                winbar = {
                    lualine_c = {
                        { navic.get_location, cond = navic.is_available },
                    },
                },
            })
        end,
    },
}
