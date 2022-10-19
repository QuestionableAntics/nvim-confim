-- https://github.com/wbthomason/packer.nvim

-- Reduce nesting
local utils = require('utils')
local use = utils.packer_use()

-- Speeds up loading of lua modules for better start up time.
-- Periodically check if this is needed (it will be merged into neovim main at some point)
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
-- Other VS Code theme
-- use {
-- 	'Mofiqul/vscode.nvim',
-- 	config = function()
-- 		-- vim.o.background = 'dark'
--
-- 		require('vscode').setup{
-- 			transparent = true,
-- 			italic_comments = true,
-- 		}
-- 	end
-- }
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
-- Debug Jest
use 'David-Kunz/jester'

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
	-- Last commit before a breaking change that changes what highlight groups use to work
	-- check if this is still needed
	commit = '4cccb6f',
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
				"markdown",
				"http"
			},
			highlight = { enable = true },
			-- async installation of parsers
			sync_install = false,
			indent = { enable = true },
			-- enable nvim-ts-context-commentstring
			context_commentstring = { enable = true },
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
-- Comment stuff out with lua
use {
	'numToStr/Comment.nvim',
	config = function()
		require('Comment').setup {
			pre_hook = function(ctx)
			-- Only calculate commentstring for tsx filetypes
			if vim.bo.filetype == 'typescriptreact' then
				local U = require('Comment.utils')

				-- Determine whether to use linewise or blockwise commentstring
				local type = ctx.ctype == U.ctype.linewise and '__default' or '__multiline'

				-- Determine the location where to calculate commentstring from
				local location = nil
				if ctx.ctype == U.ctype.blockwise then
					location = require('ts_context_commentstring.utils').get_cursor_location()
				elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
					location = require('ts_context_commentstring.utils').get_visual_start_location()
				end

				return require('ts_context_commentstring.internal').calculate_commentstring({
					key = type,
					location = location,
				})
			end
		end,
		}
	end
}
-- Folding
use {
	'anuvyklack/pretty-fold.nvim',
	config = function()
		require('pretty-fold').setup{}
		require('fold-preview').setup{}
	end,
	requires = {
		'anuvyklack/nvim-keymap-amend',
		'anuvyklack/fold-preview.nvim'
	}
}
-- Better Quickfix
use {
	'kevinhwang91/nvim-bqf',
	config = function() require('bqf').setup() end
}

-- Track mouse
use 'DanilaMihailov/beacon.nvim'

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
use {
	"rest-nvim/rest.nvim",
	requires = { "nvim-lua/plenary.nvim" },
	-- ft = {'http'},
	config = function()
		require("rest-nvim").setup({
			json = "jq",
		})

		-- local wk = require('which-key')
		-- local rest_nvim = require('rest-nvim')

		-- utils.map('n', '<C-k>', rest_nvim.run)

		-- wk.register({
		-- 	["<C-k>"] = {
		-- 		mode = 'n',
		-- 		action = rest_nvim.run,
		-- 		label = "Run",
		-- 		buffer = vim.api.nvim_get_current_buf()
		-- 	}
		-- })
		--
		-- maybe someday
		-- _G.WhichkeyHTTP = function()
		-- 	local wk = require('which-key')
		-- 	local rest_nvim = require('rest-nvim')

		-- 	-- utils.map('n', '<C-k>', rest_nvim.run)


		-- 	wk.register({
		-- 		["<C-k>"] = {
		-- 			mode = 'n',
		-- 			action = rest_nvim.run,
		-- 			label = "Run",
		-- 			buffer = vim.api.nvim_get_current_buf()
		-- 		}
		-- 	})
		-- end

		-- vim.cmd[[
		-- 	autocmd FileType http lua WhichkeyHTTP()
		-- ]]

	end
}
-- Markdown previewer
use {
	'iamcco/markdown-preview.nvim',
	run = 'cd app && npm install',
}

-- modify filepath and file contents in Quickfix buffer
use 'gabrielpoca/replacer.nvim'

--------------------------------


-------- Development --------

-- Reusable UI components
-- use 'MunifTanjim/nui.nvim'

-----------------------------


-------- Currently Unused --------

local CurrentlyUnused = function()
	-- Note taking functionality
	use {
		'phaazon/mind.nvim',
		config = function()
			require('mind').setup{}
		end,
	}
	-- Breakdown of what vim spends time on when starting up
	use 'dstein64/vim-startuptime'
	-- Additional Omnisharp functionality
	use 'Hoffs/omnisharp-extended-lsp.nvim'
	-- Assorted things
	use 'echasnovski/mini.nvim'
	-- Manipulate object surrounding characters
	use {
		'https://github.com/kylechui/nvim-surround',
		config = function()
			require("nvim-surround").setup()
		end
	}
	-- Per project navigation
	use 'ThePrimeagen/harpoon'
	-- Undo Tree
	use 'mbbill/undotree'
	-- Develop inside Docker containers
	use 'jamestthompson3/nvim-remote-containers'

	-- Lua AI in my code
	use {
		'zbirenbaum/copilot.lua',
		-- event = {"VimEnter"},
		config = function()
			vim.defer_fn(function()
				require('copilot').setup({
				  panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
					  jump_prev = "[[",
					  jump_next = "]]",
					  accept = "<CR>",
					  refresh = "gr",
					  open = "<M-CR>"
					},
				  },
				  suggestion = {
					enabled = true,
					auto_trigger = false,
					debounce = 75,
					keymap = {
					 accept = "<C-J>",
					 next = "<M-]>",
					 prev = "<M-[>",
					 dismiss = "<C-]>",
					},
				  },
				  filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				  },
				  copilot_node_command = 'node', -- Node version must be < 18
				  plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
				  server_opts_overrides = {},
				})
				-- require("copilot").setup()
			end, 100)
		end,
	}


end
