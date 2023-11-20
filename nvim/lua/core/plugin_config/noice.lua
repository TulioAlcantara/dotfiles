require('noice').setup({
	views = {
		cmdline_popup = {
			border = {
				style = 'none',
				padding = { 2, 3 },
			},
			filter_options = {},
			win_options = {
				winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
			},
		},
	},
	routes = {
		{
			filter = {
				event = 'msg_show',
				kind = '',
				find = 'written',
			},
			opts = { skip = true },
		},
	},
})
