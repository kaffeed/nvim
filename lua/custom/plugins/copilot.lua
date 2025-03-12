-- Copilot.
return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      -- I don't find the panel useful.
      -- panel = { enabled = true },
      suggestion = {
        auto_trigger = true,
        -- Use alt to interact with Copilot.
        keymap = {
          -- Disable the built-in mapping, we'll configure it in nvim-cmp.
          accept = false,
          accept_word = '<M-w>',
          accept_line = '<M-l>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '/',
        },
      },
      filetypes = { markdown = true },
    },
  },
}
