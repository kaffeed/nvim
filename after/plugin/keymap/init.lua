local Remap = require('core.keymap')

local nnoremap = Remap.nnoremap

local opts = { silent = true, noremap = true }

nnoremap('<C-n>', ':NvimTreeToggle<CR>', opts)
nnoremap('Y', 'y$')

nnoremap('<C-x>', ':ToggleTerm direction=float<CR>', opts)
nnoremap('<leader>gg', ':LazyGit<CR>', opts)

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
