local vim = vim
local Plug = vim.fn['plug#']

vim.loader.enable()

-- start Configuration
vim.g.mapleader = ","
vim.cmd([[language en_US.UTF-8]])
require("keymaps")
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
