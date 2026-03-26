local utils = require("daze.config.dap.utils")

return {
	adapter = {
		type = "server",
		host = "localhost",
		port = "${port}",
		executable = {
			command = "js-debug-adapter",
			args = { "${port}" },
		},
	},
	languages = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
	configurations = {
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach: Crawler (Docker)",
			port = 9229,
			cwd = utils.find_report_root,
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
				utils.cleanup_port()
				local root = utils.find_report_root()
				local report_name = vim.fn.fnamemodify(root, ":t")
				return { "crawler", "test", "-s", report_name }
			end,
			cwd = utils.find_report_root,
			env = {
				APP_ENV = "tst",
				NODE_OPTIONS = "--inspect=0.0.0.0:9229",
			},
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
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
			cwd = utils.find_report_root,
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
				local scripts = utils.get_pkg_scripts()
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
			cwd = utils.find_report_root,
			console = "integratedTerminal",
		},
	},
}
