local M = {}

M.setup = function()
    local telescope = require('telescope')
    local trouble = require('trouble.providers.telescope')
    telescope.setup({
        defaults = {
            mappings = {
                i = { ['<c-t>'] = trouble.open_with_trouble },
                n = { ['<c-t>'] = trouble.open_with_trouble },
            },
        },
        pickers = {
            find_files = {
                theme = 'dropdown',
            },
            buffers = {
                theme = 'dropdown',
            },
            oldfiles = {
                theme = 'dropdown',
            },
            git_branches = {
                theme = 'dropdown',
            },
            git_status = {
                theme = 'dropdown',
            },
            grep_string = {
                theme = 'dropdown',
            },
        },
        extensions = {
            ['ui-select'] = {
                require('telescope.themes').get_cursor(),
            },
        },
    })

    telescope.load_extension('ui-select')
end

return M
