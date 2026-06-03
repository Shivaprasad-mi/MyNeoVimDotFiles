vim.pack.add({
    -- Theme (load early so highlights apply before UI plugins)
    { src = "https://github.com/morhetz/gruvbox" },

    -- Shared dependencies
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-mini/mini.icons" },

    -- Completion + snippets
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },

    -- Mason
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },

    -- Pickers / UI
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/stevearc/quicker.nvim" },
    { src = "https://github.com/tpope/vim-surround" },

    -- Treesitter (main branch uses the new ts.install API)
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

    -- Harpoon v2 branch
    { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },

    -- Editing
    { src = "https://github.com/numToStr/Comment.nvim" },

    -- Git
    { src = "https://github.com/sindrets/diffview.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/tpope/vim-fugitive" },

    -- Markdown
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },

})

-- Setup order matters for a few: theme first, completion before LSP plugins reference it,
-- snacks/lualine/oil whenever.
require("plugins.theme")
require("plugins.completions")
require("plugins.mason")
require("plugins.snacks")
require("plugins.treesitter")
require("plugins.harpoon")
require("plugins.comments")
require("plugins.git")
require("plugins.lualine")
require("plugins.oil")
require("plugins.quicker")
require("plugins.surrounds")
require("plugins.markdown")
