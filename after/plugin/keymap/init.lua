local Remap = require('keymap')

local nnoremap = Remap.nnoremap

local opts = { silent = true, noremap = true }

nnoremap('Y', 'y$')

nnoremap('<leader>tt', ':TodoTrouble<CR>', opts)

nnoremap('<C-w>z', ':WindowsMaximize<CR>', opts)

-- Diffview stuff
nnoremap('<leader>gdo', ':DiffviewOpen<CR>', opts)
nnoremap('<leader>gdc', ':DiffviewClose<CR>', opts)
nnoremap('<leader>gdf', ':DiffviewFileHistory<CR>', opts)
nnoremap('<leader>gdr', ':DiffviewRefresh<CR>', opts)

vim.keymap.set(
    '',
    '<Esc>',
    "<ESC>:noh<CR>:lua require('notify').dismiss()<CR>",
    { silent = true }
)

nnoremap('<leader>td', ':Trouble document_diagnostics<CR>', opts)

nnoremap('<leader>bc', ':<C-U>bprevious <bar> bdelete #<CR>', opts)

nnoremap('<C-u>', '<C-u>zz')
nnoremap('<C-d>', '<C-d>zz')
nnoremap('n', 'nzz')
nnoremap('N', 'Nzz')

nnoremap('<leader>gg', ':G<CR>', opts)

nnoremap('<leader>tz', require('config.util').select_zen_mode, opts)
