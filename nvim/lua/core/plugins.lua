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
  'github/copilot.vim',
  'onsails/lspkind.nvim',
  'akinsho/bufferline.nvim',
  'nvim-tree/nvim-web-devicons',
  'kdheepak/lazygit.nvim',
  'max397574/better-escape.nvim',
  'tpope/vim-fugitive',
  {
    'folke/flash.nvim',
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
  },
  {
    'folke/trouble.nvim',
    config = true,
  },
  { 'akinsho/toggleterm.nvim', config = true },
  {
    'windwp/nvim-ts-autotag',
    config = true,
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = true,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup()
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = 'nvim-lua/plenary.nvim',
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin-macchiato]])
    end,
  },
  { 'windwp/nvim-autopairs',   event = 'InsertEnter', config = true },
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
