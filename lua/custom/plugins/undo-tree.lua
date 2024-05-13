return {
  'mbbill/undotree',
  config = function()
    vim.keymap.set('n', '<leader>tu', vim.cmd.UndotreeToggle, { desc = '[T]oggle [U]ndotree' })

    vim.g.undotree_WindowLayout = 3
  end,
}
