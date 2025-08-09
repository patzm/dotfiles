-- <leader>-m: new horizontal window & switch
vim.keymap.set('n', '<leader>n', function()
  vim.cmd('split')
  vim.cmd('wincmd j')
  vim.cmd('enew')
end, { noremap = true, silent = true })

-- <leader>-n: new vertical window & switch
vim.keymap.set('n', '<leader>m', function()
  vim.cmd('vsplit')
  vim.cmd('wincmd l')
  vim.cmd('enew')
end, { noremap = true, silent = true })

-- Switch windows with Ctrl+hjkl
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Disable arrow keys to avoid being tempted to use them
vim.keymap.set('n', '<Up>', '<nop>', { noremap = true })
vim.keymap.set('n', '<Down>', '<nop>', { noremap = true })
vim.keymap.set('n', '<Left>', '<nop>', { noremap = true })
vim.keymap.set('n', '<Right>', '<nop>', { noremap = true })

-- clear all search results
vim.keymap.set('n', '<leader><space>', function()
  vim.cmd('nohlsearch')
  vim.fn.clearmatches()
end, { noremap = true, silent = true })
