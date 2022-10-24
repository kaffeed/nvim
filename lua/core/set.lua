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

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.termguicolors = true
