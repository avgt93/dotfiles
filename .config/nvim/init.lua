require("daze.options")
require("daze.keybinds")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("daze.plugins")

require("daze.colorscheme")

pcall(require, "impatient")
