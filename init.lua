-- Disable netrw early to prevent it from opening
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- If the first argument is a directory, cd into it immediately
local first_arg = vim.fn.argv(0)
if first_arg ~= "" and vim.fn.isdirectory(first_arg) == 1 then
    vim.api.nvim_set_current_dir(first_arg)
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not(vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
	if vim.v.shell_error ~= 0 then 
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim :\n", "ErrorMsg"},
			{ out, "WarningMsg" }, 
			{ "\nPress Any key to Continue...."},
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)


local opts = {}
require("core.vim-options")
require("core.templates")
require("core.add-context")
require("core.smart-getfile")
require("core.windows-specific")
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    change_detection = { notify = false }
})
require('core.lsp')

-- to supress the initial error for gd,gi functions temporary fix
local original_notify = vim.notify
vim.notify = function(msg, level, opts)
  if type(msg) == "string" and msg:match("position_encoding param is required") then
    return
  end
  original_notify(msg, level, opts)
end

