local function get_terminal_buffer()
    local terminal_buffer

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buftype == "terminal" then
            terminal_buffer = vim.b[buf].terminal_job_id
            break
        else
	        print("No terminal buffer found")
        end
    end

    if terminal_buffer == nil then
        return nil
    else
        print("Terminal buffer id: ", terminal_buffer)
        return terminal_buffer
    end
end

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Minimize current file" })

vim.keymap.set('n', '<leader>rr', function ()
	vim.cmd("source $MYVIMRC")
	vim.cmd("lua dofile(vim.env.MYVIMRC)")
	print("Config reloaded")
end, { desc = "Reload Config" })

-- DE-EMPHASIZE SEARCHED FILES
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>', { silent = true })

-- OPEN RIGHT SIDED-TERMINAL
vim.keymap.set('n', '<leader>t',function ()
	local width = math.floor(vim.o.columns * 0.4)
	vim.cmd("vertical botright " .. width .. "vsplit | terminal")
end, { desc = "Open sided-terminal", noremap = true, silent = true })

-- BUILD & TEST C FILES
vim.keymap.set('n', '<leader>rc', function ()
	local cleanCmd = "clear"
	local makeCmd = "./build.sh && ./bin/tests"

    local current_terminal = get_terminal_buffer()

    if current_terminal then
        vim.fn.chansend(current_terminal, cleanCmd .. "\n")
        print("Command executed: ", cleanCmd)
        vim.fn.chansend(current_terminal, makeCmd .. "\n")
        print("Command executed: ", makeCmd)
    end
end, { desc = "Build & Test - C", noremap = true, silent = true })

