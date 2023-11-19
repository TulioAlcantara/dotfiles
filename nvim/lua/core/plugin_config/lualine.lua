require('lualine').setup({
	options = {
		icons_enabled = true,
		theme = 'auto',
		disabled_filetypes = { 'toggleterm', 'NvimTree' },
		component_separators = { left = '|', right = '|' },
		section_separators = { left = '', right = '' },
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'fancy_branch', 'fancy_diff' },
		lualine_c = { 'fancy_diagnostics' },
		lualine_x = { 'selectioncount', 'searchcount' },
		lualine_y = { 'filetype' },
		lualine_z = { 'progress' },
	},
	tabline = {
		lualine_a = {
			{
				'buffers',
				use_mode_colors = true,
				symbols = {
					modified = ' ●',
					alternate_file = '',
					directory = '',
				},
			},
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { 'tabs' },
	},
	winbar = {
		lualine_a = {
			'navic',
			color_correction = nil,
			navic_opts = nil,
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
})
