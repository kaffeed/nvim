return {
  {
    'VonHeikemen/lsp-zero.nvim',
    lazy = false,
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
{
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "ruff",
        "debugpy",
        "codelldb",
      },
    },
    config = function(_, opts)
      require("mason").setup()
      local mr = require "mason-registry"
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'onsails/lspkind.nvim' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
      {
        'folke/neodev.nvim',
        opts = {
          library = {
            plugins = { 'neotest', 'nvim-dap-ui' },
            types = true,
          },
        },
      },
    },
    config = function(_, _)
      local lsp = require('lsp-zero')
      lsp.preset('recommended')
      lsp.set_preferences({
        set_lsp_keymaps = false,
      })

      lsp.on_attach(require('plugins.lsp.keymap'))

      lsp.ensure_installed({
        'tsserver',
        'eslint',
        'omnisharp',
        'lua_ls',
        'rust_analyzer',
      })

      lsp.nvim_workspace()
      lsp.setup()
    end,
  },
}
