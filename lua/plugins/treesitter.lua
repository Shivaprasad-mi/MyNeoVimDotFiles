return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
    branch = "master",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {"lua", "c_sharp", "sql", "angular", "html", "cpp"},
			highlight = {enable = true},
			indent = {enable = true},
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<Enter>",
                    node_incremental = "<Enter>",
                    scope_incremental = false,
                    node_decremental = "<Backspace>"
                }
            }
		})
	end
}
