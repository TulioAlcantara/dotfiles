--------------------------------
--           LSP              --
--------------------------------

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })
	lsp_zero.buffer_autoformat()
end)

require('lspconfig').tsserver.setup({
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
	ensure_installed = {},
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
			-- documentation says this is important.
			-- I don't know why.
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
			mode = 'symbol_text', -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
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
		null_ls.builtins.formatting.prettierd.with({
			env = {
				PRETTIERD_DEFAULT_CONFIG = vim.fn.expand('~/.config/nvim/.prettierrc.json'),
			},
		}),
		-- null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.formatting.stylua,
	},
})

mason_null_ls.setup({
	ensure_installed = {},
	automatic_installation = true,
	automatic_setup = true,
})
