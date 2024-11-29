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
	{ 'echasnovski/mini.icons', version = false },
	'MunifTanjim/nui.nvim',
	-- 'nvim-tree/nvim-tree.lua',
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {
			'meuter/lualine-so-fancy.nvim',
		},
	},
	{
		'catppuccin/nvim',
		name = 'catppuccin',
	},
	{
		'norcalli/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup()
		end,
	},
	-- {
	-- 	'lukas-reineke/indent-blankline.nvim',
	-- 	config = function()
	-- 		require('ibl').setup()
	-- 	end,
	-- },
	{
		'windwp/nvim-ts-autotag',
		opts = {},
	},
	{
		'goolord/alpha-nvim',
		config = function()
			require('alpha').setup(require('alpha.themes.startify').config)
		end,
	},
	{
		'stevearc/dressing.nvim',
		opts = {},
	},
	{
		'rebelot/kanagawa.nvim',
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme kanagawa]])
		end,
	},
	'sainnhe/gruvbox-material',
	{
		'rose-pine/neovim',
		name = 'rose-pine',
	},

	--------------------------------
	--          GIT               --
	--------------------------------

	{
		'kdheepak/lazygit.nvim',
		init = function()
			vim.g.lazygit_floating_window_scaling_factor = 1
		end,
	},
	{
		'NeogitOrg/neogit',
		dependencies = {
			'echasnovski/mini.pick',
		},
		config = true,
	},
	'tpope/vim-fugitive',
	'sindrets/diffview.nvim',
	{
		'APZelos/blamer.nvim',
		init = function()
			vim.g.blamer_enabled = false
		end,
	},

	--------------------------------
	--          ACTIONS           --
	--------------------------------

	{
		'ThePrimeagen/harpoon',
		config = function()
			require('harpoon').setup({
				menu = {
					width = vim.api.nvim_win_get_width(0) - 4,
				},
			})
		end,
	},
	'folke/which-key.nvim',
	'nvim-pack/nvim-spectre',
	'mbbill/undotree',
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
	{
		'ibhagwan/fzf-lua',
		config = function()
			require('fzf-lua').setup({
				winopts = {
					fullscreen = true,
					preview = {
						layout = 'vertical',
					},
				},
				files = {
					formatter = 'path.filename_first',
				},
			})
		end,
	},
	{
		'stevearc/oil.nvim',
		opts = {},
	},
	{
		'jake-stewart/multicursor.nvim',
		branch = '1.0',
	},
	{
		'folke/ts-comments.nvim',
		opts = {},
		event = 'VeryLazy',
		enabled = vim.fn.has('nvim-0.10.0') == 1,
	},
	{
		'mikavilpas/yazi.nvim',
		event = 'VeryLazy',
		opts = {
			open_for_directories = true,
			keymaps = {
				show_help = '<f1>',
			},
			floating_window_scaling_factor = 1,
			yazi_floating_window_border = 'none',
		},
	},
	--------------------------------
	--            LSP             --
	--------------------------------

	'nvim-treesitter/nvim-treesitter',
	'nvim-treesitter/nvim-treesitter-context',
	'onsails/lspkind.nvim',
	'simrat39/symbols-outline.nvim',
	'simrat39/rust-tools.nvim',
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
		},
	},
	{
		'folke/trouble.nvim',
		opts = {},
	},
	{
		'L3MON4D3/LuaSnip',
		version = 'v2.*',
		build = 'make install_jsregexp',
	},

	--------------------------------
	--            DAP            	--
	--------------------------------

	--------------------------------
	--            MISC            --
	--------------------------------

	'github/copilot.vim',
	{ 'aserowy/tmux.nvim', opts = {} },
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
