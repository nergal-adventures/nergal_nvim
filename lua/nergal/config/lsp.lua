-- Mason setup
require("mason").setup()

-- require("mason-lspconfig").setup({
-- 	ensure_installed = { "lua_ls" },
-- 	autmatic_installation = true,
-- })

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- lspconfig capabilities
local lspconfig = require("lspconfig")
local servers = { "lua_ls", "bashls", "clangd", "pyright" }

for _, server in ipairs(servers) do
	lspconfig[server].setup({
		capabilities = capabilities,
	})
end

-- Lua specific config
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- Kotlin specific config
lspconfig.kotlin_language_server.setup({
	capabilities = capabilities,
})

-- keymaps
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP Hover" })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Go to References" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename Symbol" })
