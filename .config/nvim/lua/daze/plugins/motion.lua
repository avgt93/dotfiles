return {
	{
		"https://codeberg.org/andyg/leap.nvim",
		config = function()
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
			vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
		end,
	},
	{
		"ggandor/flit.nvim",
		config = function()
			require("flit").setup({
				keys = { f = "f", F = "F", t = "t", T = "T" },
				labeled_modes = "v",
				multiline = true,
				lazy = {},
			})
		end,
	},
}
