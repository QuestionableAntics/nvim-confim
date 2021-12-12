local Plug = vim.fn['plug#']


vim.call('plug#begin', '~/.vim/plugged')

-- Speed up
Plug 'lewis6991/impatient.nvim'

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


---------- Completion ----------

	-- Fast as FUCK autocompletion
	Plug('ms-jpq/coq_nvim', { branch = 'coq' } )
	-- coq.nvim dependency
	Plug('ms-jpq/coq.artifacts', { branch = 'artifacts' } )
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
	Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
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
	-- Plug 'jose-elias-alvarez/null-ls.nvim'

------------------------------------------------------------------

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

vim.call('plug#end')
