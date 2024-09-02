--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
	return function(str)
		local win_width = vim.fn.winwidth(0)
		if hide_width and win_width < hide_width then
			return ''
		elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
			return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
		end
		return str
	end
end

require('lualine').setup({
	options = {
		icons_enabled = true,
		color_icons = true,
		theme = 'auto',
		component_separators = { left = '/', right = '\\' },
		section_separators = { left = '', right = '' },
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'fancy_diff' },
		lualine_c = { 'filename' },
		lualine_x = { 'selectioncount', 'fancy_searchcount', 'fancy_diagnostics' },
		lualine_y = { 'filetype', 'fileformat', 'encoding' },
		lualine_z = { 'location' },
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
				filetype_names = {
					TelescopePrompt = 'Telescope',
					dashboard = 'Dashboard',
					NvimTree = 'File Explorer',
					lazy = 'Lazy',
				},
				-- max_length = vim.o.columns * 2 / 2,
			},
		},
		-- lualine_a = { 'filename' },
		lualine_b = { '' },
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { 'tabs' },
	},
	-- winbar = {
	-- 	lualine_a = { 'filename' },
	-- 	lualine_b = {},
	-- 	lualine_c = {},
	-- 	lualine_x = {},
	-- 	lualine_y = {},
	-- 	lualine_z = {},
	-- },
})
