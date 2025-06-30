require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua", "c", "bash", "python", "kotlin", "swift"
	},
	sync_install = false,
	auto_install = true,

	indent = {
		enable = true
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "markdown" },
	},
})

local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
treesitter_parser_config.templ = {
	install_info = {
		url = "http://github.com/vrishmann/tree-sitter-templ.git",
		files = { "src/parser.c", "src/scannec.c" },
		branch = "master",
	},
}

vim.treesitter.language.register("templ", "templ")
