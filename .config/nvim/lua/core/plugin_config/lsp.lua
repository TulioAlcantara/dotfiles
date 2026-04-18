--------------------------------
--           LSP              --
--------------------------------

-- Register filetypes used by LSP servers below so Neovim recognizes them
vim.filetype.add({
	extension = {
		templ = 'templ',
		hbs = 'handlebars',
		handlebars = 'handlebars',
	},
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end)
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end)

-- Diagnostic signs
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '✘',
			[vim.diagnostic.severity.WARN] = '▲',
			[vim.diagnostic.severity.HINT] = '⚑',
			[vim.diagnostic.severity.INFO] = '»',
		},
	},
})

-- LSP-aware keymaps + format-on-save. Runs once per (client, buffer) pair
-- when any language server attaches — the 0.11+ idiom replacing per-server
-- on_attach callbacks.
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then return end

		local opts = { buffer = bufnr }

		-- K: show diagnostic float if the cursor line has one, otherwise hover.
		-- Press again on a diagnostic line to fall through to hover.
		vim.keymap.set('n', 'K', function()
			local line = vim.api.nvim_win_get_cursor(0)[1] - 1
			local diags = vim.diagnostic.get(bufnr, { lnum = line })
			if #diags > 0 and not vim.b[bufnr]._k_saw_diag then
				vim.b[bufnr]._k_saw_diag = true
				vim.defer_fn(function() vim.b[bufnr]._k_saw_diag = false end, 500)
				vim.diagnostic.open_float(nil, { scope = 'line', border = 'rounded' })
			else
				vim.b[bufnr]._k_saw_diag = false
				vim.lsp.buf.hover({ border = 'rounded' })
			end
		end, opts)

		-- gD: jump to references (most IDE's "find usages"). textDocument/declaration
		-- is rarely implemented by language servers, so we remap it to the more
		-- useful references lookup via fzf-lua.
		vim.keymap.set('n', 'gD', '<cmd>FzfLua lsp_references<cr>', opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<F3>', vim.lsp.buf.format, opts)
		vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)

		if client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = bufnr,
				callback = function()
					-- On .vue files, biome only covers <script>, so route
					-- formatting through vue_ls which handles the whole SFC.
					-- Everywhere else, keep vue_ls out of the way.
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(c)
							if vim.bo[bufnr].filetype == 'vue' then
								return c.name == 'vue_ls'
							end
							return c.name ~= 'vue_ls'
						end,
					})
				end,
			})
		end
	end,
})

-- Ensure `q` closes LSP/diagnostic float windows even when another plugin
-- (e.g. markdown-preview loading via ft=markdown) clobbers the default mapping.
vim.api.nvim_create_autocmd('BufWinEnter', {
	callback = function(args)
		local win = vim.api.nvim_get_current_win()
		if vim.api.nvim_win_get_config(win).relative ~= '' then
			vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = args.buf, nowait = true })
		end
	end,
})

-- Servers that should never provide formatting (delegated to prettier, stylua
-- via null-ls, etc.). Handled once globally instead of repeated per-server.
local no_format_servers = {
	ts_ls = true,
	cssls = true,
	eslint = true,
	jsonls = true,
	html = true,
}

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and no_format_servers[client.name] then
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end
	end,
})

--------------------------------
--           MASON            --
--------------------------------

require('mason').setup({})

