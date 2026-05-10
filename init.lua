-- Disable netrw early to prevent it from opening
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- If the first argument is a directory, cd into it immediately
local first_arg = vim.fn.argv(0)
if first_arg ~= "" and vim.fn.isdirectory(first_arg) == 1 then
    vim.api.nvim_set_current_dir(first_arg)
end

require("core.vim-options")
require("core.templates")
require("core.add-context")
require("core.smart-getfile")
require("core.windows-specific")
require("plugins")
require("core.checkbox")
require("core.lsp")

-- suppress the initial error for gd, gi functions; temporary fix
local original_notify = vim.notify
vim.notify = function(msg, level, opts)
    if type(msg) == "string" and msg:match("position_encoding param is required") then
        return
    end
    original_notify(msg, level, opts)
end
