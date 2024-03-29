return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'p00f/nvim-ts-rainbow',
            'windwp/nvim-ts-autotag',
            'JoosepAlviste/nvim-ts-context-commentstring',
            {
                'romgrk/nvim-treesitter-context',
                opts = {
                    enable = true,
                    throttle = true,
                },
            },
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        event = 'BufReadPost',
        opts = {
            ensure_installed = {
                'bash',
                'dockerfile',
                'help',
                'html',
                'lua',
                'markdown',
                'markdown_inline',
                'query',
                'regex',
                'vim',
                'yaml',
            },
            --
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- auto_install = true,

            -- List of parsers to ignore installing (for "all")
            ignore_install = { 'phpdoc', 'php' },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = 'gnn',
                    node_incremental = 'grn',
                    scope_incremental = 'grc',
                    node_decremental = 'grm',
                },
            },

            highlight = {
                -- `false` will disable the whole extension
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
            rainbow = {
                enable = true,
                extended_mode = true,
            },
            autotag = {
                enable = true,
            },
            context_commentstring = {
                enable = true,
            },
            matchup = {
                enable = true,
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,

                    keymaps = {
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                        ['aC'] = '@comment.outer',
                        ['iC'] = '@comment.outer',
                        ['al'] = '@loop.outer',
                        ['il'] = '@loop.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                    },
                    include_surrounding_whitespace = false,
                },
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.install').prefer_git = false
            require('nvim-treesitter.install').compilers = { 'clang', 'gcc' }
            require('nvim-treesitter.configs').setup(opts)
        end,
    },
}
