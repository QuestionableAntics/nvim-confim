local VimPlug = vim.fn['plug#']

local function Plug(config)
	local disable = config.disable or false

	if disable then
		return
	end

	if type(config) == 'string' then
		VimPlug(config)
	elseif type(config) == 'table' then
		VimPlug(config.name, config.opts)
	end
end


vim.call('plug#begin', '~/.vim/plugged')

-- Speed up
Plug 'lewis6991/impatient.nvim'

---------- Visuals ----------

	-- More pretty icons
	Plug 'kyazdani42/nvim-web-devicons'
	-- highlight matching html tags
	Plug 'gregsexton/MatchTag'
	-- VS Code theme
	Plug 'tomasiser/vim-code-dark'
	-- Nice status bar
	Plug 'nvim-lualine/lualine.nvim'
	-- Tabline
	Plug 'nanozuki/tabby.nvim'
	-- VS Code Icons for LSP
	-- Plug { name = 'onsails/lspkind-nvim' }
	-- Sidebar
	Plug 'sidebar-nvim/sidebar.nvim'
	-- Dap extension for sidebar
	Plug 'sidebar-nvim/sections-dap'
	-- LSP progress
	Plug 'j-hui/fidget.nvim'

--------------------------------------


---------- DB ----------

	-- DB interface
	Plug 'tpope/vim-dadbod'
	-- UI for DB interface
	Plug 'kristijanhusak/vim-dadbod-ui'
	-- Postgres driver
	Plug 'jackc/pgx'

----------------------------


---------- Version Control ----------

	-- git functions on vim command line
	Plug 'tpope/vim-fugitive'
	-- sign column symbols for git changes and git hunk actions
	Plug 'lewis6991/gitsigns.nvim'
	-- git commit browser
	Plug 'junegunn/gv.vim'

------------------------------------------------------


------------- Debug/Test -------------

	-- Debug adapter protocol, base plugin {name = for debugging}
	Plug 'mfussenegger/nvim-dap'
	-- Defaults for Python debugging
	Plug 'mfussenegger/nvim-dap-python'
	-- UI for nvim dap
	Plug 'rcarriga/nvim-dap-ui'
	-- Virtual Text
	Plug 'theHamsta/nvim-dap-virtual-text'
	-- Testing
	Plug 'vim-test/vim-test' -- required for ulte
	Plug { name = 'rcarriga/vim-ultest', opts = { ['do'] = ':UpdateRemotePlugins' } }
	-- Debug installer
	Plug 'Pocco81/DAPInstall.nvim'
	-- Debug Jest
	Plug 'David-Kunz/jester'

---------------------------------


---------- Code Functionality ----------

	-- Automatic pairing of ([{--'
	Plug 'tmsvg/pear-tree'
	-- Syntax tree parser for better syntax highlighting
	Plug { name = 'nvim-treesitter/nvim-treesitter', opts = { ['do'] = ':TSUpdate' } }
	-- Pretty diagnostics and easy navigation
	Plug 'folke/trouble.nvim'
	-- Highlight other instances of word under cursor
	Plug 'yamatsum/nvim-cursorline'
	-- Auto close and update jsx tags
	Plug 'windwp/nvim-ts-autotag'
	-- jsx aware commenting
	Plug 'JoosepAlviste/nvim-ts-context-commentstring'
	-- REPL
	Plug 'metakirby5/codi.vim'

------------------------------------------------------------


---------- Functionality ----------

	-- File explorer
	Plug { name = 'ms-jpq/chadtree', opts = { branch = 'chad', ['do'] = 'python3 -m chadtree deps' } }
	-- Fast motions
	Plug { name = 'phaazon/hop.nvim', disable = vim.g.vscode}
	-- Fuzzy motions
	Plug 'rlane/pounce.nvim'
	-- Session Management
	Plug 'rmagatti/auto-session'
	-- Session integration for Telescope
	Plug 'rmagatti/session-lens'
	-- Enhanced clipboard
	Plug 'AckslD/nvim-neoclip.lua'
	Plug { name = 'tami5/sqlite.lua', opts = { module = 'sqlite' } }
	-- Comment stuff out
	Plug 'tpope/vim-commentary'
	-- Per project navigation
	Plug 'ThePrimeagen/harpoon'
	-- Folding
	Plug 'anuvyklack/pretty-fold.nvim'

--------------------------------------------------


---------- Completion ----------

	-- Fast as FUCK autocompletion
	Plug { name = 'ms-jpq/coq_nvim', opts = { branch = 'coq' } }
	-- coq.nvim dependency
	Plug { name = 'ms-jpq/coq.artifacts', opts = { branch = 'artifacts' } }
	-- coq.nvim snippets and other third party sources of completion
	Plug 'ms-jpq/coq.thirdparty'
	-- AI in my code
	Plug 'github/copilot.vim'
	-- Autocomplete source for vim dadbod (database)
	Plug 'kristijanhusak/vim-dadbod-completion'
	---- nvim cmp
	Plug 'hrsh7th/nvim-cmp'

--------------------------------------------


---------- Search ----------

	-- Pretty fuzzy finder
	Plug 'nvim-telescope/telescope.nvim'
	-- fzf
	Plug { name = 'nvim-telescope/telescope-fzf-native.nvim', opts = { ['do'] = 'make' } }
	-- dap integration
	Plug 'nvim-telescope/telescope-dap.nvim'

------------------------------------


---------- Language Server Stuff ----------

	-- A collection of common configurations for Neovim's built-in language server client
	-- Handles automatically launching and initializing installed language servers
	Plug 'neovim/nvim-lspconfig'
	-- LSP installer
	Plug 'williamboman/nvim-lsp-installer'

	---- General dependencies
	-- popup window interface
	Plug 'nvim-lua/popup.nvim'
	-- a bunch of nice functions that creators of nvim plugins don't want to rewrite
	Plug 'nvim-lua/plenary.nvim'
	-- language server for alternative completions provided through LSP (don't have a use for it right now, but it seems neat)
	Plug 'jose-elias-alvarez/null-ls.nvim'
	-- Make working with TS LS better
	Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

------------------------------------------------------------------

---------- Misc ----------

	-- Don't change initial buffer position when opening new buffer
	Plug 'luukvbaal/stabilize.nvim'
	-- More speed up
	Plug 'nathom/filetype.nvim'
	-- Virtual text to add indentation guides
	Plug 'lukas-reineke/indent-blankline.nvim'
	-- Use vim anywhere
	-- vim.cmd [[ Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } ]]

--------------------------------

vim.call('plug#end')
