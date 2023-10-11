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
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'folke/which-key.nvim',
  'lewis6991/gitsigns.nvim',
  'numToStr/Comment.nvim',
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  {'nvim-telescope/telescope.nvim', tag = '0.1.3', dependencies = 'nvim-lua/plenary.nvim'},
  {'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  {'windwp/nvim-autopairs', event = "InsertEnter", opts = {}},
}

require('lazy').setup(plugins, opts)
