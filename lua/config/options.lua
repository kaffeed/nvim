vim.g.mapleader = ' '

local options = {
    backup = false, -- creates a backup file
    clipboard = 'unnamedplus', -- allows neovim to access the system clipboard
    fileencoding = 'utf-8', -- the encoding written to a file
    hidden = true, -- required to keep multiple buffers and open multiple buffers
    hlsearch = true, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    mouse = 'a', -- allow the mouse to be used in neovim
    showtabline = 2, -- always show tabs
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    termguicolors = true, -- set term gui colors (most terminals support this)
    undofile = true, -- enable persistent undo
    updatetime = 300, -- faster completion (4000ms default)
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true, -- convert tabs to spaces
    shiftwidth = 2, -- the number of spaces inserted for each indentation
    tabstop = 2, -- insert 2 spaces for a tab
    cursorline = true, -- highlight the current line
    number = true, -- set numbered lines
    relativenumber = true, -- set relative numbered lines
    signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
    wrap = true, -- display lines as one long line
    scrolloff = 8, -- is one of my fav
    sidescrolloff = 8,
    list = true,
}

--vim.cmd([[colorscheme catppuccin-macchiato]])

vim.o.background = 'dark'
vim.o.relativenumber = true

local signs =
    { Error = ' ', Warning = ' ', Hint = ' ', Information = ' ' }
for type, icon in pairs(signs) do
    local hl = 'LspDiagnosticsSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

for k, v in pairs(options) do
    vim.opt[k] = v
end
vim.opt.listchars:append('eol:↴')
