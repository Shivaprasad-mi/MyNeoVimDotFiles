vim.wo.number = true;
vim.wo.relativenumber = true;
vim.g.mapleader = " ";
vim.o.tabstop = 4;
vim.o.shiftwidth = 4;
vim.o.expandtab = true;
vim.o.scrollopt = 'ver,jump,hor';
vim.o.sidescrolloff = 5;
vim.o.ignorecase = true;
vim.o.smartcase = true;
vim.opt.splitright = true;
vim.opt.conceallevel = 2
--default horizonal scroll enabled
vim.opt.wrap = false
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 8
vim.opt.cursorline = true
vim.keymap.set("v", "/", [[<Esc>/\%V]], { desc = "Real-time search in selection" })

local modes = {'n', 'v'};
local options = { noremap = true, silent = true };

vim.keymap.set(modes, '<leader>y', '"+y', options)
vim.keymap.set(modes, '<leader>p', '"+p', options)
-- below is only for VSCode like setup I'll be shifting to harpoon or snipe in future
-- as remapping tab will break <C-i>
vim.keymap.set(modes, '<leader>l', ':tabnext<CR>', options)
vim.keymap.set(modes, '<leader>h', ':tabprevious<CR>', options)
vim.keymap.set(modes, '<leader>t', ':tabnew<CR>', options)
vim.keymap.set(modes, '<leader>x', ':q!<CR>', options)
vim.keymap.set('n', '<Esc>', "<cmd>nohlsearch<CR>", options)

-- command for select replace
vim.keymap.set("x", "<leader>r", function()
  -- Yank the visual selection
  vim.cmd('normal! "vy')

  -- Escape the yanked text for literal search (\V for very nomagic)
  local escaped = vim.fn.escape(vim.fn.getreg("v"), [[\/]])
  local cmd = string.format([[%%s/\V%s/]], escaped)

  -- Open the command-line with the substitution pre-filled
  vim.api.nvim_feedkeys(":" .. cmd, "n", false)
end, { desc = "Search and replace visual selection with confirmation" })

--terminal realted configs
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- text wrap and unwrap
vim.keymap.set('n', '<leader>uw', function()
    local is_wrapping = vim.opt_local.wrap:get()
    if is_wrapping then
        vim.opt_local.wrap = false
        vim.opt_local.sidescroll = 1
        vim.opt_local.sidescrolloff = 8
        print("Horizontal scroll mode")
    else
        vim.opt_local.wrap = true
        print("Wrap mode")
    end
end, { desc = "Toggle Wrap and Smooth Scroll" })

-- change tabs to show numbers instead of the buffer name 
vim.o.showtabline = 2
vim.opt.showtabline = 1
vim.o.tabline = "%!v:lua.CustomTabLine()"

function _G.CustomTabLine()
  local s = ""
  local tabs = vim.fn.tabpagenr("$")

  for i = 1, tabs do
    local hl = (i == vim.fn.tabpagenr()) and "%#TabLineSel#" or "%#TabLine#"
    s = s .. hl .. "%" .. i .. "T Tab " .. i .. " "
  end

  s = s .. "%#TabLineFill#%T"
  return s
end

-- quick fix list navigation
vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "Next Quickfix Item" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "Previous Quickfix Item" })

-- open git
vim.keymap.set("n", "<C-g>", "<cmd>tab Git<CR>", { desc = "Git Status in New Tab" })
