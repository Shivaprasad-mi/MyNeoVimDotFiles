local ts = require("nvim-treesitter")

ts.install({ "lua", "c_sharp", "sql", "angular", "html", "cpp", "json" })

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        pcall(vim.treesitter.start, bufnr)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
