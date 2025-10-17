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
  -- {
  -- 	'romgrk/barbar.nvim',
  -- 	init = function()
  -- 		vim.g.barbar_auto_setup = false
  -- 	end,
  -- 	opts = {},
  -- },

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
  -- 'nvim-treesitter/nvim-treesitter-context',
  'onsails/lspkind.nvim',
  'simrat39/symbols-outline.nvim',
  'simrat39/rust-tools.nvim',
  { 'windwp/nvim-autopairs',  event = 'InsertEnter', opts = {} },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
  },
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
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

  {
    'zbirenbaum/copilot.lua',
    config = function()
      require('copilot').setup({
        panel = {
          auto_refresh = true,
        },
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = '<Tab>',
          },
        },
      })
    end,
  },
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
