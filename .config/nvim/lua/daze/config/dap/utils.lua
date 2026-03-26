local M = {}

M.signs = {
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
		linehl = "DapStopped",
		numhl = "DapStopped",
	},
}

function M.setup_signs()
	vim.fn.sign_define("DapBreakpoint", M.signs.error)
	vim.fn.sign_define("DapBreakpointCondition", M.signs.condition)
	vim.fn.sign_define("DapBreakpointRejected", M.signs.rejected)
	vim.fn.sign_define("DapLogPoint", M.signs.logpoint)
	vim.fn.sign_define("DapStopped", M.signs.stopped)
end

function M.find_report_root()
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

function M.get_pkg_scripts()
	local root = M.find_report_root()
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

function M.cleanup_port()
	vim.fn.system("sudo /usr/bin/fuser -k 9229/tcp 2>/dev/null")
	vim.cmd("sleep 200m")
end

return M
