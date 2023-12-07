local options = {
	-- backup / swap/ undo
	backup = false,
	undofile = true,
	swapfile = false,

	-- style
	termguicolors = true,
	number = true,
	relativenumber = true,
	cmdheight = 1,
	splitbelow = true,
	splitright = true,
	signcolumn = 'yes',
	cursorline = false,
	wrap = false,
	scrolloff = 8,
	conceallevel = 0,

	-- indentation
	shiftwidth = 2,
	tabstop = 2,
	numberwidth = 2,
	smartindent = true,

	-- search
	hlsearch = true,
	incsearch = true,
	smartcase = true,
	ignorecase = true,

	-- misc
	clipboard = 'unnamedplus',
	fileencoding = 'utf-8',
	mouse = 'a',
	updatetime = 50,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- remove comments on new line
vim.opt.formatoptions:remove({ 'c', 'r', 'o' })

-- set node version to asdf
-- local home_dir = '/home/tulio'
-- local node_bin = '/.asdf/installs/nodejs/20.7.0/bin'
-- vim.g.node_host_prog = home_dir .. node_bin .. '/node'
-- vim.cmd("let $PATH = '" .. home_dir .. node_bin .. ":' . $PATH")

-- wsl clipboard
if vim.fn.has('wsl') == 1 then
	vim.g.clipboard = {
		name = 'WslClipboard',
		copy = {
			['+'] = 'clip.exe',
			['*'] = 'clip.exe',
		},
		paste = {
			['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
end
