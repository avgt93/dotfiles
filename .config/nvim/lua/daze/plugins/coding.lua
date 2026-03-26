return {
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = false,
		config = function()
			require("refactoring").setup({
				prompt_func_return_type = {
					go = true,
					cpp = true,
					c = true,
					java = true,
				},
				prompt_func_param_type = {
					go = true,
					cpp = true,
					c = true,
					java = true,
				},
			})
		end,
		opts = {},
	},
	{ "mattn/emmet-vim" },
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({ enable_check_bracket_line = false })
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
					update_in_insert = true,
					underline = true,
					virtual_text = {
						spacing = 5,
						severity_limit = "Warning",
					},
				},
			})
		end,
	},
	{ "AndrewRadev/tagalong.vim" },
	{
		"olrtg/nvim-emmet",
		config = function()
			vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("daze.config.comment")
		end,
	},
}
