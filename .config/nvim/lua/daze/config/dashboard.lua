local home = os.getenv("HOME")
require("dashboard").setup({
	theme = "doom",
	config = {
		header = {
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
			" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
			" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
			" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
			" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
			" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
			"",
			"",
			"",
			"",
			"",
			"",
		},
		center = {
			{
				icon = "  ",
				desc = "Find  File",
				action = "Telescope find_files",
				key = "SPC f f",
			},
			{
				icon = "  ",
				desc = "Find  word",
				action = "Telescope live_grep",
				key = "SPC f w",
			},
			{
				icon = "  ",
				desc = "Recent session",
				key = "SPC s l",
				action = "SessionLoad",
			},
			{
				icon = "  ",
				desc = "Recently opened files",
				action = "DashboardFindHistory",
				key = "SPC f h",
			},
			{
				icon = "  ",
				desc = "Themes",
				action = "Telescope colorscheme",
				key = "SPC t h",
			},
			{
				icon = "  ",
				desc = "Open Personal dotfiles",
				action = function()
					local dotfiles_path = home .. "/.config/nvim"

					-- Change working directory
					vim.cmd("cd " .. dotfiles_path)

					-- Open Telescope in that folder
					require("telescope.builtin").find_files({
						prompt_title = "Dotfiles",
						cwd = dotfiles_path,
						find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
					})
				end,
				key = "SPC f d",
			},
		},
		-- footer = { "", "", "Loaded " .. require("dashboard.utils").get_packages_count() .. " packages" },
	},
})
