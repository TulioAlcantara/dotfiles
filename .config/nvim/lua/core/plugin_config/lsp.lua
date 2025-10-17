--------------------------------
--           LSP              --
--------------------------------

-- Global keybindings
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- Set up diagnostic signs
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»',
    }
  }
})

-- Function to set up LSP keymaps when an LSP attaches
local function on_attach(client, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<F3>', vim.lsp.buf.format, opts)
  vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)

  -- Auto format on save
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

-- LSP server configurations using the new vim.lsp.config API
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
  on_attach = function(client, bufnr)
    -- Disable formatting for ts_ls, use prettier instead
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingRangeProvider = false
    on_attach(client, bufnr)
  end,
})

vim.lsp.config('cssls', {
  cmd = { 'vscode-css-language-server', '--stdio' },
  root_markers = { 'package.json', '.git' },
  on_attach = function(client, bufnr)
    -- Disable formatting for cssls
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingRangeProvider = false
    on_attach(client, bufnr)
  end,
})

vim.lsp.config('eslint', {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  root_markers = { '.eslintrc.js', '.eslintrc.json', '.eslintrc.yaml', '.eslintrc.yml', 'package.json', '.git' },
  on_attach = function(client, bufnr)
    -- Disable formatting for eslint
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingRangeProvider = false
    on_attach(client, bufnr)
  end,
})

vim.lsp.config('jsonls', {
  cmd = { 'vscode-json-language-server', '--stdio' },
  root_markers = { 'package.json', '.git' },
  on_attach = function(client, bufnr)
    -- Disable formatting for jsonls
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingRangeProvider = false
    on_attach(client, bufnr)
  end,
})

vim.lsp.config('volar', {
  cmd = { 'vue-language-server', '--stdio' },
  root_markers = { 'package.json', 'vue.config.js', '.git' },
  filetypes = { 'vue' },
  init_options = {
    vue = {
      hybridMode = false,
    },
  },
  on_attach = function(client, bufnr)
    -- Disable formatting for volar
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingRangeProvider = false
    on_attach(client, bufnr)
  end,
})

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library"
        }
      },
      completion = {
        callSnippet = "Replace"
      },
      diagnostics = {
        disable = { 'missing-fields' }
      }
    }
  },
  on_attach = on_attach,
})

vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  root_markers = { 'package.json', '.git' },
  on_attach = on_attach,
})

vim.lsp.config('bashls', {
  cmd = { 'bash-language-server', 'start' },
  root_markers = { '.git' },
  on_attach = on_attach,
})

vim.lsp.config('glint', {
  cmd = { 'glint-language-server' },
  root_markers = { 'package.json', '.git' },
  on_attach = on_attach,
})

vim.lsp.config('astro', {
  cmd = { 'astro-ls', '--stdio' },
  root_markers = { 'astro.config.mjs', 'astro.config.js', 'package.json', '.git' },
  on_attach = on_attach,
})

--------------------------------
--           MASON            --
--------------------------------

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'ts_ls',
    'eslint',
    'lua_ls',
    'bashls',
    'jsonls',
    'cssls',
    'html',
    'volar',
    'glint',
    'astro',
  },
})

--------------------------------
--           CMP              --
--------------------------------

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
  sources = {
    { name = 'copilot' },
    { name = 'nvim_lsp' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
    }),
  },
})

--------------------------------
--          NULL-LS           --
--------------------------------

local null_ls = require('null-ls')
local mason_null_ls = require('mason-null-ls')

null_ls.setup({
  on_attach = on_attach,
  sources = {
    -- null_ls.builtins.formatting.prettierd.with({
    -- 	env = {
    -- 		PRETTIERD_DEFAULT_CONFIG = vim.fn.expand('~/.config/nvim/.prettierrc.json'),
    -- 	},
    -- }),
    null_ls.builtins.formatting.stylua,
  },
})

mason_null_ls.setup({
  ensure_installed = {},
  automatic_installation = true,
  automatic_setup = true,
})
