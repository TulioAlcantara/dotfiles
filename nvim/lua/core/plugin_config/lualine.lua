require('lualine').setup({
	options = {
		icons_enabled = true,
		theme = 'auto',
		-- disabled_filetypes = { 'toggleterm', 'NvimTree', 'Outline' },
		component_separators = { left = '|', right = '|' },
		section_separators = { left = '', right = '' },
		globalstatus = true,
	},
	sections = {
		lualine_a = { { 'fancy_mode', width = 6 } },
		lualine_b = { 'fancy_branch', 'fancy_diff' },
		lualine_c = { { 'fancy_cwd', substitute_home = true }, 'filename' },
		lualine_x = { 'selectioncount', 'fancy_searchcount', 'fancy_diagnostics' },
		lualine_y = { 'filetype', 'fileformat', 'encoding' },
		lualine_z = { 'progress' },
	},
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
	-- 				TelescopePrompt = 'Telescope',
	-- 				dashboard = 'Dashboard',
	-- 				NvimTree = 'File Explorer',
	-- 				lazy = 'Lazy',
	-- 			},
	-- 			max_length = vim.o.columns * 2 / 2,
	-- 		},
	-- 	},
	-- 	lualine_b = {},
	-- 	lualine_c = {},
	-- 	lualine_x = {},
	-- 	lualine_y = {},
	-- 	lualine_z = { 'tabs' },
	-- },
	-- winbar = {
	-- 	lualine_a = {
	-- 		'navic',
	-- 		color_correction = nil,
	-- 		navic_opts = nil,
	-- 	},
	-- 	lualine_b = {},
	-- 	lualine_c = {},
	-- 	lualine_x = {},
	-- 	lualine_y = {},
	-- 	lualine_z = {},
	-- },
})
