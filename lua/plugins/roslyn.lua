return {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
        filewatching = "roslyn",
        choose_target = function(targets)
            return vim.iter(targets):find(function(item)
                return item:match("%.sln$")
            end)
        end,
        lock_target = true
    },
}
