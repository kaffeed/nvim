-- TODO: Clean all this shit up
local M = {}

local Remap = require('core.keymap')

local nnoremap = Remap.nnoremap

-- local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local opts = { noremap = true, silent = true }
nnoremap('<space>cd', vim.diagnostic.open_float, opts)
nnoremap('[d', vim.diagnostic.goto_prev, opts)
nnoremap(']d', vim.diagnostic.goto_next, opts)
nnoremap('<space>cD', vim.diagnostic.setloclist, opts)

M.on_attach_keybindings = function(client, bufnr)
    require('nvim-navic').attach(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    nnoremap('gd', vim.lsp.buf.definition, bufopts)
    nnoremap('gD', vim.lsp.buf.declaration, bufopts)
    nnoremap('gi', vim.lsp.buf.implementation, bufopts)
    nnoremap('K', vim.lsp.buf.hover, bufopts)
    nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts)
    nnoremap('<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    nnoremap('<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    nnoremap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    -- nnoremap("gs", ":Lspsaga signature_help<CR>", bufopts)
    nnoremap('crn', vim.lsp.buf.rename, bufopts)
    nnoremap('<leader>ca', vim.lsp.buf.code_action, bufopts)
    nnoremap('<leader>cs', vim.lsp.buf.workspace_symbol, bufopts)
    nnoremap('<leader>vd', vim.diagnostic.open_float, bufopts)
    nnoremap('<leader>cf', function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)
end

local on_attach = function(client, bufnr)
    M.on_attach_keybindings(client, bufnr)
end

local function config(_config)
    return vim.tbl_deep_extend('force', {
        capabilities = require('cmp_nvim_lsp').update_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        ),
        on_attach = on_attach,
    }, _config or {})
end

local luadev = require('lua-dev').setup({
    library = {
        vimruntime = true, -- runtime path
        types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        plugins = true, -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as a workspace library
        -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },
    runtime_path = false, -- enable this to get completion in require strings. Slow!
    -- pass any additional options that will be merged in the final lsp config
    lspconfig = {
        cmd = { 'lua-language-server' },
        on_attach = on_attach,
        capabilities = capabilities,
    },
})

M.servers = {
    ['sumneko_lua'] = luadev,
    -- ["rust_analyzer"] = config({}),
    ['gopls'] = config({}),
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
    -- ["lemminx"] = config({
    --     filetypes = { "xml", "xsd", "xsl", "xslt", "svg", "xaml" }
    -- }),
    ['pyright'] = config(),
    ['jdtls'] = config(),
}

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = M.servers,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local cmp = require('cmp')
local source_mapping = {
    buffer = '[Buffer]',
    nvim_lsp = '[LSP]',
    nvim_lua = '[Lua]',
    path = '[Path]',
}

local lspkind = require('lspkind')

cmp.setup({
    snippet = {
        expand = function(args)
            -- For `vsnip` user.
            -- vim.fn["vsnip#anonymous"](args.body)

            -- For `luasnip` user.
            require('luasnip').lsp_expand(args.body)

            -- For `ultisnips` user.
            -- vim.fn["UltiSnips#Anon"](args.body)
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
        { name = 'luasnip' },

        { name = 'buffer' },
    },
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

for server, cfg in pairs(M.servers) do
    require('lspconfig')[server].setup(cfg)
end

return M
