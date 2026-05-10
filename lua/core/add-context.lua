local function add_to_context()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line = start_pos[2]
    local end_line = end_pos[2]

    if start_line == 0 or end_line == 0 then return end

    -- Get relative path from CWD
    local full_path = vim.fn.expand('%:p')
    local file_path = vim.fn.fnamemodify(full_path, ':.')
    local file_type = vim.bo.filetype
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

    -- Indentation stripping
    local min_indent = nil
    for _, line in ipairs(lines) do
        if line:find("%S") then 
            local indent = line:match("^%s*"):len()
            if min_indent == nil or indent < min_indent then
                min_indent = indent
            end
        end
    end

    if min_indent and min_indent > 0 then
        for i, line in ipairs(lines) do
            if line:len() >= min_indent then
                lines[i] = line:sub(min_indent + 1)
            end
        end
    end

    local content = table.concat(lines, "\n")
    
    -- FORMAT: path:line
    -- We put it in a specific line to make it easy for 'gf' to grab the whole string
    local context_entry = string.format(
        "\n---\n**File:** %s:%d  (Lines: %d-%d)\n\n```%s\n%s\n```\n",
        file_path, start_line, start_line, end_line, file_type, content
    )

    local mka_dir = vim.fn.getcwd() .. "/.MKA"
    if vim.fn.isdirectory(mka_dir) == 0 then
        vim.fn.mkdir(mka_dir, "p")
    end
    local context_path = mka_dir .. "/context.md"
    local f = io.open(context_path, "a")
    if f then
        f:write(context_entry)
        f:close()
        print("Snippet added! 'gf' on the path to jump.")
    else
        print("Error: Could not write to " .. context_path)
    end
end

local function add_to_context_with_description()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line = start_pos[2]
    local end_line = end_pos[2]

    if start_line == 0 or end_line == 0 then return end

    local full_path = vim.fn.expand('%:p')
    local file_path = vim.fn.fnamemodify(full_path, ':.')
    local file_type = vim.bo.filetype
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

    -- Indentation stripping
    local min_indent = nil
    for _, line in ipairs(lines) do
        if line:find("%S") then
            local indent = line:match("^%s*"):len()
            if min_indent == nil or indent < min_indent then
                min_indent = indent
            end
        end
    end

    if min_indent and min_indent > 0 then
        for i, line in ipairs(lines) do
            if line:len() >= min_indent then
                lines[i] = line:sub(min_indent + 1)
            end
        end
    end

    local content = table.concat(lines, "\n")

    vim.ui.input({ prompt = "What to do: " }, function(instruction)
        if not instruction or instruction == "" then return end

        local context_entry = string.format(
            "\n> %s\n\n---\n**File:** %s:%d  (Lines: %d-%d)\n\n```%s\n%s\n```\n",
            instruction, file_path, start_line, start_line, end_line, file_type, content
        )

        local mka_dir = vim.fn.getcwd() .. "/.MKA"
        if vim.fn.isdirectory(mka_dir) == 0 then
            vim.fn.mkdir(mka_dir, "p")
        end
        local context_path = mka_dir .. "/context.md"
        local f = io.open(context_path, "a")
        if f then
            f:write(context_entry)
            f:close()
            print("Context added! 'gf' on the path to jump.")
        else
            print("Error: Could not write to " .. context_path)
        end
    end)
end

local function open_context_buffer()
    local path = ".MKA/context.md"
    
    -- Check if file exists to avoid errors
    if vim.fn.filereadable(path) == 1 then
        vim.cmd("edit " .. path)
    else
        print("File not found: " .. path)
    end
end

vim.keymap.set("n", "<leader>ct", open_context_buffer, { desc = "Open context.md in vertical split" })
-- <leader>sn — plain snippet append (for note-taking)
vim.keymap.set('v', '<leader>sn', function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'x', true)
    add_to_context()
end, { desc = "Append selection to context.md", silent = true })

-- <leader>sc — snippet with title + description prompt (for Claude context)
vim.keymap.set('v', '<leader>ac', function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'x', true)
    vim.schedule(add_to_context_with_description)
end, { desc = "Append selection to context.md with description", silent = true })
