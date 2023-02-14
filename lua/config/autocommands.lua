local augroup = vim.api.nvim_create_augroup

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 200,
        })
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {
        'OverseerForm',
        'OverseerList',
        'checkhealth',
        'floggraph',
        'fugitive',
        'git',
        'help',
        'lspinfo',
        'man',
        'neotest-output',
        'neotest-summary',
        'qf',
        'query',
        'spectre_panel',
        'startuptime',
        'toggleterm',
        'tsplayground',
        'vim',
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set(
            'n',
            'q',
            '<cmd>close<cr>',
            { buffer = event.buf, silent = true }
        )
    end,
})

vim.api.nvim_create_user_command(
    'TelescopeFindFiles',
    'Telescope find_files',
    {}
)
