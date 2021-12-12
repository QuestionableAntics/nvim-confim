local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.vim/plugged')

	-- Autocomplete source for vim dadbod (database)
	Plug 'kristijanhusak/vim-dadbod-completion'
	-- Fast as FUCK autocompletion
	Plug('ms-jpq/coq_nvim', { branch = 'coq' } )
	-- coq.nvim dependency
	Plug('ms-jpq/coq.artifacts', { branch = 'artifacts' } )
	-- coq.nvim snippets and other third party sources of completion
	Plug 'ms-jpq/coq.thirdparty'
	-- AI in my code
	Plug 'github/copilot.vim'
	---- nvim cmp
	Plug 'hrsh7th/nvim-cmp'


vim.call('plug#end')

-- Auto start coq (must be run before require 'coq')
vim.g.coq_settings = { auto_start = 'shut-up', keymap = { jump_to_mark = '' } }

-- Database autocompletion on entering a sql buffer
-- vim.cmd "autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })"


local coq = require 'coq'
