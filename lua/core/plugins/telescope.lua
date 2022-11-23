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
                theme = 'ivy',
            },
            buffers = {
                theme = 'ivy',
            },
            oldfiles = {
                theme = 'ivy',
            },
            git_branches = {
                theme = 'ivy',
            },
            git_status = {
                theme = 'ivy',
            },
            grep_string = {
                theme = 'ivy',
            },
        },
        extensions = {
            ['ui-select'] = {
                require('telescope.themes').get_dropdown(),
            },
        },
    })

    telescope.load_extension('ui-select')
    telescope.load_extension('harpoon')
end

return M
