--------------------- Plugins --------------------- 

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

----------------------------------------------------


----------------- Config -----------------

	-- Make sure `substring` is part of this list. Other items are optional for this completion source
	vim.g.completion_matching_strategy_list = {'fuzzy', 'exact', 'substring'}
	vim.g.completion_matching_ignore_case = 1

	-- Source is automatically added, you just need to include it in the chain complete list
	vim.g.completion_chain_complete_list = { sql = { complete_items = { 'vim-dadbod-completion' } } }

-- Auto start coq (must be run before require 'coq')
	vim.g.coq_settings = { auto_start = 'shut-up', keymap = { jump_to_mark = '' } }
------------------------------------------


-- Database autocompletion on entering a sql buffer
vim.cmd "autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })"


local coq = require 'coq'
