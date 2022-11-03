-- TODO: Clean all this shit up
local M = {}

local Remap = require('core.keymap')

local nnoremap = Remap.nnoremap

-- cmp
--
local cmp = require('cmp')
local source_mapping = {
    buffer = '[Buffer]',
    nvim_lsp = '[LSP]',
    nvim_lua = '[Lua]',
    path = '[Path]',
}

local lspkind = require('lspkind')

cmp.setup({
    experimental = {
        ghost_text = true,
    },
    snippet = {
        expand = function(args)
            -- For `luasnip` user.
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),

    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            vim_item.menu = menu
            return vim_item
        end,
    },

    sources = {
        { name = 'nvim_lsp' },
        -- For luasnip user.
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'buffer', keyword_length = 5 },
    },
})

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    }),
})

local snippets_paths = function()
    local plugins = { 'friendly-snippets' }
    local paths = {}
    local path
    local root_path = vim.env.HOME .. '/.vim/plugged/'
    for _, plug in ipairs(plugins) do
        path = root_path .. plug
        if vim.fn.isdirectory(path) ~= 0 then
            table.insert(paths, path)
        end
    end
    return paths
end

require('luasnip.loaders.from_vscode').lazy_load({
    paths = snippets_paths(),
    include = nil, -- Load all languages
    exclude = {},
})

-- local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local opts = { noremap = true, silent = true }
nnoremap('<space>ld', vim.diagnostic.open_float, opts)
nnoremap('[d', vim.diagnostic.goto_prev, opts)
nnoremap(']d', vim.diagnostic.goto_next, opts)
nnoremap('<space>lD', '<cmd>Trouble document_diagnostics <CR>', opts)

M.on_attach_keybindings = function(client, bufnr)
    -- vim.lsp.handlers['textDocument/hover'] =
    --     vim.lsp.with(vim.lsp.handlers.hover, {
    --         border = 'rounded',
    --     })

    require('nvim-navic').attach(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    nnoremap('gd', vim.lsp.buf.definition, bufopts)
    nnoremap('gD', vim.lsp.buf.declaration, bufopts)
    nnoremap('gi', vim.lsp.buf.implementation, bufopts)
    nnoremap('gr', ':Telescope lsp_references<CR>', bufopts)
    nnoremap('K', vim.lsp.buf.hover, bufopts)
    nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts)
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

M.on_attach = function(client, bufnr)
    M.on_attach_keybindings(client, bufnr)
end

local function config(_config)
    return vim.tbl_deep_extend('force', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        on_attach = M.on_attach,
    }, _config or {})
end

require('neodev').setup()

local angular_project_library_path = nil

if vim.fn.has('unix') == 1 then
    local home = os.getenv('HOME')
    angular_project_library_path = home .. '/.npm-global/lib/node_modules/'
else
    local app_data = os.getenv('AppData')
    angular_project_library_path = app_data .. '/npm/node_modules/'
end

local angular_cmd = {
    'node',
    angular_project_library_path .. '/@angular/language-server',
    '--stdio',
    '--tsProbeLocations',
    angular_project_library_path,
    '--ngProbeLocations',
    angular_project_library_path,
}

M.servers = {
    ['html'] = config(),
    ['cssls'] = config(),
    ['sumneko_lua'] = config(),
    ['sqlls'] = config(),
    ['gopls'] = config(),
    ['omnisharp'] = config({
        enable_editorconfig_support = true,

        -- If true, MSBuild project system will only load projects for files that
        -- were opened in the editor. This setting is useful for big C# codebases
        -- and allows for faster initialization of code navigation features only
        -- for projects that are relevant to code that is being edited. With this
        -- setting enabled OmniSharp may load fewer projects and may thus display
        -- incomplete reference lists for symbols.
        enable_ms_build_load_projects_on_demand = false,

        -- Enables support for roslyn analyzers, code fixes and rulesets.
        enable_roslyn_analyzers = false,

        -- Specifies whether 'using' directives should be grouped and sorted during
        -- document formatting.
        organize_imports_on_format = false,

        -- Enables support for showing unimported types and unimported extension
        -- methods in completion lists. When committed, the appropriate using
        -- directive will be added at the top of the current file. This option can
        -- have a negative impact on initial completion responsiveness,
        -- particularly for the first few completion sessions after opening a
        -- solution.
        enable_import_completion = false,

        -- Specifies whether to include preview versions of the .NET SDK when
        -- determining which version to use for project loading.
        sdk_include_prereleases = true,

        -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
        -- true
        analyze_open_documents_only = false,
    }),
    ['lemminx'] = config({
        filetypes = { 'xml', 'xsd', 'xsl', 'xslt', 'svg', 'xaml' },
    }),
    ['pyright'] = config(),
    ['angularls'] = config({
        filetypes = { 'html', 'typescriptreact', 'typescript.tsx' }, -- overwrite typescript because the ts language server works better
        cmd = angular_cmd,
        on_new_config = function(new_config, _)
            -- P(new_config)
            -- P(new_root_dir)
            new_config.cmd = angular_cmd
        end,
    }),
    ['tsserver'] = config(),
    ['bashls'] = config(),
    ['powershell_es'] = config(),
}

local get_keys = function(t)
    local keys = {}
    for key, _ in pairs(t) do
        table.insert(keys, key)
    end
    return keys
end

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = get_keys(M.servers),
})

vim.lsp.set_log_level('OFF')

for server, cfg in pairs(M.servers) do
    require('lspconfig')[server].setup(cfg)
end

return M
