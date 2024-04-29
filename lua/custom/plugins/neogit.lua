return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration

    -- Only one of these is needed, not both.
    'nvim-telescope/telescope.nvim', -- optional
    'ibhagwan/fzf-lua', -- optional
  },
  config = function(_, opts)
    require('neogit').setup(opts)

    vim.keymap.set('n', '<leader>gg', function()
      require('neogit').open()
    end, { desc = '[Git] [g]ut' })
  end,
}
