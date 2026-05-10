return {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { "markdown", "Avante" },
    config = function()
        require("render-markdown").setup({
            checkbox = {
                enabled = true,
            },
            heading = {
                setext = false,
            }
        })
    end,
}
