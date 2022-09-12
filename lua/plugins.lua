-- https://github.com/wbthomason/packer.nvim

-- Reduce nesting
local use = require('utils').packer_use()

-- Speeds up loading of lua modules for better start up time. Periodically check if this is needed (it will be merged into neovim main at some point)
use {
	'lewis6991/impatient.nvim',
	config = function() require('impatient') end
}

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
use {
	'nvim-lualine/lualine.nvim',
	requires = { 'kyazdani42/nvim-web-devicons', opt = true },
	config = function()
		require('lualine').setup {
			options = { theme = 'onedark' },
			sections = {
				lualine_a = {
					{ 'filename', path = 1 },
				},
			},
		}
	end
}
-- Tabline
use {
	'nanozuki/tabby.nvim',
	config = function() require('tabby').setup{} end
}
-- LSP progress
use {
	'j-hui/fidget.nvim',
	config = function() require('fidget').setup() end
}

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
use {
	'lewis6991/gitsigns.nvim',
	config = function()
		require('gitsigns').setup {
			current_line_blame = true,
			current_line_blame_opts = { delay = 200, },
		}
	end
}
-- git commit browser
use 'junegunn/gv.vim'

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
use 'vim-test/vim-test' -- required for neotest
use {
	'nvim-neotest/neotest',
	requires = {
		'nvim-lua/plenary.nvim',
		'nvim-treesitter/nvim-treesitter',
		'antoinemadec/FixCursorHold.nvim',
		'haydenmeade/neotest-jest',
		'nvim-neotest/neotest-python',
		'nvim-neotest/neotest-vim-test'
	},
}
-- Debug installer
use 'Pocco81/DAPInstall.nvim'
-- Debug Jest
use 'David-Kunz/jester'
-- Develop inside Docker containers
-- use 'jamestthompson3/nvim-remote-containers'

---------------------------------


---------- Code Functionality ----------

