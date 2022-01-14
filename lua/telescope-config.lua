local telescope = require 'telescope'

--------------- Setup ---------------

	telescope.setup{
		defaults = {
			-- rip grep really lives up to the rip part in certain projects otherwise
			file_ignore_patterns = { "node_modules", ".git/", ".aws-sam/" },
		},
		pickers = {
			find_files = {
				-- use fd to find files
				find_command = { "fd" },
				-- search hidden files in the directory
				hidden = true
			}
		},
	}
	telescope.load_extension('dap')
	telescope.load_extension('fzf')
	telescope.load_extension('neoclip')
	telescope.load_extension('harpoon')
	-- telescope.extensions.macroscope.default()

-------------------------------------
