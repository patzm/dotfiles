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

vim.call('plug#', 'catppuccin/nvim', { as = 'catppuccin' })
vim.call('plug#', 'ibhagwan/fzf-lua')
vim.call('plug#', 'echasnovski/mini.icons')
vim.call('plug#', 'nvim-tree/nvim-tree.lua')
vim.call('plug#', 'nvim-tree/nvim-web-devicons')
vim.call('plug#', 'tpope/vim-sensible')
vim.call('plug#', 'tpope/vim-surround')

vim.call('plug#end')

require("theme")
require("fzf")
require("tree")
-- end Plugins
