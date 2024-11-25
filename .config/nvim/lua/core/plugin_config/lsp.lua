--------------------------------
--           LSP              --
--------------------------------

-- Global keybindings
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<F3>', vim.lsp.buf.format, opts)
	vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)

	lsp_zero.buffer_autoformat()
end)

lsp_zero.set_sign_icons({
	error = '✘',
	warn = '▲',
	hint = '⚑',
	info = '»',
})

-- Disable inline diagnostics
-- vim.diagnostic.config({
-- 	virtual_text = false,
-- })

-- Disable formatting for some LSPs, instead use null-ls
require('lspconfig').ts_ls.setup({
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentFormattingRangeProvider = false
	end,
})
require('lspconfig').cssls.setup({
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentFormattingRangeProvider = false
	end,
})
require('lspconfig').volar.setup({
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentFormattingRangeProvider = false
	end,
	filetypes = { 'vue' },
	init_options = {
		vue = {
			hybridMode = false,
		},
	},
})
require('lspconfig').jsonls.setup({
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentFormattingRangeProvider = false
	end,
})

require('lspconfig').lua_ls.setup(lsp_zero.nvim_lua_ls())
lsp_zero.setup()

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
	handlers = {
		lsp_zero.default_setup,
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
local null_opts = lsp_zero.build_options('null-ls', {})
local mason_null_ls = require('mason-null-ls')

null_ls.setup({
	on_attach = function(client, bufnr)
		null_opts.on_attach(client, bufnr)
	end,
	sources = {
		-- null_ls.builtins.formatting.prettierd.with({
		-- 	env = {
		-- 		PRETTIERD_DEFAULT_CONFIG = vim.fn.expand('~/.config/nvim/.prettierrc.json'),
		-- 	},
		-- }),
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.formatting.biome,
	},
})

mason_null_ls.setup({
	ensure_installed = {},
	automatic_installation = true,
	automatic_setup = true,
})
