require("daze.options")
require("daze.keybinds")

vim.opt.confirm = true
vim.opt.writebackup = false
vim.opt.backup = false
vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.winborder = "rounded"

vim.cmd([[syntax enable]])
vim.cmd([[filetype plugin indent on]])
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

-- auto complete
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("daze.plugins")
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "ts_ls", "gopls" },
})
require("daze.colorscheme")

pcall(require, "impatient")
