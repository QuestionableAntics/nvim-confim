------------------------------ Plugins ------------------------------

	local Plug = vim.fn['plug#']


	vim.call('plug#begin', '~/.vim/plugged')

	-- Speed up
	Plug 'lewis6991/impatient.nvim'


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


	---------- Code Functionality ----------

		-- Automatic pairing of ([{--'
		Plug 'tmsvg/pear-tree'
		-- Syntax tree parser for better syntax highlighting
		Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' } )
		-- Comment stuff out
		Plug 'tpope/vim-commentary'
		-- Debug adapter protocol, base plugin for debugging
		Plug 'mfussenegger/nvim-dap'
		-- Defaults for Python debugging
		Plug 'mfussenegger/nvim-dap-python'
		-- UI for nvim dap
		Plug 'rcarriga/nvim-dap-ui'
		-- Virtual Text
		Plug 'theHamsta/nvim-dap-virtual-text'
		-- Pretty diagnostics and easy navigation
		Plug 'folke/trouble.nvim'

	------------------------------------------------------------


	---------- Functionality ----------

		-- File explorer
		Plug('ms-jpq/chadtree', { branch = 'chad', ['do'] = 'python3 -m chadtree deps'} )
		-- Fast motions
		Plug 'phaazon/hop.nvim'
		-- Session Management
		-- Plug 'rmagatti/auto-session'
		-- Fast project switching
		Plug 'ahmedkhalf/project.nvim'

	--------------------------------------------------


	---------- Search ----------

		-- Pretty fuzzy finder
		Plug 'nvim-telescope/telescope.nvim'
		-- fzf
		Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
		-- dap integration
		Plug 'nvim-telescope/telescope-dap.nvim'

	------------------------------------


	---------- Misc ----------

		-- Don't change initial buffer position when opening new buffer
		Plug 'luukvbaal/stabilize.nvim'
		-- Personal Plugins
		Plug '~/Projects/Personal/nvim-plugins/layout.nvim'
		-- More speed up
		Plug 'nathom/filetype.nvim'
		-- Virtual text to add indentation guides
		Plug 'lukas-reineke/indent-blankline.nvim'
		-- Use vim anywhere
		vim.cmd [[ Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } ]]

	--------------------------------


	---------- Visuals ----------

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

	-----------------------------


	---------- LSP  ----------

		-- A collection of common configurations for Neovim's built-in language server client
		-- Handles automatically launching and initializing installed language servers
		Plug 'neovim/nvim-lspconfig'
		-- SQL language server
		Plug 'nanotee/sqls.nvim'
		-- TS language server
		Plug 'typescript-language-server/typescript-language-server'
		-- LSP installer
		Plug 'williamboman/nvim-lsp-installer'

		---- General dependencies
		-- popup window interface
		Plug 'nvim-lua/popup.nvim'
		-- a bunch of nice functions that creators of nvim plugins don't want to rewrite
		Plug 'nvim-lua/plenary.nvim'
		-- language server for alternative completions provided through LSP
		Plug 'jose-elias-alvarez/null-ls.nvim'

	--------------------------


	---------- Autocompletion  ----------

		-- Autocomplete source for vim dadbod (database)
		Plug 'kristijanhusak/vim-dadbod-completion'
		-- Fast as FUCK autocompletion
		Plug('ms-jpq/coq_nvim', { branch = 'coq' } )
		-- coq.nvim dependency
		Plug('ms-jpq/coq.artifacts', { branch = 'artifacts' } )
		-- coq.nvim snippets and other third party sources of completion
		Plug 'ms-jpq/coq.thirdparty'
		-- AI in my code
		Plug 'github/copilot.vim'
		---- nvim cmp
		Plug 'hrsh7th/nvim-cmp'

	--------------------------------------


	vim.call('plug#end')

----------------------------------------------------------------------------



--------------- Setup ---------------

	require 'impatient'

	local gitsigns = require 'gitsigns'
	local hop = require 'hop'
	local indent_blankline = require 'indent_blankline'
	local project = require 'project_nvim'
	local stabilize = require 'stabilize'
	local telescope = require 'telescope'
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


	--------------- Fuzzy Finder ---------------

		telescope.setup{
			defaults = {
				-- rip grep really lives up to the rip part in certain projects otherwise
				file_ignore_patterns = { "node_modules", "^.git/", "^.aws-sam/" },
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
		telescope.load_extension('fzf')
		telescope.load_extension('projects')
		telescope.load_extension('dap')

	--------------------------------------------

	--------------- Motions ---------------

		hop.setup(
			-- Themes will overwrite this sometimes, this ensures that hop greys out non highlighted letters
			{ create_hl_autocmd = true }
		)

	---------------------------------------

	----- Misc -----

		gitsigns.setup{
			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				delay = 200,
			},
		}
		project.setup {}
		stabilize.setup()
		trouble.setup {}
		indent_blankline.setup {
			show_current_context = true,
			show_current_context_start = true,
		}

	----------------

----------------------------------------------------------

	vim.cmd 'colorscheme codedark'
