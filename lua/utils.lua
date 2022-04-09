local cmd = vim.cmd

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

	if opts.disable == true then
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

-- look into using this instead of the vim notes window
-- local Popup = require "nui.popup"
-- local event = require("nui.utils.autocmd").event

-- local popup = Popup({
--   enter = false,
--   focusable = true,
--   zindex = -1,
--   border = {
--     style = "rounded",
--   },
--   position = {
-- 	 row = "10%",
-- 	 col = "90%",
--   },
--   size = {
--     width = "10%",
--     height = "10%",
--   },
--   buf_options = {
--     modifiable = false,
--     readonly = true,
--   },
-- })

-- -- unmount component when cursor leaves buffer
-- popup:on({ event.BufLeave }, function()
--   popup:unmount()
-- end, { once = true })
-- popup:on(event.FocusLost, function() popup:unmount() end)

-- mount/open the component
-- popup:mount()

-- vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { "asdfasdf" })

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

return M
