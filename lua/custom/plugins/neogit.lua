return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration

    -- Only need Telescope now, removed fzf-lua
    'nvim-telescope/telescope.nvim', -- optional
  },
  config = function(_, opts)
    require('neogit').setup(opts)

    vim.keymap.set('n', '<leader>gg', function()
      require('neogit').open()
    end, { desc = '[Git] [g]ut' })
  end,
}
