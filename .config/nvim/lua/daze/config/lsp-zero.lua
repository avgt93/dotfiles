local lsp = require("lsp-zero").preset("recommended")
local lspconfig = require("lspconfig")

lsp.setup_nvim_cmp({
	preselect = "none",
	completion = { completeopt = "menu,menuone,noinsert,noselect" },
})

require("lspconfig").dartls.setup({
	cmd = { "dart", "language-server", "--protocol=lsp" },
})

require("lspconfig").intelephense.setup({
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	root_dir = lspconfig.util.root_pattern("composer.json", ".git", ".autocomplete"),
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
	end,
})

require("lspconfig").ts_ls.setup({
	on_attach = function(client, bufnr)
		-- Disable formatting if you're using another tool like Prettier
		client.resolved_capabilities.document_formatting = false

		-- You can add more custom on_attach behavior here if needed
		local opts = { noremap = true, silent = true }

		-- Example keymap for LSP functionality
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	end,
	filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
	cmd = { "typescript-language-server", "--stdio" },
	root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json", ".git"),
	handlers = {
		["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
			if result.diagnostics == nil then
				return
			end

			-- ignore some tsserver diagnostics
			local idx = 1
			while idx <= #result.diagnostics do
				local entry = result.diagnostics[idx]

				local formatter = require("format-ts-errors")[entry.code]
				entry.message = formatter and formatter(entry.message) or entry.message

				-- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
				if entry.code == 80001 then
					-- { message = "File is a CommonJS module; it may be converted to an ES module.", }
					table.remove(result.diagnostics, idx)
				else
					idx = idx + 1
				end
			end

			vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
		end,
	},
})

require("lspconfig").eslint.setup({
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})

lsp.setup()

-- vim.lsp.inlay_hint.enable(0, true)

require("daze.config.cmp")
