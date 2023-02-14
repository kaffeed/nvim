
return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-telescope/telescope-ui-select.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
            },
            {
                'folke/trouble.nvim',
                dependencies = 'kyazdani42/nvim-web-devicons',
                config = true,
            },
            'ThePrimeagen/harpoon',
            'ahmedkhalf/project.nvim',
        },
        cmd = 'Telescope',
        keys = {
          {
            '<leader>ff', function() require('telescope.builtin').find_files() end, desc = "Find files",
          },
          {
            '<leader>fr', function() require('telescope.builtin').oldfiles() end, desc = "Recent files",
          },
          { '<leader>pf', function() require('telescope.builtin').git_files() end, desc = "Project files"},
          { '<leader>ss', function() require('telescope.builtin').live_grep() end, desc = "Grep project" },
          { '<leader>sw', function()
            require('telescope.builtin').grep_string({
              search = vim.fn.expand('<cword>'),
            })
          end, desc = "Search word"  },
          { '<leader>pp', function() require('telescope').extensions.projects.projects() end, desc = "Switch project" },
          { '<leader>bb', function() require('telescope.builtin').buffers() end, desc = "Switch buffers" },
          { '<leader>hf', function() require('telescope.builtin').help_tags() end, desc = "Search help" },
          { '<C-p>', function() require('telescope.builtin').commands() end, desc = "Commands"  },
          { '<C-y>', function() require('telescope.builtin').registers() end, desc = "Registers" },
        },
        config = function(_, _)
            local telescope = require('telescope')

            telescope.setup({
                defaults = {
                    mappings = {
                        i = { ['<c-t>'] = require('trouble.providers.telescope').open_with_trouble },
                        n = { ['<c-t>'] = require('trouble.providers.telescope').open_with_trouble },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
                    },
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            })

            telescope.load_extension('ui-select')
            telescope.load_extension('harpoon')
            telescope.load_extension('projects')
            telescope.load_extension('fzf')
        end,
    },
}
