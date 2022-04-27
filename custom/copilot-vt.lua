local source = {}
local util = require("copilot.util")
local existing_matches = {}

local get_line = function (line)
  local line_text = vim.api.nvim_buf_get_lines(0, line, line+1, false)[1]
  return line_text
end

local get_line_text = function ()
  local next_line = vim.api.nvim_win_get_cursor(0)[1]
  return get_line(next_line) or ""
end

local function split_remove_trailing_newline(str)
  local list = vim.fn.split(str, "\n")
  if list[#list] == "" then
    list[#list] = nil
  end
  return list
end

local get_text_after_cursor = function()
  local current_line = vim.api.nvim_get_current_line()
  current_line = current_line:sub(vim.api.nvim_win_get_cursor(0)[2]+1)
  return current_line or ""
end

local remove_string_from_end = function(str, str_to_remove)
  if str:sub(-#str_to_remove) == str_to_remove then
    return str:sub(1, -#str_to_remove - 1)
  end
  return str
end

local clean_insertion = function(text)
  local indent = string.match(text, '^%s*')
  if not indent then return text end
  local list = split_remove_trailing_newline(string.gsub(text, '^' .. indent, ''))
  list[1] = remove_string_from_end(list[1], get_text_after_cursor())
  if #list > 1 then
    list[#list] = remove_string_from_end(list[#list], get_line_text())
  end
  return remove_string_from_end(table.concat(list, '\n'), '\n')
end

local get_range = function (item, params)
  return {
    start = item.range.start,
    ['end'] = params.context.cursor,
  }
end

source.format_and_clean_insertion = function(item, params)
  local deindented = clean_insertion(item.text)
  return {
    range = get_range(item, params),
    newText = deindented
  }
end

source.new = function(client)
  local self = setmetatable({ timer = vim.loop.new_timer() }, { __index = source })
  self.client = client
  self.request_ids = {}
  return self
end

source.get_trigger_characters = function()
  return { "\t", "\n", ".", ":", "(", "'", '"', "[", ",", "#", "*", "@", "|", "=", "-", "{", "/", "\\", " ", "+", "?"}
end

source.is_available = function(self)
  -- client is stopped.
  if self.client.is_stopped() then
    return false
  end
  -- client is not attached to current buffer.
  if not vim.lsp.buf_get_clients(vim.api.nvim_get_current_buf())[self.client.id] then
    return false
  end
  if not self.client.name == "copilot" then
    return false
  end
  return true
end

source.deindent = function(text)
  local indent = string.match(text, '^%s*')
  if not indent then
    return text
  end
  return string.gsub(string.gsub(text, '^' .. indent, ''), '\n' .. indent, '\n')
end

source.format_completions = function(_, params, completions)
  local formatted = {
    IsIncomplete = true,
    items = vim.tbl_map(function(item)
      item = vim.tbl_extend('force', {}, item)
      local cleaned = source.deindent(item.text)
      local label = cleaned:gsub('\n', ' ')
      label = label:len()<30 and label or label:sub(1,20).." ... "..label:sub(-10)
      return {
        label = label,
        kind = 15,
        textEdit = source.format_and_clean_insertion(item, params),
        documentation = {
          kind = "markdown",
          value = "```" .. vim.bo.filetype .. "\n" .. cleaned .. "\n```"
        },
      }
    end, completions)
  }
  return formatted
end

source.complete = function(self, params, callback)
  existing_matches[params.context.bufnr] = existing_matches[params.context.bufnr] or {}
  existing_matches[params.context.bufnr][params.context.cursor.row] = existing_matches[params.context.bufnr][params.context.cursor.row] or { IsIncomplete = true }
  local existing = existing_matches[params.context.bufnr][params.context.cursor.row]
  local has_complete = false
  vim.lsp.buf_request(0, "getCompletionsCycling", util.get_completion_params(), function(_, response)
    if response and not vim.tbl_isempty(response.completions) then
      existing = vim.tbl_deep_extend("force", existing, self:format_completions(params, response.completions))
      has_complete = true
    end
    vim.schedule(function() callback(existing) end)
  end)
  if not has_complete then
    callback(existing)
  end
end


----------------------------------------------------------------------------------


local M = {}

---Registered client and source mapping.
M.client_source_map = {}
M.registered = false

M.setup = function()
	vim.api.nvim_create_autocmd({ "InsertEnter" }, { callback = M._on_insert_enter })
end

---Setup cmp-nvim-lsp source.
local if_nil = function(val, default)
  if val == nil then
    return default
  end
  return val
end

M.update_capabilities = function(capabilities, override)
  override = override or {}
  local completionItem = capabilities.textDocument.completion.completionItem
  completionItem.snippetSupport = if_nil(override.snippetSupport, true)
  completionItem.preselectSupport = if_nil(override.preselectSupport, true)
  completionItem.insertReplaceSupport = if_nil(override.insertReplaceSupport, true)
  completionItem.labelDetailsSupport = if_nil(override.labelDetailsSupport, true)
  completionItem.deprecatedSupport = if_nil(override.deprecatedSupport, true)
  completionItem.commitCharactersSupport = if_nil(override.commitCharactersSupport, true)
  completionItem.tagSupport = if_nil(override.tagSupport, { valueSet = { 1 } })
  completionItem.resolveSupport = if_nil(override.resolveSupport, {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  })

  return capabilities
end

local find_buf_client = function()
  for _, client in ipairs(vim.lsp.get_active_clients()) do
    if client.name == "copilot" then
      return client
    end
  end
end

M._on_insert_enter = function()
	
  -- local cmp = require("cmp")
	local copilot = find_buf_client()

	local s = source.new(copilot)
	if copilot and not M.client_source_map[copilot.id] then
		if s:is_available() then
			M.registered = true
			M.client_source_map[copilot.id] = s

			local bnr = vim.fn.bufnr('%')
			local ns_id = vim.api.nvim_create_namespace('copilot-vt')

			local line_num = 5
			local col_num = 5

			local opts = {
				end_line = 10,
				id = 1,
				virt_text = {{"demo", "IncSearch"}},
				virt_text_pos = 'overlay',
				-- virt_text_win_col = 20,
			}

			vim.api.nvim_buf_set_extmark(bnr, ns_id, line_num, col_num, opts)
		end
	end
	-- 	local s = source.new(copilot)
	-- 	if s:is_available() then
	-- 		M.client_source_map[copilot.id] = s
	-- 		-- M.client_source_map[copilot.id] = cmp.register_source("copilot", s)
	-- 	end
	-- end
end

-- return M
