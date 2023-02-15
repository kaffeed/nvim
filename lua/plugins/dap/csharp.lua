local M = {}

local install_root_dir = vim.fn.stdpath('data') .. '/mason'
local command_path = install_root_dir .. 'bin/netcoredbg.cmd'

function M.setup()
    local dap = require('dap')
    dap.configurations.cs = {
        {
            type = 'coreclr',
            name = 'launch - netcoredbg',
            request = 'launch',
            program = function()
                return vim.fn.input(
                    'Path to dll',
                    vim.fn.getcwd() .. '/bin/Debug/',
                    'file'
                )
            end,
        },
    }

    dap.adapters.coreclr = {
        type = 'executable',
        command = command_path,
        args = { '--interpreter=vscode' },
    }
end

return M
