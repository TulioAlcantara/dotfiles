local opts = {
	mode = 'n',
	prefix = '<leader>',
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
}

local vopts = {
	mode = 'v',
	prefix = '<leader>',
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
}

local mappings = {
	['e'] = { '<cmd>NvimTreeToggle<cr>', 'Explorer' },
	['w'] = { '<cmd>w!<cr>', 'Save' },
	['q'] = { '<cmd>qa!<cr>', 'Quit' },
	['s'] = { '<cmd>vsplit<CR>', 'Split' },
	['p'] = { '<cmd>Lazy<cr>', 'Package Manager (Lazy)' },
	['t'] = { '<cmd>TroubleToggle<cr>', 'Troubleshoot' },
	['z'] = { '<cmd>ZenMode<cr>', 'ZenMode' },
	['r'] = { '<cmd>Spectre<cr>', 'Replace (Spectre)' },
	['o'] = { '<cmd>SymbolsOutline<cr>', 'Symbols Outline' },
	['c'] = { '<cmd>nohl<cr>', 'Clear Highlight' },
	['u'] = { '<cmd>UndotreeToggle<cr>', 'Undo Tree' },

	h = {
		name = 'Harpoon',
		h = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', 'Toggle Quick Menu' },
		a = { '<cmd>lua require("harpoon.mark").add_file()<cr>', 'Add Buffer' },
		c = { '<cmd>lua require("harpoon.mark").clear_all()<cr>', 'Clear All' },
		n = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', 'Next' },
		p = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', 'Previous' },
	},

	f = {
		name = 'Find',
		g = { '<cmd>FzfLua live_grep<cr>', 'Live Grep' },
		b = { '<cmd>FzfLua buffers<cr>', 'Buffers' },
		h = { '<cmd>FzfLua helptags<cr>', 'Help' },
		f = { '<cmd>FzfLua files<cr>', 'File' },
		o = { '<cmd>FzfLua oldfiles<cr>', 'Old Files' },
		r = { '<cmd>FzfLua resume<cr>', 'Resume' },
	},

	g = {
		name = 'Git',
		g = { '<cmd>LazyGit<cr>', 'LazyGit' },
		s = { '<cmd>Telescope git_status<cr>', 'Status' },
		f = { '<cmd>DiffviewFileHistory %<cr>', 'File History' },
		d = { '<cmd>DiffviewOpen<cr>', 'Diff' },
	},

	l = {
		name = 'LSP',
		a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action' },
		R = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
		f = { '<cmd>lua vim.lsp.buf.format()<cr>', 'Format' },
		m = { '<cmd>Mason<cr>', 'Mason' },
		d = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Go to definition' },
		D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Go to declaration' },
		i = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Go to implementation' },
		r = { '<cmd>lua vim.lsp.buf.references()<cr>', 'Go to references' },
	},
}

local vmappings = {}

local which_key = require('which-key')
which_key.setup()
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
