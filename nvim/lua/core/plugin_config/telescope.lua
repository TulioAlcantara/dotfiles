local telescope = require('telescope')
local lga_actions = require('telescope-live-grep-args.actions')

telescope.setup({
	defaults = {
		path_display = { truncate = 3 },
		file_ignore_patterns = { 'node_modules' },
		layout_strategy = 'horizontal',
		layout_config = {
			horizontal = {
				prompt_position = 'top',
			},
		},
		sorting_strategy = 'ascending',
		mappings = {
			n = {
				['<C-p>'] = require('telescope.actions').cycle_history_prev,
				['<C-n>'] = require('telescope.actions').cycle_history_next,
				['<C-d>'] = require('telescope.actions').delete_buffer,
			},
		},
	},
	extensions = {
		live_grep_args = {
			auto_quoting = true,
			mappings = {
				i = {
					['<C-d>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
					['<C-t>'] = lga_actions.quote_prompt({ postfix = ' -t ' }),
				},
			},
		},
	},
	pickers = {
		colorscheme = {
			enable_preview = true,
		},
	},
})
