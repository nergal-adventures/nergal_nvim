require("mason").setup()


vim.lsp.config('clangd', {
	cmd = { 'clangd', '--background-index' },
	filetypes = { 'c', },
	root_markers = { '.clangd', 'compile_commands.json', '.git' },
	capabilities = {
		offsetEncoding = { 'utf-16' },
	},
	init_options = {
		clangdFileStatus = true,
	},
})

vim.lsp.enable('clangd')

-- keymaps
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP Hover" })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Go to References" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename Symbol" })
