local utils = require('utils')

local map = utils.map
local imap = utils.imap
local nmap = utils.nmap
local tmap = utils.tmap
local vmap = utils.vmap
local cmap = utils.cmap
-- local xmap = utils.xmap

vim.g.mapleader = ' '
imap('jk', '<ESC>')
cmap('jk', '<ESC>')
-- Get me the fuck out of the terminal
tmap('jk', [[<C-\><C-N>]])


------------------- Random -------------------

	-- ESC to de-highlight
	nmap('<esc>', '<esc>:noh<CR>')
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

	-- Harpoon
	nmap('<leader>fm', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>')
	nmap('<leader>am', '<cmd>lua require("harpoon.mark").add_file()<CR>')

-----------------------------------------------


--------------- Fuzzy Finder ---------------

	nmap('<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
	nmap('<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
	nmap('<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
	nmap('<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>')
	nmap('<leader>fo', '<cmd>lua require("telescope.builtin").oldfiles()<cr>')
	nmap('<leader>fs', '<cmd>lua require("session-lens").search_session()<cr>')
	nmap('gh', '<cmd>Telescope lsp_references<cr>')


-----------------------------------------


-------------------- Diagnostics --------------------

	nmap('<leader>xx', '<cmd>TroubleToggle<cr>')
	nmap('<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>')
	nmap('<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>')
	nmap('<leader>xq', '<cmd>TroubleToggle quickfix<cr>')
	nmap('<leader>xl', '<cmd>TroubleToggle loclist<cr>')

--------------------------------------------------


------------ Testing ------------

	nmap('<leader>dn', '<cmd>UltestDebugNearest<CR>')
	nmap('<leader>df', '<cmd>UltestDebug<CR>')
	vim.cmd [[nmap ]t <Plug>(ultest-next-fail)<CR>]]
	vim.cmd [[nmap [t <Plug>(ultest-prev-fail)<CR>]]
	vim.cmd [[nmap <leader>uf <Plug>(ultest-run-file)<CR>]]
	nmap('<leader>un', '<cmd>UltestNearest<CR>')
	nmap('<leader>ul', '<cmd>UltestLast<CR>')
	nmap('<leader>us', '<cmd>UltestSummary<CR>')
	nmap('<leader>uo', '<cmd>UltestOutput<CR>')

---------------------------------


--------------- Debug ---------------

	vmap('<leader>ds', '<ESC>:lua require("dap-python").debug_selection()<CR>')

	nmap('<F9>', '<cmd>lua require"dap".continue()<CR>')
	nmap('<F10>', '<cmd>lua require"dap".step_over()<CR>')
	nmap('<F11>', '<cmd>lua require"dap".step_into()<CR>')
	nmap('<F12>', '<cmd>lua require"dap".step_out()<CR>')
	nmap('<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<CR>')

	nmap('<leader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>')
	nmap('<leader>duf', "<cmd>lua local widget=require'dap.ui.widgets'.centered_float(require'dap.ui.widgets'.scopes)<CR>")

	nmap('<leader>dsbr', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
	nmap('<leader>dsbm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
	nmap('<leader>dr', '<cmd>lua require"dap".repl.open()<CR>')
	nmap('<leader>dl', '<cmd>lua require"dap".repl.run_last()<CR>')

	-- dap ui
	nmap('<leader>dui', '<cmd>lua require"dapui".toggle()<CR>')

	-- telescope-dap
	nmap('<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>')
	nmap('<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>')
	nmap('<leader>dlb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
	nmap('<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
	-- nmap('<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')

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

---------------------------------------------------------


---------------- Motions ----------------

	nmap('s', '<cmd>HopChar2<CR>')

	-- Quicker moving to front and back of lines
	nmap('H', '^')
	nmap('L', '$')

-----------------------------------------


---------------- Tabs ----------------

	nmap('<leader>ta', ':$tabnew<CR>')
	nmap('<leader>tc', ':tabclose<CR>')
	nmap('<leader>to', ':tabonly<CR>')
	nmap('<leader>tn', ':tabnext<CR>')
	nmap('<leader>tp', ':tabprevious<CR>')
	-- move current tab to previous position
	nmap('<leader>tmp', ':-tabmove<CR>')
	-- move current tab to next position
	nmap('<leader>tmn', ':+tabmove<CR>')

--------------------------------------
