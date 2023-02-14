-- if vim.fn.has('nvim-0.5.1') == 1 then
--require('vim.lsp.log').set_format_func(vim.inspect)
-- end
--
require('config.options')
require('config.lazy')

vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
        require('config.autocommands')
    end,
})
