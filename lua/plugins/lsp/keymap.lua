local nnoremap = require('lua.keymap').nnoremap
return function(client, bufnr)
    require('nvim-navic').attach(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    nnoremap('gd', vim.lsp.buf.definition, bufopts)
    nnoremap('gD', vim.lsp.buf.declaration, bufopts)
    nnoremap('gi', vim.lsp.buf.implementation, bufopts)
    nnoremap('gr', ':Telescope lsp_references<CR>', bufopts)
    nnoremap('K', vim.lsp.buf.hover, bufopts)
    nnoremap('<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    nnoremap('<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    nnoremap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    nnoremap('crn', vim.lsp.buf.rename, bufopts)
    nnoremap('<leader>la', vim.lsp.buf.code_action, bufopts)
    nnoremap('<leader>ls', ':SymbolsOutline<CR>', bufopts)
    nnoremap('<leader>vd', vim.diagnostic.open_float, bufopts)
    nnoremap('<leader>lf', function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)
    nnoremap('<c-f>', function()
        if not require('noice.lsp').scroll(4) then
            return '<c-f>'
        end
    end, { silent = true, expr = true })

    nnoremap('<c-b>', function()
        if not require('noice.lsp').scroll(-4) then
            return '<c-b>'
        end
    end, { silent = true, expr = true })
end
