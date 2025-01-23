return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function(_, opts)
    require('trouble').setup(opts)

    vim.keymap.set('n', '<leader>tx', function()
      require('trouble').toggle()
    end, {
      desc = '[T]rouble',
    })
    vim.keymap.set('n', '<leader>tw', function()
      require('trouble').toggle 'workspace_diagnostics'
    end, {
      desc = '[T]rouble [w]orkspace diagnostics',
    })
    vim.keymap.set('n', '<leader>td', function()
      require('trouble').toggle 'document_diagnostics'
    end, {
      desc = '[T]rouble [d]ocument diagnostics',
    })
    vim.keymap.set('n', '<leader>tl', function()
      require('trouble').toggle 'loclist'
    end, {
      desc = '[T]rouble [l]ocationlist',
    })
  end,
}
