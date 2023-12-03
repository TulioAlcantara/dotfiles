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
	['c'] = { '<cmd>nohl<cr>', 'Clear Search' },
	['t'] = { '<cmd>TroubleToggle<cr>', 'Troubleshoot' },
	['z'] = { '<cmd>ZenMode<cr>', 'ZenMode' },
	['r'] = { '<cmd>Spectre<cr>', 'Replace (Spectre)' },
	['o'] = { '<cmd>SymbolsOutline<cr>', 'Symbols Outline' },

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
		g = { '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>', 'Live Grep' },
		b = { '<cmd>Telescope buffers<cr>', 'Buffers' },
		h = { '<cmd>Telescope help_tags<cr>', 'Help' },
		f = { '<cmd>Telescope find_files<cr>', 'File' },
		o = { '<cmd>Telescope oldfiles<cr>', 'Old Files' },
		r = { '<cmd>Telescope resume<cr>', 'Resume' },
	},

	g = {
		name = 'Git',
		g = { '<cmd>LazyGit<cr>', 'LazyGit' },
		s = { '<cmd>Telescope git_status<cr>', 'Status' },
		f = { '<cmd>DiffviewFileHistory %<cr>', 'File History' },
	},

	l = {
		name = 'LSP',
		a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action' },
		r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
		f = { '<cmd>lua vim.lsp.buf.format()<cr>', 'Format' },
		m = { '<cmd>Mason<cr>', 'Mason' },
	},

	b = {
		name = 'Buffer',
		b = { '<cmd>Telescope buffers<cr>', 'Buffers' },
		d = { '<cmd>bd<cr>', 'Delete' },
		n = { '<cmd>bn<cr>', 'Next' },
		p = { '<cmd>bp<cr>', 'Previous' },
		s = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Search' },
	},
}

local vmappings = {}

local which_key = require('which-key')
which_key.setup()
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
