return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function(_, _)
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
  },

  { 'nvim-lua/popup.nvim', event = "VeryLazy" },

  {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    config = function()
      require('Comment').setup()
    end,
  },

  { 'L3MON4D3/LuaSnip' },

  { 'mbbill/undotree', event = "VeryLazy" },

  {
    'tpope/vim-surround', event = "BufReadPre"
  },

  {
    'tpope/vim-fugitive',
    event = "VeryLazy",
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
  },

  {
    'simrat39/rust-tools.nvim',
    config = function()
      local rt = require('rust-tools')
      local Rebind = require('core.keymap')
      local nnoremap = Rebind.nnoremap
      rt.setup({
        server = {
          on_attach = function(client, bufnr)
            require('core.mason').on_attach_keybindings( client, bufnr)
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
  },

  { 'gpanders/editorconfig.nvim', 
    event = "VeryLazy",
},

  {
    'sindrets/diffview.nvim',
    event = "VeryLazy",
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = "VeryLazy",
    opts = {
      show_current_context = true,
      show_current_context_start = true,
      show_end_of_line = true,
    },
  },

  {
    'mfussenegger/nvim-jdtls',
    event = "VeryLazy",
  },

  {
    'simrat39/symbols-outline.nvim',
    event = "VeryLazy",
    config = function()
      require('symbols-outline').setup()
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },

  {
    'RRethy/vim-illuminate',
    event = 'BufReadPost',
    config = function()
      require('illuminate').configure({ delay = 200 })
    end,
  },

  {
    'echasnovski/mini.nvim',
    event = "VeryLazy",
    config = function()
      require('mini.align').setup()
    end,
  },

  {
    'simrat39/inlay-hints.nvim',
    event = "VeryLazy",
    config = function()
      require('inlay-hints').setup()
    end,
  },

  {
    'prichrd/netrw.nvim',
    event = "VeryLazy",
    config = function()
      require('netrw').setup({
        _devicons = true,
      })
    end,
  },

  { 'tpope/vim-vinegar',
    event = "VeryLazy",
},

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
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
    },
    config = function(opts)
      require('catppuccin').setup(opts)
      vim.cmd [[ colorscheme catppuccin ]] 
    end,
  },

  { 'aduros/ai.vim' },

  {
    'Pocco81/true-zen.nvim',
    event = "VeryLazy",
    config = true,
  },
  {
    'andymass/vim-matchup',
    event = "VeryLazy",
    config = function(_, _)
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },
}
