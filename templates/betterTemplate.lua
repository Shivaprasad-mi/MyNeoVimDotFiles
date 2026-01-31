-- this should be better implimentation but I don't know how it works
-- gfg_templates.lua
-- Smart boilerplate loader for Neovim
-- Auto-loads templates ONLY inside /gfg/ paths
-- Supports multiple templates per filetype
-- Provides :Template command for manual use

local M = {}

local TEMPLATE_ROOT = vim.fn.expand("~/.config/nvim/templates")

-- Utility: list templates for a filetype (optionally filtered)
local function get_templates(ft, pattern)
  local dir = TEMPLATE_ROOT .. "/" .. ft
  if vim.fn.isdirectory(dir) == 0 then
    return {}
  end

  local glob_pattern = dir .. "/" .. (pattern or "*.tpl")
  return vim.fn.glob(glob_pattern, false, true)
end

-- Utility: prompt user to select from templates
local function choose_template(templates, title)
  if #templates == 1 then
    return templates[1]
  end

  local choices = { title or "Select template:" }
  for _, t in ipairs(templates) do
    table.insert(choices, vim.fn.fnamemodify(t, ":t:r"))
  end

  local choice = vim.fn.inputlist(choices)
  if choice < 2 then
    return nil
  end

  return templates[choice - 1]
end

-- Auto insert logic (GFG only)
local function maybe_insert_gfg_template()
  local ft = vim.bo.filetype
  if ft == "" then return end

  local path = vim.fn.expand("%:p"):lower()
  if not path:match("/GFG/") then return end

  -- Avoid double insert / existing content
  if vim.fn.line("$") > 1 then return end

  local templates = get_templates(ft, "gfg*.tpl")
  if #templates == 0 then return end

  local template = choose_template(templates, "Select GFG template:")
  if not template then return end

  vim.cmd("0r " .. template)
end

-- Public: setup autocmds
function M.setup()
  vim.api.nvim_create_autocmd({ "BufNewFile", "FileType" }, {
    once = true,
    callback = maybe_insert_gfg_template,
  })

  -- Manual command: :Template
  vim.api.nvim_create_user_command("Template", function()
    local ft = vim.bo.filetype
    if ft == "" then return end

    local templates = get_templates(ft)
    if #templates == 0 then
      print("No templates for " .. ft)
      return
    end

    local template = choose_template(templates, "Select template:")
    if not template then return end

    vim.cmd("0r " .. template)
  end, {})
end

return M
