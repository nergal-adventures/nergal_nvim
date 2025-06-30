return {
	"nvim-tree/nvim-web-devicons",
	lazy = false,
	opts = {},
	config = function(_, opts)
		require("nvim-web-devicons").setup(opts)
	end,
}
