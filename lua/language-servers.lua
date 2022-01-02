local util = require("lspconfig.util")

------------- Config -------------

	-- Source is automatically added, you just need to include it in the chain complete list
	vim.g.completion_chain_complete_list = { sql = { complete_items = { 'vim-dadbod-completion' } } }

	-- Database autocompletion on entering a sql buffer
	vim.cmd [[ autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} }) ]]

	-- Run lint on save
	vim.cmd [[ autocmd BufWritePre <buffer> <cmd>EslintFixAll<CR> ]]

	-- Auto start coq (must be run before require 'coq')
	vim.g.coq_settings = {
		-- always start coq (silently)
		auto_start = 'shut-up',
		-- maybe I'll use snippets eventually, but for now I get my tab key back
		keymap = { jump_to_mark = '' },
		-- a lot of what I want from autocomplete is exploring properties on objects
		-- this makes those properties more visible in large projects by prioritizing lsp results
		clients = { lsp = { weight_adjust = 1.6 } }
	}

----------------------------------

local coq = require 'coq'
local lsp_installer_servers = require 'nvim-lsp-installer.servers'
local lspconfig = require 'lspconfig'

------------ Setup ------------

	-- Add more paths to the lua package search path
	local lua_rtp = vim.split(package.path, ";")
	table.insert(lua_rtp, "lua/?.lua")
	table.insert(lua_rtp, "lua/?/init.lua")

	lspconfig.eslint.setup{}

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
		eslint = {},
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
