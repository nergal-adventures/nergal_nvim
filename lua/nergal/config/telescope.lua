require('telescope').setup({})

local builtin = require('telescope.builtin')

-- Keymaps
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "File finder"})
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Git files" })
vim.keymap.set('n', '<leader>pws', function ()
	local word = vim.fn.expand("<cword>")
	builtin.grep_string({ search = word })
end, { desc = "Search for current word" })
vim.keymap.set('n', '<leader>pWs', function ()
	local word = vim.fn.expand("<cWORD>")
	builtin.grep_string({ search = word })
end, { desc = "Search for current unspaced WORD" })
vim.keymap.set('n', '<leader>ps', function ()
	builtin.grep_string({ search = vim.fn.input("Grep > ")})
end, { desc = "Grep search" })
vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "Help files" })
