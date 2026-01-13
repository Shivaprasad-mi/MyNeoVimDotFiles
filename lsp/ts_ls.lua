local cmd = vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server.cmd"

return {
  cmd = { cmd, "--stdio" },
  filetypes = { "typescript", "typescriptreact", "typescript.tsx",
                "javascript", "javascriptreact", "javascript.jsx" },
  root_markers = {"package.json", "tsconfig.json", "jsconfig.json", ".git"},
  settings = {
    completions = { completeFunctionCalls = true },
    typescript = { format = { enable = true } },
    javascript = { format = { enable = true } },
  },
}
