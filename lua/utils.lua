local cmd = vim.cmd
local vscode = vim.g.vscode

local M = {}

M.merge_tables = function(tables)
	local new_table = {}

	for _, table in ipairs(tables) do
		for key, value in pairs(table) do
			new_table[key] = value
		end
	end

	return new_table
end

M.base_map = function(modes, shortcut, command, opts, map_opts)
	opts = opts or {}
	map_opts = map_opts or {}

	if opts.disable == nil and vscode then
		return
	end

	if not opts.override then
		map_opts = M.merge_tables { map_opts, { noremap = true, silent = true } }
	end

	if type(modes) == "string" then
		modes = { modes }
	end

	for _, mode in ipairs(modes) do
		vim.keymap.set( mode, shortcut, command, map_opts )
	end
end

local get_mapper = function(mode)
	return function(shortcut, command, opts, map_opts)
		M.base_map(mode, shortcut, command, opts, map_opts)
	end
end

M.imap = get_mapper('i')
M.nmap = get_mapper('n')
M.tmap = get_mapper('t')
M.vmap = get_mapper('v')
M.cmap = get_mapper('c')
M.xmap = get_mapper('x')

-- Borrowed from https://github.com/wbthomason/dotfiles/blob/9134e87b00102cda07f875805f900775244067fe/neovim/.config/nvim/lua/config/utils.lua#L10-L17
---@param group string augroup
---@param cmds string|table autocmd
---@param clear boolean clear augroup
M.autocmd = function (group, cmds, clear)
  clear = clear == nil and false or clear
  if type(cmds) == 'string' then cmds = {cmds} end
  cmd('augroup ' .. group)
  if clear then cmd [[autocmd!]] end
  for _, c in ipairs(cmds) do cmd('autocmd ' .. c) end
  cmd [[augroup END]]
end

M.Spawn_note_window = function()
	vim.cmd [[
	  let path = "~/notes/"
	  let file_name = path.strftime("note-%d-%m-%y.wiki")
	  " Empty buffer
	  let buf = nvim_create_buf(v:false, v:true)
	  " Get current UI
	  let ui = nvim_list_uis()[0]
	  " Dimension
	  let width = (ui.width/2)
	  let height = (ui.height/2)
	  " Options for new window
	  let opts = {'relative': 'editor',
				  \ 'width': width,
				  \ 'height': height,
				  \ 'col': (ui.width - width)/2,
				  \ 'row': (ui.height - height)/2,
				  \ 'anchor': 'NW',
				  \ 'style': 'minimal',
				  \ 'border': 'single',
				  \ }
	  " Spawn window
	  let win = nvim_open_win(buf, 1, opts)
	  " Now we can actually open or create the note for the day?
	  if filereadable(expand(file_name))
		execute "e ".fnameescape(file_name)
		let column = 80
		execute "set textwidth=".column
		execute "set colorcolumn=".column
		execute "norm Go"
		execute "norm zz"
		execute "startinsert"
	  else
		execute "e ".fnameescape(file_name)
		let column = 80
		execute "set textwidth=".column
		execute "set colorcolumn=".column
		execute "norm Gi= Notes for ".strftime("%d-%m-%y")." ="
		execute "norm G2o"
		execute "norm Gi- " 
		execute "norm zz"
		execute "startinsert"
	  endif
  ]]
end

local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local sorters = require "telescope.sorters"
local conf = require("telescope.config").values

local Path = require "plenary.path"

local Popup = require "nui.popup"
local event = require("nui.utils.autocmd").event

-- local popup = Popup({
--   enter = true,
--   focusable = true,
--   border = {
--     style = "rounded",
--   },
--   position = "90%",
--   size = {
--     width = "10%",
--     height = "10%",
--   },
--   buf_options = {
--     modifiable = false,
--     readonly = true,
--   },
-- })

-- unmount component when cursor leaves buffer
-- popup:on(event.BufLeave, function()
--   popup:unmount()
-- end)

local flatten = vim.tbl_flatten
local filter = vim.tbl_filter

-- Special keys:
--  opts.search_dirs -- list of directory to search in
--  opts.grep_open_files -- boolean to restrict search to open files
M.live_grep = function(opts)
  opts = opts or {}

  local vimgrep_arguments = opts.vimgrep_arguments or conf.vimgrep_arguments
  local search_dirs = opts.search_dirs
  local grep_open_files = opts.grep_open_files
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()

  local filelist = {}

  if grep_open_files then
    local bufnrs = filter(function(b)
      if 1 ~= vim.fn.buflisted(b) then
        return false
      end
      return true
    end, vim.api.nvim_list_bufs())
    if not next(bufnrs) then
      return
    end

    for _, bufnr in ipairs(bufnrs) do
      local file = vim.api.nvim_buf_get_name(bufnr)
      table.insert(filelist, Path:new(file):make_relative(opts.cwd))
    end
  elseif search_dirs then
    for i, path in ipairs(search_dirs) do
      search_dirs[i] = vim.fn.expand(path)
    end
  end

  local additional_args = {}
  if opts.additional_args ~= nil and type(opts.additional_args) == "function" then
    additional_args = opts.additional_args(opts)
  end


  local live_grepper = finders.new_job(function(prompt)
    -- TODO: Probably could add some options for smart case and whatever else rg offers.

    if not prompt or prompt == "" then
      return nil
    end

    local search_list = {}

    if search_dirs then
      table.insert(search_list, search_dirs)
    end

    if grep_open_files then
      search_list = filelist
    end

    local search_string = flatten { vimgrep_arguments, additional_args, "--", prompt, search_list }

	-- mount/open the component
	-- popup:mount()

	-- vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, search_string)

	return search_string
  end, opts.entry_maker or make_entry.gen_from_vimgrep(opts), opts.max_results, opts.cwd)

  pickers.new(opts, {
    prompt_title = "Live Grep",
    finder = live_grepper,
    previewer = conf.grep_previewer(opts),
    -- TODO: It would be cool to use `--json` output for this
    -- and then we could get the highlight positions directly.
    sorter = sorters.highlighter_only(opts),
  }):find()
end

return M
