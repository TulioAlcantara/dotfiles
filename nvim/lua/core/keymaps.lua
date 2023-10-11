local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

--------------------------------
--           NORMAL           --
--------------------------------

-- Close Buffer
keymap('n', '<leader>q', '<CMD>wq<CR>', default_opts)


-- Switch Buffer
keymap("n", "<S-h>", ":bprevious<CR>", default_opts)
keymap("n", "<S-l>", ":bnext<CR>", default_opts)


--------------------------------
--           INSERT           --
--------------------------------

-- Save Buffer
keymap('i', '<c-s>', '<Esc>:w<CR>', default_opts)

--------------------------------
--           VISUAL           --
--------------------------------

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

