local opts = {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
      mode = "v", -- VISUAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  --['a'] = { '<cmd>Alpha<cr>', 'Alpha' },
  ['e'] = { '<cmd>NvimTreeToggle<cr>', 'Explorer' },
  ['w'] = { '<cmd>w!<CR>', 'Save' },
  ['q'] = { '<cmd>q!<CR>', 'Quit' },
  ['c'] = { '<cmd>bdelete!<CR>', 'Close Buffer' },
  ['h'] = { '<cmd>nohlsearch<CR>', 'No Highlight' },
  ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },

  f = {
    name = 'File', 
    g = { '<cmd>Telescope live_grep<cr>', 'Live Grep' },
    b = { '<cmd>Telescope buffers<cr>', 'Buffers' },
    h = { '<cmd>Telescope help_tags<cr>', 'Help' },
    f = { '<cmd>Telescope find_files<cr>', 'File' },
  },

  g = {
    name = 'Git',
    o = { '<cmd>Telescope git_status<cr>', 'Open changed file' },
    b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
    c = { '<cmd>Telescope git_commits<cr>', 'Checkout commit' },
  },
}

local vmappings = {
  ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
}

local which_key = require('which-key')
which_key.setup()
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
