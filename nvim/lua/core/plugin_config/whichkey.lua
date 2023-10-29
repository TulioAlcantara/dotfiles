local opts = {
	mode = 'n', -- NORMAL mode
	prefix = '<leader>',
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
	mode = 'v', -- VISUAL mode
	prefix = '<leader>',
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	['e'] = { '<cmd>NvimTreeToggle<cr>', 'Explorer' },
	['w'] = { '<cmd>w!<CR>', 'Save' },
	['q'] = { '<cmd>q!<CR>', 'Quit' },
	['/'] = { '<Plug>(comment_toggle_linewise_current)', 'Comment toggle current line' },
	['v'] = { '<cmd>vsplit<CR>', 'Vertical Split' },
	['h'] = { '<cmd>split<CR>', 'Horizontal Split' },
	['p'] = { '<cmd>Lazy<CR>', 'Package Manager (Lazy)' },

	t = {
		name = 'Troubleshoot',
		t = { '<cmd>TroubleToggle<cr>', 'Toggle' },
		w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Workspace' },
		d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'Document' },
		-- q = { '<cmd>TroubleToggle quickfix<cr>', 'Quickfix' },
		-- l = { '<cmd>TroubleToggle loclist<cr>', 'Location List' },
		-- r = { '<cmd>TroubleToggle lsp_references<cr>', 'References' },
	},

	f = {
		name = 'File',
		g = { '<cmd>Telescope live_grep<cr>', 'Live Grep' },
		b = { '<cmd>Telescope buffers<cr>', 'Buffers' },
		h = { '<cmd>Telescope help_tags<cr>', 'Help' },
		f = { '<cmd>Telescope find_files<cr>', 'File' },
		r = { '<cmd>Telescope oldfiles<cr>', 'Recent Files' },
	},

	g = {
		name = 'Git',
		g = { '<cmd>LazyGit<cr>', 'LazyGit' },
		s = { '<cmd>Telescope git_status<cr>', 'Status' },
		b = { '<cmd>Telescope git_branches<cr>', 'Checkout Branch' },
		C = { '<cmd>Telescope git_commits<cr>', 'Checkout Commit' },
		c = { '<cmd>Git commit<cr>', 'Commit' },
		a = { '<cmd>Git add .<cr>', 'Add' },
		P = { '<cmd>Git push<cr>', 'Push' },
		p = { '<cmd>Git pull<cr>', 'Pull' },
	},

	l = {
		name = 'LSP',
		a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action' },
		r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
		f = { '<cmd>lua vim.lsp.buf.format()<cr>', 'Format' },
		m = { '<cmd>Mason<cr>', 'Mason' },
	},
}

local vmappings = {
	['/'] = { '<Plug>(comment_toggle_linewise_visual)', 'Comment toggle linewise (visual)' },
}

local which_key = require('which-key')
which_key.setup()
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
