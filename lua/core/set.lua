vim.g.mapleader = ' '

if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    vim.opt.shell = 'pwsh.exe -NoLogo'
    vim.opt.shellcmdflag =
        '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'

    vim.cmd([[
	let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
	let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
	set shellquote= shellxquote=
	]])

    -- Set a compatible clipboard manager
    vim.g.clipboard = {
        copy = {
            ['+'] = 'win32yank.exe -i --crlf',
            ['*'] = 'win32yank.exe -i --crlf',
        },
        paste = {
            ['+'] = 'win32yank.exe -o --lf',
            ['*'] = 'win32yank.exe -o --lf',
        },
    }
end

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
    cursorline = false, -- highlight the current line
    number = true, -- set numbered lines
    relativenumber = true, -- set relative numbered lines
    signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
    wrap = true, -- display lines as one long line
    scrolloff = 8, -- is one of my fav
    sidescrolloff = 8,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
