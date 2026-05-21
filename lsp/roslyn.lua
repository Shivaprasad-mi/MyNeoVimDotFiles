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
        local sln = vim.fn.globpath(root, "*.sln", false, true)
        if #sln == 0 then
            sln = vim.fn.globpath(root, "*.slnx", false, true)
        end

        if #sln > 0 then
            client:notify("solution/open", {
                solution = vim.uri_from_fname(sln[1]),
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
