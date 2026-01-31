vim.lsp.enable({
    "clangd",
    "ts_ls"
})
vim.diagnostic.config({
    virtual_text = {spacing = 4},
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true
    }
})
local ui = require("fzf-lua")
ui.register_ui_select()
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gi", ui.lsp_implementations, {})
vim.keymap.set("n", "gd", ui.lsp_definitions, {})
vim.keymap.set({ "n", "v" }, "<leader>ca", ui.lsp_code_actions, {silent = true})
vim.keymap.set({ "n", "v" }, "gr", ui.lsp_references, {})
vim.keymap.set('n', '<leader>en', "<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ep', "<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>", { noremap = true, silent = true })

vim.keymap.set('n', '<leader>ea', function()
    ui.diagnostics_workspace({
        severity_only = vim.diagnostic.severity.ERROR,
    })
end, {})
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>ci", vim.lsp.buf.incoming_calls, { desc = "Incoming Calls" })
vim.keymap.set("n", "<leader>co", vim.lsp.buf.outgoing_calls, { desc = "Outgoing Calls" })
vim.keymap.set("i", "<C-m>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

vim.keymap.set('n', '<leader>d', function()
    vim.diagnostic.open_float(nil, { border = "rounded" })
end, { desc = "Show diagnostic" })

vim.keymap.set('n', "gs", ui.lsp_document_symbols, { desc = "Get Symbols list" })
-- below will change with change in the UI provider
vim.keymap.set('n', "gm", function()
    ui.lsp_document_symbols({
        regex_filter = function(item)
            return item.kind == "Method"
        end
    })
end, { desc = "Get Methods list" })
