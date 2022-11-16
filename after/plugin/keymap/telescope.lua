local Remap = require('core.keymap')
local nnoremap = Remap.nnoremap

nnoremap('<Space>ff', require('telescope.builtin').find_files)

nnoremap('<Space>fr', require('telescope.builtin').oldfiles)

nnoremap('<Space>gf', require('telescope.builtin').git_files)

nnoremap('<Space>ss', require('telescope.builtin').live_grep)

nnoremap('<Space>sw', function()
    require('telescope.builtin').grep_string({
        search = vim.fn.expand('<cword>'),
    })
end)

nnoremap('<Space>bb', require('telescope.builtin').buffers)

nnoremap('<Space>hf', require('telescope.builtin').help_tags)

nnoremap('<Space>p', require('telescope.builtin').commands)

nnoremap('<C-y>', require('telescope.builtin').registers)
