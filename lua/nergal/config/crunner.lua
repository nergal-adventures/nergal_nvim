local function compile_and_run_c()
    local file = vim.fn.expand("%:p")
    local name = vim.fn.expand("%:t:r")
    local build_dir = vim.fn.expand("%:p:h") .. "/.build"
    local out = build_dir .. "/" .. name

    vim.fn.mkdir(build_dir, "p")

    if vim.bo.filetype ~= "c" then
        vim.notify("Not a C file", vim.log.levels.WARN)
        return
    end

    vim.cmd("write")

    local cmd_compile = string.format(
        'clang -std=c11 -Wall -Wextra -O2 -g "%s" -o "%s"',
        file,
        out
    )

    local cmd_run = string.format(
        out
    )

    local job_id
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buftype == "terminal" then
            job_id = vim.b[buf].terminal_job_id
        end
    end

    if not job_id then
        print("No terminal buffer found")

        local previous_buf = vim.api.nvim_get_current_win()
        local terminal_width = math.floor(vim.o.columns * 0.5)

        vim.cmd("vertical botright " .. terminal_width .. "vsplit | terminal ")
        vim.api.nvim_set_current_win(previous_buf)
    end

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buftype == "terminal" then
            job_id = vim.b[buf].terminal_job_id
        end
    end

    if job_id then
        vim.fn.chansend(job_id, "clear" .. "\n")
        print("Job id: ", job_id)

        vim.fn.chansend(job_id, cmd_compile .. "\n")
        vim.fn.chansend(job_id, cmd_run .. "\n")
        return
    else
    end
end

vim.keymap.set("n", "<leader>cr", compile_and_run_c, { desc = "Compile & Run (C)" })

