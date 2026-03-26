return {
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = { "mfussenegger/nvim-dap" },
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("daze.config.dap-ui-config")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("daze.config.dap-config")
		end,
	},
}
