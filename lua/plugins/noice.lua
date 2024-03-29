return {
    {
        'folke/noice.nvim',
        event = 'VimEnter',
        opts = {
            presets = {
                bottom_search = true, --  a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
            lsp = {
                hover = {
                    enabled = false,
                },
                signature = {
                    enabled = false,
                },
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
            },
        },

        keys = {
            {
                '<leader>nh',
                ':Noice telescope<CR>',
                desc = 'Notification history',
                silent = true,
            },
        },

        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
    },
}
