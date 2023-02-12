local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    })
    vim.cmd([[packadd packer.nvim]])
end

-- TODO: This needs to be cleaned up some time as well, also maybe split up the configuration from here

return require('packer').startup(function(use)
    --configure packages here
    use('wbthomason/packer.nvim')

    use({
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig',
        {
            'neovim/nvim-lspconfig',
            requires = {
                'folke/neodev.nvim',
                'jose-elias-alvarez/null-ls.nvim',
            },
        },
    }) -- Configurations for Nvim LSP

    use({ 'onsails/lspkind.nvim' })

    use({
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            local nls = require('null-ls')
            local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
            nls.setup({
                sources = {
                    nls.builtins.formatting.stylua,
                    nls.builtins.code_actions.refactoring,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method('textDocument/formatting') then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr,
                        })
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({
                                    bufnr = bufnr,
                                    filter = function(c)
                                        return c.name == 'null-ls'
                                    end,
                                })
                            end,
                        })
                    end
                end,
            })
        end,
    })

    use('nvim-lua/plenary.nvim')

    use('nvim-lua/popup.nvim')

    use({
        'nvim-telescope/telescope-ui-select.nvim',
        requires = {
            'nvim-telescope/telescope.nvim',
        },
    })

    use({
        'nvim-telescope/telescope.nvim',
        config = function()
            require('core.plugins.telescope').setup()
        end,
    })

    use({
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        },
        config = function()
            local lsp = require('lsp-zero')

            lsp.preset('recommended')

            lsp.set_preferences({
                set_lsp_keymaps = false,
            })

            lsp.on_attach(require('core.mason').on_attach_keybindings)

            lsp.ensure_installed({
                'tsserver',
                'eslint',
                'omnisharp',
                'sumneko_lua',
                'rust_analyzer',
            })

            lsp.nvim_workspace()
            lsp.setup()
        end,
    })

    use({
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    })

    use('L3MON4D3/LuaSnip')

    use('mbbill/undotree')

    use({
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('core.plugins.treesitter')
        end,
    })

    use({
        'p00f/nvim-ts-rainbow',
        requires = {
            'nvim-treesitter/nvim-treesitter',
        },
    })

    use({
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({})
        end,
    })

    use({
        'windwp/nvim-ts-autotag',
        requires = {
            'nvim-treesitter/nvim-treesitter',
        },
    })

    use({
        'JoosepAlviste/nvim-ts-context-commentstring',
        requires = {
            'nvim-treesitter/nvim-treesitter',
        },
    })

    use({ 'folke/neodev.nvim' })

    use({
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('trouble').setup({})
        end,
    })

    use({
        'romgrk/nvim-treesitter-context',
        config = function()
            require('treesitter-context').setup({
                enable = true,
                throttle = true,
                max_lines = 0,
            })
        end,
    })

    use({
        'wthollingsworth/pomodoro.nvim',
        require = 'MunifTanjim/nui.nvim',
        config = function()
            require('pomodoro').setup({
                time_work = 25,
                time_break_short = 5,
                time_break_long = 20,
                timers_to_long_break = 4,
            })
        end,
    })

    use({
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        config = function()
            local navic = require('nvim-navic')
            local pomodoro = require('pomodoro').statusline
            require('lualine').setup({
                sections = {
                    lualine_c = {
                        pomodoro,
                    },
                },
                options = {
                    theme = 'gruvbox_dark',
                },
                tabline = {
                    lualine_a = { 'buffers' },
                    lualine_b = { 'branch' },
                    lualine_c = { 'filename' },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = { 'tabs' },
                },
                winbar = {
                    lualine_c = {
                        { navic.get_location, cond = navic.is_available },
                    },
                },
            })
        end,
    })

    use({
        'tpope/vim-surround',
    })

    use({
        'tpope/vim-fugitive',
        cmd = {
            'G',
            'Git',
            'Gdiffsplit',
            'Gread',
            'Gwrite',
            'Ggrep',
            'GMove',
            'GDelete',
            'GBrowse',
            'GRemove',
            'GRename',
            'Glgrep',
            'Gedit',
        },
        ft = { 'fugitive' },
    })

    use({
        'simrat39/rust-tools.nvim',
        config = function()
            local rt = require('rust-tools')
            local Rebind = require('core.keymap')
            local nnoremap = Rebind.nnoremap
            rt.setup({
                server = {
                    on_attach = function(client, bufnr)
                        require('core.mason').on_attach_keybindings(
                            client,
                            bufnr
                        )
                        nnoremap(
                            '<C-space>',
                            rt.hover_actions.hover_actions,
                            { buffer = bufnr }
                        )
                        nnoremap(
                            '<leader>lra',
                            rt.code_action_group.code_action_group,
                            { buffer = bufnr }
                        )
                        nnoremap(
                            '<leader>lrr',
                            rt.runnables.runnables,
                            { buffer = bufnr }
                        )
                        nnoremap('<C-Shift-n>', function()
                            rt.move_item.move_item(false)
                        end, { buffer = bufnr }) -- move down
                        nnoremap('<C-Shift-p>', function()
                            rt.move_item.move_item(true)
                        end, { buffer = bufnr }) -- move up
                    end,
                },
            })
        end,
    })

    use({ 'gpanders/editorconfig.nvim' })

    use({
        'sindrets/diffview.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        },
    })

    use({
        'TimUntersberger/neogit',
        cmd = {
            'Neogit',
        },
        requires = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
        },
        config = function()
            require('neogit').setup({
                integrations = {
                    diffview = true,
                },
            })
        end,
    })

    use({
        'SmiteshP/nvim-navic',
        requires = 'neovim/nvim-lspconfig',
    })

    use({
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup({
                show_current_context = true,
                show_current_context_start = true,
                show_end_of_line = true,
            })
        end,
    })

    use({ 'lewis6991/impatient.nvim' })

    use({
        'mfussenegger/nvim-jdtls',
    })

    use({
        'simrat39/symbols-outline.nvim',
        config = function()
            require('symbols-outline').setup()
        end,
    })

    use({ 'shaunsingh/nord.nvim' })

    use({
        'folke/noice.nvim',
        event = 'VimEnter',
        config = function()
            require('noice').setup({
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = true, -- add a border to hover docs and signature help
                },
                lsp = {
                    override = {
                        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                        ['vim.lsp.util.stylize_markdown'] = true,
                        ['cmp.entry.get_documentation'] = true,
                    },
                },
            })
        end,
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            'MunifTanjim/nui.nvim',
            -- 'rcarriga/nvim-notify',
        },
    })

    use({
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    })

    use({
        'akinsho/toggleterm.nvim',
        config = function()
            require('core.plugins.toggleterm')
        end,
    })

    use({
        'RRethy/vim-illuminate',
        event = 'BufReadPost',
        config = function()
            require('illuminate').configure({ delay = 200 })
        end,
    })

    use({
        'echasnovski/mini.nvim',
        config = function()
            require('mini.align').setup()
        end,
    })

    use({
        'simrat39/inlay-hints.nvim',
        config = function()
            require('inlay-hints').setup()
        end,
    })

    use({
        'ThePrimeagen/harpoon',
        config = function()
            require('harpoon').setup()
        end,
    })

    use({
        'ahmedkhalf/project.nvim',
        config = function()
            require('project_nvim').setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    })

    use({
        'prichrd/netrw.nvim',
        config = function()
            require('netrw').setup({
                use_devicons = true,
            })
        end,
    })

    use({ 'tpope/vim-vinegar' })

    use({
        'catppuccin/nvim',
        as = 'catppuccin',
        config = function()
            require('catppuccin').setup({
                flavour = 'macchiato',
                dim_inactive = {
                    enabled = true,
                },
                integrations = {
                    telescope = true,
                    mini = true,
                    noice = true,
                    indent_blankline = {
                        enabled = true,
                        colored_indent_levels = true,
                    },
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { 'italic' },
                            hints = { 'italic' },
                            warnings = { 'italic' },
                            information = { 'italic' },
                        },
                        underlines = {
                            errors = { 'underline' },
                            hints = { 'underline' },
                            warnings = { 'underline' },
                            information = { 'underline' },
                        },
                    },
                },
            })
        end,
    })

    use({ 'nyoom-engineering/oxocarbon.nvim' })
    use({ 'aduros/ai.vim' })
    use({
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    })

    -- TODO: configure the debug adapter

    use({ 'mfussenegger/nvim-dap' })

    use({
        'rcarriga/nvim-dap-ui',
        requires = {
            'mfussenegger/nvim-dap',
        },
    })

    use({
        'vim-syntastic/syntastic',
    })
    use({ 'shortcuts/no-neck-pain.nvim', tag = '*' })

    use({
        'Pocco81/true-zen.nvim',
        config = function()
            require('true-zen').setup({
                -- your config goes here
                -- or just leave it empty :)
            })
        end,
    })

    use({
        'nvim-treesitter/nvim-treesitter-textobjects',
    })

    use({
        'andymass/vim-matchup',
        setup = function()
            -- may set any options here
            vim.g.matchup_matchparen_offscreen = { method = 'popup' }
        end,
    })

    use({ 'ellisonleao/gruvbox.nvim' })
end)
