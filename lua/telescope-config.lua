local telescope = require 'telescope'

--------------- Setup ---------------

	telescope.setup{
		defaults = {
			-- rip grep really lives up to the rip part in certain projects otherwise
			file_ignore_patterns = { "node_modules", ".git/", ".aws-sam/", "build", "dist", ".idea", ".pytest_cache" },
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--trim"
			},
		},
		pickers = {
			find_files = {
				-- use fd to find files
				find_command = { "fd" },
				-- search hidden files in the directory
				hidden = true
			}
		},
		extensions = {
			["ui-select"] = {require("telescope.themes").get_dropdown()}
		},
	}
	telescope.load_extension('dap')
	telescope.load_extension('fzf')
	telescope.load_extension('live_grep_args')
	telescope.load_extension('neoclip')
	-- part of neoclip, keeps history of macros
	telescope.load_extension('macroscope')
	telescope.load_extension('harpoon')
	telescope.load_extension('ui-select') -- vim.ui.select

-------------------------------------
