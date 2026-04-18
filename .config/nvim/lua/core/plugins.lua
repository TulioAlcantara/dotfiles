local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
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
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {
			'meuter/lualine-so-fancy.nvim',
		},
	},
	{
		'NvChad/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup()
		end,
	},
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
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require('tokyonight').setup({
				style = 'night',
			})
			vim.cmd('colorscheme tokyonight')
		end,
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

	'nvim-lua/plenary.nvim',
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
		'nvim-tree/nvim-tree.lua',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
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
	--------------------------------
	--            LSP             --
	--------------------------------

	'nvim-treesitter/nvim-treesitter',
	-- 'nvim-treesitter/nvim-treesitter-context',
	'onsails/lspkind.nvim',
	{
		'hedyhli/outline.nvim',
		opts = {},
	},
	{
		'nvimtools/none-ls.nvim',
		dependencies = {
			'williamboman/mason.nvim',
		},
	},
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
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

}

require('lazy').setup(plugins)
