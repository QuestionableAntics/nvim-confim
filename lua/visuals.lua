---------- Plugins ----------

	local Plug = vim.fn['plug#']

	vim.call('plug#begin', '~/.vim/plugged')

	--------------------------------------------------

	-- pretty icons everywhere
	Plug 'ryanoasis/vim-devicons'
	-- More pretty icons
	Plug 'kyazdani42/nvim-web-devicons'
	-- highlight matching html tags
	Plug 'gregsexton/MatchTag'
	-- VS Code theme
	Plug 'tomasiser/vim-code-dark'
	-- Nice status bar
	Plug 'nvim-lualine/lualine.nvim'
	-- VS Code Icons for LSP
	Plug 'onsails/lspkind-nvim'

	--------------------------------------------------

	vim.call('plug#end')

--------------------------------------


----- Config -----

	-- Highlight on yank
	vim.cmd 'autocmd TextYankPost * silent! lua vim.highlight.on_yank()'
	vim.cmd 'colorscheme codedark'
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
