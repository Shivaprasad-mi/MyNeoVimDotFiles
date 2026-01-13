return 
{
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local fzf = require("fzf-lua")
            fzf.setup({
                files = {
                    previewer = false
                }
            })
            vim.keymap.set('n', '<C-p>', fzf.files, {})
            vim.keymap.set('n', '<leader>f', fzf.live_grep, {})
            vim.keymap.set('n', '<leader>b', fzf.buffers, {})
        end
    }
} 
