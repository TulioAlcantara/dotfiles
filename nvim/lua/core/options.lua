local options = {
	backup = false, -- creates a backup file
	clipboard = 'unnamedplus', -- allows neovim to access the system clipboard
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	fileencoding = 'utf-8', -- the encoding written to a file
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	mouse = 'a', -- allow the mouse to be used in neovim
	showtabline = 2, -- always show tabs
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	undofile = true, -- enable persistent undo
	timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
	updatetime = 300, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	cursorline = true, -- highlight the current line
	numberwidth = 2, -- set number column width to 2 {default 4}
	signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
	wrap = true, -- display lines as one long line
	linebreak = true, -- companion to wrap, don't split words
	conceallevel = 0, -- so that `` is visible in markdown files
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

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
