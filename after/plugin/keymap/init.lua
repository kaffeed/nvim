local Remap = require("core.keymap")

local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

local opts = { silent = true, noremap = true }
nnoremap("<leader>u", ":UndotreeToggle<CR>", opts)
nnoremap("<C-n>", ":NvimTreeToggle<CR>", opts)
nnoremap("<Esc><Esc>", ":nohl<CR>", opts)
vnoremap("<Esc><Esc>", ":nohl<CR>", opts)

nnoremap("<C-t>", ":ToggleTerm direction=float<CR>", opts)
nnoremap("<leader>gg", ":LazyGit<CR>", opts)

