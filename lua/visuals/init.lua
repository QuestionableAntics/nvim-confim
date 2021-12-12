----- Config -----

	-- Highlight on yank
	vim.cmd 'autocmd TextYankPost * silent! lua vim.highlight.on_yank()'
	-- vim.cmd 'colorscheme codedark'
	vim.g.db_ui_use_nerd_fonts = 1
	vim.g.diagnostic_enable_virtual_text = 1

-------------------


--------------- Setup ---------------

local lspkind = require 'lspkind'
local lualine = require 'lualine'

lualine.setup { options = { theme = 'onedark' } }
lspkind.init( {
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
} )

-------------------------------------
