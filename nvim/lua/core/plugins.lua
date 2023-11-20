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
	--------------------------------
	--        DECORATION          --
	--------------------------------

	'lewis6991/gitsigns.nvim',
	'nvim-tree/nvim-web-devicons',
	'SmiteshP/nvim-navic',
	'MunifTanjim/nui.nvim',
	'folke/zen-mode.nvim',
	'folke/twilight.nvim',
	'nvim-tree/nvim-tree.lua',
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {
			'meuter/lualine-so-fancy.nvim',
		},
	},
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme catppuccin-macchiato]])
		end,
	},
	{
		'norcalli/nvim-colorizer.lua',
		opts = {},
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		config = function()
			require('ibl').setup()
		end,
	},
	{
		'windwp/nvim-ts-autotag',
		opts = {},
	},
	-- {
	-- 	'folke/noice.nvim',
	-- 	event = 'VeryLazy',
	-- 	dependencies = {
	-- 		'rcarriga/nvim-notify',
	-- 	},
	-- },

	--------------------------------
	--          GIT               --
	--------------------------------

	'kdheepak/lazygit.nvim',
	'tpope/vim-fugitive',
	'sindrets/diffview.nvim',
	{
		'APZelos/blamer.nvim',
		init = function()
			vim.g.blamer_enabled = true
		end,
	},

	--------------------------------
	--          ACTIONS           --
	--------------------------------

	{ 'max397574/better-escape.nvim', opts = {} },
	'ThePrimeagen/harpoon',
	'folke/which-key.nvim',
	{ 'numToStr/Comment.nvim', opts = {}, lazy = false },
	{ 'akinsho/toggleterm.nvim', opts = {} },
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.3',
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
			{
				'nvim-telescope/telescope-live-grep-args.nvim',
				version = '^1.0.0',
			},
		},
	},
	-- {
	-- 	'folke/flash.nvim',
	-- 	opts = {
	-- 		modes = {
	-- 			char = {
	-- 				jump_labels = true,
	-- 			},
	-- 		},
	-- 	},
	-- },

	--------------------------------
	--            LSP             --
	--------------------------------

	'nvim-treesitter/nvim-treesitter',
	'nvim-treesitter/nvim-treesitter-context',
	'onsails/lspkind.nvim',
	{ 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },
	{
		'jay-babu/mason-null-ls.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			'williamboman/mason.nvim',
			'nvimtools/none-ls.nvim',
		},
	},
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
		'folke/trouble.nvim',
		opts = {},
	},

	--------------------------------
	--            MISC            --
	--------------------------------

	'github/copilot.vim',
	'epwalsh/obsidian.nvim',
	{
		'iamcco/markdown-preview.nvim',
		cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
		build = 'cd app && yarn install',
		init = function()
			vim.g.mkdp_filetypes = { 'markdown' }
		end,
		ft = { 'markdown' },
	},
	-- {
	-- 	'm4xshen/hardtime.nvim',
	-- 	opts = {},
	-- },
}

require('lazy').setup(plugins)
