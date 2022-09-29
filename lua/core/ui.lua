vim.cmd([[colorscheme gruvbox]])
vim.o.relativenumber = true

local signs =
    { Error = ' ', Warning = ' ', Hint = ' ', Information = ' ' }
for type, icon in pairs(signs) do
    local hl = 'LspDiagnosticsSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.opt.list = true
vim.opt.listchars:append('eol:↴')
