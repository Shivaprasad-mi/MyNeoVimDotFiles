return {
    {
        "zbirenbaum/copilot.lua",
        config = function()
            require('copilot').setup({})
        end,
    },
    {
        "yetone/avante.nvim",
        -- lazy = true,
        version = false,
        opts = {
            windows = { width = 40 },
            provider = "copilot",
            mode = "agentic",
            providers = {
                copilot = {
                    model = "claude-sonnet-4.5",
                    auto_select_model = false,
                },
            },
            hints = { enabled = true },
            selector = {
                provider = "telescope",
            },
            behaviour = {
                auto_suggestions = false,
                auto_set_highlight_group = true,
                auto_set_keymaps = true,
                auto_apply_diff_after_generation = false,
                support_paste_from_clipboard = false,
                enable_token_counting = false,
                auto_approve_tool_permissions = false,
                enable_fastapply = false,
            },
        },
        build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-telescope/telescope.nvim",
            "stevearc/dressing.nvim",
            "nvim-tree/nvim-web-devicons",
            "nvim-treesitter/nvim-treesitter",
            "zbirenbaum/copilot.lua",
            {
                'MeanderingProgrammer/render-markdown.nvim',
                ft = { "markdown", "Avante" },
            },
        },
    },
    
}
