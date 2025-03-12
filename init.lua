-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, for help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

local is_windows = vim.fn.has 'win64' or vim.fn.has 'win32' or vim.fn.has 'win16'

if is_windows then
  vim.opt.shadafile = 'NONE'
  vim.opt.shell = 'pwsh'
  vim.opt.shellcmdflag =
    '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'

  vim.opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellquote = ''
  vim.opt.shellxquote = ''
end
-- Set term gui colors for tmux
vim.o.termguicolors = true

vim.filetype.add { extension = { templ = 'templ' } }

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- use Y for yank line to end
vim.keymap.set('n', 'Y', 'y$')

-- Remap <C-d> and <C-u> to center afterwards
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins, you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.

require('lazy').setup {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },

    { -- Useful plugin to show you pending keybinds.
      'folke/which-key.nvim',
      event = 'VimEnter', -- Sets the loading event to 'VimEnter'
      config = function() -- This is the function that runs, AFTER loading
        require('which-key').setup()

        -- Document existing key chains
        require('which-key').register {
          ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
          ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
          ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
          ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
          ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
          ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
          ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
        }
      end,
    },

    -- NOTE: Plugins can specify dependencies.
    --
    -- The dependencies are proper plugin specifications as well - anything
    -- you do for a plugin at the top level, you can do for a dependency.
    --
    -- Use the `dependencies` key to specify the dependencies of a particular plugin

    {
      'ibhagwan/fzf-lua',
      event = 'VimEnter',
      opts = function(_, _)
        local actions = require 'fzf-lua.actions'

        return {
          oldfiles = {
            include_current_session = true,
          },
          winopts = {
            preview = {
              layout = 'vertical',
            },
          },
          previewers = {
            builtin = {
              -- fzf-lua ist sehr schnell, aber es hatte wirklich Probleme, ein paar Dateien
              -- in einem Repo in der Vorschau anzuzeigen. Diese Dateien waren sehr große JavaScript-Dateien (1 MB, minimiert, alle in einer einzigen Zeile).
              -- Es stellte sich heraus, dass Treesitter Probleme beim Parsen der Dateien hatte.
              -- Mit dieser Änderung fügt die Vorschau keine Syntaxhervorhebung für Dateien hinzu, die größer als 100 KB sind
              -- (Ja, ich weiß, dass man keine 100 KB großen minimierten Dateien in der Quellcodeverwaltung haben sollte.)
              syntax_limit_b = 1024 * 100, -- 100KB
            },
          },
          grep = {
            rg_glob = true, -- Glob-Parsing aktivieren
            glob_flag = '--iglob', -- Groß-/Kleinschreibung unempfindliche Globs
            glob_separator = '%s%-%-', -- Muster für den Abfrage-Separator (Lua): ' --'
            actions = {
              ['ctrl-q'] = {
                fn = actions.file_edit_or_qf,
                prefix = 'select-all+',
              },
            },
          },
        }
      end,
      config = function(_, opts)
        local fzflua = require 'fzf-lua'

        vim.keymap.set('n', '<leader>sh', fzflua.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sk', fzflua.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>sf', fzflua.files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>sw', fzflua.grep_cword, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', fzflua.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', fzflua.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', fzflua.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>sp', fzflua.grep_project, { desc = '[S]earch [P]roject' })
        vim.keymap.set('n', '<leader>s.', fzflua.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', fzflua.buffers, { desc = '[ ] Find existing buffers' })

        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set('n', '<leader>/', function()
          fzflua.grep_curbuf {}
        end, { desc = '[/] Fuzzily search in current buffer' })

        -- Also possible to pass additional configuration options.
        vim.keymap.set('n', '<leader>s/', function()
          fzflua.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end, { desc = '[S]earch [/] in Open Files' })

        -- Shortcut for searching your neovim configuration files
        vim.keymap.set('n', '<leader>sn', function()
          fzflua.files { cwd = vim.fn.stdpath 'config' }
        end, { desc = '[S]earch [N]eovim files' })

        fzflua.register_ui_select()
        fzflua.setup { opts }
      end,
    },
    -- LSP Plugins
    {
      -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          -- Load luvit types when the `vim.uv` word is found
          { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          { path = 'wezterm-types', mods = { 'wezterm' } },
        },
      },
    },
    { 'justinsgithub/wezterm-types', lazy = true },
    { 'Bilal2453/luvit-meta', lazy = true },
    { 'folke/neoconf.nvim' },
    {
      -- Main LSP Configuration
      'neovim/nvim-lspconfig',
      dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        -- Mason must be loaded before its dependents so we need to set it up here.
        -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
        { 'williamboman/mason.nvim', opts = {} },
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        -- Useful status updates for LSP.
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim', opts = {} },

        -- Allows extra capabilities provided by nvim-cmp
        -- 'hrsh7th/cmp-nvim-lsp',
        'saghen/blink.cmp',
      },
      config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
          callback = function(event)
            -- NOTE: Remember that Lua is a real programming language, and as such it is possible
            -- to define small helper and utility functions so you don't have to repeat yourself.
            --
            -- In this case, we create a function that lets us more easily define mappings specific
            -- for LSP related items. It sets the mode, buffer and description for us each time.
            local map = function(keys, func, desc, mode)
              mode = mode or 'n'
              vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
            end

            -- Jump to the definition of the word under your cursor.
            --  This is where a variable was first declared, or where a function is defined, etc.
            --  To jump back, press <C-T>.
            map('gd', require('fzf-lua').lsp_definitions, '[G]oto [D]efinition')

            -- Find references for the word under your cursor.
            map('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')

            -- Jump to the implementation of the word under your cursor.
            --  Useful when your language has ways of declaring types without an actual implementation.
            map('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')

            -- Jump to the type of the word under your cursor.
            --  Useful when you're not sure what type a variable is and you want to see
            --  the definition of its *type*, not where it was *defined*.
            map('<leader>D', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')

            -- Fuzzy find all the symbols in your current document.
            --  Symbols are things like variables, functions, types, etc.
            map('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')

            -- Fuzzy find all the symbols in your current workspace
            --  Similar to document symbols, except searches over your whole project.
            map('<leader>ws', require('fzf-lua').lsp_workspace_symbols, '[W]orkspace [S]ymbols')

            -- Rename the variable under your cursor.
            --  Most Language Servers support renaming across files, etc.
            map('crn', vim.lsp.buf.rename, '[R]e[n]ame')

            -- Execute a code action, usually your cursor needs to be on top of an error
            -- or a suggestion from your LSP for this to activate.
            map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

            -- WARN: This is not Goto Definition, this is Goto Declaration.
            --  For example, in C this would take you to the header.
            map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

            -- The following two autocommands are used to highlight references of the
            -- word under your cursor when your cursor rests there for a little while.
            --    See `:help CursorHold` for information about when this is executed
            --
            -- When you move your cursor, the highlights will be cleared (the second autocommand).
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
              local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
              vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
              })

              vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
              })

              vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                callback = function(event2)
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                end,
              })
            end

            -- The following code creates a keymap to toggle inlay hints in your
            -- code, if the language server you are using supports them
            --
            -- This may be unwanted, since they displace some of your code
            if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
              map('<leader>th', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
              end, '[T]oggle Inlay [H]ints')
            end
          end,
        })

        -- Change diagnostic symbols in the sign column (gutter)
        -- if vim.g.have_nerd_font then
        --   local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
        --   local diagnostic_signs = {}
        --   for type, icon in pairs(signs) do
        --     diagnostic_signs[vim.diagnostic.severity[type]] = icon
        --   end
        --   vim.diagnostic.config { signs = { text = diagnostic_signs } }
        -- end

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

        -- Enable the following language servers
        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        --
        --  Add any additional override configuration in the following tables. Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
        local servers = {
          -- clangd = {},
          -- gopls = {},
          -- pyright = {},
          -- rust_analyzer = {},
          -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
          --
          -- Some languages (like typescript) have entire language plugins that can be useful:
          --    https://github.com/pmizio/typescript-tools.nvim
          --
          -- But for many setups, the LSP (`ts_ls`) will work just fine
          ts_ls = {},
          --
          omnisharp = {
            settings = {
              RoslynExtensionsOptions = {
                InlayHintsOptions = {
                  EnableForParameters = true,
                  ForLiteralParameters = true,
                  ForIndexerParameters = true,
                  ForObjectCreationParameters = true,
                  ForOtherParameters = true,
                  SuppressForParametersThatDifferOnlyBySuffix = false,
                  SuppressForParametersThatMatchMethodIntent = false,
                  SuppressForParametersThatMatchArgumentName = false,
                  EnableForTypes = true,
                  ForImplicitVariableTypes = true,
                  ForLambdaParameterTypes = true,
                  ForImplicitObjectCreatio = true,
                },
              },
            },
          },

          lua_ls = {
            -- cmd = { ... },
            -- filetypes = { ... },
            -- capabilities = {},
            settings = {
              Lua = {
                completion = {
                  callSnippet = 'Replace',
                },
                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                -- diagnostics = { disable = { 'missing-fields' } },
              },
            },
          },
        }

        -- Ensure the servers and tools above are installed
        --
        -- To check the current status of installed tools and/or manually install
        -- other tools, you can run
        --    :Mason
        --
        -- You can press `g?` for help in this menu.
        --
        -- `mason` had to be setup earlier: to configure its options see the
        -- `dependencies` table for `nvim-lspconfig` above.
        --
        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
          'stylua', -- Used to format Lua code
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        require('mason-lspconfig').setup {
          handlers = {
            function(server_name)
              local server = servers[server_name] or {}
              -- This handles overriding only values explicitly passed
              -- by the server configuration above. Useful when disabling
              -- certain features of an LSP (for example, turning off formatting for ts_ls)
              server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
              require('lspconfig')[server_name].setup(server)
            end,
          },
        }
      end,
    },

    { -- Autoformat
      'stevearc/conform.nvim',
      opts = {
        notify_on_error = false,
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          lua = { 'stylua' },
          go = { 'goimports', 'gofmt' },
          -- Conform can also run multiple formatters sequentially
          -- python = { "isort", "black" },
          --
          -- You can use a sub-list to tell conform to run *until* a formatter
          -- is found.
          -- javascript = { { "prettierd", "prettier" } },
        },
      },
    },
    {
      'saghen/blink.cmp',
      dependencies = {
        { 'rafamadriz/friendly-snippets' },
        { 'giuxtaposition/blink-cmp-copilot' },
      },
      event = 'InsertEnter',
      -- use a release tag to download pre-built binaries
      version = '*',
      -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
      -- build = 'cargo build --release',
      -- If you use nix, you can build from source using latest nightly rust with:
      -- build = 'nix run .#build-plugin',

      opts = {
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- See the full "keymap" documentation for information on defining your own keymap.
        keymap = { preset = 'default' },

        appearance = {
          -- Sets the fallback highlight groups to nvim-cmp's highlight groups
          -- Useful for when your theme doesn't support blink.cmp
          -- Will be removed in a future release
          use_nvim_cmp_as_default = true,
          -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
          -- Adjusts spacing to ensure icons are aligned
          nerd_font_variant = 'mono',
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
          providers = {
            copilot = {
              name = 'copilot',
              module = 'blink-cmp-copilot',
              score_offset = 100,
              async = true,
            },
          },
        },
      },
      opts_extend = { 'sources.default' },
    },
    -- { -- Autocompletion
    --   'hrsh7th/nvim-cmp',
    --   event = 'InsertEnter',
    --   dependencies = {
    --     -- Snippet Engine & its associated nvim-cmp source
    --     {
    --       'L3MON4D3/LuaSnip',
    --       build = (function()
    --         -- Build Step is needed for regex support in snippets
    --         -- This step is not supported in many windows environments
    --         -- Remove the below condition to re-enable on windows
    --         if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
    --           return
    --         end
    --         return 'make install_jsregexp'
    --       end)(),
    --     },
    --     'saadparwaiz1/cmp_luasnip',
    --
    --     -- Adds other completion capabilities.
    --     --  nvim-cmp does not ship with all sources by default. They are split
    --     --  into multiple repos for maintenance purposes.
    --     'hrsh7th/cmp-nvim-lsp',
    --     'hrsh7th/cmp-path',
    --
    --     -- If you want to add a bunch of pre-configured snippets,
    --     --    you can use this plugin to help you. It even has snippets
    --     --    for various frameworks/libraries/etc. but you will have to
    --     --    set up the ones that are useful for you.
    --     'rafamadriz/friendly-snippets',
    --   },
    --   config = function()
    --     -- See `:help cmp`
    --     local cmp = require 'cmp'
    --     local luasnip = require 'luasnip'
    --     luasnip.config.setup {}
    --
    --     cmp.setup {
    --       snippet = {
    --         expand = function(args)
    --           luasnip.lsp_expand(args.body)
    --         end,
    --       },
    --       completion = { completeopt = 'menu,menuone,noinsert' },
    --
    --       -- For an understanding of why these mappings were
    --       -- chosen, you will need to read `:help ins-completion`
    --       --
    --       -- No, but seriously. Please read `:help ins-completion`, it is really good!
    --       mapping = cmp.mapping.preset.insert {
    --         -- Select the [n]ext item
    --         ['<C-n>'] = cmp.mapping.select_next_item(),
    --         -- Select the [p]revious item
    --         ['<C-p>'] = cmp.mapping.select_prev_item(),
    --
    --         -- Accept ([y]es) the completion.
    --         --  This will auto-import if your LSP supports it.
    --         --  This will expand snippets if the LSP sent a snippet.
    --         ['<C-y>'] = cmp.mapping.confirm { select = true },
    --
    --         -- Manually trigger a completion from nvim-cmp.
    --         --  Generally you don't need this, because nvim-cmp will display
    --         --  completions whenever it has completion options available.
    --         ['<C-Space>'] = cmp.mapping.complete {},
    --
    --         -- Think of <c-l> as moving to the right of your snippet expansion.
    --         --  So if you have a snippet that's like:
    --         --  function $name($args)
    --         --    $body
    --         --  end
    --         --
    --         -- <c-l> will move you to the right of each of the expansion locations.
    --         -- <c-h> is similar, except moving you backwards.
    --         ['<C-l>'] = cmp.mapping(function()
    --           if luasnip.expand_or_locally_jumpable() then
    --             luasnip.expand_or_jump()
    --           end
    --         end, { 'i', 's' }),
    --         ['<C-h>'] = cmp.mapping(function()
    --           if luasnip.locally_jumpable(-1) then
    --             luasnip.jump(-1)
    --           end
    --         end, { 'i', 's' }),
    --       },
    --       sources = {
    --         { name = 'nvim_lsp' },
    --         { name = 'luasnip' },
    --         { name = 'path' },
    --       },
    --     }
    --   end,
    -- },
    {
      'folke/tokyonight.nvim',
      priority = 1000, -- Make sure to load this before all the other start plugins.
      init = function()
        -- Load the colorscheme here.
        -- Like many other themes, this one has different styles, and you could load
        -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
        vim.cmd.colorscheme 'tokyonight-moon'

        -- You can configure highlights by doing something like:
        vim.cmd.hi 'Comment gui=none'
      end,
    },
    -- { -- You can easily change to a different colorscheme.
    --   -- Change the name of the colorscheme plugin below, and then
    -- Highlight todo, notes, etc in comments
    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

    { -- Collection of various small independent plugins/modules
      'echasnovski/mini.nvim',
      config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require('mini.ai').setup { n_lines = 500 }

        require('mini.pairs').setup()

        -- ... and there is more!
        --  Check out: https://github.com/echasnovski/mini-nvim
      end,
    },

    { -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdateSync',
      config = function()
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
        -- require('nvim-treesitter.install').compilers = { 'zig' }

        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup {
          ensure_installed = (function()
            local servers = { 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc', 'c_sharp', 'angular', 'typescript', 'templ', 'powershell' }
            if not is_windows then
              vim.list_extend(servers, { 'bash' })
            end
            return servers
          end)(),
          -- Autoinstall languages that are not installed
          auto_install = true,
          highlight = { enable = true },
          indent = { enable = true },
        }

        -- There are additional nvim-treesitter modules that you can use to interact
        -- with nvim-treesitter. You should go explore a few and see what interests you:
        --
        --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
        --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      end,
    },

    -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
    -- init.lua. If you want these files, they are in the repository, so you can just download them and
    -- put them in the right spots if you want.

    -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for kickstart
    --
    --  Here are some example plugins that I've included in the kickstart repository.
    --  Uncomment any of the lines below to enable them (you will need to restart nvim).
    --
    require 'kickstart.plugins.debug',
    -- require 'kickstart.plugins.indent_line',

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    This is the easiest way to modularize your config.
    --
    --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
    { import = 'custom.plugins' },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