-- Merge cmp-nvim-lsp capabilities into every server's default config. This
-- advertises client support for completion, snippets, additional triggers,
-- etc. — without it, some servers silently fall back to minimal features.
vim.lsp.config('*', {
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- Per-server configs

-- Vue Language Tools v3 wiring:
--   * ts_ls hosts the @vue/typescript-plugin so it understands .vue files.
--   * vue_ls forwards its own tsserver/request events to ts_ls via on_init,
--     which is what powers template prop/event completion in v3.
-- See https://github.com/vuejs/language-tools/discussions/5455
local vue_ls_path = vim.fn.stdpath('data')
	.. '/mason/packages/vue-language-server/node_modules/@vue/language-server'

local vue_plugin = {
	name = '@vue/typescript-plugin',
	location = vue_ls_path,
	languages = { 'vue' },
	configNamespace = 'typescript',
}

vim.lsp.config('ts_ls', {
	cmd = { 'typescript-language-server', '--stdio' },
	filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
	root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
	init_options = {
		plugins = { vue_plugin },
	},
})

vim.lsp.config('cssls', {
	cmd = { 'vscode-css-language-server', '--stdio' },
	filetypes = { 'css', 'scss', 'less' },
	root_markers = { 'package.json', '.git' },
})

vim.lsp.config('eslint', {
	cmd = { 'vscode-eslint-language-server', '--stdio' },
	filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
	-- Only attach when the project actually has an ESLint config. Without this,
	-- the server starts with a nil root in Biome-only projects and crashes on
	-- textDocument/diagnostic with "path undefined".
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local markers = {
			'eslint.config.js',
			'eslint.config.mjs',
			'eslint.config.cjs',
			'eslint.config.ts',
			'.eslintrc.js',
			'.eslintrc.cjs',
			'.eslintrc.json',
			'.eslintrc.yaml',
			'.eslintrc.yml',
		}
		local found = vim.fs.find(markers, { path = fname, upward = true })[1]
		if found then
			on_dir(vim.fs.dirname(found))
		end
	end,
	settings = {
		workingDirectory = { mode = 'auto' },
		format = { enable = false },
		lint = { enable = true },
	},
})

vim.lsp.config('jsonls', {
	cmd = { 'vscode-json-language-server', '--stdio' },
	filetypes = { 'json', 'jsonc' },
	root_markers = { 'package.json', '.git' },
})

-- Vue Language Tools v3: vue_ls handles Vue SFCs end-to-end including
-- embedded TypeScript. No hybrid mode, no TS plugin wiring into ts_ls.
vim.lsp.config('vue_ls', {
	cmd = { 'vue-language-server', '--stdio' },
	filetypes = { 'vue' },
	root_markers = { 'package.json', 'vue.config.js', '.git' },
	on_init = function(client)
		-- vue_ls v3 delegates all tsserver work to ts_ls by emitting
		-- `tsserver/request` notifications. We route them into ts_ls's
		-- `typescript.tsserverRequest` command and pipe the response back.
		client.handlers['tsserver/request'] = function(_, result, context)
			local ts_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })
			if #ts_clients == 0 then
				vim.notify('vue_ls: no ts_ls client found to forward tsserver/request', vim.log.levels.ERROR)
				return
			end
			local ts_client = ts_clients[1]
			local param = unpack(result)
			local id, command, payload = unpack(param)
			ts_client:exec_cmd({
				title = 'vue_request_forward',
				command = 'typescript.tsserverRequest',
				arguments = { command, payload },
			}, { bufnr = context.bufnr }, function(_, r)
				local response = r and r.body
				client:notify('tsserver/response', { { id, response } })
			end)
		end
	end,
})

vim.lsp.config('lua_ls', {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = {
		'.luarc.json', '.luarc.jsonc', '.luacheckrc',
		'.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git',
	},
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME, '${3rd}/luv/library' },
			},
			completion = { callSnippet = 'Replace' },
			diagnostics = { disable = { 'missing-fields' } },
		},
	},
})

vim.lsp.config('html', {
	cmd = { 'vscode-html-language-server', '--stdio' },
	filetypes = { 'html', 'templ' },
	root_markers = { 'package.json', '.git' },
})

vim.lsp.config('bashls', {
	cmd = { 'bash-language-server', 'start' },
	filetypes = { 'sh', 'bash' },
	root_markers = { '.git' },
})

vim.lsp.config('glint', {
	cmd = { 'glint-language-server' },
	filetypes = { 'javascript', 'typescript', 'handlebars' },
	root_markers = { 'package.json', '.git' },
})

-- Biome: use its built-in LSP to format JS/TS/Vue on save. Only attaches when
-- a biome.json is found, so projects without Biome are untouched.
vim.lsp.config('biome', {
	cmd = { 'biome', 'lsp-proxy' },
	filetypes = {
		'javascript', 'javascriptreact', 'typescript', 'typescriptreact',
		'json', 'jsonc', 'vue', 'css',
	},
	root_markers = { 'biome.json', 'biome.jsonc' },
})

vim.lsp.config('astro', {
	cmd = { 'astro-ls', '--stdio' },
	filetypes = { 'astro' },
	root_markers = { 'astro.config.mjs', 'astro.config.js', 'package.json', '.git' },
})

-- Mason: ensure servers are installed and let mason-lspconfig auto-enable
-- exactly the ones we've configured above.
local servers = {
	'ts_ls',
	'eslint',
	'lua_ls',
	'bashls',
	'jsonls',
	'cssls',
	'html',
	'vue_ls',
	'glint',
	'astro',
	'biome',
}

require('mason-lspconfig').setup({
	ensure_installed = servers,
	automatic_installation = true,
	automatic_enable = servers,
})

--------------------------------
--           CMP              --
--------------------------------

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
	sources = {
		{ name = 'nvim_lsp' },
	},
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
	}),
	snippet = {
		expand = function(args) require('luasnip').lsp_expand(args.body) end,
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
	sources = {
		null_ls.builtins.formatting.stylua,
	},
})
