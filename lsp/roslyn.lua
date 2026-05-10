local log_dir = vim.fn.stdpath("log") .. "/roslyn"
vim.fn.mkdir(log_dir, "p")

return {
    cmd = {
        "roslyn-language-server",
        "--logLevel=Information",
        "--extensionLogDirectory=" .. log_dir,
        "--stdio",
    },
    filetypes = { "cs" },
    root_markers = { "*.sln", "*.slnx", "*.csproj", ".git" },
    on_attach = function(client, bufnr)
        local root = client.config.root_dir or vim.fn.getcwd()

        local candidates = vim.fn.globpath(root, "*.sln", false, true)
        vim.list_extend(candidates, vim.fn.globpath(root, "*.slnx", false, true))

        -- Prefer .sln over .slnx when both exist
        local choice = vim.iter(candidates):find(function(p)
            return p:match("%.sln$")
        end) or candidates[1]

        if choice then
            client:notify("solution/open", {
                solution = vim.uri_from_fname(choice),
            })
        else
            local csproj = vim.fn.globpath(root, "**/*.csproj", false, true)
            if #csproj > 0 then
                local uris = {}
                for _, p in ipairs(csproj) do
                    table.insert(uris, vim.uri_from_fname(p))
                end
                client:notify("project/open", { projects = uris })
            end
        end
    end,
}
