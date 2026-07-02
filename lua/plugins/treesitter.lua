return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install({
            "lua", "c_sharp", "sql", "angular", "html", "cpp", "json",
            "markdown", "markdown_inline",
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "lua", "cs", "sql", "html", "htmlangular",
                "cpp", "c", "json", "markdown",
            },
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })

        -- Incremental selection (replacement for removed built-in module).
        -- <CR> grows selection to parent node, <BS> shrinks it.
        local stack = {}

        local function select_node(node)
            local sr, sc, er, ec = node:range()
            vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
            vim.cmd("normal! v")
            vim.api.nvim_win_set_cursor(0, { er + 1, math.max(ec - 1, 0) })
        end

        -- vim.keymap.set({ "n", "x" }, "<CR>", function()
        --     local node
        --     if vim.fn.mode() == "n" then
        --         stack = {}
        --         node = vim.treesitter.get_node()
        --     else
        --         local top = stack[#stack]
        --         node = top and top:parent() or vim.treesitter.get_node()
        --     end
        --     if not node then return end
        --     table.insert(stack, node)
        --     select_node(node)
        -- end, { desc = "TS incremental selection" })

        vim.keymap.set("x", "<BS>", function()
            if #stack <= 1 then return end
            table.remove(stack)
            select_node(stack[#stack])
        end, { desc = "TS decremental selection" })
    end,
}
