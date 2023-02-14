return {
    {
        'folke/todo-comments.nvim',
        cmd = { 'TodoTrouble', 'TodoTelescope' },
        event = 'BufReadPost',
        config = true,
        keys = {
            {
                ']t',
                function()
                    require('todo-comments').jump_next()
                end,
                desc = 'Next ToDo',
            },
            {
                '[t',
                function()
                    require('todo-comments').jump_prev()
                end,
                desc = 'Previous ToDo',
            },
            { '<leader>tt', '<cmd>TodoTrouble<cr>', desc = 'ToDo (Trouble)' },
            { '<leader>tT', '<cmd>TodoTelescope<cr>', desc = 'ToDo' },
        },
    },
}
