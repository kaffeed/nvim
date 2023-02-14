return {
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        dependencies = {
            {
                'folke/neodev.nvim',
                opts = {
                    library = {
                        plugins = { 'neotest', 'nvim-dap-ui' },
                        types = true,
                    },
                },
            },
            { 'j-hui/fidget.nvim', config = true },
            { 'smjonas/inc-rename.nvim', config = true },
            'williamboman/mason.nvim',
            { 'folke/neoconf.nvim', cmd = 'Neoconf', config = true },
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
        },
        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                            completion = { callSnippet = 'Replace' },
                            telemetry = { enable = false },
                            hint = {
                                enable = false,
                            },
                        },
                    },
                },

                omnisharp = {
                    enable_editorconfig_support = true,
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
                    enable_import_completion = true,

                    -- Specifies whether to include preview versions of the .NET SDK when
                    -- determining which version to use for project loading.
                    sdk_include_prereleases = true,

                    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
                    -- true
                    analyze_open_documents_only = false,
                },
                dockerls = {},
            },
            setup = {
                omnisharp = function(_, _)
                    local lsp_utils = require('plugins.lsp.utils')
                    lsp_utils.on_attach(function(client, buffer)
                        if client.name == 'omnisharp' then
                            client.server_capabilities.semanticTokensProvider =
                                {
                                    full = vim.empty_dict(),
                                    legend = {
                                        tokenModifiers = { 'static_symbol' },
                                        tokenTypes = {
                                            'comment',
                                            'excluded_code',
                                            'identifier',
                                            'keyword',
                                            'keyword_control',
                                            'number',
                                            'operator',
                                            'operator_overloaded',
                                            'preprocessor_keyword',
                                            'string',
                                            'whitespace',
                                            'text',
                                            'static_symbol',
                                            'preprocessor_text',
                                            'punctuation',
                                            'string_verbatim',
                                            'string_escape_character',
                                            'class_name',
                                            'delegate_name',
                                            'enum_name',
                                            'interface_name',
                                            'module_name',
                                            'struct_name',
                                            'type_parameter_name',
                                            'field_name',
                                            'enum_member_name',
                                            'constant_name',
                                            'local_name',
                                            'parameter_name',
                                            'method_name',
                                            'extension_method_name',
                                            'property_name',
                                            'event_name',
                                            'namespace_name',
                                            'label_name',
                                            'xml_doc_comment_attribute_name',
                                            'xml_doc_comment_attribute_quotes',
                                            'xml_doc_comment_attribute_value',
                                            'xml_doc_comment_cdata_section',
                                            'xml_doc_comment_comment',
                                            'xml_doc_comment_delimiter',
                                            'xml_doc_comment_entity_reference',
                                            'xml_doc_comment_name',
                                            'xml_doc_comment_processing_instruction',
                                            'xml_doc_comment_text',
                                            'xml_literal_attribute_name',
                                            'xml_literal_attribute_quotes',
                                            'xml_literal_attribute_value',
                                            'xml_literal_cdata_section',
                                            'xml_literal_comment',
                                            'xml_literal_delimiter',
                                            'xml_literal_embedded_expression',
                                            'xml_literal_entity_reference',
                                            'xml_literal_name',
                                            'xml_literal_processing_instruction',
                                            'xml_literal_text',
                                            'regex_comment',
                                            'regex_character_class',
                                            'regex_anchor',
                                            'regex_quantifier',
                                            'regex_grouping',
                                            'regex_alternation',
                                            'regex_text',
                                            'regex_self_escaped_character',
                                            'regex_other_escape',
                                        },
                                    },
                                    range = true,
                                }
                        end
                    end)

                    -- stylua: ignore
                end,
                lua_ls = function(_, _)
                    local lsp_utils = require('plugins.lsp.utils')
                    lsp_utils.on_attach(function(client, buffer)

            -- stylua: ignore
            if client.name == "lua_ls" then
              vim.keymap.set("n", "<leader>dX", function() require("osv").run_this() end,
                { buffer = buffer, desc = "OSV Run" })
              vim.keymap.set("n", "<leader>dL", function() require("osv").launch({ port = 8086 }) end,
                { buffer = buffer, desc = "OSV Launch" })
            end
                    end)
                end,
            },
        },
        config = function(plugin, opts)
            require('plugins.lsp.servers').setup(plugin, opts)
        end,
    },
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
        opts = {
            ensure_installed = {
                'stylua',
                'omnisharp',
                'ruff',
                'debugpy',
                'codelldb',
            },
        },
        config = function(_, opts)
            require('mason').setup()
            local mr = require('mason-registry')
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        event = 'BufReadPre',
        dependencies = { 'mason.nvim' },
        config = function()
            local nls = require('null-ls')
            nls.setup({
                sources = {
                    nls.builtins.formatting.stylua,
                    nls.builtins.diagnostics.ruff.with({
                        extra_args = { '--max-line-length=180' },
                    }),
                },
            })
        end,
    },
    {
        'folke/trouble.nvim',
        cmd = { 'TroubleToggle', 'Trouble' },
        opts = { use_diagnostic_signs = true },
        keys = {
            {
                '<leader>td',
                '<cmd>TroubleToggle document_diagnostics<cr>',
                desc = 'Document Diagnostics',
            },
            {
                '<leader>cD',
                '<cmd>TroubleToggle workspace_diagnostics<cr>',
                desc = 'Workspace Diagnostics',
            },
        },
    },
    {
        'glepnir/lspsaga.nvim',
        event = 'VeryLazy',
        opts = {
            lightbulb = {
                enable = false,
            },
            symbol_in_winbar = {
                enable = false,
            },
        },
    },
}
