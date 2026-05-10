-- Default config merged into every server: include nvim-cmp capabilities
-- so completion works without each lsp/<name>.lua repeating it.
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = ok
    and cmp_lsp.default_capabilities()
    or vim.lsp.protocol.make_client_capabilities()

vim.lsp.config("*", {
    capabilities = capabilities,
})

vim.lsp.enable({
    "ts_ls",
    "lua_ls",
    "roslyn",
})

vim.diagnostic.config({
    virtual_text = { spacing = 4 },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = { border = "rounded", source = true },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN]  = "W",
            [vim.diagnostic.severity.INFO]  = "I",
            [vim.diagnostic.severity.HINT]  = "H",
        },
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        map("n", "K", vim.lsp.buf.hover, "Hover")
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("n", "<leader>ci", vim.lsp.buf.incoming_calls, "Incoming Calls")
        map("n", "<leader>co", vim.lsp.buf.outgoing_calls, "Outgoing Calls")
        map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
        map("n", "gr", vim.lsp.buf.references, "Go to References")
        map("n", "gt", vim.lsp.buf.type_definition, "Go to Type Definition")
        map("i", "<C-m>", vim.lsp.buf.signature_help, "Signature Help")

        local client = vim.lsp.get_client_by_id(args.data.client_id)
    end,
})

-- Diagnostic navigation: vim.diagnostic.jump replaces deprecated goto_next/prev.
vim.keymap.set("n", "<leader>en", function()
    vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, { noremap = true, silent = true, desc = "Next error" })

vim.keymap.set("n", "<leader>ep", function()
    vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end, { noremap = true, silent = true, desc = "Previous error" })

vim.keymap.set("n", "<leader>d", function()
    vim.diagnostic.open_float(nil, { border = "rounded" })
end, { desc = "Show diagnostic" })
