---- Important

vim.opt.emoji = true

---- Not Important

require('plugins')
require('setup')
if not vim.g.vscode then
	require('null-ls-config')
	require('telescope-config')
	require('language-servers')
	require('debug-config')
end
require('config')
require('mappings')
