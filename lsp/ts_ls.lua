-- ts_ls {{

vim.lsp.config.ts_ls = {
  init_options = {
    preferences = {
      -- other preferences...
      importModuleSpecifierPreference = 'non-relative',
      importModuleSpecifierEnding = 'minimal',
    },
  },
}

vim.lsp.enable 'ts_ls'

-- }}
