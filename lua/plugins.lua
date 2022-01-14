local VimPlug = vim.fn['plug#']

local function Plug(config)
	local disable = config.disable or false

	if disable then
		return
	end

	if config.opts then
		VimPlug(config.name, config.opts)
	else
		VimPlug(config.name)
	end
end


vim.call('plug#begin', '~/.vim/plugged')

-- Speed up
Plug { name = 'lewis6991/impatient.nvim' }

---------- Visuals ----------

	-- More pretty icons
	Plug { name = 'kyazdani42/nvim-web-devicons' }
	-- highlight matching html tags
	Plug { name = 'gregsexton/MatchTag' }
	-- VS Code theme
	Plug { name = 'tomasiser/vim-code-dark' }
	-- Nice status bar
	Plug { name = 'nvim-lualine/lualine.nvim' }
	-- Tabline
	Plug { name = 'nanozuki/tabby.nvim' }
	-- VS Code Icons for LSP
	-- Plug { name = 'onsails/lspkind-nvim' }

--------------------------------------


---------- DB ----------

	-- DB interface
	Plug { name = 'tpope/vim-dadbod' }
	-- UI for DB interface
	Plug { name = 'kristijanhusak/vim-dadbod-ui' }
	-- Postgres driver
	Plug { name = 'jackc/pgx' }

----------------------------


---------- Version Control ----------

	-- git functions on vim command line
	Plug { name = 'tpope/vim-fugitive' }
	-- sign column symbols for git changes and git hunk actions
	Plug { name = 'lewis6991/gitsigns.nvim' }
	-- git commit browser
	Plug { name = 'junegunn/gv.vim' }

------------------------------------------------------


------------- Debug/Test -------------

	-- Debug adapter protocol, base plugin {name = for debugging}
	Plug { name = 'mfussenegger/nvim-dap' }
	-- Defaults for Python debugging
	Plug { name = 'mfussenegger/nvim-dap-python' }
	-- UI for nvim dap
	Plug { name = 'rcarriga/nvim-dap-ui' }
	-- Virtual Text
	Plug { name = 'theHamsta/nvim-dap-virtual-text' }
	-- Testing
	Plug { name = 'vim-test/vim-test' } -- required for ultest
	Plug { name = 'rcarriga/vim-ultest', opts = { ['do'] = ':UpdateRemotePlugins' } }
	-- Debug installer
	Plug { name = 'Pocco81/DAPInstall.nvim' }
	-- Debug Jest
	Plug { name = 'David-Kunz/jester' }

---------------------------------


---------- Code Functionality ----------

	-- Automatic pairing of ([{--'
	Plug { name = 'tmsvg/pear-tree' }
	-- Syntax tree parser for better syntax highlighting
	Plug { name = 'nvim-treesitter/nvim-treesitter', opts = { ['do'] = ':TSUpdate' } }
	-- Pretty diagnostics and easy navigation
	Plug { name = 'folke/trouble.nvim' }
	-- Highlight other instances of word under cursor
	Plug { name = 'yamatsum/nvim-cursorline' }
	-- Auto close and update jsx tags
	Plug { name = 'windwp/nvim-ts-autotag' }
	-- jsx aware commenting
	Plug { name = 'JoosepAlviste/nvim-ts-context-commentstring' }

------------------------------------------------------------


---------- Functionality ----------

	-- File explorer
	Plug { name = 'ms-jpq/chadtree', opts = { branch = 'chad', ['do'] = 'python3 -m chadtree deps' } }
	-- Fast motions
	Plug { name = 'phaazon/hop.nvim', disable = vim.g.vscode}
	-- Session Management
	Plug { name = 'rmagatti/auto-session' }
	-- Session integration for Telescope
	Plug { name = 'rmagatti/session-lens' }
	-- Enhanced clipboard
	Plug { name = 'AckslD/nvim-neoclip.lua' }
	Plug { name = 'tami5/sqlite.lua', opts = { module = 'sqlite' } }
	-- Comment stuff out
	Plug { name = 'tpope/vim-commentary' }
	-- Per project navigation
	Plug { name = 'ThePrimeagen/harpoon' }
	-- Folding
	Plug { name = 'anuvyklack/pretty-fold.nvim' }

--------------------------------------------------


---------- Completion ----------

	-- Fast as FUCK autocompletion
	Plug { name = 'ms-jpq/coq_nvim', opts = { branch = 'coq' } }
	-- coq.nvim dependency
	Plug { name = 'ms-jpq/coq.artifacts', opts = { branch = 'artifacts' } }
	-- coq.nvim snippets and other third party sources of completion
	Plug { name = 'ms-jpq/coq.thirdparty' }
	-- AI in my code
	Plug { name = 'github/copilot.vim' }
	-- Autocomplete source for vim dadbod (database)
	Plug { name = 'kristijanhusak/vim-dadbod-completion' }
	---- nvim cmp
	Plug { name = 'hrsh7th/nvim-cmp' }

--------------------------------------------


---------- Search ----------

	-- Pretty fuzzy finder
	Plug { name = 'nvim-telescope/telescope.nvim' }
	-- fzf
	Plug { name = 'nvim-telescope/telescope-fzf-native.nvim', opts = { ['do'] = 'make' } }
	-- dap integration
	Plug { name = 'nvim-telescope/telescope-dap.nvim' }

------------------------------------


---------- Language Server Stuff ----------

	-- A collection of common configurations for Neovim's built-in language server client
	-- Handles automatically launching and initializing installed language servers
	Plug { name = 'neovim/nvim-lspconfig' }
	-- LSP installer
	Plug { name = 'williamboman/nvim-lsp-installer' }

	---- General dependencies
	-- popup window interface
	Plug { name = 'nvim-lua/popup.nvim' }
	-- a bunch of nice functions that creators of nvim plugins don't want to rewrite
	Plug { name = 'nvim-lua/plenary.nvim' }
	-- language server for alternative completions provided through LSP (don't have a use for it right now, but it seems neat)
	Plug { name = 'jose-elias-alvarez/null-ls.nvim' }
	-- Make working with TS LS better
	Plug { name = 'jose-elias-alvarez/nvim-lsp-ts-utils' }

------------------------------------------------------------------

---------- Misc ----------

	-- Don't change initial buffer position when opening new buffer
	Plug { name = 'luukvbaal/stabilize.nvim' }
	-- More speed up
	Plug { name = 'nathom/filetype.nvim' }
	-- Virtual text to add indentation guides
	Plug { name = 'lukas-reineke/indent-blankline.nvim' }
	-- Use vim anywhere
	-- vim.cmd [[ Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } ]]

--------------------------------

vim.call('plug#end')
