vim.lsp.set_log_level('trace')

-- if vim.fn.has('nvim-0.5.1') == 1 then
require('vim.lsp.log').set_format_func(vim.inspect)
-- end

require('core')
