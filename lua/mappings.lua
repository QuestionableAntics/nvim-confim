local utils = require('utils')

local map = utils.map
local imap = utils.imap
local nmap = utils.nmap
local tmap = utils.tmap
local vmap = utils.vmap
local cmap = utils.cmap
-- local xmap = utils.xmap

vim.g.mapleader = ' '
nmap(';', ':')

imap('jk', '<ESC>')
cmap('jk', '<ESC>')
-- Get me the fuck out of the terminal
tmap('jk', [[<C-\><C-N>]])


------------------- Random -------------------
	local sidebar = require('sidebar-nvim')

	-- ESC to de-highlight
	nmap('<esc>', '<esc>:noh<CR>')
	-- Open file explorer
	nmap('<leader>v', '<cmd>CHADopen<cr>')
	-- Open Sidebar
	nmap('<leader>s', sidebar.toggle)

	vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', { expr = true, silent = true, script = true })

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
	local harpoon_ui = require('harpoon.ui')
	local harpoon_mark = require('harpoon.mark')

	nmap('<leader>fm', harpoon_ui.toggle_quick_menu)
	nmap('<leader>am', harpoon_mark.add_file)

	-- Notes
	nmap('<leader>n', utils.Spawn_note_window)

	-- REPL
	nmap('<leader>rpy', '<cmd>Codi python<CR>')
    nmap('<leader>rjs', '<cmd>Codi javascript<CR>')
    nmap('<leader>rts', '<cmd>Codi typescript<CR>')

-----------------------------------------------


--------------- Fuzzy Finder ---------------
	local telescope_builtin = require('telescope.builtin')
	local session_lens = require('session-lens')

	nmap('<leader>ff', telescope_builtin.find_files)
	nmap('<leader>fg', telescope_builtin.live_grep)
	nmap('<leader>fb', telescope_builtin.buffers)
	nmap('<leader>fh', telescope_builtin.help_tags)
	nmap('<leader>fo', telescope_builtin.oldfiles)
	nmap('<leader>fs', session_lens.search_session)

	nmap('gh', telescope_builtin.lsp_references)


-----------------------------------------


-------------------- Diagnostics --------------------
	local trouble = require('trouble')
	-- local trouble_providers = require('trouble.providers')

	nmap('<leader>xx', trouble.toggle)
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
	local dap_python = require('dap-python')
	local dap = require('dap')
	local dap_ui_widgets = require('dap.ui.widgets')
	local dapui = require('dapui')
	local telescope = require('telescope')

	vmap('<leader>ds', dap_python.debug_selection)

	nmap('<F9>', dap.continue)
	nmap('<F10>', dap.step_over)
	nmap('<F11>', dap.step_into)
	nmap('<F12>', dap.step_out)
	nmap('<leader>db', dap.toggle_breakpoint)

	nmap('<leader>duh', dap_ui_widgets.hover)
	nmap('<leader>duf', function() dap_ui_widgets.centered_float(dap_ui_widgets.scopes) end)

	nmap('<leader>dsbr', (function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end))
	nmap('<leader>dsbm', (function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end))
	nmap('<leader>dr', dap.repl.open)
	-- nmap('<leader>dl', dap.repl.run_last)

	-- dap ui
	nmap('<leader>dui', dapui.toggle)

	-- telescope-dap
	nmap('<leader>dcc', telescope.extensions.dap.commands)
	nmap('<leader>dco', telescope.extensions.dap.configurations)
	nmap('<leader>dlb', telescope.extensions.dap.list_breakpoints)
	nmap('<leader>dv', telescope.extensions.dap.variables)
	-- nmap('<leader>df', telescope.extensions.dap.frames)

-------------------------------------


------------------ LSP Mappings ------------------

	nmap('gd', vim.lsp.buf.definition)
	nmap('gD', vim.lsp.buf.declaration)
	nmap('gi', vim.lsp.buf.implementation)
	nmap('gs', vim.lsp.buf.signature_help)
	nmap('gr', vim.lsp.buf.rename)
	nmap('gt', vim.lsp.buf.type_definition)
	nmap('K', vim.lsp.buf.hover)
	nmap('ca', vim.lsp.buf.code_action)
	nmap(']e', vim.diagnostic.goto_next)
	nmap('[e', vim.diagnostic.goto_prev)
	nmap('<leader>gw', vim.lsp.buf.document_symbol)
	nmap('<leader>gW', vim.lsp.buf.workspace_symbol)
	nmap('<leader>dd', vim.diagnostic.open_float)
	nmap('<leader>=', vim.lsp.buf.formatting)
	nmap('<leader>-', vim.diagnostic.setloclist)

---------------------------------------------------


---------------------------- Git ------------------------

	local gitsigns = require'gitsigns'

	nmap(']c', gitsigns.next_hunk)
	nmap('[c', gitsigns.prev_hunk)
	nmap('<leader>hs', gitsigns.stage_hunk)
	nmap('<leader>hu', gitsigns.undo_stage_hunk)
	nmap('<leader>hr', gitsigns.reset_hunk)
	nmap('<leader>hR', gitsigns.reset_buffer)
	nmap('<leader>hp', gitsigns.preview_hunk)
	nmap('<leader>hb', function () gitsigns.blame_line{full=true} end)
	nmap('<leader>hS', gitsigns.stage_buffer)
	nmap('<leader>hU', gitsigns.reset_buffer_index)

---------------------------------------------------------


---------------- Motions ----------------

	local hop = require('hop')
	local pounce = require('pounce')

	nmap( 's', hop.hint_char2, { disable = false } )
	nmap( 'S', pounce.pounce, { disable = false } )

	-- Quicker moving to front and back of lines
	nmap( 'H', '^', { disable = false } )
	vmap( 'H', '^', { disable = false } )
	nmap( 'L', '$', { disable = false } )
	vmap( 'L', '$', { disable = false } )

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
