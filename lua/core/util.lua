local M = {}
function M.select_zen_mode()
    vim.ui.select({ 'Focus', 'Narrow', 'Minimalist', 'Ataraxis' }, {
        prompt = 'Select zen mode',
    }, function(mode, idx)
        if mode then
            local tzmode = ':TZ' .. mode
            vim.cmd(tzmode)
        else
            print('Cancelled')
        end
    end)
end

return M
