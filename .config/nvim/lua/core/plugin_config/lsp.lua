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

  -- Auto format on save for supported servers (only if not disabled)
  if client:supports_method('textDocument/formatting') and
      client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

-- Helper function to find TypeScript SDK
local function get_typescript_server_path(root_dir)
  local project_root = root_dir or vim.fn.getcwd()

  -- Check for local TypeScript installation
  local ts_lib_path = project_root .. '/node_modules/typescript/lib'
  if vim.fn.isdirectory(ts_lib_path) == 1 then
    return ts_lib_path
  end

  -- Try to find TypeScript in parent directories (for monorepos)
  local parent = vim.fn.fnamemodify(project_root, ':h')
  while parent ~= '/' and parent ~= project_root do
    local parent_ts = parent .. '/node_modules/typescript/lib'
    if vim.fn.isdirectory(parent_ts) == 1 then
      return parent_ts
    end
    local new_parent = vim.fn.fnamemodify(parent, ':h')
    if new_parent == parent then break end
    parent = new_parent
  end

  -- Fallback to global TypeScript (if available)
  local ok, global_ts = pcall(vim.fn.system, 'npm root -g 2>/dev/null')
  if ok and global_ts and global_ts ~= '' then
    local global_path = vim.trim(global_ts) .. '/typescript/lib'
    if vim.fn.isdirectory(global_path) == 1 then
      return global_path
    end
  end

  -- Final fallback - check common global locations
  local common_paths = {
    '/usr/local/lib/node_modules/typescript/lib',
    '/opt/homebrew/lib/node_modules/typescript/lib',
  }

  for _, path in ipairs(common_paths) do
    if vim.fn.isdirectory(path) == 1 then
      return path
    end
  end

  return nil
end

--------------------------------
--           MASON            --
--------------------------------

require('mason').setup({})

-- Set up LSP configurations using vim.lsp.config
vim.lsp.config.ts_ls = {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
  on_attach = function(client, bufnr)
    -- Disable formatting for ts_ls, use prettier instead
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingRangeProvider = false
    on_attach(client, bufnr)
  end,
}

vim.lsp.config.cssls = {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  root_markers = { 'package.json', '.git' },
  on_attach = function(client, bufnr)
    -- Disable formatting for cssls
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingRangeProvider = false
    on_attach(client, bufnr)
  end,
}

vim.lsp.config.eslint = {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
  root_markers = { '.eslintrc.js', '.eslintrc.json', '.eslintrc.yaml', '.eslintrc.yml', 'package.json', '.git' },
  settings = {
    workingDirectory = { mode = "auto" },
    format = { enable = false },
    lint = { enable = true },
  },
  on_attach = function(client, bufnr)
    -- Disable formatting for eslint
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingRangeProvider = false
    on_attach(client, bufnr)
  end,
}

vim.lsp.config.jsonls = {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { 'package.json', '.git' },
  on_attach = function(client, bufnr)
    -- Disable formatting for jsonls
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingRangeProvider = false
    on_attach(client, bufnr)
  end,
}

vim.lsp.config.volar = {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_markers = { 'package.json', 'vue.config.js', '.git' },
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
}

vim.lsp.config.lua_ls = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
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
}

vim.lsp.config.html = {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html', 'templ' },
  root_markers = { 'package.json', '.git' },
  on_attach = on_attach,
}

vim.lsp.config.bashls = {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  root_markers = { '.git' },
  on_attach = on_attach,
}

vim.lsp.config.glint = {
  cmd = { 'glint-language-server' },
  filetypes = { 'javascript', 'typescript', 'handlebars' },
  root_markers = { 'package.json', '.git' },
  on_attach = on_attach,
}

vim.lsp.config.astro = {
  cmd = { 'astro-ls', '--stdio' },
  filetypes = { 'astro' },
  root_markers = { 'astro.config.mjs', 'astro.config.js', 'package.json', '.git' },
  on_new_config = function(config, root_dir)
    local ts_server_path = get_typescript_server_path(root_dir)
    if ts_server_path then
      config.init_options = config.init_options or {}
      config.init_options.typescript = config.init_options.typescript or {}
      config.init_options.typescript.tsdk = ts_server_path
    else
      -- Warn if TypeScript SDK not found but don't fail
      vim.notify('TypeScript SDK not found for Astro LSP. Install typescript: npm install typescript',
        vim.log.levels.WARN)
    end
  end,
  on_attach = on_attach,
}

-- Mason LSP config for automatic installation
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
  automatic_installation = true,
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
