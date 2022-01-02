require 'impatient'

local auto_session = require 'auto-session'
local gitsigns = require 'gitsigns'
local hop = require 'hop'
local indent_blankline = require 'indent_blankline'
local lspkind = require 'lspkind'
local lualine = require 'lualine'
local neoclip = require 'neoclip'
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
	}

-----------------------------------------


--------------- Motions ---------------

	hop.setup(
		-- Themes will overwrite this sometimes, this ensures that hop greys out non highlighted letters
		{ create_hl_autocmd = true }
	)

---------------------------------------


----- Misc -----

	auto_session.setup {
		auto_session_root_dir = os.getenv('HOME') .. '/.vim/sessions/',
	}
	neoclip.setup {
		enable_persistant_history = true,
	}
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
	lspkind.init {
		-- enables text annotations
		--
		-- default: true
		with_text = true,

		-- default symbol map
		-- can be either 'default' (requires nerd-fonts font) or
		-- 'codicons' for codicon preset (requires vscode-codicons font)
		--
		-- default: 'default'
		preset = 'codicons',

		-- override preset symbols
		--
		-- default: {}
		symbol_map = {
		  Text = "",
		  Method = "",
		  Function = "",
		  Constructor = "",
		  Field = "ﰠ",
		  Variable = "",
		  Class = "ﴯ",
		  Interface = "",
		  Module = "",
		  Property = "ﰠ",
		  Unit = "塞",
		  Value = "",
		  Enum = "",
		  Keyword = "",
		  Snippet = "",
		  Color = "",
		  File = "",
		  Reference = "",
		  Folder = "",
		  EnumMember = "",
		  Constant = "",
		  Struct = "פּ",
		  Event = "",
		  Operator = "",
		  TypeParameter = ""
		},
	}

----------------
