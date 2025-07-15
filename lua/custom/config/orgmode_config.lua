-- Doom Emacs-inspired org-mode configuration for Neovim
-- This configuration aims to provide a similar experience to Doom Emacs' org-mode

local function setup_orgmode()
  -- Ensure orgmode is loaded
  local orgmode_ok, orgmode = pcall(require, 'orgmode')
  if not orgmode_ok then
    vim.notify('orgmode plugin not found!', vim.log.levels.ERROR)
    return
  end

  -- Setup treesitter for org
  local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
  parser_config.org = {
    install_info = {
      url = 'https://github.com/milisims/tree-sitter-org',
      files = { 'src/parser.c', 'src/scanner.cc' },
      branch = 'main',
    },
    filetype = 'org',
  }

  -- Configure orgmode
  orgmode.setup {
    -- Files & Default locations (similar to Doom Emacs)
    org_agenda_files = { '~/org/**/*', '~/projects/**/*.org' },
    org_default_notes_file = '~/org/refile.org',

    -- Appearance settings to match Doom Emacs
    org_hide_leading_stars = true,
    org_hide_emphasis_markers = true,
    org_ellipsis = '…', -- Doom uses a fancy arrow, but this is close
    org_adapt_indentation = true,
    org_startup_indented = true,
    org_startup_folded = 'overview',

    -- Todo keywords (similar to Doom defaults)
    org_todo_keywords = {
      'TODO(t)',
      'PROJ(p)',
      'STRT(s)',
      'WAIT(w)',
      'HOLD(h)',
      '|',
      'DONE(d)',
      'KILL(k)',
    },

    -- Todo keyword faces (Doom-inspired colors)
    org_todo_keyword_faces = {
      TODO = ':foreground #da8548 :weight bold',
      PROJ = ':foreground #da8548 :weight bold',
      STRT = ':foreground #51afef :weight bold',
      WAIT = ':foreground #c678dd :weight bold',
      HOLD = ':foreground #c678dd :weight bold',
      DONE = ':foreground #98be65 :weight bold',
      KILL = ':foreground #ff6c6b :weight bold',
    },

    -- Agenda settings
    org_agenda_span = 'week',
    org_agenda_start_on_weekday = 1,
    org_agenda_block_separator = '━━━━━━━━━━━━━━━━━━━━━━━━━',
    org_agenda_skip_scheduled_if_done = true,
    org_agenda_skip_deadline_if_done = true,
    org_deadline_warning_days = 14,
    org_priority_highest = 'A',
    org_priority_default = 'B',
    org_priority_lowest = 'C',

    -- Capture templates (similar to Doom's defaults)
    org_capture_templates = {
      t = {
        description = 'Personal todo',
        template = '* TODO %?\n%U\n%a\n',
        target = '~/org/todo.org',
      },
      n = {
        description = 'Notes',
        template = '* %?\n%U\n%a\n',
        target = '~/org/notes.org',
      },
      j = {
        description = 'Journal',
        template = '** %<%Y-%m-%d> %<%A>\n%?\n',
        target = '~/org/journal.org',
      },
      p = {
        description = 'Project',
        template = '* PROJ %?\n%U\n',
        target = '~/org/projects.org',
      },
    },

    -- Custom agenda views (similar to Doom's defaults)
    org_agenda_custom_commands = {
      d = {
        description = 'Dashboard',
        types = {
          {
            type = 'agenda',
            org_agenda_span = 'day',
            org_agenda_overriding_header = '⚡ Today',
          },
          {
            type = 'tags_todo',
            match = '+PRIORITY="A"',
            org_agenda_overriding_header = '🔥 High Priority',
          },
          {
            type = 'tags_todo',
            match = '-SOMEDAY/STRT|WAIT|HOLD',
            org_agenda_overriding_header = '👉 In Progress',
          },
          {
            type = 'tags_todo',
            match = '-SOMEDAY-ARCHIVE-REFILE/TODO|PROJ',
            org_agenda_overriding_header = '📌 Pending Tasks',
          },
        },
      },
    },

    -- Better UI (Doom-like improvements)
    win_split_mode = 'float',
    win_border = 'rounded',

    -- Calendar settings
    calendar_week_start_day = 1,

    -- Tags settings
    org_tags_column = 80,
    org_use_tag_inheritance = true,

    -- Logging
    org_log_done = 'time',
    org_log_into_drawer = 'LOGBOOK',

    -- Custom mappings (similar to Doom's spacemacs-inspired bindings)
    mappings = {
      global = {
        org_agenda = '<leader>oa',
        org_capture = '<leader>oc',
      },
      agenda = {
        org_agenda_later = 'l',
        org_agenda_earlier = 'h',
        org_agenda_goto_today = '.',
        org_agenda_day_view = 'vd',
        org_agenda_week_view = 'vw',
        org_agenda_month_view = 'vm',
        org_agenda_year_view = 'vy',
        org_agenda_goto_date = 'gd',
      },
      capture = {
        org_capture_finalize = '<leader>w',
        org_capture_refile = '<leader>r',
        org_capture_kill = '<leader>k',
      },
      org = {
        org_refile = '<leader>or',
        org_timestamp_up = '<C-a>',
        org_timestamp_down = '<C-x>',
        org_todo = '<leader>ot',
        org_todo_prev = '<leader>oT',
        org_toggle_checkbox = '<C-space>',
        org_toggle_heading = '<leader>o*',
        org_meta_return = '<leader><CR>',
        org_insert_heading_respect_content = '<leader>oih',
        org_do_promote = '<<',
        org_do_demote = '>>',
        org_promote_subtree = '<s',
        org_demote_subtree = '>s',
        org_export = '<leader>oe',
        org_next_visible_heading = '}',
        org_previous_visible_heading = '{',
        org_cycle = '<Tab>',
        org_global_cycle = '<S-Tab>',
      },
    },

    -- Notifications
    notifications = {
      enabled = true,
      repeater_reminder_time = 10,
      deadline_warning_reminder_time = 0,
      reminder_time = { 10, 5 },
      deadline_reminder = true,
      scheduled_reminder = true,
    },

    -- UI configuration for a more Doom-like experience
    ui = {
      -- menu = {
      --   handler = function(data)
      --     -- Create a more Doom Emacs like menu experience
      --     local options = {}
      --     local options_by_label = {}
      --
      --     for _, item in ipairs(data.items) do
      --       if item.key and item.label:lower() ~= 'quit' then
      --         local label = string.format('%s: %s', item.key, item.label)
      --         table.insert(options, label)
      --         options_by_label[label] = item
      --       end
      --     end
      --
      --     local handler = function(choice)
      --       if not choice then
      --         return
      --       end
      --       local option = options_by_label[choice]
      --       if option and option.action then
      --         option.action()
      --       end
      --     end
      --
      --     vim.ui.select(options, {
      --       prompt = data.prompt or 'Select an option:',
      --     }, handler)
      --   end,
      -- },

      -- Modern fold indicator
      folds = {
        colored = true,
      },

      -- Use Neovim UI for input when available
      input = {
        use_vim_ui = true,
      },
    },
  }

  -- Additional aesthetic configurations
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
      -- Refine org-mode colors for a more Doom-like appearance
      vim.api.nvim_set_hl(0, '@org.heading', { link = 'Title' })
      vim.api.nvim_set_hl(0, '@org.tag', { fg = '#51afef', italic = true })
      vim.api.nvim_set_hl(0, '@org.timestamp.active', { fg = '#98be65' })
      vim.api.nvim_set_hl(0, '@org.timestamp.inactive', { fg = '#5b6268' })
      vim.api.nvim_set_hl(0, '@org.bullet', { fg = '#51afef' })
      vim.api.nvim_set_hl(0, '@org.directive', { fg = '#c678dd' })
      vim.api.nvim_set_hl(0, '@org.drawer', { fg = '#5b6268' })
      -- Add more highlight customizations as needed
    end,
  })
end

-- Set up basic org-mode keybindings (Doom-like)
local function setup_keymaps()
  -- Global mappings
  vim.keymap.set('n', '<leader>ol', '<cmd>e ~/org/todo.org<CR>', { desc = 'Open Todo List' })
  vim.keymap.set('n', '<leader>on', '<cmd>e ~/org/notes.org<CR>', { desc = 'Open Notes' })
  vim.keymap.set('n', '<leader>oj', '<cmd>e ~/org/journal.org<CR>', { desc = 'Open Journal' })
  vim.keymap.set('n', '<leader>op', '<cmd>e ~/org/projects.org<CR>', { desc = 'Open Projects' })

  -- Fast capture/agenda
  vim.keymap.set('n', '<leader>ox', "<cmd>lua require('orgmode').action('org_capture.refile')<CR>", { desc = 'Org Refile' })
  vim.keymap.set('n', '<leader>od', "<cmd>lua require('orgmode').action('agenda.set_date')<CR>", { desc = 'Org Set Date' })

  -- Fast todo states
  vim.keymap.set('n', '<leader>ot', "<cmd>lua require('orgmode').action('org_mappings.todo')<CR>", { desc = 'Org Todo' })
  vim.keymap.set('n', '<leader>oT', "<cmd>lua require('orgmode').action('org_mappings.todo_prev')<CR>", { desc = 'Org Todo Previous' })
end

-- Enable auto-bullets and improve list behavior (like Doom)
local function setup_org_bullets()
  -- Check if org-bullets is available
  local bullets_ok, _ = pcall(require, 'org-bullets')
  if bullets_ok then
    require('org-bullets').setup {
      symbols = { '◉', '○', '✸', '✿' },
      concealcursor = true,
    }
  end
end

-- Setup additional helper functions
local function setup_additional_features()
  -- Add auto-formatting for tables and other org elements
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'org',
    callback = function()
      -- Enable spell checking (common in Doom)
      vim.opt_local.spell = true
      vim.opt_local.spelllang = 'en_us'

      -- Enable auto-formatting when leaving insert mode (like Doom)
      vim.api.nvim_create_autocmd('InsertLeave', {
        buffer = 0,
        callback = function()
          -- Format tables and lists
          vim.cmd 'normal! gqq'
        end,
      })

      -- Enable indentation-based folding (like Doom)
      vim.opt_local.foldmethod = 'expr'
      vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
    end,
  })
end

-- Execute all setups
return function()
  setup_orgmode()
  setup_keymaps()
  setup_org_bullets()
  setup_additional_features()
end
