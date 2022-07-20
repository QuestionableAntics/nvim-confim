local utils = require 'utils'

local map = utils.base_map
local imap = utils.imap
local nmap = utils.nmap
local tmap = utils.tmap
local cmap = utils.cmap

vim.g.mapleader = ' '
nmap(';', ':')

imap('jk', '<ESC>')
cmap('jk', '<ESC>')
-- Get me the fuck out of the terminal
tmap('jk', [[<C-\><C-N>]])

local stems = {}
local mappings = {}

------------------- Random -------------------

	local harpoon_ui = require('harpoon.ui')
	local harpoon_mark = require('harpoon.mark')

	-- These clash despite lua table indexes being case sensitive?
	imap('<C-J>', 'copilot#Accept("\\<CR>")', { override = true }, { expr = true, silent = true, script = true })
	map('', '<C-j>', '<C-W>j')

	mappings['random'] = {
		['<esc>'] = { mode = 'n', action = '<esc>:noh<CR>', label = 'Remove Highlights' },
		['<leader>v'] = { mode = 'n', action = '<cmd>CHADopen<cr>', label = 'Open file explorer' },

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
		['<leader>jm'] = { mode = 'n', action = harpoon_ui.toggle_quick_menu, label = 'Open Harpoon Quick Menu' },
		['<leader>am'] = { mode = 'n', action = harpoon_mark.add_file, label = 'Add file to Harpoon Mark' },

		-- notes
		['<leader>n'] = { mode = 'n', action = utils.Spawn_note_window, label = 'Spawn note window' },

		-- REPL
		['<leader>rpy'] = { mode = 'n', action = '<cmd>Codi python<CR>', label = 'Open Python REPL' },
		['<leader>rjs'] = { mode = 'n', action = '<cmd>Codi javascript<CR>', label = 'Open JS REPL' },
		['<leader>rts'] = { mode = 'n', action = '<cmd>Codi typescript<CR>', label = 'Open TS REPL' },

		-- copy path to file from CWD
		['cp'] = { mode = 'n', action = ':let @* = expand("%")<CR>', label = 'Copy file path from CWD' },
		-- copy current relative file path
		['crp'] = { mode = 'n', action = ':let @* = expand("%:~")<CR>', label = 'Copy current file path from home directory' },
		-- copy current file name
		['cn'] = { mode = 'n', action = ':let @* = expand("%:t")<CR>', label = 'Copy current file name' },

		-- open markdown previewer
		['<leader>md'] = { mode = 'n', action = ':MarkdownPreview', label = 'Open Markdown Previewer' },
	}

	stems['<leader>r'] = { label =  'REPL' }

-----------------------------------------------


--------------- Fuzzy Finder ---------------

	local telescope = require('telescope')
	local telescope_builtin = require('telescope.builtin')

	mappings['fuzzy_finder'] = {
		['<leader>ff'] = { mode = 'n', action = telescope_builtin.find_files, label = 'Find files' },
		-- ['<leader>fg'] = { mode = 'n', action = telescope_builtin.live_grep, label = 'Live Grep' },
		['<leader>fg'] = { mode = 'n', action = telescope.extensions.live_grep_args.live_grep_args, label = 'Live Grep' },
		['<leader>fb'] = { mode = 'n', action = telescope_builtin.buffers, label = 'Find Buffers' },
		['<leader>fh'] = { mode = 'n', action = telescope_builtin.help_tags, label = 'Find Help Tags' },
		['<leader>fo'] = { mode = 'n', action = telescope_builtin.oldfiles, label = 'Find Old Files' },
		['<leader>fl'] = { mode = 'n', action = telescope_builtin.resume, label = 'Last Search Results' },
		['<leader>fm'] = { mode = 'n', action = telescope.extensions.macroscope.default, label = 'Search Macros' },
		['<leader>fxd'] = { mode = 'n', action = function() telescope_builtin.diagnostics {bufnr=0} end, label = 'Find Diagnostics in Focused Buffer'},
		['<leader>fxw'] = { mode = 'n', action = telescope_builtin.diagnostics, label = 'Find Diagnostics in Open Buffers'},
		['gh'] = { mode = 'n', action = telescope_builtin.lsp_references, label = 'Find References' },
	}

	stems['<leader>f'] = { label = 'Fuzzy Finder' }
	stems['<leader>fx'] = { label = 'Find Diagnostics' }

-----------------------------------------


------------ Testing ------------

	local neotest = require('neotest')

	mappings['testing'] = {
		-- TODO: Revisit this later and see if there's clearer errors around it not working
		-- ['<leader>dn'] = { mode = 'n', action = function() neotest.run.run({strategy = "dap"}) end, label = 'Debug Nearest Test' },
		['<leader>un'] = { mode = 'n', action = function() neotest.run.run() end, label = 'Run Nearest Test' },
		['<leader>ul'] = { mode = 'n', action = function() neotest.run.run_last() end, label = 'Run Last Test' },
		['<leader>uf'] = { mode = 'n', action = function() neotest.run.run(vim.fn.expand("%")) end, label = 'Run File' },
		['<leader>us'] = { mode = 'n', action = function() neotest.summary.open() end, label = 'Open Test Summary' },
		['<leader>uo'] = { mode = 'n', action = function() neotest.output.open() end, label = 'Test Output' },
	}

	stems['<leader>u'] = { label = 'Testing' }