-- Automatic pairing of ([{--'
use {
	'windwp/nvim-autopairs',
	config = function() require('nvim-autopairs').setup{} end
}
-- Syntax tree parser for better syntax highlighting among other things
use {
	'nvim-treesitter/nvim-treesitter',
	run = ':TSUpdate',
	config = function()
		require('nvim-treesitter.configs').setup {
			-- either "all" or {"a", "list", "of", "languages"}
			ensure_installed = {
				"python",
				"javascript",
				"typescript",
				"c_sharp",
				"tsx",
				"lua",
				"yaml",
				"graphql",
				"java",
				"scss",
				"css",
				"html",
				"jsdoc",
				"dockerfile",
				"toml",
				"json",
				"json5",
				"markdown"
			},
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
			textobjects = {
				select = {
					enable = true,
					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
			},
		}
	end
}
-- Highlight other instances of word under cursor
use 'yamatsum/nvim-cursorline'
-- Auto close and update jsx tags
use {
	'windwp/nvim-ts-autotag',
	config = function() require('nvim-ts-autotag').setup() end
}
-- jsx aware commenting
use 'JoosepAlviste/nvim-ts-context-commentstring'
-- REPL
use 'metakirby5/codi.vim'
-- Change the surroundings
use 'tpope/vim-surround'
-- use {
-- 	'https://github.com/kylechui/nvim-surround',
-- 	config = function()
-- 		require("nvim-surround").setup()
-- 	end
-- }
-- Better auto indent
use 'yioneko/nvim-yati'
-- Assorted things
-- use 'echasnovski/mini.nvim'

------------------------------------------------------------


---------- Functionality ----------

-- File explorer
use {
	'ms-jpq/chadtree',
	run = 'python3 -m chadtree deps',
	branch = 'chad'
}
-- Fast motions
use {
	'phaazon/hop.nvim',
	config = function()
		require('hop').setup {
			-- Themes will overwrite this sometimes, this ensures that hop greys out non highlighted letters
			create_hl_autocmd = true
		}
	end
}
-- Fuzzy motions
use 'rlane/pounce.nvim'
-- Additional treesitter functionality (in/around function/class/etc. operations)
use 'nvim-treesitter/nvim-treesitter-textobjects'
-- Session Management
use {
	'rmagatti/auto-session',
	config = function()
		require('auto-session').setup{
			auto_session_root_dir = os.getenv('HOME') .. '/.vim/sessions/',
			auto_session_suppress_dirs = { '~/' },
		}
	end
}
-- Session integration for Telescope
use 'rmagatti/session-lens'
-- Enhanced clipboard
use {
	"AckslD/nvim-neoclip.lua",
	config = function()
		require('neoclip').setup{
			enable_persistent_history = true,
			default_register_macros = 'q',
			enable_macro_history = true,
		}
	end,
	requires = {
		{'tami5/sqlite.lua', module = 'sqlite'},
		{'nvim-telescope/telescope.nvim'},
	},
}
-- Comment stuff out with lua (does not work with nvim-ts-context-commentstring currently)
-- use {
-- 	'numToStr/Comment.nvim',
-- 	config = function() require('Comment').setup() end
-- }
-- Comment stuff out
use 'tpope/vim-commentary'
-- Per project navigation
use 'ThePrimeagen/harpoon'
-- Folding
use {
	'anuvyklack/pretty-fold.nvim',
	config = function()
		require('pretty-fold').setup{}
		require('fold-preview').setup{}
	end,
	requires = {
		'anuvyklack/nvim-keymap-amend',
		'https://github.com/anuvyklack/fold-preview.nvim'
	}
}
-- Better Quickfix
use {
	'kevinhwang91/nvim-bqf',
	config = function() require('bqf').setup() end
}

--------------------------------------------------


---------- Completion ----------

-- Fast as FUCK autocompletion
use { 'ms-jpq/coq_nvim', branch = 'coq' }
-- coq.nvim dependency
use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
-- coq.nvim snippets and other third party sources of completion
use {
	'ms-jpq/coq.thirdparty',
	config = function()
		require('coq_3p') {
			{ src = 'vim_dadbod_completion', short_name = 'DB' },
			{ src = 'dap' },
			-- { src = 'copilot', short_name = 'COP', accept_key = '<C-J>'}
		}
	end
}
-- AI in my code
use 'github/copilot.vim'
-- Lua AI in my code
-- use {
-- 	'zbirenbaum/copilot.lua',
-- 	-- event = {"VimEnter"},
-- 	config = function()
-- 		vim.defer_fn(function()
-- 			require("copilot").setup()
-- 		end, 100)
-- 	end,
-- }
-- Autocomplete source for vim dadbod (database)
use 'kristijanhusak/vim-dadbod-completion'

--------------------------------------------


---------- Search ----------

	-- Pretty fuzzy finder
	use {
		'nvim-telescope/telescope.nvim',

		requires = {
			-- rg raw live grep
			'nvim-telescope/telescope-live-grep-args.nvim'
		},
	}
	-- Telescope fzf integration
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	-- dap integration
	use 'nvim-telescope/telescope-dap.nvim'
	-- Uses telescope for the native ui-select
	use 'nvim-telescope/telescope-ui-select.nvim'

------------------------------------


---------- Language Server Stuff ----------

-- A collection of common configurations for Neovim's built-in language server client
-- Handles automatically launching and initializing installed language servers
use 'neovim/nvim-lspconfig'

-- General external editor tooling installation management (Language servers, dap servers, linters, formatters)
use {
	'williamboman/mason.nvim',
	config = function()
		require('mason').setup()
		require('mason-lspconfig').setup()
	end,
	requires = { 'williamboman/mason-lspconfig.nvim' }
}

---- General dependencies
-- popup window interface
use 'nvim-lua/popup.nvim'
-- a bunch of nice functions that creators of nvim plugins don't want to rewrite
use 'nvim-lua/plenary.nvim'
-- language server for alternative completions provided through LSP
use 'jose-elias-alvarez/null-ls.nvim'
-- Make working with TS LS better
use 'jose-elias-alvarez/nvim-lsp-ts-utils'
-- Additional Omnisharp functionality
use 'https://github.com/Hoffs/omnisharp-extended-lsp.nvim'

------------------------------------------------------------------


---------- Misc ----------

-- Don't change initial buffer position when opening new buffer
use {
	'luukvbaal/stabilize.nvim',
	config = function()
		require('stabilize').setup{
			dap = {
				breakpoints = {
					icon = "🛑"
				}
			}
		}
	end
}
-- More speed up
use 'nathom/filetype.nvim'
-- Virtual text to add indentation guides
use {
	'lukas-reineke/indent-blankline.nvim',
	config = function()
		require('indent_blankline').setup{
			show_current_context = true,
			show_current_context_start = true,
		}
	end
}
-- Hints for keybindings
use 'folke/which-key.nvim'
-- Rest Client
-- use 'NTBBloodbath/rest.nvim'
-- Breakdown of what vim spends time on when starting up
-- use 'dstein64/vim-startuptime'
-- Markdown previewer
use {
	'iamcco/markdown-preview.nvim',
	run = 'cd app && npm install',
}
use {
	'https://github.com/phaazon/mind.nvim',
	config = function()
		require('mind').setup{}
	end,
}

--------------------------------


-------- Development --------

-- Reusable UI components
-- use 'MunifTanjim/nui.nvim'

-----------------------------

-- end)
