return {
	{
		"hrsh7th/cmp-nvim-lsp",
		
	},
	{
		'L3MON4D3/LuaSnip',
		dependencies = {
			'saadparwaiz1/cmp_luasnip',
			'rafamadriz/friendly-snippets',
		}
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			require('luasnip.loaders.from_vscode').lazy_load()
			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end
				},
				window ={
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({select =true}),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" }
                }),
                -- sorting = {
                --     priority_weight = 2,
                --     comparators = {
                --         -- Custom comparator to sort snippets before other kinds
                --         function(entry1, entry2)
                --             local kind1 = entry1:get_kind()
                --             local kind2 = entry2:get_kind()
                --
                --             -- `Snippet` has kind = 15 in LSP specification
                --             if kind1 == cmp.lsp.CompletionItemKind.Snippet then
                --                 if kind2 ~= cmp.lsp.CompletionItemKind.Snippet then
                --                     return true
                --                 end
                --             elseif kind2 == cmp.lsp.CompletionItemKind.Snippet then
                --                 return false
                --             end
                --             return nil  -- fallback to other comparators
                --         end,
                --
                --         -- Default comparators (keep these after your custom one)
                --         cmp.config.compare.offset,
                --         cmp.config.compare.exact,
                --         cmp.config.compare.score,
                --         cmp.config.compare.recently_used,
                --         cmp.config.compare.kind,
                --         cmp.config.compare.sort_text,
                --         cmp.config.compare.length,
                --         cmp.config.compare.order,
                --     },
                -- },
			})
            cmp.setup.filetype({"sql"}, {
                sources = {
                    { name = "vim-dadbod-completion" },
                    { name = "buffer" },
                }
            })
		end,
	},
}
