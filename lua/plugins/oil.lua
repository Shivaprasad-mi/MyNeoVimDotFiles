require("mini.icons").setup()

local oil = require("oil")
oil.setup({
    keymaps = {
        ["<C-p>"] = false,
        ["<C-h>"] = "actions.preview",
    },
    skip_confirm_for_simple_edits = true,
})

vim.keymap.set("n", "-", function() oil.open() end, { desc = "Open parent directory in Oil" })
