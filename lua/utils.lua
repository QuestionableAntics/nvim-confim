local cmd = vim.cmd

local vscode = vim.g.vscode

local function map(mode, shortcut, command, opts)
	opts = opts or {}
	local disable = vscode

	if opts.disable ~= nil then
		disable = opts.disable
	end

	if disable then
		return
	end

	vim.api.nvim_set_keymap( mode, shortcut, command, { noremap = true, silent = true } )
end

local function imap(shortcut, command, opts)
  map('i', shortcut, command, opts)
end

local function nmap(shortcut, command, opts)
  map('n', shortcut, command, opts)
end

local function tmap(shortcut, command, opts)
  map('t', shortcut, command, opts)
end

local function vmap(shortcut, command, opts)
  map('v', shortcut, command, opts)
end

local function cmap(shortcut, command, opts)
  map('c', shortcut, command, opts)
end

local function xmap(shortcut, command, opts)
  map('x', shortcut, command, opts)
end

-- Borrowed from https://github.com/wbthomason/dotfiles/blob/9134e87b00102cda07f875805f900775244067fe/neovim/.config/nvim/lua/config/utils.lua#L10-L17
---@param group string augroup
---@param cmds string|table autocmd
---@param clear boolean clear augroup
local autocmd = function (group, cmds, clear)
  clear = clear == nil and false or clear
  if type(cmds) == 'string' then cmds = {cmds} end
  cmd('augroup ' .. group)
  if clear then cmd [[autocmd!]] end
  for _, c in ipairs(cmds) do cmd('autocmd ' .. c) end
  cmd [[augroup END]]
end

return {
  map = map,
  imap = imap,
  nmap = nmap,
  tmap = tmap,
  vmap = vmap,
  cmap = cmap,
  xmap = xmap,
  autcmd = autocmd,
}
