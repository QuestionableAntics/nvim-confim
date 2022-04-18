-- Speeds up loading of lua modules for better start up time. Periodically check if this is needed (it will be merged into neovim main at some point)
require 'impatient'


local hop = require 'hop'

--------------- Motions ---------------

	hop.setup {
		-- Themes will overwrite this sometimes, this ensures that hop greys out non highlighted letters
		create_hl_autocmd = true
	}

---------------------------------------

local mappings = require 'mappings'

local autopairs = require 'nvim-autopairs'
local autotag = require 'nvim-ts-autotag'
local auto_session = require 'auto-session'
local bqf = require 'bqf'
-- local comment = require 'Comment'
-- local copilot = require 'copilot'
local fidget = require 'fidget'
local gitsigns = require 'gitsigns'
local indent_blankline = require 'indent_blankline'
local lualine = require 'lualine'
local neoclip = require 'neoclip'
local pretty_fold = require 'pretty-fold'
local pretty_fold_preview = require 'pretty-fold.preview'
local stabilize = require 'stabilize'
local tabby = require 'tabby'
local which_key = require 'which-key'


----------- Which Key ---------------

	local which_key_mappings = {}

	for k, v in pairs(mappings.all_mappings) do
		which_key_mappings[k] = { v.action, v.label }
	end

	for k,v in pairs(mappings.stems) do
		which_key_mappings[k] = v.label
	end

	which_key.register(which_key_mappings)

-------------------------------------


----- Misc -----

	autopairs.setup{}
	autotag.setup()
	auto_session.setup {
		auto_session_root_dir = os.getenv('HOME') .. '/.vim/sessions/',
		auto_session_suppress_dirs = { '~/' },
	}
	bqf.setup()
	-- copilot.setup {
	-- 	plugin_manager_path = os.getenv('HOME') .. '/.vim/plugged',
	-- }
	require('coq_3p') {
		{ src = 'vim_dadbod_completion', short_name = 'DB' },
		{ src = 'dap' },
		-- { src = 'copilot', short_name = 'COP', accept_key = '<C-J>'}
	}
	-- comment.setup()
	fidget.setup()
	neoclip.setup {
		enable_persistent_history = true,
		default_register_macros = 'q',
		enable_macro_history = true,
	}
	pretty_fold.setup{}
	pretty_fold_preview.setup_keybinding()
	stabilize.setup {
		dap = {
			breakpoints = {
				icon = "🛑"
			}
		}
	}
	tabby.setup {}
	gitsigns.setup {
		current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			delay = 200,
		},
	}
	indent_blankline.setup {
		show_current_context = true,
		show_current_context_start = true,
	}
	lualine.setup {
		options = { theme = 'onedark' },
		sections = {
			lualine_a = {
				{ 'filename', path = 1 },
			},
		},
	}

----------------
