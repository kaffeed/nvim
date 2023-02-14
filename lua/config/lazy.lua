local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- TODO: This needs to be cleaned up some time as well, also maybe split up the configuration from here
require('lazy').setup({
    spec = {
        { import = 'plugins' },
        { import = 'plugins.extras.lang' }, -- for languages that require additional setup
        { import = 'plugins.extras.ui' },
    },
    defaults = {
        lazy = true,
        version = nil,
    },
    performance = {
        cache = {
            enabled = true,
        },
    },
})
