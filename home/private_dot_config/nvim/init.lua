local vim = vim
local Plug = vim.fn['plug#']

vim.loader.enable()

-- start Configuration
vim.g.mapleader = ","
vim.cmd([[language en_US.UTF-8]])
require("keymaps")

-- Clipboard with OSC52, require neovim 0.10+
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

vim.opt.clipboard = 'unnamedplus'
-- end Configuration

-- start Plugins & their configuration
vim.call('plug#begin')

Plug ('ibhagwan/fzf-lua')
Plug ('echasnovski/mini.icons')
Plug ('nvim-tree/nvim-tree.lua')
Plug ('nvim-tree/nvim-web-devicons')
Plug ('tpope/vim-sensible')
Plug ('tpope/vim-surround')

vim.call('plug#end')

require("fzf")
require("tree")
-- end Plugins
