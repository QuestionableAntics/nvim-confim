local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, {noremap = true, silent = true})
end

local function imap(shortcut, command)
  map('i', shortcut, command)
end

local function nmap(shortcut, command)
  map('n', shortcut, command)
end

local function tmap(shortcut, command)
  map('t', shortcut, command)
end

local function vmap(shortcut, command)
  map('v', shortcut, command)
end

local function cmap(shortcut, command)
  map('c', shortcut, command)
end

local function xmap(shortcut, command)
  map('x', shortcut, command)
end

return {
  map = map,
  imap = imap,
  nmap = nmap,
  tmap = tmap,
  vmap = vmap,
  cmap = cmap,
  xmap = xmap,
}
