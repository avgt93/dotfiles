return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("daze.config.catppuccin")
		end,
	},
	{
		"glepnir/dashboard-nvim",
		config = function()
			require("daze.config.dashboard")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("daze.config.indent-blankline")
		end,
	},
	"arkav/lualine-lsp-progress",
	{
		"akinsho/bufferline.nvim",
		version = "v4.*",
		config = function()
			require("bufferline").setup({
				options = {
					offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
				},
			})
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				update_focused_file = {
					enable = true,
					update_root = false,
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("daze.config.lualine")
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		---@module 'render-markdown'
		opts = {},
	},
}
