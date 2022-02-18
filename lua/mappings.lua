local utils = require('utils')

local map = utils.base_map
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
	local harpoon_ui = require('harpoon.ui')
	local harpoon_mark = require('harpoon.mark')

	-- These clash despite lua table indexes being case sensitive?
	imap('<C-J>', 'copilot#Accept("\\<CR>")', { override = true }, { expr = true, silent = true, script = true })
	map('', '<C-j>', '<C-W>j')

	local random_mappings = {
		['<esc>'] = { mode = 'n', action = '<esc>:noh<CR>', label = 'Remove Highlights' },
		['<leader>v'] = { mode = 'n', action = '<cmd>CHADopen<cr>', label = 'Open file explorer' },
		['<leader>s'] = { mode = 'n', action = sidebar.toggle, label = 'Open Sidebar' },
		-- ['<C-J>'] = { mode = 'i', action = 'copilot#Accept("\\<CR>")', label = 'Accept copilot', opts = { override = true }, map_opts = { expr = true, silent = true, script = true } },

		-- change pane by direction
		-- ['<C-j>'] = { mode = 'n', action = '<C-W>j', label = 'Go to pane underneath' },
		['<C-k>'] = { mode = 'n', action = '<C-W>k', label = 'Go to pane above' },
		['<C-h>'] = { mode = 'n', action = '<C-W>h', label = 'Go to pane to the left' },
		['<C-l>'] = { mode = 'n', action = '<C-W>l', label = 'Go to pane to the right' },

		-- resize panes
		['_'] = { mode = 'n', action = ':vertical resize -15<CR>', label = 'Vertical Size Decrease ' },
		['+'] = { mode = 'n', action = ':vertical resize +15<CR>', label = 'Vertical Size Increase' },
		['='] = { mode = 'n', action = ':resize +5<CR>', label = 'Horizontal Size Increase' },
		['-'] = { mode = 'n', action = ':resize -5<CR>', label = 'Horizontal Size Decrease' },

		-- harpoon
		['<leader>fm'] = { mode = 'n', action = harpoon_ui.toggle_quick_menu, label = 'Open Harpoon Quick Menu' },
		['<leader>am'] = { mode = 'n', action = harpoon_mark.add_file, label = 'Add file to Harpoon Mark' },

		-- notes
		['<leader>n'] = { mode = 'n', action = utils.Spawn_note_window, label = 'Spawn note window' },

		-- REPL
		['<leader>rpy'] = { mode = 'n', action = '<cmd>Codi python<CR>', label = 'Open Python REPL' },
		['<leader>rjs'] = { mode = 'n', action = '<cmd>Codi javascript<CR>', label = 'Open JS REPL' },
		['<leader>rts'] = { mode = 'n', action = '<cmd>Codi typescript<CR>', label = 'Open TS REPL' },
	}

-----------------------------------------------


--------------- Fuzzy Finder ---------------

	local telescope = require('telescope')
	local telescope_builtin = require('telescope.builtin')
	local session_lens = require('session-lens')

	local fuzzy_finder_mappings = {
		['<leader>ff'] = { mode = 'n', action = telescope_builtin.find_files, label = 'Find files' },
		-- ['<leader>fg'] = { mode = 'n', action = telescope_builtin.live_grep, label = 'Live Grep' },
		['<leader>fg'] = { mode = 'n', action = telescope.extensions.live_grep_raw.live_grep_raw, label = 'Live Grep' },
		['<leader>fb'] = { mode = 'n', action = telescope_builtin.buffers, label = 'Find Buffers' },
		['<leader>fh'] = { mode = 'n', action = telescope_builtin.help_tags, label = 'Find Help Tags' },
		['<leader>fo'] = { mode = 'n', action = telescope_builtin.oldfiles, label = 'Find Old Files' },
		['<leader>fl'] = { mode = 'n', action = telescope_builtin.resume, label = 'Last Search Results' },
		['<leader>fs'] = { mode = 'n', action = session_lens.search_session, label = 'Search Sessions' },
		['gh'] = { mode = 'n', action = telescope_builtin.lsp_references, label = 'Find References' },
	}

-----------------------------------------


