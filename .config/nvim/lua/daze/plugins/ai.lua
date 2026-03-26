return {
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			vim.keymap.set("n", "<C-l>", "<Nop>", { silent = true })
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<C-l>",
					clear_suggestion = "<C-]>",
					accept_word = "<C-j>",
				},
			})
		end,
	},
	{
		"ThePrimeagen/99",
		config = function()
			local _99 = require("99")

			local cwd = vim.uv.cwd()
			local basename = vim.fs.basename(cwd)
			_99.setup({
				logger = {
					level = _99.DEBUG,
					path = "/tmp/" .. basename .. ".99.debug",
					print_on_error = true,
				},
				model = "google/antigravity-gemini-3-flash",

				completion = {
					custom_rules = {
						"scratch/custom_rules/",
					},
					source = "cmp",
				},

				md_files = {
					"AGENT.md",
				},
			})

			vim.keymap.set("n", "<leader>99", function()
				_99.fill_in_function()
			end)
			vim.keymap.set("v", "<leader>90", function()
				_99.visual()
			end)

			vim.keymap.set("v", "<leader>9s", function()
				_99.stop_all_requests()
			end)

			vim.keymap.set("n", "<leader>98", function()
				_99.fill_in_function_prompt()
			end)
		end,
	},
	{
		dir = "~/all/vortex-plugins/wingman-vim/",
		name = "Winger",
		event = "VeryLazy",
		config = function()
			require("Winger").setup({
				basePath = "~/all/vortex-plugins/",
			})
		end,
	},
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for `snacks` provider.
			---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		config = function()
			vim.g.opencode_opts = {}

			vim.o.autoread = true

			vim.keymap.set({ "n", "x" }, "<leader>aa", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode" })
			vim.keymap.set({ "n", "x" }, "<leader>ax", function()
				require("opencode").select()
			end, { desc = "Execute opencode action…" })
			vim.keymap.set({ "n", "t" }, "<leader>.", function()
				require("opencode").toggle()
			end, { desc = "Toggle opencode" })

			vim.keymap.set({ "n", "x" }, "go", function()
				return require("opencode").operator("@this ")
			end, { expr = true, desc = "Add range to opencode" })
			vim.keymap.set("n", "goo", function()
				return require("opencode").operator("@this ") .. "_"
			end, { expr = true, desc = "Add line to opencode" })

			vim.keymap.set("n", "<S-C-u>", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "opencode half page up" })
			vim.keymap.set("n", "<S-C-d>", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "opencode half page down" })
		end,
	},
}
