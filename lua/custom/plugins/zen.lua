return {
  'folke/zen-mode.nvim',
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },

  config = function(_, _)
    require('zen-mode').setup()

    vim.keymap.set('n', '<leader>tz', function()
      require('zen-mode').toggle {}
    end, { desc = '[T]oggle [Z]en-mode' })

    -- vim.keymap.map('n',
  end,
}
