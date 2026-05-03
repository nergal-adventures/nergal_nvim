return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")

		-- Setup with basic options
		ts.setup({
			auto_install = true,
		})

		-- Manually install parsers
		ts.install({ "lua", "vim", "vimdoc", "python" })

		-- Enable features like highlighting via autocommands
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "netrw",
			callback = function()
				pcall(vim.treesitter.stop)
			end,
		})
	end,
}
