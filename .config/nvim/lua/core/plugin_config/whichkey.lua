local wk = require('which-key')
wk.add({
	{
		mode = { 'n' },
		{ '<leader>d', '<cmd>bd<cr>', desc = 'Close Buffer' },
		{ '<leader>q', '<cmd>qa!<cr>', desc = 'Quit' },
		{ '<leader>e', '<cmd>Oil<cr>', desc = 'Explorer' },
		{ '<leader>s', '<cmd>vsplit<cr>', desc = 'Split' },
		{
			'<leader>p',
			'<cmd>Lazy<cr>',
			desc = 'Package Manager (Lazy)',
		},
		{ '<leader>t', '<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>', desc = 'Troubleshoot' },
		{ '<leader>o', '<cmd>SymbolsOutline<cr>', desc = 'Symbols Outline' },
		{ '<leader>c', '<cmd>nohl<cr>', desc = 'Clear Highlight' },
		{ '<leader>u', '<cmd>UndotreeToggle<cr>', desc = 'Undo Tree' },
		{ '<leader>r', '<cmd>Spectre<cr>', desc = 'Replace (Spectre)' },
		{ '<leader>b', '<cmd>FzfLua buffers<cr>', desc = 'Buffers' },
	},
	{
		mode = { 'n' },
		{ '<leader>f', group = 'Find' },
		{ '<leader>fg', '<cmd>FzfLua live_grep<cr>', desc = 'Live Grep' },
		{ '<leader>fb', '<cmd>FzfLua buffers<cr>', desc = 'Buffers' },
		{ '<leader>fh', '<cmd>FzfLua helptags<cr>', desc = 'Help' },
		{ '<leader>ff', '<cmd>FzfLua files<cr>', desc = 'File' },
		{ '<leader>fo', '<cmd>FzfLua oldfiles<cr>', desc = 'Old Files' },
		{ '<leader>fr', '<cmd>FzfLua resume<cr>', desc = 'Resume' },
	},
	{
		mode = { 'n' },
		{ '<leader>g', group = 'Git' },
		{ '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Lazy Git' },
		{ '<leader>gf', '<cmd>DiffviewFileHistory %<<cr>', desc = 'File History' },
		{ '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diff' },
	},
})
