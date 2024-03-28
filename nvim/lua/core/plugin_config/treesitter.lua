require('nvim-treesitter.configs').setup({
	ensure_installed = {
		'c',
		'lua',
		'vim',
		'vimdoc',
		'query',
		'javascript',
		'css',
		'scss',
		'html',
		'typescript',
		'vue',
		'markdown',
		'go',
		'rust',
		'python',
		'astro',
	},

	sync_install = false,
	auto_install = true,
	ignore_install = {},

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
