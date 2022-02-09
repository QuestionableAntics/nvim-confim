local cmd = vim.cmd
local vscode = vim.g.vscode

local M = {}

M.merge_tables = function(first_table, second_table)
	for k,v in pairs(second_table) do
		first_table[k] = v
	end
end

M.map = function(mode, shortcut, command, opts)
	opts = opts or {}

	if opts.disable == nil and vscode then
		return
	end

	vim.keymap.set( mode, shortcut, command, M.merge_tables({ noremap = true, silent = true }, opts) )
end

M.imap = function(shortcut, command, opts)
  M.map('i', shortcut, command, opts)
end

M.nmap = function(shortcut, command, opts)
  M.map('n', shortcut, command, opts)
end

M.tmap = function(shortcut, command, opts)
  M.map('t', shortcut, command, opts)
end

M.vmap = function(shortcut, command, opts)
  M.map('v', shortcut, command, opts)
end

M.cmap = function(shortcut, command, opts)
  M.map('c', shortcut, command, opts)
end

M.xmap = function(shortcut, command, opts)
  M.map('x', shortcut, command, opts)
end

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

return M
