local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	'nvim-tree/nvim-tree.lua',
	'nvim-lualine/lualine.nvim',
	'nvim-treesitter/nvim-treesitter',
	'folke/which-key.nvim',
	'lewis6991/gitsigns.nvim',
	'numToStr/Comment.nvim',
	'lukas-reineke/indent-blankline.nvim',
	'github/copilot.vim',
	'windwp/nvim-ts-autotag',
	'norcalli/nvim-colorizer.lua',
	'onsails/lspkind.nvim',
	'folke/trouble.nvim',
	'kdheepak/lazygit.nvim',
	'max397574/better-escape.nvim',
	'tpope/vim-fugitive',
	'mg979/vim-visual-multi',
	{ 'akinsho/toggleterm.nvim', version = '*', config = true },
	{ 'akinsho/bufferline.nvim', version = '*', dependencies = 'nvim-tree/nvim-web-devicons' },
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.3', dependencies = 'nvim-lua/plenary.nvim' },
	{ 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
	{ 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'L3MON4D3/LuaSnip' },
		},
	},
	{
		'jay-babu/mason-null-ls.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			'williamboman/mason.nvim',
			'nvimtools/none-ls.nvim',
		},
	},
	{
		'iamcco/markdown-preview.nvim',
		cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
		build = 'cd app && yarn install',
		init = function()
			vim.g.mkdp_filetypes = { 'markdown' }
		end,
		ft = { 'markdown' },
	},
}

require('lazy').setup(plugins)
