vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('n', '<leader>rr', function ()
	vim.cmd("source $MYVIMRC")
	vim.cmd("lua dofile(vim.env.MYVIMRC)")
	print("Config reloaded")
end, { desc = "Reload Config" })

