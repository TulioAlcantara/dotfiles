local wk = require('which-key')

wk.register({
  f = {
    name = 'file', 
    f = { 'find' }, 
    g = { 'grep' }, 
    b = { 'buffers' }, 
    h = { 'help' }, 
  },
  q = {
    name = 'close buffer'
  }
}, { prefix = '<leader>' })
