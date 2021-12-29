local util = require("lspconfig.util")

-- Auto start coq (must be run before require 'coq')
vim.g.coq_settings = {
	-- always start coq (silently)
	auto_start = 'shut-up',
	-- maybe I'll use snippets eventually, but for now I get my tab key back
	keymap = { jump_to_mark = '' },
	-- a lot of what I want from autocomplete is exploring properties on objects, this makes them more visible amongst the noise in large projects by prioritizing lsp results
	clients = { lsp = { weight_adjust = 1.6 } }
}

-- Database autocompletion on entering a sql buffer
vim.cmd "autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })"

require 'impatient'

local auto_session = require 'auto-session'
local coq = require 'coq'
local dap = require 'dap'
local dap_python = require 'dap-python'
local dap_ui = require 'dapui'
local dap_vscode_ext = require 'dap.ext.vscode'
local gitsigns = require 'gitsigns'
local hop = require 'hop'
local indent_blankline = require 'indent_blankline'
local lsp = require 'lspconfig'
local lsp_installer_servers = require 'nvim-lsp-installer.servers'
local lspkind = require 'lspkind'
local lualine = require 'lualine'
-- local null_ls = require 'null-ls'
local project = require 'project_nvim'
local stabilize = require 'stabilize'
local tabby = require 'tabby'
local telescope = require 'telescope'
local treesitter = require 'nvim-treesitter.configs'
local trouble = require 'trouble'
local ultest = require 'ultest'
-- local weather = require'weather'


-- local null_ls_formatting = function(client)
-- 	client.resolved_capabilities.document_formatting = false
-- 	client.resolved_capabilities.document_range_formatting = false
-- end


------------ Language Servers ------------

	local lua_rtp = vim.split(package.path, ";")
	table.insert(lua_rtp, "lua/?.lua")
	table.insert(lua_rtp, "lua/?/init.lua")

	local server_configs = {
		-- the biggest config for the by far least used language
		sumneko_lua = {
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
						path = lua_rtp,
					},
					diagnostics = { globals = { "vim", "coq" } },
					workspace = {
						library = vim.api.nvim_get_runtime_file('', true),
					},
					telemetry = {
						enable = false,
					},
				},
			}
		},
		tsserver = {
			root_dir = util.root_pattern("package.json"),
			-- on_attach = function(client, _)
			-- 	null_ls_formatting(client)
			-- end,
			init_options = {
				lint = true,
			},
		},
		-- Setup guide for C#
		-- https://rudism.com/coding-csharp-in-neovim/
		omnisharp = {
			on_attach = function(_, bufnr)
				vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
			end,
			cmd = {
				"/Users/kean.mattingly@equipmentshare.com/Downloads/omnisharp-osx/run",
				"--languageserver",
				"--hostPID",
				tostring(pid)
			},
		},
		-- and the smallest for the most used lol
		pyright = {},
	}

	for server, config in pairs(server_configs) do
		local server_available, requested_server = lsp_installer_servers.get_server(server)

		if server_available then
			requested_server:on_ready(function ()
				requested_server:setup(
					coq.lsp_ensure_capabilities(config)
				)
			end)

			if not requested_server:is_installed() then
				-- Queue the server to be installed
				requested_server:install()
			end
		end
	end

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
	-- Reference for debugging setup
	-- https://github.com/mfussenegger/dotfiles/blob/master/vim/.config/nvim/lua/me/dap.lua

	dap_python.setup(os.getenv('HOME') .. '/.pyenv/versions/debugpy/bin/python')
	dap_python.test_runner = 'pytest'

	-- dap.adapters.node2 = {
	-- 	type = 'executable',
	-- 	command = 'node',
	-- 	args = {os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
	-- }
	-- dap.configurations.javascript = {
	-- 	{
	-- 		type = 'node2',
	-- 		request = 'launch',
	-- 		program = '${workspaceFolder}/${file}',
	-- 		cwd = '/tmp/',
	-- 		sourceMaps = true,
	-- 		protocol = 'inspector',
	-- 		console = 'integratedTerminal',
	-- 	},
	-- }
	-- dap.adapters.netcoredbg = {
	-- 	type = 'executable',
	-- 	command = os.getenv('HOME') .. '/.local/dotnet/netcoredbg/netcoredbg',
	-- 	args = {'--interpreter=vscode'}
	-- }

	-- dap.configurations.cs = {
	-- 	{
	-- 		type = "netcoredbg",
	-- 		name = "launch - netcoredbg",
	-- 		request = "launch",
	-- 		program = function()
	-- 			return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
	-- 		end,
	-- 		stopAtEntry = true,
	-- 	},
	-- }
	
	ultest.setup({
		builders = {
			['python#pytest'] = function (cmd)
				-- The command can start with python command directly or an env manager
				local non_modules = {'python', 'pipenv', 'poetry'}
				-- Index of the python module to run the test.
				local module_index = 1
				if vim.tbl_contains(non_modules, cmd[1]) then
					module_index = 3
				end
				local module = cmd[module_index]

				-- Remaining elements are arguments to the module
				local args = vim.list_slice(cmd, module_index + 1)
				return {
					dap = {
						type = 'python',
						request = 'launch',
						module = module,
						args = args
					}
				}
			end
		}
	})

	dap_ui.setup()
	-- loads VS Code 'launch.json' for project (if this gets more fleshed out it might be worth converting, but ^ works for now)
	dap_vscode_ext.load_launchjs()


-----------------------------------------------


--------------- Motions ---------------

	hop.setup(
		-- Themes will overwrite this sometimes, this ensures that hop greys out non highlighted letters
		{ create_hl_autocmd = true }
	)

---------------------------------------


----- Misc -----

	auto_session.setup {
		auto_session_root_dir = os.getenv('HOME') .. '/.vim/sessions/',
		-- auto_session_root_dir = '~/.vim/sessions/',
	}
	tabby.setup()
	project.setup()
	stabilize.setup()
	trouble.setup()
	-- weather.setup {}
	gitsigns.setup {
		current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			delay = 200,
		},
	}
	indent_blankline.setup {
		show_current_context = true,
		show_current_context_start = true,
	}
	lualine.setup {
		options = { theme = 'onedark' },
		sections = {
			lualine_a = {
				{ 'filename', path = 1 },
				-- { "require'weather.lualine'.custom(my_custom_formatter, { pending = '羽', error = '' })" }
			},
			-- lualine_b = { "require'weather.lualine'.custom(my_custom_formatter)" },
			-- lualine_c = { default_f },
		},
	}
	lspkind.init {
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
	}

----------------
