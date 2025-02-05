local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },

		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },

		-- Use a sub-list to run only the first available formatter
		javascript = { "prettier" },
		html = { "prettier" },

		typescript = { "prettier" },

		typescriptreact = { "prettier" },

		javascriptreact = { "prettier" },

		css = { "prettier" },

		json = { "prettier" },

		rust = { "rustfmt" },

		dart = { "dart_format" },

		php = { "pretty-php" },
	},

	format_after_save = {
		lsp_format = "fallback",
	},
	notify_no_formatters = true,
})
