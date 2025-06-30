return {
	'sainnhe/gruvbox-material',
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.background = "dark"
		vim.g.gruvbox_material_enable_italic = true
		vim.cmd.colorscheme('gruvbox-material')
	end
}

