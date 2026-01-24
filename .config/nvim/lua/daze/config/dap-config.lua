local dap = require("dap")

-- -----------------------------------------------------------------------------
-- UI / Signs Configuration (VS Code Style)
-- -----------------------------------------------------------------------------
local dap_breakpoint = {
	error = {
		text = "●",
		texthl = "DapBreakpoint",
		linehl = "",
		numhl = "DapBreakpoint",
	},
	condition = {
		text = "●",
		texthl = "DapBreakpoint",
		linehl = "",
		numhl = "DapBreakpoint",
	},
	rejected = {
		text = "",
		texthl = "DapBreakpoint",
		linehl = "",
		numhl = "DapBreakpoint",
	},
	logpoint = {
		text = "◆",
		texthl = "DapLogPoint",
		linehl = "",
		numhl = "DapLogPoint",
	},
	stopped = {
		text = "→",
		texthl = "DapStopped",
		linehl = "DapStopped", -- Highlights the line background where execution stopped
		numhl = "DapStopped",
	},
}

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)

-- -----------------------------------------------------------------------------
-- Helpers
-- -----------------------------------------------------------------------------

--- Find the nearest package.json starting from current file
local function find_report_root()
	local file_path = vim.api.nvim_buf_get_name(0)
	if file_path == "" then
		return vim.fn.getcwd()
	end
	local root_file = vim.fs.find({ "package.json" }, { upward = true, path = file_path })[1]
	if root_file then
		return vim.fs.dirname(root_file)
	end
	return vim.fn.getcwd()
end

--- Parse package.json scripts in the nearest report root
local function get_pkg_scripts()
	local root = find_report_root()
	local path = root .. "/package.json"
	if vim.fn.filereadable(path) == 0 then
		return {}
	end

	local lines = vim.fn.readfile(path)
	local data = vim.fn.json_decode(table.concat(lines, ""))
	if not data or not data.scripts then
		return {}
	end

	local scripts = {}
	for name, _ in pairs(data.scripts) do
		table.insert(scripts, name)
	end
	table.sort(scripts)
	return scripts
end

--- Cleanup port 9229
local function cleanup_port()
	vim.fn.system("sudo /usr/bin/fuser -k 9229/tcp 2>/dev/null")
	-- Small sleep to allow port to be released
	vim.cmd("sleep 200m")
end

-- -----------------------------------------------------------------------------
-- 1. Python
-- -----------------------------------------------------------------------------
dap.adapters.python = function(cb, config)
	if config.request == "attach" then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = {
				source_filetype = "python",
			},
		})
	else
		cb({
			type = "executable",
			command = "python3",
			args = { "-m", "debugpy.adapter" },
			options = {
				source_filetype = "python",
			},
		})
	end
end

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
				return cwd .. "/venv/bin/python"
			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/.venv/bin/python"
			else
				return "python3"
			end
		end,
	},
}

-- -----------------------------------------------------------------------------
-- 2. JavaScript / TypeScript
-- -----------------------------------------------------------------------------
dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "js-debug-adapter",
		args = { "${port}" },
	},
}

local js_based_languages = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
for _, language in ipairs(js_based_languages) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach: Crawler (Docker)",
			port = 9229,
			cwd = find_report_root,
			restart = true,
			sourceMaps = true,
			autoAttachChildProcesses = false,
			skipFiles = { "<node_internals>/**", "**/node_modules/**" },
			protocol = "inspector",
			localRoot = "/home/avgt/all/vortex-plugins/vtx/vortex-ts-crawler",
			remoteRoot = "/home/grepsr/crawler",
			sourceMapPathOverrides = {
				["/home/grepsr/crawler/*"] = "/home/avgt/all/vortex-plugins/vtx/vortex-ts-crawler/*",
				["../src/*"] = "${workspaceFolder}/src/*",
			},
			resolveSourceMapLocations = {
				"/home/avgt/all/vortex-plugins/vtx/vortex-ts-crawler/**/*.js",
				"!**/node_modules/**",
			},
			outFiles = {
				"/home/avgt/all/vortex-plugins/vtx/vortex-ts-crawler/**/*.js",
				"!**/node_modules/**",
			},
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "GCLI: Crawler Test (Docker Launch)",
			runtimeExecutable = "/home/avgt/.local/bin/gcli",
			runtimeArgs = function()
				cleanup_port()
				local root = find_report_root()
				local report_name = vim.fn.fnamemodify(root, ":t")
				return { "crawler", "test", "-s", report_name }
			end,
			cwd = find_report_root,
			env = {
				APP_ENV = "tst",
				-- Use inspect instead of inspect-brk to avoid stopping at start
				NODE_OPTIONS = "--inspect=0.0.0.0:9229",
			},
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
			-- CRITICAL: Disable autoAttach to prevent bootloader.js injection error
			autoAttachChildProcesses = false,
			localRoot = "/home/avgt/all/vortex-plugins/vtx/vortex-ts-crawler",
			remoteRoot = "/home/grepsr/crawler",
			sourceMapPathOverrides = {
				["/home/grepsr/crawler/*"] = "/home/avgt/all/vortex-plugins/vtx/vortex-ts-crawler/*",
				["../src/*"] = "${workspaceFolder}/src/*",
			},
			resolveSourceMapLocations = {
				"**",
				"!**/node_modules/**",
			},
			outFiles = {
				"/home/avgt/all/vortex-plugins/vtx/vortex-ts-crawler/**/*.js",
				"!**/node_modules/**",
			},
			skipFiles = {
				"<node_internals>/**",
				"**/node_modules/**",
			},
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach to Process",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Crawler: npm start (Report Root)",
			runtimeExecutable = "npm",
			runtimeArgs = { "start" },
			cwd = find_report_root,
			env = { APP_ENV = "tst" },
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Package Script (Selection)",
			runtimeExecutable = "npm",
			runtimeArgs = function()
				local scripts = get_pkg_scripts()
				if #scripts == 0 then
					vim.notify("No scripts found in package.json", vim.log.levels.ERROR)
					return nil
				end
				local chosen = nil
				vim.ui.select(scripts, { prompt = "Select script to debug: " }, function(selection)
					chosen = selection
				end)
				-- Wait for selection
				local wait_count = 0
				while chosen == nil and wait_count < 100 do
					vim.cmd("sleep 100m")
					wait_count = wait_count + 1
				end
				if chosen then
					return { "run", chosen }
				end
				return nil
			end,
			cwd = find_report_root,
			console = "integratedTerminal",
		},
	}
end

-- -----------------------------------------------------------------------------
-- 3. PHP
-- -----------------------------------------------------------------------------
dap.adapters.php = {
	type = "executable",
	command = "php-debug-adapter",
}

dap.configurations.php = {
	{
		type = "php",
		request = "launch",
		name = "Listen for Xdebug",
		port = 9003,
		pathMappings = {
			["/var/www/html"] = "${workspaceFolder}",
		},
	},
}

-- -----------------------------------------------------------------------------
-- 4. Go
-- -----------------------------------------------------------------------------
dap.adapters.delve = {
	type = "server",
	port = "${port}",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

dap.configurations.go = {
	{
		type = "delve",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
	{
		type = "delve",
		name = "Debug test",
		request = "launch",
		mode = "test",
		program = "${file}",
	},
}
