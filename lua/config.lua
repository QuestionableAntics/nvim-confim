local opt = vim.opt
local wo = vim.wo
local o = vim.o

-- Let me backspace like I want
opt.backspace = {'indent','eol','start'}

-- Hybrid line numbers: shows relative number for all lines, but shows absolute for current line
wo.relativenumber = true
wo.nu = true

-- Case insensitive searching
opt.ignorecase = true

-- If a capital is included, make the search case sensitive
opt.smartcase = true

-- Show completion popup menu in command view
opt.wildmenu = true

-- Set the completion popup menu to
--  - always show the menu
--  - not insert match until manually selected
--  - not auto select match
opt.completeopt = {'menuone','noinsert','noselect'}

-- enable mouse for not me
opt.mouse = "a"

-- Set default grep to ripgrep (faster fuzzy finding)
opt.grepprg = [[rg\]] ---vimgrep

-- Make tab width equivalent to 4 spaces
opt.tabstop = 4

-- Make an indent equivalent to 4 spaces
opt.shiftwidth = 4

-- https://vi.stackexchange.com/questions/10124/what-is-the-difference-between-filetype-plugin-indent-on-and-filetype-indent
vim.cmd 'filetype plugin indent on'

-- How long before a swp file is written and a CursorHold event is triggered
-- Having longer updatetime (default is 4000 ms) leads to noticeable delays and poor user experience.
opt.updatetime = 300

-- Don't pass messages to |ins-completion-menu|.
opt.shortmess:append('c')

-- Maintain undo history between sessions
opt.undofile = true
opt.undodir = os.getenv('HOME') .. [[/.vim/undodir/]]

-- Recommended settings for auto-session via the readme file
o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- Keep a buffer of 10 lines/columns between cursor and edge when scrolling
vim.opt.scrolloff = 10

----- Visuals -----

	-- Highlight yanked text on yank
	vim.cmd [[ autocmd TextYankPost * silent! lua vim.highlight.on_yank() ]]

	-- No other way to set colorscheme in Lua config currently
	vim.cmd 'colorscheme codedark'

	-- Nice icons for DBUI
	vim.g.db_ui_use_nerd_fonts = 1

	-- Highlight the current line
	opt.cursorline = true

	-- ooo pretty colors 😯
	opt.termguicolors = true

	-- Allow for width of numbers and arbitrary symbols in sign column
	opt.signcolumn = 'yes:1'

-------------------