---------------------------------


--------------- Debug ---------------

	local dap_python = require('dap-python')
	local dap = require('dap')
	local dap_ui_widgets = require('dap.ui.widgets')
	local dapui = require('dapui')

	mappings['debug'] = {
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

	stems['<leader>d'] = { label = 'Debug' }
	stems['<leader>du'] = { label = 'Debug UI' }
	stems['<leader>dc'] = { label = 'Debug Telescope' }

-------------------------------------


------------------ LSP Mappings ------------------

	mappings['lsp'] = {
		['gd'] = { mode = 'n', action = vim.lsp.buf.definition, label = 'Go to definition' },
		['gD'] = { mode = 'n', action = vim.lsp.buf.declaration, label = 'Go to declaration' },
		-- ['gi'] = { mode = 'n', action = vim.lsp.buf.implementation, label = 'Go to implementation' },
		['gs'] = { mode = 'n', action = vim.lsp.buf.signature_help, label = 'Signature help' },
		['gr'] = { mode = 'n', action = vim.lsp.buf.rename, label = 'Rename' },
		['gt'] = { mode = 'n', action = vim.lsp.buf.type_definition, label = 'Go to type definition' },
		['K'] = { mode = 'n', action = vim.lsp.buf.hover, label = 'Hover' },
		['ca'] = { mode = 'n', action = vim.lsp.buf.code_action, label = 'Code actions' },
		[']e'] = { mode = 'n', action = vim.diagnostic.goto_next, label = 'Next diagnostic' },
		['[e'] = { mode = 'n', action = vim.diagnostic.goto_prev, label = 'Previous diagnostic' },
		['<leader>gw'] = { mode = 'n', action = vim.lsp.buf.document_symbol, label = 'Document symbols' },
		['<leader>gW'] = { mode = 'n', action = vim.lsp.buf.workspace_symbol, label = 'Workspace symbols' },
		['<leader>='] = { mode = 'n', action = vim.lsp.buf.formatting, label = 'Formatting' },
		['<leader>-'] = { mode = 'n', action = vim.diagnostic.setloclist, label = 'Diagnostic locations' },

		['gi'] = { mode = 'n', action = ":TSLspImportCurrent<CR>", label = "Import Current"},
		['gia'] = { mode = 'n', action = ":TSLspImportAll<CR>", label = "Import All"},
	}

---------------------------------------------------


---------------------------- Git ------------------------

	local gitsigns = require('gitsigns')

	mappings['git'] = {
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

	stems['<leader>h'] = { label = 'Git' }

---------------------------------------------------------


---------------- Motions ----------------

	local hop = require('hop')
	local pounce = require('pounce')

	mappings['motion'] = {
		['s'] = { mode = '', action = hop.hint_char2, label = 'Hint character', opts = { disable = false } },
		['S'] = { mode = '', action = pounce.pounce, label = 'Pounce', opts = { disable = false } },

		-- Quicker moving to front and back of lines
		['H'] = { mode = '', action = '^', label = 'Move to start of line' },
		['L'] = { mode = '', action = '$', label = 'Move to end of line' },
	}

-----------------------------------------


---------------- Tabs ----------------

	mappings['tab'] = {
		['<leader>ta'] = { mode = 'n', action = ':$tabnew<CR>', label = 'New tab' },
		['<leader>tc'] = { mode = 'n', action = ':tabclose<CR>', label = 'Close tab' },
		['<leader>to'] = { mode = 'n', action = ':tabonly<CR>', label = 'Close Other Tabs' },
		['<leader>tn'] = { mode = 'n', action = ':tabnext<CR>', label = 'Next tab' },
		['<leader>tp'] = { mode = 'n', action = ':tabprevious<CR>', label = 'Previous tab' },
		['<leader>tmp'] = { mode = 'n', action = ':-tabmove<CR>', label = 'Move tab to previous position' },
		['<leader>tmn'] = { mode = 'n', action = ':+tabmove<CR>', label = 'Move tab to next position' },
	}

	stems['<leader>t'] = { label = 'Tabs' }
	stems['<leader>tm'] = { label = 'Move tab' }

--------------------------------------

local all_mappings = {}

for _, v in pairs(mappings) do
	for k2, v2 in pairs(v) do
		all_mappings[k2] = v2
	end
end

for k, v in pairs(all_mappings) do
	if type(v.mode) == 'string' then
		v.mode = { v.mode }
	end

	for _, mode in ipairs(v.mode) do
		map(mode, k, v.action, v.opts, v.map_opts)
	end
end

local which_key = require 'which-key'


----------- Which Key ---------------

	local which_key_mappings = {}

	for k, v in pairs(all_mappings) do
		which_key_mappings[k] = { v.action, v.label }
	end

	for k,v in pairs(stems) do
		which_key_mappings[k] = v.label
	end

	which_key.register(which_key_mappings)

------------------------------------

return {
	all_mappings = all_mappings,
	stems = stems,
}
