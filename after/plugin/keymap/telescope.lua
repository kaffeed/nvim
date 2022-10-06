local Remap = require('core.keymap')
local nnoremap = Remap.nnoremap

nnoremap('<leader>ff', function()
    require('telescope.builtin').find_files()
end)

nnoremap('<leader>fr', function()
    require('telescope.builtin').oldfiles()
end)

nnoremap('<leader>gf', function()
    require('telescope.builtin').git_files()
end)

nnoremap('<leader>ss', function()
    require('telescope.builtin').live_grep()
end)

nnoremap('<leader>sw', function()
    require('telescope.builtin').grep_string({
        search = vim.fn.expand('<cword>'),
    })
end)

nnoremap('<leader>bb', function()
    require('telescope.builtin').buffers()
end)

nnoremap('<leader>hf', function()
    require('telescope.builtin').help_tags()
end)
