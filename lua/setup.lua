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

local coq = require 'coq'
local dap = require 'dap'
local dap_python = require 'dap-python'
local dap_ui = require 'dapui'
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
local telescope = require 'telescope'
local treesitter = require 'nvim-treesitter.configs'
local trouble = require 'trouble'

------------ Language Servers ------------

	local servers = {'pyright', 'tsserver', 'omnisharp', 'sumneko_lua'}

	for _, server in ipairs(servers) do
		local server_available, requested_server = lsp_installer_servers.get_server(server)
		if server_available then
			requested_server:on_ready(function ()
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
				if server == 'omnisharp' then
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

				requested_server:setup(opts)
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
	lualine.setup { options = { theme = 'onedark' }, sections = { lualine_a = { { 'filename', path = 1 } } } }
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
