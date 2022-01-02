local dap_python = require 'dap-python'
local dap_ui = require 'dapui'
-- local dap_vscode_ext = require 'dap.ext.vscode'
-- local dap = require 'dap'
local ultest = require 'ultest'

--------------- Config ----------------

-- Enable virtual text.
vim.g.dap_virtual_text = true

-- Fancy breakpoint symbol.
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

-- logs live at ~/.cache/nvim/dap.log
-- one of TRACE, DEBUG, INFO, WARN, ERROR
-- dap.set_log_level('DEBUG')

-- Colored output
vim.g.ultest_use_pty = 1

-- Display variable values as virtual text next to the variable
vim.g.diagnostic_enable_virtual_text = 1

---------------------------------------


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
	-- loads VS Code 'launch.json' for project (if this allows adding env variables it'd be worth adding back in)
	-- dap_vscode_ext.load_launchjs()

-----------------------------------------------
