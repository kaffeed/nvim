return {
{
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    'SmiteshP/nvim-navic',

    },
    config = function(_,_)
      local navic = require('nvim-navic')
      local pomodoro = require('pomodoro').statusline
      require('lualine').setup({
        sections = {
          lualine_c = {
            pomodoro,
          },
        },
        options = {
          theme = 'catppuccin',
        },
        tabline = {
          lualine_a = { 'buffers' },
          lualine_b = { 'branch' },
          lualine_c = { 'filename' },
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'tabs' },
        },
        winbar = {
          lualine_c = {
            { navic.get_location, cond = navic.is_available },
          },
        },
      })
    end,
  }
    {},
}
