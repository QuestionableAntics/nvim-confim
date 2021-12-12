local opt = vim.opt
local wo = vim.wo

-- Let me backspace like I want
opt.backspace = {'indent','eol','start'}

-- Hybrid line numbers: shows relative number for all lines, but shows absolute for current line
wo.relativenumber = true
wo.nu = true

-- Case insensitive searching
opt.ignorecase = true

-- If a capital is included, make the search case sensitive
opt.smartcase = true

-- Show completion options in command view
opt.wildmenu = true

-- Set completeopt to have a better completion experience
opt.completeopt = {'menuone','noinsert','noselect'}

-- Set default grep to ripgrep
opt.grepprg=[[rg\]] ---vimgrep

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

-- Allow for width of numbers and arbitrary symbols in sign column
opt.signcolumn = 'yes:1'

-- Maintain undo history between sessions
opt.undofile = true
opt.undodir = os.getenv('HOME') .. [[/.vim/undodir/]]

-- Highlight the current line
opt.cursorline = true

-- Add more paths to the lua package search path
-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, 'lua/?.lua')
-- table.insert(runtime_path, 'lua/?/init.lua')

---------- Configurations ----------
------------------------------------------------------------------------------------------

