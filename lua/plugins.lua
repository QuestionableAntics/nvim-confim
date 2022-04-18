-- https://github.com/wbthomason/packer.nvim

require('packer').startup(function(use)

	-- Speed up
	use 'lewis6991/impatient.nvim'

	-- package manager
	use 'wbthomason/packer.nvim'

	---------- Visuals ----------

		-- More pretty icons
		use 'kyazdani42/nvim-web-devicons'
		-- highlight matching html tags
		use 'gregsexton/MatchTag'
		-- VS Code theme
		use 'tomasiser/vim-code-dark'
		-- Nice status bar
		use 'nvim-lualine/lualine.nvim'
		-- Tabline
		use 'nanozuki/tabby.nvim'
		-- LSP progress
		use 'j-hui/fidget.nvim'

	--------------------------------------


	---------- DB ----------

		-- DB interface
		use 'tpope/vim-dadbod'
		-- UI for DB interface
		use 'kristijanhusak/vim-dadbod-ui'
		-- Postgres driver
		use 'jackc/pgx'

	----------------------------


	---------- Version Control ----------

		-- git in vim (required for other git plugins)
		use 'tpope/vim-fugitive'
		-- sign column symbols for git changes and git hunk actions
		use 'lewis6991/gitsigns.nvim'
		-- git commit browser
		use 'junegunn/gv.vim'
		-- easy conflict resolution
		use 'rhysd/conflict-marker.vim'

	------------------------------------------------------


	------------- Debug/Test -------------

		-- Debug adapter protocol, base plugin {name = for debugging}
		use 'mfussenegger/nvim-dap'
		-- Defaults for Python debugging
		use 'mfussenegger/nvim-dap-python'
		-- UI for nvim dap
		use 'rcarriga/nvim-dap-ui'
		-- Virtual Text
		use 'theHamsta/nvim-dap-virtual-text'
		-- Testing
		use 'vim-test/vim-test' -- required for ultest
		use { 'rcarriga/vim-ultest', run = ':UpdateRemotePlugins' }
		-- Debug installer
		use 'Pocco81/DAPInstall.nvim'
		-- Debug Jest
		use 'David-Kunz/jester'
		-- Develop inside Docker containers
		-- use 'jamestthompson3/nvim-remote-containers'

	---------------------------------


	---------- Code Functionality ----------

		-- Automatic pairing of ([{--'
		use 'windwp/nvim-autopairs'
		-- Syntax tree parser for better syntax highlighting among other things
		use {
			'nvim-treesitter/nvim-treesitter',
			run = ':TSUpdate',
			config = function()
				require('nvim-treesitter.configs').setup {
					-- one of "all", "maintained" (parsers with maintainers), or a list of languages
					ensure_installed = "maintained",
					-- ensure_installed = {
					-- 	"python",
					-- 	"javascript",
					-- 	"typescript",
					-- 	"c_sharp",
					-- 	"tsx",
					-- 	"lua",
					-- 	"yaml",
					-- 	"graphql",
					-- 	"java",
					-- 	"scss",
					-- 	"css",
					-- 	"html",
					-- 	"jsdoc",
					-- 	"dockerfile",
					-- 	"toml",
					-- 	"json",
					-- 	"json5",
					-- 	"markdown"
					-- },
					-- false will disable the whole extension
					highlight = { enable = true },
					-- async installation of parsers
					sync_install = false,
					-- something else does indentations already, this would probably be better if I can disable whatever else is indenting
					indent = { enable = false },
					-- enable nvim-ts-context-commentstring
					context_commentstring = { enable = true },
					-- Better auto indent
					-- yati = { enable = true },
				}
			end
		}
		-- use { name = 'nvim-treesitter/nvim-treesitter', opts = { ['do'] = ':TSUpdate' } }
		-- Highlight other instances of word under cursor
		use 'yamatsum/nvim-cursorline'
		-- Auto close and update jsx tags
		use 'windwp/nvim-ts-autotag'
		-- jsx aware commenting
		use 'JoosepAlviste/nvim-ts-context-commentstring'
		-- REPL
		use 'metakirby5/codi.vim'
		-- Change the surroundings
		use 'tpope/vim-surround'
		-- Better auto indent
		use 'yioneko/nvim-yati'
		-- Assorted things
		-- use 'echasnovski/mini.nvim'

	------------------------------------------------------------


	---------- Functionality ----------

		-- File explorer
		use { 'ms-jpq/chadtree', run = 'python3 -m chadtree deps', branch = 'chad' }
		-- Fast motions
		use 'phaazon/hop.nvim'
		-- Fuzzy motions
		use 'rlane/pounce.nvim'
		-- Session Management
		use 'rmagatti/auto-session'
		-- Session integration for Telescope
		use 'rmagatti/session-lens'
		-- Enhanced clipboard
		-- use 'AckslD/nvim-neoclip.lua'
		-- use { name = 'tami5/sqlite.lua', opts = { module = 'sqlite' } }
		use {
		  "AckslD/nvim-neoclip.lua",
		  requires = {
			{'tami5/sqlite.lua', module = 'sqlite'},
			{'nvim-telescope/telescope.nvim'},
		  },
		}
		-- Comment stuff out with lua (does not work with nvim-ts-context-commentstring currently)
		-- use 'numToStr/Comment.nvim'
		-- Comment stuff out
		use 'tpope/vim-commentary'
		-- Per project navigation
		use 'ThePrimeagen/harpoon'
		-- Folding
		use 'anuvyklack/pretty-fold.nvim'
		-- Better Quickfix
		use 'kevinhwang91/nvim-bqf'

	--------------------------------------------------


	---------- Completion ----------

		-- Fast as FUCK autocompletion
		use { 'ms-jpq/coq_nvim', branch = 'coq' }
		-- coq.nvim dependency
		use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
		-- coq.nvim snippets and other third party sources of completion
		use 'ms-jpq/coq.thirdparty'
		-- AI in my code
		use 'github/copilot.vim'
		-- Lua AI in my code
		-- use 'zbirenbaum/copilot.lua'
		-- Autocomplete source for vim dadbod (database)
		use 'kristijanhusak/vim-dadbod-completion'

	--------------------------------------------


	---------- Search ----------

		-- Pretty fuzzy finder
		use 'nvim-telescope/telescope.nvim'
		-- Telescope fzf integration
		use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
		-- rg raw live grep
		use 'nvim-telescope/telescope-rg.nvim'
		-- dap integration
		use 'nvim-telescope/telescope-dap.nvim'
		-- Uses telescope for the native ui-select
		use 'nvim-telescope/telescope-ui-select.nvim'

	------------------------------------


	---------- Language Server Stuff ----------

		-- A collection of common configurations for Neovim's built-in language server client
		-- Handles automatically launching and initializing installed language servers
		use 'neovim/nvim-lspconfig'
		-- LSP installer
		use 'williamboman/nvim-lsp-installer'

		---- General dependencies
		-- popup window interface
		use 'nvim-lua/popup.nvim'
		-- a bunch of nice functions that creators of nvim plugins don't want to rewrite
		use 'nvim-lua/plenary.nvim'
		-- language server for alternative completions provided through LSP
		use 'jose-elias-alvarez/null-ls.nvim'
		-- Make working with TS LS better
		use 'jose-elias-alvarez/nvim-lsp-ts-utils'

	------------------------------------------------------------------


	---------- Misc ----------

		-- Don't change initial buffer position when opening new buffer
		use 'luukvbaal/stabilize.nvim'
		-- More speed up
		use 'nathom/filetype.nvim'
		-- Virtual text to add indentation guides
		use 'lukas-reineke/indent-blankline.nvim'
		-- Hints for keybindings
		use 'folke/which-key.nvim'
		-- Rest Client
		-- use 'NTBBloodbath/rest.nvim'
		-- Breakdown of what vim spends time on when starting up
		-- use 'dstein64/vim-startuptime'

	--------------------------------


	-------- Development --------

		-- Reusable UI components
		-- use 'MunifTanjim/nui.nvim'

	-----------------------------

end)
