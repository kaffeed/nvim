local angular_project_library_path = nil

if vim.fn.has('unix') == 1 then
    local home = os.getenv('HOME')
    angular_project_library_path = home .. '/.npm-global/lib/node_modules/'
else
    local app_data = os.getenv('AppData')
    angular_project_library_path = app_data .. '/npm/node_modules/'
end

local angular_cmd = {
    'node',
    angular_project_library_path .. '/@angular/language-server',
    '--stdio',
    '--tsProbeLocations',
    angular_project_library_path,
    '--ngProbeLocations',
    angular_project_library_path,
}

return {
    cmd = angular_cmd,
    on_new_config = function(new_config, _)
        -- P(new_config)
        -- P(new_root_dir)
        new_config.cmd = angular_cmd
    end,
}
