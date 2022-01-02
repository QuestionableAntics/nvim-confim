local null_ls = require 'null-ls'

local builtins = null_ls.builtins

local sources = {
	builtins.diagnostics.eslint,
	builtins.code_actions.eslint,
	builtins.formatting.prettier
}

null_ls.setup {
	sources = sources
}

-- local null_ls_formatting = function(client)
-- 	client.resolved_capabilities.document_formatting = false
-- 	client.resolved_capabilities.document_range_formatting = false
-- end


