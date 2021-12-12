local utils = require('utils')

local map = utils.map
local imap = utils.imap
local nmap = utils.nmap
local tmap = utils.tmap
local vmap = utils.vmap
local cmap = utils.cmap
local xmap = utils.xmap

vim.g.mapleader = ';'
imap('jk', '<ESC>')
cmap('jk', '<ESC>')
-- Get me the fuck out of the terminal
tmap('jk', [[<C-\><C-N>]])


------------------- Random -------------------

	-- ESC to de-highlight
	nmap('<esc>', '<esc>:noh<CR>')
	-- Sets current pane to 66% of available window height or width (whichever are applicable)
	nmap('<leader>rs', '<cmd>GoldenRatioResize<CR>')
	-- Open file explorer
	nmap('<leader>v', '<cmd>CHADopen<cr>')

	-- Copilot accept remap (this wasn't playing nice with the lua map function)
	vim.cmd([[imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")]])

	-- change pane by direction
	map('', '<C-j>', '<C-W>j')
	map('', '<C-k>', '<C-W>k')
	map('', '<C-h>', '<C-W>h')
	map('', '<C-l>', '<C-W>l')

	-- resize panes
	nmap('_', ':vertical resize -15<CR>')
	nmap('+', ':vertical resize +15<CR>')
	nmap('=', ':resize +5<CR>')
	nmap('-', ':resize -5<CR>')

-----------------------------------------------


--------------- Fuzzy Finder ---------------

	nmap('<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
	nmap('<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
	nmap('<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
	nmap('<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>')
	nmap('<leader>fo', '<cmd>lua require("telescope.builtin").oldfiles()<cr>')
	nmap('<leader>e', '<cmd>Telescope projects<cr>')
	nmap('gh', '<cmd>Telescope lsp_references<cr>')

-----------------------------------------


-------------------- Diagnostics --------------------

	nmap('<leader>xx', '<cmd>TroubleToggle<cr>')
	nmap('<leader>xw', '<cmd>TroubleToggle lsp_workspace_diagnostics<cr>')
	nmap('<leader>xd', '<cmd>TroubleToggle lsp_document_diagnostics<cr>')
	nmap('<leader>xq', '<cmd>TroubleToggle quickfix<cr>')
	nmap('<leader>xl', '<cmd>TroubleToggle loclist<cr>')

--------------------------------------------------


--------------- Debug ---------------

	nmap('<leader>dn', '<cmd>lua require("dap-python").test_method()<CR>')
	nmap('<leader>df', '<cmd>lua require("dap-python").test_class()<CR>')
	vmap('<leader>ds', '<ESC>:lua require("dap-python").debug_selection()<CR>')

-------------------------------------


------------------ LSP Mappings ------------------

	nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
	nmap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
	nmap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
	nmap('gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
	nmap('gr', '<cmd>lua vim.lsp.buf.rename()<CR>')
	nmap('gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
	nmap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
	nmap('ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
	nmap(']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
	nmap('[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
	nmap('<leader>gw', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
	nmap('<leader>gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
	nmap('<leader>dd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
	nmap('<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
	nmap('<leader>-', '<cmd>lua vim.diagnostic.setloclist()<CR>')

---------------------------------------------------


---------------------------- Git ------------------------

	nmap(']c', '<cmd>Gitsigns next_hunk<CR>')
	nmap('[c', '<cmd>Gitsigns prev_hunk<CR>')
	nmap('<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')
	vmap('<leader>hs', ':Gitsigns stage_hunk<CR>')
	nmap('<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
	nmap('<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
	vmap('<leader>hr', ':Gitsigns reset_hunk<CR>')
	nmap('<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
	nmap('<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
	nmap('<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
	nmap('<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
	nmap('<leader>hU', '<cmd>Gitsigns reset_buffer_index<CR>')

---------------- Motions ----------------

	nmap('s', '<cmd>HopChar2<CR>')

-----------------------------------------

