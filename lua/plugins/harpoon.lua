local harpoon = require("harpoon")

harpoon:setup({
    default = {
        display = function(list_item)
            return vim.fn.fnamemodify(list_item.value, ":t")
        end,
    },
})

vim.keymap.set("n", "<leader>a", function()
    harpoon:list():add()
end, { desc = "Add file to Harpoon" })

vim.keymap.set("n", "<leader><leader>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list(), { title = " Quick Access " })
end, { desc = "Toggle Harpoon menu" })

vim.keymap.set("n", "<leader>+", function()
    harpoon:list("enums"):add()
end, { desc = "Add file to Enums list" })

vim.keymap.set("n", "<leader>ee", function()
    local list = harpoon:list("enums")
    harpoon.ui:toggle_quick_menu(list, { title = " Enums " })
end, { desc = "Toggle Enums menu" })

vim.keymap.set("n", "<C-e>", function()
    local list = harpoon:list("enums")
    if list:length() == 1 then
        list:select(1)
    else
        harpoon.ui:toggle_quick_menu(list, { title = " Enums " })
    end
end, { desc = "Toggle Enums menu (Direct open if only 1)" })

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)
