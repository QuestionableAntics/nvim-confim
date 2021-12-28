local dap = require 'dap'

local function attach()
	dap.run{
		type = 'node2',
		requirest = 'attach',
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = 'inspector',
		skipFiles = {'<node_internals>/**/*.js'}
	}
end

dap.adapters.node2 = {
	type = 'executable',
	command = 'node',
	args = {os.getenv('HOME') .. '/apps/vscode-js-debug/src/debugServer.ts'}
}

return {
	attach = attach
}












-- local dap = require 'dap'
-- local utils = require 'utils'
-- dap.set_log_level('TRACE'); -- logs live at ~/.cache/nvim/dap.log

-- -- Enable virtual text.
-- vim.g.dap_virtual_text = true
-- -- Fancy breakpoint symbol.
-- vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

-- local ensure_script = os.getenv('PLAID_PATH') .. '/go.git/scripts/ensure_debugger_session.sh';
-- local batch_mocha_script = os.getenv('HOME') .. '/.start_mocha_batch.sh';

-- local function get_debugging_port(service_name)
--   if service_name == 'stasher' then
--     service_name = 'scheduler_stasher'
--   end
--   local ports_compose = io.open(
--     os.getenv('PLAID_PATH') .. '/go.git/proto/src/plaidtypes/coretypes/service.proto', 'r'
--   )
--   local port = nil
--   for line in ports_compose:lines() do
--     -- Match lines like: "    SERVICE_FEATURE_SERVER_CONSUMER = 181 [" and pull the 181.
--     local proto_base = string.match(
--       line,
--       '^%s-SERVICE_' .. string.upper(service_name) .. '%s-=%s-(%d+)%s-%['
--     )
--     if proto_base ~= nil then
--       port = 50000 + (proto_base + 1) * 10 - 1
--       break
--     end
--   end
--   ports_compose:close()
--   return port
-- end


-- local function start_devenv_debug_session()
--   local service_name = vim.fn.input('\nDebugee Service: ')
--   local port = get_debugging_port(service_name) or vim.fn.input('\nDebuggee Port: ')
--   -- Start the debugger in the devenv service.
--   vim.fn.system({ensure_script, service_name})
--   io.write(string.format('Debug session for %s with port %d', service_name, port))
--   return service_name, port;
-- end

-- local function get_devenv_host()
--   local remoteness = vim.fn.input('\nRemote or Local Devenv: ')
--   local host;
--   if remoteness == 'remote' then
--     host = '10.131.1.149';
--   elseif remoteness == 'local' then
--     host = '127.0.0.1';
--   else
--     io.write(string.format('Unusable remoteness value: %s', remoteness));
--   end
--   return host
-- end


-- ------ Adapters ------

-- -- NODE / TYPESCRIPT
-- dap.adapters.node2 = function(cb, config)
--   local cb_input = {
--     type = 'executable';
--     command = os.getenv('HOME') .. '/.nvm/versions/node/v12.18.2/bin/node';
--     args = { os.getenv('HOME') .. '/vscode-node-debug2/out/src/nodeDebug.js' };
--   };
--   if config.request == 'attach' and config.mode == 'remote' then
--     local _, port = start_devenv_debug_session()
--     cb_input.enrich_config = function(config, on_config)
--       local f_config = vim.deepcopy(config)
--       f_config.port = tonumber(port)
--       on_config(f_config)
--     end;
--   elseif config.mode == 'test' then
--     if config.request == 'attach' then
--       local _, port = start_devenv_debug_session();
--       local host = get_devenv_host();
--       vim.fn.input('\n[Optional] test flter: ');
--       vim.fn.system({batch_mocha_script});
--       cb_input.enrich_config = function(config, on_config)
--         local f_config = vim.deepcopy(config)
--         f_config.port = tonumber(port)
--         f_config.host = host;
--         on_config(f_config)
--       end;
--     elseif config.request == 'launch' then
--       cb_input.enrich_config = function(config, on_config)
--         local f_config = vim.deepcopy(config)
--         local grepFilter = vim.fn.input('\n[Optional] test filter: ');
--         if grepFilter ~= '' then
--           table.insert(f_config.args, 1, string.format("--grep=%s", grepFilter));
--         end
--         print(utils.debug_print(f_config));
--         on_config(f_config);
--       end;
--     end
--   end

--   cb(cb_input);
-- end
