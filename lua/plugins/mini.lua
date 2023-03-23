return {
    -- TODO: configure keys for bracketed
    {
        'echasnovski/mini.bracketed',
        event = 'VeryLazy',
    },
    {
        'echasnovski/mini.bufremove',
        keys = {
            {
                '<leader>bd',
                function()
                    require('mini.bufremove').delete(0, false)
                end,
                desc = 'Delete Buffer',
            },
            {
                '<leader>bD',
                function()
                    require('mini.bufremove').delete(0, true)
                end,
                desc = 'Delete Buffer (Force)',
            },
        },
    },
    {
        'echasnovski/mini.animate',
        event = 'VeryLazy',
        enabled = false,
        config = function(_, _)
            require('mini.animate').setup()
        end,
    },
}
