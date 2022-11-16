local Remap = require('core.keymap')

local nnoremap = Remap.nnoremap

local opts = { silent = true, noremap = true }

nnoremap('Y', 'y$')

nnoremap('<leader>tt', ':TodoTrouble<CR>', opts)

nnoremap('<C-w>z', ':WindowsMaximize<CR>', opts)

nnoremap(
    'f',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
    opts
)

nnoremap(
    'F',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
    opts
)

nnoremap(
    't',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
    opts
)

nnoremap(
    'T',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>",
    opts
)

-- Diffview stuff
nnoremap('<leader>gdo', ':DiffviewOpen<CR>', opts)
nnoremap('<leader>gdc', ':DiffviewClose<CR>', opts)
nnoremap('<leader>gdf', ':DiffviewFileHistory<CR>', opts)
nnoremap('<leader>gdr', ':DiffviewRefresh<CR>', opts)

nnoremap('<leader>td', ':Trouble document_diagnostics<CR>', opts)

nnoremap('<leader>bc', ':<C-U>bprevious <bar> bdelete #<CR>', opts)

nnoremap('<leader>nh', ':Noice history<CR>', opts)
nnoremap('<leader>nt', ':Noice telescope<cr>', opts)

nnoremap('<C-u>', '<C-u>zz')
nnoremap('<C-d>', '<C-d>zz')
nnoremap('n', 'nzz')
nnoremap('N', 'Nzz')

--
-- SymbolsOutline
-- nnoemap('<leader>cs', ':SymbolsOutline<CR>', opts)
--

nnoremap('<leader>tp', ':PomodoroStart<CR>', opts)
