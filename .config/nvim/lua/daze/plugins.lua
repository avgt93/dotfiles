return {
	"wbthomason/packer.nvim",
	"nvim-lua/plenary.nvim",
	"lewis6991/impatient.nvim",

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
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },

			-- optional picker via telescope
			{ "nvim-telescope/telescope.nvim" },
			-- optional picker via fzf-lua
			{ "ibhagwan/fzf-lua" },
			-- .. or via snacks
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
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
		opts = {
			-- add any opts here
		},
		config = function()
			require("daze.config.avante")
		end,

		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	-- Autopair
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
		"davidosomething/format-ts-errors.nvim",
		config = function()
			require("format-ts-errors").setup({
				add_markdown = true, -- wrap output with markdown ```ts ``` markers
				start_indent_level = 1, -- initial indent
			})
		end,
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-vscode-js").setup({
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			})

			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						{
							type = "pwa-node",
							request = "launch",
							name = "Launch file",
							program = "${file}",
							cwd = "${workspaceFolder}",
						},
						{
							type = "pwa-node",
							request = "attach",
							name = "Attach",
							processId = require("dap.utils").pick_process,
							cwd = "${workspaceFolder}",
						},
					},
				}
			end
		end,
	},
	{
		"AndrewRadev/tagalong.vim",
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
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

	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
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
					background = "CursorLine", -- Can be a highlight or a hexadecimal color (#RRGGBB)
					mixing_color = "None", -- Can be None or a hexadecimal color (#RRGGBB). Used to blend the background color with the diagnostic background color with another color.
				},
				blend = {
					factor = 0.27,
				},
				options = {
					-- Show the source of the diagnostic.
					show_source = true,

					-- Throttle the update of the diagnostic when moving cursor, in milliseconds.
					-- You can increase it if you have performance issues.
					-- Or set it to 0 to have better visuals.
					throttle = 20,

					-- The minimum length of the message, otherwise it will be on a new line.
					softwrap = 15,

					-- If multiple diagnostics are under the cursor, display all of them.
					multiple_diag_under_cursor = false,

					-- Enable diagnostic message on all lines.
					multilines = false,

					overflow = {
						-- Manage the overflow of the message.
						--    - wrap: when the message is too long, it is then displayed on multiple lines.
						--    - none: the message will not be truncated.
						--    - oneline: message will be displayed entirely on one line.
						mode = "wrap",
					},

					-- Format the diagnostic message.
					-- Example:
					format = function(diagnostic)
						return diagnostic.message .. " [" .. diagnostic.source .. "]"
					end,
					-- format = nil,

					--- Enable it if you want to always have message with `after` characters length.
					break_line = {
						enabled = false,
						after = 30,
					},

					virt_texts = {
						priority = 2048,
					},

					-- Filter by severity.
					severity = {
						vim.diagnostic.severity.ERROR,
						vim.diagnostic.severity.WARN,
						vim.diagnostic.severity.INFO,
						vim.diagnostic.severity.HINT,
					},

					-- Overwrite events to attach to a buffer. You should not change it, but if the plugin
					-- does not works in your configuration, you may try to tweak it.
					overwrite_events = nil,
				},
			})
		end,
	},
	{
		"AndrewRadev/tagalong.vim",
	},
	{
		"olrtg/nvim-emmet",
		config = function()
			vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xq",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- optional
			"neovim/nvim-lspconfig", -- optional
		},
		opts = {}, -- your configuration
	},
	{ "djoshea/vim-autoread" },
	-- Theme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("daze.config.catppuccin")
		end,
	},

	-- Dashboard
	{
		"glepnir/dashboard-nvim",
		config = function()
			require("daze.config.dashboard")
		end,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.x",
		config = function()
			require("daze.config.telescope")
		end,
	},

	-- Harpoon for nagivation
	"ThePrimeagen/harpoon",

	-- Indentation guides
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("daze.config.indent-blankline")
		end,
	},

	"arkav/lualine-lsp-progress",

	-- Top buffer line
	{
		"akinsho/bufferline.nvim",
		version = "v4.*",
		config = function()
			require("bufferline").setup({
				options = {
					offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
				},
				highlights = require("catppuccin.groups.integrations.bufferline").get(),
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
			require("nvim-tree").setup({})
		end,
	},

	{
		"stevearc/conform.nvim",
		config = function()
			require("daze.config.conform")
		end,
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

	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			-- { "jose-elias-alvarez/null-ls.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-cmdline" },
			{ "zbirenbaum/copilot-cmp" }, -- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional
		},
		config = function()
			require("daze.config.lsp-zero")
			require("daze.config.copilot")
		end,
	},

	-- Github Copilot
	{ "zbirenbaum/copilot.lua" },

	-- Commenting
	{
		"numToStr/Comment.nvim",
		config = function()
			require("daze.config.comment")
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	-- Status Line Related
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("daze.config.lualine")
		end,
	},

	-- Treesitter for highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("daze.config.nvim-treesitter")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup()
		end,
	},

	-- Visual surround
	{
		"kylechui/nvim-surround",
		version = "*",
		config = function()
			require("nvim-surround").setup({ keymaps = { visual = "A" } })
		end,
	},

	-- Motion
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	--
	-- {
	--     "lewis6991/hover.nvim",
	--     config = function()
	--         require("hover").setup {
	--             init = function()
	--                 -- Require providers
	--                 require("hover.providers.lsp")
	--                 -- require('hover.providers.gh')
	--                 -- require('hover.providers.gh_user')
	--                 -- require('hover.providers.jira')
	--                 -- require('hover.providers.dap')
	--                 -- require('hover.providers.man')
	--                 -- require('hover.providers.dictionary')
	--             end,
	--             preview_opts = {
	--                 border = 'single'
	--             },
	--
	--                 keymaps = {
	--                 hover = '<C-]>',
	--
	--                 },
	--             -- Whether the contents of a currently open hover window should be moved
	--             -- to a :h preview-window when pressing the hover keymap.
	--             preview_window = false,
	--             title = true,
	--             mouse_providers = {
	--                 'LSP'
	--             },
	--             mouse_delay = 1000
	--         }
	--
	--         -- Setup keymaps
	--         -- vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
	--         -- vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
	--         -- vim.keymap.set("n", "<C-p>", function() require("hover").hover_switch("previous") end, { desc = "hover.nvim (previous source)" })
	--         -- vim.keymap.set("n", "<C-n>", function() require("hover").hover_switch("next") end, { desc = "hover.nvim (next source)" })
	--         --
	--         -- -- Mouse support
	--         -- vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = "hover.nvim (mouse)" })
	--         -- vim.o.mousemoveevent = true
	--     end
	-- },
	{
		"ggandor/flit.nvim",
		config = function()
			require("flit").setup({
				keys = { f = "f", F = "F", t = "t", T = "T" },
				-- A string like "nv", "nvo", "o", etc.
				labeled_modes = "v",
				multiline = true,
				-- Like `leap`s similar argument (call-specific overrides).
				-- E.g.: opts = { equivalence_classes = {} }
				lazy = {},
			})
		end,
	},
	{
		"piersolenski/wtf.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {},
		keys = {
			{
				"<leader>wa",
				mode = { "n", "x" },
				function()
					require("wtf").ai()
				end,
				desc = "Debug diagnostic with AI",
			},
			{
				mode = { "n" },
				"<leader>ws",
				function()
					require("wtf").search()
				end,
				desc = "Search diagnostic with Google",
			},
			{
				mode = { "n" },
				"<leader>wh",
				function()
					require("wtf").history()
				end,
				desc = "Populate the quickfix list with previous chat history",
			},
			{
				mode = { "n" },
				"<leader>wg",
				function()
					require("wtf").grep_history()
				end,
				desc = "Grep previous chat history with Telescope",
			},
		},
		-- Default AI popup type
		-- popup_type = "popup" | "horizontal" | "vertical",
		popup_type = "popup",
		-- An alternative way to set your API key
		-- ChatGPT Model
		openai_model_id = "gpt-3.5-turbo",
		-- Send code as well as diagnostics
		context = true,
		-- Set your preferred language for the response
		language = "english",
		-- Any additional instructions
		-- Default search engine, can be overridden by passing an option to WtfSeatch
		-- search_engine = "google" | "duck_duck_go" | "stack_overflow" | "github" | "phind" | "perplexity",
		search_engine = "google",
		-- Callbacks
		hooks = {
			request_started = nil,
			request_finished = nil,
		},
		-- Add custom colours
		winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
	},

	-- Repeat
	{
		"tpope/vim-repeat",
		config = function()
			require("leap").add_default_mappings()
		end,
	},

	-- Git Plugin
	{ "tpope/vim-fugitive" },

	{ "ron-rs/ron.vim" },

	{ "stevearc/dressing.nvim" },

	-- Dart & Flutter Plugin
	-- use {
	--     'akinsho/flutter-tools.nvim',
	--     config = function() require("daze.config.flutter-tools") end
	-- }
	{ "ThePrimeagen/vim-be-good" },
	{ "tikhomirov/vim-glsl" },
	--
	-- 	{
	-- 		"karb94/neoscroll.nvim",
	-- 		config = function()
	-- 			require("daze.config.neoscroll")
	-- 		end,
	-- 	},
}
