local Remap = require("core.keymap")

local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

local opts = { silent = true, noremap = true }

nnoremap("<C-n>", ":NvimTreeToggle<CR>", opts)
nnoremap("<Esc><Esc>", ":nohl<CR>", opts)
vnoremap("<Esc><Esc>", ":nohl<CR>", opts)
nnoremap("Y", "y$")

nnoremap("<C-x>", ":ToggleTerm direction=float<CR>", opts)
nnoremap("<leader>gg", ":LazyGit<CR>", opts)

nnoremap("<leader>tt", ":TodoTrouble<CR>", opts)

nnoremap("<C-w>z", ":WindowsMaximize<CR>", opts)
