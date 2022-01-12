require 'impatient'

local autotag = require 'nvim-ts-autotag'
local auto_session = require 'auto-session'
local gitsigns = require 'gitsigns'
local hop = require 'hop'
local indent_blankline = require 'indent_blankline'
local lsp_signature = require 'lsp_signature'
local lualine = require 'lualine'
local neoclip = require 'neoclip'
local pretty_fold = require 'pretty-fold'
local pretty_fold_preview = require 'pretty-fold.preview'
local stabilize = require 'stabilize'
local tabby = require 'tabby'
local treesitter = require 'nvim-treesitter.configs'
local trouble = require 'trouble'

--------------- Treesitter ---------------

	treesitter.setup {
		-- one of "all", "maintained" (parsers with maintainers), or a list of languages
		ensure_installed = "maintained",
		-- false will disable the whole extension
		highlight = { enable = true },
		-- something else does indentations already, this would probably be better if I can disable whatever else is indenting
		indent = { enable = false },
		-- enable nvim-ts-context-commentstring
		context_comment_string = {
			enable = true,
		}
	}

-----------------------------------------


--------------- Motions ---------------

	hop.setup(
		-- Themes will overwrite this sometimes, this ensures that hop greys out non highlighted letters
		{ create_hl_autocmd = true }
	)

---------------------------------------


----- Misc -----

	autotag.setup()
	auto_session.setup {
		auto_session_root_dir = os.getenv('HOME') .. '/.vim/sessions/',
		auto_session_suppress_dirs = { '~/' },
	}
	lsp_signature.setup()
	neoclip.setup {
		enable_persistant_history = true,
	}
	pretty_fold.setup{}
	pretty_fold_preview.setup_keybinding()
	stabilize.setup()
	tabby.setup()
	trouble.setup()
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
