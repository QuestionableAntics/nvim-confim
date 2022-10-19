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

M.packer_use = function()
	local use = nil
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	local packer_bootstrap = false

	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		packer_bootstrap = true
	end

	if packer_bootstrap then
		require('packer').sync()
	end

	require('packer').startup({
		function(pack_use) use = pack_use end,
		-- does not solve, but seems to help some with packer sync/install/update not finishing checking commits for all packages
		config = { display = { max_jobs = 10 } }
	})

	return use
end

return M
