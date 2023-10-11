require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'catppuccin-mocha',
  },
  sections = {
    lualine_a = {
	{
	  'filename',
	  path = 1,
	}
     }
  }
}
