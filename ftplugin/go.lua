local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
end

map('<leader>cgat', '<cmd>GoAddTags<cr>', '[A]dd [T]ags')
