require("lualine").setup({
    options = {
        theme = "gruvbox",
        globalstatus = true,
    },
    sections = {
        lualine_a = { "filename" },
        lualine_b = { "branch" },
        lualine_c = {},
        lualine_x = { "" },
        lualine_y = { "diagnostics" },
        lualine_z = { "mode" },
    },
    inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
})
