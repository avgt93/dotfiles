return {
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
			{ "ibhagwan/fzf-lua" },
			{
				"folke/snacks.nvim",
				opts = {
					terminal = {},
				},
			},
		},
		event = "LspAttach",
		opts = {},
	},
	{
		"davidosomething/format-ts-errors.nvim",
		config = function()
			require("format-ts-errors").setup({
				add_markdown = true,
				start_indent_level = 1,
			})
		end,
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		config = function()
			require("tiny-inline-diagnostic").setup({
				signs = {
					left = "",
					right = "",
					diag = "●",
					arrow = "    ",
					up_arrow = "    ",
					vertical = " │",
					vertical_end = " └",
				},
				hi = {
					error = "DiagnosticError",
					warn = "DiagnosticWarn",
					info = "DiagnosticInfo",
					hint = "DiagnosticHint",
					arrow = "NonText",
					background = "CursorLine",
					mixing_color = "None",
				},
				blend = { factor = 0.27 },
				options = {
					show_source = true,
					throttle = 20,
					softwrap = 15,
					multiple_diag_under_cursor = true,
					multilines = false,
					overflow = { mode = "wrap" },
					format = function(diagnostic)
						local source = diagnostic.source or "LSP"
						return source .. ": " .. diagnostic.message
					end,
					break_line = { enabled = false, after = 30 },
					virt_texts = { priority = 2048 },
					severity = {
						vim.diagnostic.severity.ERROR,
						vim.diagnostic.severity.WARN,
						vim.diagnostic.severity.INFO,
						vim.diagnostic.severity.HINT,
					},
					overwrite_events = nil,
				},
			})
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
			{ "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		},
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
		},
		opts = {},
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("daze.config.conform")
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-cmdline" },
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
		config = function()
			require("daze.config.lsp-zero")
		end,
	},
}
