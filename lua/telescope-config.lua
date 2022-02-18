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
			-- prompt_prefix = "   ",
			-- selection_caret = "  ",
			-- entry_prefix = "  ",
			-- initial_mode = "insert",
			-- selection_strategy = "reset",
			-- sorting_strategy = "ascending",
			-- layout_strategy = "horizontal",
			-- layout_config = {
			-- 	horizontal = {
			-- 		prompt_position = "top",
			-- 		preview_width = 0.55,
			-- 		results_width = 0.8,
			-- 	},
			-- 	vertical = {
			-- 		mirror = false,
			-- 	},
			-- 	width = 0.87,
			-- 	height = 0.80,
			-- 	preview_cutoff = 120,
			-- },
			-- winblend = 0,
			-- border = {},
			-- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			-- color_devicons = true,
			-- use_less = true,
			-- set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			-- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			-- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			-- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
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
	telescope.load_extension('live_grep_raw')
	telescope.load_extension('neoclip')
	telescope.load_extension('harpoon')
	-- telescope.extensions.macroscope.default()

-------------------------------------
