vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('n', '<leader>rr', function ()
	vim.cmd("source $MYVIMRC")
	vim.cmd("lua dofile(vim.env.MYVIMRC)")
	print("Config reloaded")
end, { desc = "Reload Config" })

vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>', { silent = true })

vim.keymap.set('n', '<leader>t',function ()
	local width = math.floor(vim.o.columns * 0.4)
	vim.cmd("vertical botright " .. width .. "vsplit | terminal")
end, { desc = "Open sided-terminal", noremap = true, silent = true })

vim.keymap.set('t', '<C-t>', [[<C-\><C-n>]], { silent = true, noremap = true })

vim.keymap.set('n', '<leader>rm', function ()
	local current_terminal = vim.b.terminal_job_id
	local cleanCmd = "clear"
	local makeCmd = "./build.sh && ./bin/tests"

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].buftype == "terminal" then
			local job_id = vim.b[buf].terminal_job_id
			if job_id then
				vim.fn.chansend(job_id, "clear" .. "\n")

				vim.fn.chansend(job_id, cleanCmd .. "\n")
				print("Command executed: ", cleanCmd)
				vim.fn.chansend(job_id, makeCmd .. "\n")
				print("Command executed: ", makeCmd)
				return
			end
		end
	end
	print("No terminal buffer found")
end, { desc = "Run make default", noremap = true, silent = true })
