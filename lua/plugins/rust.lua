vim.g.rustaceanvim = {
    server = {
        on_attach = function(client, bufnr) end,
        default_settings = {
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                    buildScripts = { enable = true },
                },
                checkOnSave = true,
                procMacro = { enable = true },
            },
        },
    },
}

vim.api.nvim_create_autocmd("BufRead", {
    pattern = "Cargo.toml",
    once = true,
    callback = function()
        require("crates").setup()
    end,
})
