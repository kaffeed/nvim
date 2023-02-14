local nnoremap = require('keymap').nnoremap

local silent = { silent = true }

nnoremap('<leader>a', function()
    require('harpoon.mark').add_file()
end, silent)

nnoremap('<C-e>', ':Telescope harpoon marks<CR>', silent)

nnoremap('<C-j>', function()
    require('harpoon.ui').nav_file(1)
end, silent)
nnoremap('<C-k>', function()
    require('harpoon.ui').nav_file(2)
end, silent)
nnoremap('<C-l>', function()
    require('harpoon.ui').nav_file(3)
end, silent)
nnoremap('<C-;>', function()
    require('harpoon.ui').nav_file(4)
end, silent)
