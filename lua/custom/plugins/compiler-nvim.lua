return {
  { -- This plugin
    'Zeioth/compiler.nvim',
    cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
    dependencies = { 'stevearc/overseer.nvim' },
    opts = {},
    config = function(_, opts)
      require('compiler').setup(opts)

      -- Open compiler
      vim.api.nvim_set_keymap('n', '<leader>co', '<cmd>CompilerOpen<cr>', { noremap = true, silent = true })

      -- Redo last selected option
      vim.api.nvim_set_keymap(
        'n',
        '<S-F6>',
        '<cmd>CompilerStop<cr>' -- (Optional, to dispose all tasks before redo)
          .. '<cmd>CompilerRedo<cr>',
        { noremap = true, silent = true }
      )

      -- Toggle compiler results
      vim.api.nvim_set_keymap('n', '<S-F7>', '<cmd>CompilerToggleResults<cr>', { noremap = true, silent = true })
    end,
  },
  { -- The task runner we use
    'stevearc/overseer.nvim',
    commit = '68a2d344cea4a2e11acfb5690dc8ecd1a1ec0ce0',
    cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
    opts = {
      task_list = {
        direction = 'bottom',
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },
}
