-- diffview: no setup required for default behavior; just ensure the module loads
require("diffview")

local gitsigns = require("gitsigns")
gitsigns.setup({
    on_attach = function(bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
        if filetype ~= "diffview" and filetype ~= "DiffviewFiles" and filetype ~= "DiffviewFilePanel" then
            vim.keymap.set({ "n", "v" }, "]c", gitsigns.next_hunk, opts)
            vim.keymap.set({ "n", "v" }, "[c", gitsigns.prev_hunk, opts)
        end
    end,
})

vim.keymap.set({ "n", "v" }, "<leader>gs", gitsigns.stage_hunk, { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>gr", gitsigns.reset_hunk, { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>gb", gitsigns.blame, { noremap = true, silent = true })

-- vim-fugitive is vimscript; no lua setup needed.
