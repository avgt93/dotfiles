local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },

		python = { "isort", "black" },

		javascript = { "prettier" },

		html = { "prettier" },

		typescript = { "prettier" },

		typescriptreact = { "prettier" },

		javascriptreact = { "prettier" },

		css = { "prettier" },

		json = { "prettier" },

		rust = { "rustfmt" },

		dart = { "dart_format" },

		php = { "pretty-php", "php-cs-fixer" },

		go = { "gofmt", "gofumpt" },
	},

	format_after_save = {
		lsp_format = "fallback",
	},
	notify_no_formatters = true,
})
