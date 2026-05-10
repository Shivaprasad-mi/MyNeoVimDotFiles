vim.opt.isfname:append(":");
-- Smart 'gf' that handles file:line:column or file:line
vim.keymap.set('n', 'gf', function()
    local target = vim.fn.expand("<cfile>") -- Gets the string under cursor
    local file, line = string.match(target, "(.-):(%d+)")
    
    if file and line and vim.fn.filereadable(file) == 1 then
        vim.cmd("edit " .. file)
        vim.api.nvim_win_set_cursor(0, {tonumber(line), 0})
    else
        -- Fallback to normal gf behavior if no colon/line found
        local ok, err = pcall(vim.cmd, "normal! gf")
        if not ok then
            print("Could not find file: " .. target)
        end
    end
end, { desc = "Smart go to file with line number" })
