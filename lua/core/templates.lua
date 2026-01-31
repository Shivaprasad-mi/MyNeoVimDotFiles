local template_dir = vim.fn.stdpath("config") .. "/templates/"

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
    pattern = "*",
    callback = function()
        -- 1. Only proceed if the buffer is empty
        if vim.fn.line("$") > 1 or vim.fn.getline(1) ~= "" then
            return
        end

        -- 2. Get extension
        local ext = vim.fn.expand("%:e")
        if ext == "" then return end

        local template_file = template_dir .. "template." .. ext

        -- 3. If template exists, read it in
        if vim.fn.filereadable(template_file) == 1 then
            vim.cmd("0r " .. template_file)
            -- Clean up the extra trailing newline '0r' often leaves
            vim.cmd("silent! $delete _")
        end
    end,
})
