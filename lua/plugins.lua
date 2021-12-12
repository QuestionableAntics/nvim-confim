------------------------------ Plugins ------------------------------

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

----------------------------------------------------------------------------



--------------- Setup ---------------

	-- Auto start coq (must be run before require 'coq')
	vim.g.coq_settings = { auto_start = 'shut-up', keymap = { jump_to_mark = '' } }

	-- Database autocompletion on entering a sql buffer
	vim.cmd "autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })"

	require 'impatient'

	local coq = require 'coq'
	local dap = require 'dap'
	local dap_python = require 'dap-python'
	local dap_ui = require 'dapui'
	local gitsigns = require 'gitsigns'
	local hop = require 'hop'
	local indent_blankline = require 'indent_blankline'
	local lsp = require 'lspconfig'
	local lsp_installer = require 'nvim-lsp-installer'
	local lspkind = require 'lspkind'
	local lualine = require 'lualine'
	local null_ls = require 'null-ls'
	local project = require 'project_nvim'
	local stabilize = require 'stabilize'
	local telescope = require 'telescope'
	local treesitter = require 'nvim-treesitter.configs'
	local trouble = require 'trouble'

	------------ Language Servers ------------

		-- Register a handler that will be called for all installed servers.
		-- Alternatively, you may also register handlers on specific server instances instead (see example below).
		lsp_installer.on_server_ready(function(server)
			local opts = {
				coq.lsp_ensure_capabilities{
					capabilities = capabilities
				},
			}

			if server.name == 'sumneko_lua' then
				opts.settings = { ['Lua.diagnostic.globals'] = { 'vim' } }
			end

			-- Setup guide for C#
			-- https://rudism.com/coding-csharp-in-neovim/
			if server.name == 'omnisharp' then
				opts = {
					-- required for coq
					coq.lsp_ensure_capabilities{
						capabilities = capabilities
					},
					on_attach = function(_, bufnr)
						vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
					end,
					cmd = { "/Users/kean.mattingly@equipmentshare.com/Downloads/omnisharp-osx/run", "--languageserver" , "--hostPID", tostring(pid) },
				}
			end

			server:setup(opts)
		end)

	------------------------------------------


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


	-------------------- Debug --------------------

		dap.adapters.python = {
			type = 'executable',
			command = '/Users/kean.mattingly@equipmentshare.com/.pyenv/versions/debugpy/bin/python',
		}
		dap_python.setup('~/.pyenv/versions/debugpy/bin/python')
		dap_ui.setup()

	-----------------------------------------------


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
		lualine.setup { options = { theme = 'onedark' } }
		project.setup {}
		stabilize.setup()
		trouble.setup {}
		indent_blankline.setup {
			show_current_context = true,
			show_current_context_start = true,
		}

		lspkind.init( {
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
		} )

	----------------

----------------------------------------------------------

