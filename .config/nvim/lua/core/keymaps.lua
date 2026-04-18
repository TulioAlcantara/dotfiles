local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local t_opts = { noremap = true }

-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--------------------------------
--           NORMAL           --
--------------------------------

-- Navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Switch Harpoon Buffer
-- keymap('n', '<S-h>', '<cmd>:lua require("harpoon.ui").nav_next()<CR>', opts)
-- keymap('n', '<S-l>', '<cmd>:lua require("harpoon.ui").nav_prev()<CR>', opts)

-- Swich between buffers
keymap('n', '<S-h>', '<cmd>:bp<CR>', opts)
keymap('n', '<S-l>', '<cmd>:bn<CR>', opts)

-- Reorder Buffers
keymap('n', '<A-h>', '<cmd>:BufferMovePrevious<CR>', opts)
keymap('n', '<A-l>', '<cmd>:BufferMoveNext<CR>', opts)

-- Save Buffer
keymap('n', '<c-s>', ':w<CR>', opts)

-- Find Files
keymap('n', '<C-p>', '<cmd>FzfLua files<CR>', opts)
keymap('n', '<C-f>', '<cmd>FzfLua live_grep<CR>', opts)

-- Center screen after moving up and down
keymap('n', '<C-u>', '<C-u>zz', opts)
keymap('n', '<C-d>', '<C-d>zz', opts)

-- FzfLua Buffer
keymap('n', '<C-\\>', '<cmd>FzfLua buffers<CR>', opts)

-------------------------------
--           INSERT           --
--------------------------------

--------------------------------
--           VISUAL           --
--------------------------------

-- Move text up and down
keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)

-- Paste over currently selected text without yanking it
keymap('v', 'p', '"_dP', opts)

--------------------------------
--        VISUAL BLOCK        --
--------------------------------

-- Move text up and down
keymap('x', 'J', ":m '>+1<CR>gv=gv", opts)
keymap('x', 'K', ":m '<-2<CR>gv=gv", opts)
keymap('x', '<A-j>', ":m '>+1<CR>gv=gv", opts)
keymap('x', '<A-k>', ":m '<-2<CR>gv=gv", opts)

--------------------------------
--           TERMINAL         --
--------------------------------

-- Navigation
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', t_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', t_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', t_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', t_opts)

--------------------------------
--       USER COMMANDS         --
--------------------------------

-- :Messages — dump :messages output into a scratch buffer for easy
-- navigation, searching, and yanking.
vim.api.nvim_create_user_command('Messages', function()
	local output = vim.fn.execute('messages')
	vim.cmd('enew')
	vim.bo.buftype = 'nofile'
	vim.bo.bufhidden = 'wipe'
	vim.bo.swapfile = false
	vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(output, '\n'))
end, { desc = 'Open :messages output in a scratch buffer' })

-- :LspLog — open Neovim's LSP log file.
vim.api.nvim_create_user_command('LspLog', function()
	vim.cmd('edit ' .. vim.lsp.log.get_filename())
end, { desc = 'Open the LSP log file' })
