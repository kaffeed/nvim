local M = {}

M.setup = function()
	local telescope = require('telescope')
	telescope.setup({
		pickers = {
			find_files = {
				theme = "ivy"
			},
			buffers = {
				theme = "ivy"
			},
			oldfiles = {
				theme = "ivy"
			},
			git_branches = {
				theme = "ivy"
			},
			git_status = {
				theme = "ivy"
			},
		},
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_cursor()
			}
		}
	})

	telescope.load_extension("ui-select")
end

return M
