local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.vim/plugged')

	-- Debug adapter protocol, base plugin for debugging
	Plug 'mfussenegger/nvim-dap'
	-- Defaults for Python debugging
	Plug 'mfussenegger/nvim-dap-python'
	-- UI for nvim dap
	Plug 'rcarriga/nvim-dap-ui'
	-- Virtual Text
	Plug 'theHamsta/nvim-dap-virtual-text'

vim.call('plug#end')

local dap = require 'dap'
local dap_python = require 'dap-python'
local dap_ui = require 'dapui'

dap.adapters.python = {
	type = 'executable',
	command = '/Users/kean.mattingly@equipmentshare.com/.pyenv/versions/debugpy/bin/python',
}
dap_python.setup('~/.pyenv/versions/debugpy/bin/python')
dap_ui.setup()


