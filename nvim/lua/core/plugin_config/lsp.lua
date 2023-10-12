--------------------------------
--           LSP              --
--------------------------------

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
  lsp_zero.buffer_autoformat()
end)

require('lspconfig').lua_ls.setup(lsp_zero.nvim_lua_ls())

lsp_zero.setup()

--------------------------------
--         MASON              --
--------------------------------

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    lsp_zero.default_setup,
  },
})

--------------------------------
--           CMP              --
--------------------------------

-- local cmp = require('cmp')
-- local cmp_action = require('lsp-zero').cmp_action()
--
-- cmp.setup({
--   mapping = cmp.mapping.preset.insert({
--     -- `Enter` key to confirm completion
--     ['<CR>'] = cmp.mapping.confirm({ select = false }),
--
--     -- Ctrl+Space to trigger completion menu
--     ['<C-Space>'] = cmp.mapping.complete(),
--
--     -- Navigate between snippet placeholder
--     ['<C-j>'] = cmp_action.luasnip_jump_forward(),
--     ['<C-k>'] = cmp_action.luasnip_jump_backward(),
--
--     -- Scroll up and down in the completion documentation
--     ['<C-u>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-d>'] = cmp.mapping.scroll_docs(4),
--   })
-- })
