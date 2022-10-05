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
    -- configure packages here
    use('wbthomason/packer.nvim')

    use({
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig',
        {
            'neovim/nvim-lspconfig',
            requires = {
                'folke/lua-dev.nvim',
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
                    -- nls.builtins.diagnostics.eslint,
                    nls.builtins.completion.spell,
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
                                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
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

    -- CMP
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('saadparwaiz1/cmp_luasnip')
    use('hrsh7th/nvim-cmp')

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
        run = ':TSUpdate',
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

    use({
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('trouble').setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    })

    use({
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup({})
        end,
    })

    use({
        'folke/tokyonight.nvim',
        config = function()
            require('tokyonight').setup()
        end,
    })

    use({
        'anuvyklack/windows.nvim',
        requires = {
            'anuvyklack/middleclass',
            'anuvyklack/animation.nvim',
        },
        config = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            require('windows').setup()
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
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        config = function()
            local navic = require('nvim-navic')

            require('lualine').setup({
                sections = {
                    lualine_c = {
                        { navic.get_location, cond = navic.is_available },
                    },
                    lualine_x = {
                        'lsp_progress',
                    },
                },
                options = {
                    theme = 'nord',
                },
            })
        end,
    })

    use({
        'arkav/lualine-lsp-progress',
        requires = 'nvim-lualine/lualine.nvim',
    })

    use({
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({})
        end,
    })

    use({
        'tpope/vim-surround',
    })

    use({
        'tpope/vim-fugitive',
        cmd = {
            'G',
        },
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
                            '<leader>cra',
                            rt.code_action_group.code_action_group,
                            { buffer = bufnr }
                        )
                        nnoremap(
                            '<leader>crr',
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

    -- use({ 'kdheepak/lazygit.nvim' })
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
        'ray-x/lsp_signature.nvim',
        config = function()
            require('lsp_signature').setup({
                bind = true,
                handler_opts = { border = 'rounded' },
            })
        end,
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

    use({
        'lewis6991/impatient.nvim',
    })

    use({
        'phaazon/hop.nvim',
        config = function()
            require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
        end,
    })

    use({
        'kyazdani42/nvim-tree.lua',
        cmd = {
            'NvimTreeToggle',
        },
        config = function()
            require('nvim-tree').setup({
                sort_by = 'case_sensitive',
                view = {
                    adaptive_size = true,
                    side = 'right',
                },
            })
        end,
    })

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

    -- TODO: Evaluate if this is really necessary
    -- use({
    --     'folke/noice.nvim',
    --     event = 'VimEnter',
    --     config = function()
    --         require('noice').setup()
    --     end,
    --     requires = {
    --         'MunifTanjim/nui.nvim',
    --         'rcarriga/nvim-notify',
    --     },
    -- })
    --
    -- use({
    --     'glacambre/firenvim',
    --     run = function()
    --         vim.fn['firenvim#install'](0)
    --     end,
    -- })
    -- use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
end)
