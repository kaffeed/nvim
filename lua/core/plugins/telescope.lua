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
            commands = {
                theme = 'ivy',
            },
            command_history = {
                theme = 'ivy',
            },
        },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            },
            ['ui-select'] = {
                require('telescope.themes').get_dropdown(),
            },
        },
    })

    telescope.load_extension('ui-select')
    telescope.load_extension('harpoon')
    telescope.load_extension('projects')
    telescope.load_extension('fzf')
end

return M
