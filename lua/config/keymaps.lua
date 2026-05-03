vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open [E]xplorer' })

--- Telescope ---
require('telescope').setup({})
local builtin = require('telescope.builtin')
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

-- OPEN RIGHT SIDED-TERMINAL
vim.keymap.set('n', '<leader>t',function ()
	local width = math.floor(vim.o.columns * 0.5)
	vim.cmd("vertical botright " .. width .. "vsplit | terminal")
end, { desc = "Open sided-terminal", noremap = true, silent = true })
