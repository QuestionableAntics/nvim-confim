local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.vim/plugged')

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

vim.call('plug#end')


local lsp = require 'lspconfig'
local lsp_installer = require 'nvim-lsp-installer'
local null_ls = require 'null-ls'

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


