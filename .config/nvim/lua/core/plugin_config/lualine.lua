require('lualine').setup({
	options = {
		icons_enabled = true,
		color_icons = true,
		theme = 'auto',
		component_separators = { left = '|', right = '|' },
		section_separators = { left = '', right = '' },
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'fancy_diff' },
		lualine_c = { { 'filename', path = 1 } },
		lualine_x = { 'fancy_searchcount', 'fancy_diagnostics' },
		lualine_y = { 'filetype' },
		lualine_z = { 'location' },
	},
	tabline = {},
	-- tabline = {
	-- 	lualine_a = {
	-- 		{
	-- 			'buffers',
	-- 			use_mode_colors = true,
	-- 			symbols = {
	-- 				modified = ' ●',
	-- 				alternate_file = '',
	-- 				directory = '',
	-- 			},
	-- 			filetype_names = {
	-- 				dashboard = 'Dashboard',
	-- 			},
	-- 			max_length = vim.o.columns,
	-- 		},
	-- 	},
	-- },
})
