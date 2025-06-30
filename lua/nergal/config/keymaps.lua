vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('n', '<leader>rr', function ()
	vim.cmd("source $MYVIMRC")
	vim.cmd("lua dofile(vim.env.MYVIMRC)")
	print("Config reloaded")
end, { desc = "Reload Config" })

-- Kotlin run bluetoothcleanuptests
vim.keymap.set('n', "<leader>tb", function ()
	local cmd = "./gradlew :bluetoothcleanuptests:connectedDebugAndroidTest"
	vim.cmd("terminal " .. cmd)
end, { desc = "Run bluetoothcleanuptests" })

-- vim.keymap.set('n', "<leader>tv", function ()
-- 	local class = vim.fn.expand("%:r"):gsub("/", ".")
-- 	local method = vim.fn.expand("<cword>")
-- 	local cmd = "./gradlew :verificationtests:connectedDebugAndroidTest"
-- 	vim.cmd("terminal " .. cmd)
-- end, { desc = "Run bluetoothcleanuptests" })
