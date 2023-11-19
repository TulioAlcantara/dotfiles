local telescope = require('telescope')
local lga_actions = require('telescope-live-grep-args.actions')

telescope.setup({
  extensions = {
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          ['<C-k>'] = lga_actions.quote_prompt(),
          ['<C-i>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
          ['<C-t>'] = lga_actions.quote_prompt({ postfix = ' -t ' }),
        },
      },
    },
  },
})
