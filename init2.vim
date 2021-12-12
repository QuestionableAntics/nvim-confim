
""" Important

set emoji

""" Not Important

" Let me backspace like I want
set backspace=indent,eol,start
" Hybrid line numbers: shows relative number for all lines, but shows absolute for current line
set number relativenumber
set nu rnu
" Case insensitive searching
set ignorecase
" If a capital is included, make the search case sensitive
set smartcase
" Show completion options in command view
set wildmenu
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Set default grep to ripgrep
set grepprg=rg\ --vimgrep

" Make tab width equivalent to 4 spaces
set tabstop=4
" Make an indent equivalent to 4 spaces
set shiftwidth=4
" Indent is converted into spaces
" set expandtab

" Syntax highlighting
" syntax on

" Not 100% sure what these are for, but I don't want to forget them yet
" filetype plugin on
" filetype plugin indent on

" How long before a swp file is written and a CursorHold event is triggered
" Having longer updatetime (default is 4000 ms) leads to noticeable delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Allow for width of numbers and arbitrary symbols in sign column
set signcolumn=yes:1

" Maintain undo history between sessions
set undofile 
set undodir=~/.vim/undodir/


""""""""""""""""""""""""""""""""""""""""""""""""""" Plugs """""""""""""""""""""""""""""""""""""""""""""""""""


    call plug#begin('~/.vim/plugged')


    """"" Visuals """""

        " pretty icons everywhere
        Plug 'ryanoasis/vim-devicons'
        " More pretty icons
        Plug 'kyazdani42/nvim-web-devicons'
        " rainbow parenthesis
        Plug 'luochen1990/rainbow'
        " highlight matching html tags
        Plug 'gregsexton/MatchTag'
        " VS Code theme
        Plug 'tomasiser/vim-code-dark'

		" Faster nice status bar
		Plug 'nvim-lualine/lualine.nvim'

        " Nice status bar
        " Plug 'vim-airline/vim-airline'
        " " Nice looking status bar
        " Plug 'vim-airline/vim-airline-themes'

    """""""""""""""""""


    """"" DB """""

        " DB interface
        Plug 'tpope/vim-dadbod'
        " UI for DB interface
        Plug 'kristijanhusak/vim-dadbod-ui'
        " Postgres driver
        Plug 'jackc/pgx'

    """"""""""""""


    """"" Version Control """""

        " git functions on vim command line
        Plug 'tpope/vim-fugitive'
        " sign column symbols for git changes and git hunk actions
        Plug 'airblade/vim-gitgutter'
        " git commit browser
        Plug 'junegunn/gv.vim'

    """""""""""""""""""""""""""


    """"" Code Functionality """""

        " Automatic pairing of ([{"'
        Plug 'tmsvg/pear-tree'
        " Syntax tree parser for better syntax highlighting
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        " Comment stuff out
        Plug 'tpope/vim-commentary'
        " Debug adapter protocol, base plugin for debugging
        Plug 'mfussenegger/nvim-dap'
        " Defaults for Python debugging
        Plug 'mfussenegger/nvim-dap-python'
        " UI for nvim dap
        Plug 'rcarriga/nvim-dap-ui'
		" Virtual Text
		Plug 'theHamsta/nvim-dap-virtual-text'
        " Pretty diagnostics and easy navigation
        Plug 'folke/trouble.nvim'

    """"""""""""""""""""""""""""""


    """"" Functionality """""

        " File explorer
        Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
        " Fast motions
        Plug 'phaazon/hop.nvim'
        " Minimal common set of functionality upon getting into vim
            " (mainly for easy access to recently opened files)
        " Plug 'glepnir/dashboard-nvim'
        " Instantly resize focused pane to 66% of available screen real estate 
        Plug 'roman/golden-ratio'
        " Session Management 
        " Plug 'rmagatti/auto-session'

    """""""""""""""""""""""""


    """"" Completion """""

        " Autocomplete source for vim dadbod (database)
        Plug 'kristijanhusak/vim-dadbod-completion'           " Re-enable this if vim-dadbod-completion is updated to be compatile with neovim 0.6
        " Fast as FUCK autocompletion
        Plug 'ms-jpq/coq_nvim', { 'branch': 'coq' }
        " coq.nvim dependency
        Plug 'ms-jpq/coq.artifacts', { 'branch': 'artifacts' }
        " coq.nvim snippets and other third party sources of completion
        Plug 'ms-jpq/coq.thirdparty'
        " AI in my code
        Plug 'github/copilot.vim'
		"" nvim cmp
		Plug 'hrsh7th/nvim-cmp'

    """"""""""""""""""""""


    """"" Search """""

        " Pretty fuzzy finder
        Plug 'nvim-telescope/telescope.nvim'

    """"""""""""""""""


    """"" Language Server Stuff """""

        " A collection of common configurations for Neovim's built-in language server client
        " Handles automatically launching and initializing installed language servers
        Plug 'neovim/nvim-lspconfig'
        " SQL language server
        Plug 'nanotee/sqls.nvim'
        " TS language server
        Plug 'typescript-language-server/typescript-language-server'

        "" General dependencies
        " popup window interface
        Plug 'nvim-lua/popup.nvim'
        " a bunch of nice functions that creators of nvim plugins don't want to rewrite
        Plug 'nvim-lua/plenary.nvim'
        " language server for alternative completions provided through LSP
        Plug 'jose-elias-alvarez/null-ls.nvim'

    """""""""""""""""""""""""""""""""

    """"" Misc """""

    " Don't change initial buffer position when opening new buffer
    Plug 'luukvbaal/stabilize.nvim'
	" Personal Plugins
	Plug '~/Projects/Personal/nvim-plugins/layout.nvim'
	" Speed up
	Plug 'lewis6991/impatient.nvim' 	
	" More speed up
	Plug 'nathom/filetype.nvim'

    """"""""""""""""


    call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""" Mappings """""""""""""""""""""""""""""""""""""""""""""

    let mapleader = ";"
    imap jk <ESC>
    cmap jk <ESC>
	" Get me the fuck out of the terminal
	tnoremap jk <C-\><C-N>


    """"""""""""""""""" Random """""""""""""""""""
    
        " Double ESC to de-highlight
        nnoremap <esc> <esc>:noh<CR>
        " Sets current pane to 66% of available window height or width (whichever are applicable)
        nnoremap <leader>rs <cmd>GoldenRatioResize<CR>           
        " Open file explorer
        nnoremap <leader>v <cmd>CHADopen<cr>                     

        "" Use <Tab> and <S-Tab> to navigate through popup menu
        inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

        "" Copilot accept remap
        imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")

        "" change pane by direction
        map <C-j> <C-W>j
        map <C-k> <C-W>k
        map <C-h> <C-W>h
        map <C-l> <C-W>l

        "" resize panes
        nmap <silent>_ :vertical resize -15<CR>
        nmap <silent>+ :vertical resize +15<CR>
        nmap <silent>= :resize +5<CR>
        nmap <silent>- :resize -5<CR>

    """""""""""""""""""""""""""""""""""""""""""""""


    """"""""""""""" Fuzzy Finder """""""""""""""

        nnoremap <leader>ff <cmd>Telescope find_files<cr>
        nnoremap <leader>fg <cmd>Telescope live_grep<cr>
        nnoremap <leader>fb <cmd>Telescope buffers<cr>
        nnoremap <leader>fh <cmd>Telescope help_tags<cr>

    """""""""""""""""""""""""""""""""""""""""


    """""""""""""""""""" Diagnostics """"""""""""""""""""

        nnoremap <leader>xx <cmd>TroubleToggle<cr>
        nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
        nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
        nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
        nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
        " nnoremap gR <cmd>TroubleToggle lsp_references<cr>       " decide what to change this to, too similar to gr (rename) right now 

    """"""""""""""""""""""""""""""""""""""""""""""""""


    """"""""""""""" Debug """""""""""""""

        nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
        nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
        vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>

    """""""""""""""""""""""""""""""""""""


    """""""""""""""""" LSP Mappings """"""""""""""""""

        nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
        nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
        nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
        nnoremap <silent> gs <cmd>lua vim.lsp.buf.signature_help()<CR>
        nnoremap <silent> gr <cmd>lua vim.lsp.buf.rename()<CR>
        nnoremap <silent> gt <cmd>lua vim.lsp.buf.type_definition()<CR>
        nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR> 
        nnoremap <silent> ca <cmd>lua vim.lsp.buf.code_action()<CR> 
		nnoremap <silent> ]e <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
		nnoremap <silent> [e <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
        nnoremap <silent> <leader>gw <cmd>lua vim.lsp.buf.document_symbol()<CR> 
        nnoremap <silent> <leader>gW <cmd>lua vim.lsp.buf.workspace_symbol()<CR> 
        nnoremap <silent> <leader>ee <cmd>lua vim.lsp.util.show_line_diagnostics()<CR> 
        nnoremap <silent> <leader>= <cmd>lua vim.lsp.buf.formatting()<CR> 
        nnoremap <silent> <leader>= <cmd>lua vim.lsp.diagnostic.set_loclist()<CR> 

    """""""""""""""""""""""""""""""""""""""""""""""""""

   
    """""""""""""""" Motions """"""""""""""""

        nmap <silent> s <cmd>HopChar2<CR>

    """""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""" Configurations """"""""""

    """"" Autocomplete """""

		" Make sure `substring` is part of this list. Other items are optional for this completion source
        let g:completion_matching_strategy_list = ['fuzzy', 'exact', 'substring']
        let g:completion_matching_ignore_case = 1


		"" Start nvim-cmp for sql files and coq.nvim for everything else (if vim dadbod completion ever works with coq.nvim, remove nvim-cmp)
		let blacklist = ['sql', 'mysql', 'plsql']

		if index(blacklist, &ft) < 0
			\ | execute "let g:coq_settings = { 'auto_start': 'shut-up', 'keymap': { 'jump_to_mark': '' },  }"
		\ | else
			\ | execute "autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })"
		\ | endif


		" Source is automatically added, you just need to include it in the chain complete list
		let g:completion_chain_complete_list = {
			\   'sql': [
			\    {'complete_items': ['vim-dadbod-completion']},
			\   ],
			\ }

    """"""""""""""""""""""""


    """"" Visuals """""

        colorscheme codedark
        let g:rainbow_active = 1
        let g:db_ui_use_nerd_fonts = 1
        let g:diagnostic_enable_virtual_text = 1

    """""""""""""""""""


    """"" Functionality """""

		" don't auto resize when flipping between splits
        let g:golden_ratio_autocommand = 0
    
    """""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""" LUA Config """"""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF

	require('impatient')

	-- local cmp = require'cmp'
    local coq = require 'coq'
	local dap = require 'dap'
	local dap_python = require 'dap-python'
	local dap_ui = require 'dapui'
    local hop = require 'hop'
    local lsp = require 'lspconfig'
	local lualine = require 'lualine'
	local null_ls = require 'null-ls'
    local stabilize = require'stabilize'
    local telescope = require'telescope'
    local trouble = require 'trouble'

    trouble.setup {}


    ------------ Language Servers ------------
	
    lsp.tsserver.setup{
        -- required for coq
        coq.lsp_ensure_capabilities{
            capabilities = capabilities 
        }
    }

    lsp.pyright.setup{
        -- required for coq
        coq.lsp_ensure_capabilities{
            capabilities = capabilities
        }
    }

	-- Setup guide for C#
	-- https://rudism.com/coding-csharp-in-neovim/
	lsp.omnisharp.setup {
		-- required for coq
		coq.lsp_ensure_capabilities{
			capabilities = capabilities
		},
		on_attach = function(_, bufnr)
			vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
		end,
		cmd = { "/Users/kean.mattingly@equipmentshare.com/Downloads/omnisharp-osx/run", "--languageserver" , "--hostPID", tostring(pid) },
	}

	-- Use nvim cmp to provide DB completions
	-- vim.api.nvim_exec([[
	--	autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
	-- ]], false)

    ------------------------------------------


    --------------- Treesitter ---------------

    require'nvim-treesitter.configs'.setup {
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
                -- search hidden files in the directory
                -- hidden = true
            }
        }
    }

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

    stabilize.setup()

	lualine.setup { ['option.theme'] = 'onedark' }

    ----------------

EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