-------------------- Diagnostics --------------------

	local trouble = require('trouble')

	local diagnostics_mappings = {
		['<leader>xx'] = { mode = 'n', action = trouble.toggle, label = 'Toggle Diagnostics' },
		['<leader>xw'] = { mode = 'n', action = '<cmd>TroubleToggle workspace_diagnostics<cr>', label = 'Toggle Workspace Diagnostics' },
		['<leader>xd'] = { mode = 'n', action = '<cmd>TroubleToggle document_diagnostics<cr>', label = 'Toggle Document Diagnostics' },
		['<leader>xq'] = { mode = 'n', action = '<cmd>TroubleToggle quickfix<cr>', label = 'Toggle Quickfix' },
		['<leader>xl'] = { mode = 'n', action = '<cmd>TroubleToggle loclist<cr>', label = 'Toggle Loclist' },
	}

--------------------------------------------------


------------ Testing ------------

	vim.cmd [[nmap ]t <Plug>(ultest-next-fail)<CR>]]
	vim.cmd [[nmap [t <Plug>(ultest-prev-fail)<CR>]]
	vim.cmd [[nmap <leader>uf <Plug>(ultest-run-file)<CR>]]

	local testing_mappings = {
		['<leader>dn'] = { mode = 'n', action = '<cmd>UltestDebugNearest<CR>', label = 'Debug Nearest Test' },
		['<leader>df'] = { mode = 'n', action = '<cmd>UltestDebug<CR>', label = 'Debug Test' },
		['<leader>un'] = { mode = 'n', action = '<cmd>UltestNearest<CR>', label = 'Run Nearest Test' },
		['<leader>ul'] = { mode = 'n', action = '<cmd>UltestLast<CR>', label = 'Run Last Test' },
		['<leader>us'] = { mode = 'n', action = '<cmd>UltestSummary<CR>', label = 'Run Summary' },
		['<leader>uo'] = { mode = 'n', action = '<cmd>UltestOutput<CR>', label = 'Run Output' },
	}

---------------------------------


--------------- Debug ---------------

	local dap_python = require('dap-python')
	local dap = require('dap')
	local dap_ui_widgets = require('dap.ui.widgets')
	local dapui = require('dapui')
	local telescope = require('telescope')

	local debug_mappings = {
		-- dap
		['<leader>ds'] = { mode = 'v', action = dap_python.debug_selection, label = 'Debug Python Selection' },
		['<F9>'] = { mode = 'n', action = dap.continue, label = 'Debug Continue'},
		['<F10>'] = { mode = 'n', action = dap.step_over, label = 'Debug Step Over'},
		['<F11>'] = { mode = 'n', action = dap.step_into, label = 'Debug Step Into'},
		['<F12>'] = { mode = 'n', action = dap.step_out, label = 'Debug Step Out'},
		['<leader>db'] = { mode = 'n', action = dap.toggle_breakpoint, label = 'Debug Toggle Breakpoint'},
		['<leader>dsbr'] = { mode = 'n', action = (function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end), label = 'Debug Set Breakpoint'},
		['<leader>dsbm'] = { mode = 'n', action = (function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end), label = 'Debug Set Breakpoint Message'},
		['<leader>dr'] = { mode = 'n', action = dap.repl.open, label = 'Debug REPL'},
		-- ['<leader>dl'] = { mode = 'n', action = dap.repl.run_last, label = 'Debug Run Last'},

		-- dap ui
		['<leader>dui'] = { mode = 'n', action = dapui.toggle, label = 'Debug UI'},
		['<leader>duh'] = { mode = 'n', action = dap_ui_widgets.hover, label = 'Debug Hover'},
		['<leader>duf'] = { mode = 'n', action = (function() dap_ui_widgets.centered_float(dap_ui_widgets.scopes) end), label = 'Debug Scopes'},

		-- telescope-dap
		['<leader>dcc'] = { mode = 'n', action = telescope.extensions.dap.commands, label = 'Debug Commands'},
		['<leader>dco'] = { mode = 'n', action = telescope.extensions.dap.configurations, label = 'Debug Configurations'},
		-- ['<leader>df'] = { mode = 'n', action = telescope.extensions.dap.frames, label = 'Debug Frames'},
	}

-------------------------------------


------------------ LSP Mappings ------------------

	local lsp_mappings = {
		['gd'] = { mode = 'n', action = vim.lsp.buf.definition, label = 'Go to definition' },
		['gD'] = { mode = 'n', action = vim.lsp.buf.declaration, label = 'Go to declaration' },
		['gi'] = { mode = 'n', action = vim.lsp.buf.implementation, label = 'Go to implementation' },
		['gs'] = { mode = 'n', action = vim.lsp.buf.signature_help, label = 'Signature help' },
		['gr'] = { mode = 'n', action = vim.lsp.buf.rename, label = 'Rename' },
		['gt'] = { mode = 'n', action = vim.lsp.buf.type_definition, label = 'Go to type definition' },
		['K'] = { mode = 'n', action = vim.lsp.buf.hover, label = 'Hover' },
		['ca'] = { mode = 'n', action = vim.lsp.buf.code_action, label = 'Code actions' },
		[']e'] = { mode = 'n', action = vim.diagnostic.goto_next, label = 'Next diagnostic' },
		['[e'] = { mode = 'n', action = vim.diagnostic.goto_prev, label = 'Previous diagnostic' },
		['<leader>gw'] = { mode = 'n', action = vim.lsp.buf.document_symbol, label = 'Document symbols' },
		['<leader>gW'] = { mode = 'n', action = vim.lsp.buf.workspace_symbol, label = 'Workspace symbols' },
		['<leader>dd'] = { mode = 'n', action = vim.diagnostic.open_float, label = 'Diagnostics' },
		['<leader>='] = { mode = 'n', action = vim.lsp.buf.formatting, label = 'Formatting' },
		['<leader>-'] = { mode = 'n', action = vim.diagnostic.setloclist, label = 'Diagnostic locations' },
	}

---------------------------------------------------


---------------------------- Git ------------------------

	local gitsigns = require'gitsigns'

	local git_mappings = {
		[']c'] = { mode = 'n', action = gitsigns.next_hunk, label = 'Next hunk' },
		['[c'] = { mode = 'n', action = gitsigns.prev_hunk, label = 'Previous hunk' },
		['<leader>hs'] = { mode = 'n', action = gitsigns.stage_hunk, label = 'Stage hunk' },
		['<leader>hu'] = { mode = 'n', action = gitsigns.undo_stage_hunk, label = 'Undo stage hunk' },
		['<leader>hr'] = { mode = 'n', action = gitsigns.reset_hunk, label = 'Reset hunk' },
		['<leader>hR'] = { mode = 'n', action = gitsigns.reset_buffer, label = 'Reset buffer' },
		['<leader>hp'] = { mode = 'n', action = gitsigns.preview_hunk, label = 'Preview hunk' },
		['<leader>hb'] = { mode = 'n', action = function () gitsigns.blame_line{full=true} end, label = 'Blame line' },
		['<leader>hS'] = { mode = 'n', action = gitsigns.stage_buffer, label = 'Stage buffer' },
		['<leader>hU'] = { mode = 'n', action = gitsigns.reset_buffer_index, label = 'Reset buffer index' },
	}

---------------------------------------------------------


---------------- Motions ----------------

	local hop = require('hop')
	local pounce = require('pounce')

	local motion_mappings = {
		['s'] = { mode = 'n', action = hop.hint_char2, label = 'Hint character', opts = { disable = false } },
		['S'] = { mode = 'n', action = pounce.pounce, label = 'Pounce', opts = { disable = false } },

		-- Quicker moving to front and back of lines
		['H'] = { mode = {'n', 'v'}, action = '^', label = 'Move to start of line' },
		['L'] = { mode = {'n', 'v'}, action = '$', label = 'Move to end of line' },
	}

-----------------------------------------


---------------- Tabs ----------------

	local tab_mappings = {
		['<leader>ta'] = { mode = 'n', action = ':$tabnew<CR>', label = 'New tab' },
		['<leader>tc'] = { mode = 'n', action = ':tabclose<CR>', label = 'Close tab' },
		['<leader>to'] = { mode = 'n', action = ':tabonly<CR>', label = 'Close Other Tabs' },
		['<leader>tn'] = { mode = 'n', action = ':tabnext<CR>', label = 'Next tab' },
		['<leader>tp'] = { mode = 'n', action = ':tabprevious<CR>', label = 'Previous tab' },
		['<leader>tmp'] = { mode = 'n', action = ':-tabmove<CR>', label = 'Move tab to previous position' },
		['<leader>tmn'] = { mode = 'n', action = ':+tabmove<CR>', label = 'Move tab to next position' },
	}

--------------------------------------


local all_mappings = utils.merge_tables {
	random_mappings,
	fuzzy_finder_mappings,
	diagnostics_mappings,
	testing_mappings,
	debug_mappings,
	lsp_mappings,
	git_mappings,
	motion_mappings,
	tab_mappings,
}

for k, v in pairs(all_mappings) do
	map(v.mode, k, v.action, v.opts, v.map_opts)
end

return all_mappings
