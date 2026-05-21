require("snacks").setup({
    picker = {},
})

-- file picker
vim.keymap.set("n", "<C-p>", function() Snacks.picker.files({ layout = { preset = "select" } }) end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>f", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "<leader>b", function() Snacks.picker.buffers({ layout = { preset = "select" } }) end, { desc = "Find Buffers" })

-- git
vim.keymap.set("n", "<leader>br", function() Snacks.picker.git_branches({ layout = { preset = "select" } }) end, { desc = "Git Branches" })

-- lsp
vim.keymap.set("n", "<leader>ea", function() Snacks.picker.diagnostics({ severity = vim.diagnostic.severity.ERROR, layout = { preset = "select" } }) end, { desc = "Diagnostics" })
vim.keymap.set("n", "gs", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
vim.keymap.set("n", "gm", function() Snacks.picker.lsp_symbols({ filter = { default = { "Method" } } }) end, { desc = "Get Methods list" })
