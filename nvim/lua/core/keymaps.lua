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

-- Switch Buffer
keymap('n', '<S-h>', ':bprevious<CR>', opts)
keymap('n', '<S-l>', ':bnext<CR>', opts)

-- Save Buffer
keymap('n', '<c-s>', ':w!<CR>', opts)

-- Close Buffer
keymap('n', 'q', '<cmd>:bd|bp<CR>', opts)

-- Find Files
keymap('n', '<C-p>', '<cmd>Telescope find_files<CR>', opts)

--------------------------------
--           INSERT           --
--------------------------------

-- Save Buffer
-- keymap('i', '<c-s>', '<Esc>:w!<CR>', opts)

--------------------------------
--           VISUAL           --
--------------------------------

-- Move text up and down
keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)

-- Paste over currently selected text without yanking it
keymap('v', 'p', "'_dP", opts)

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
