local vim = vim
local Plug = vim.fn['plug#']

vim.loader.enable()

-- start Configuration
vim.g.mapleader = ","
vim.cmd([[language en_US.UTF-8]])
vim.filetype.add({})
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.list = true      -- show invisible characters
vim.opt.undofile = true  -- persist change history

-- line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- search behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true

require("tabs")
require("keymaps")

-- Clipboard with OSC52, require neovim 0.10+
local is_tmux_session = vim.env.TERM_PROGRAM == "tmux" -- Tmux is its own clipboard provider which directly works.
-- TMUX documentation about its clipboard - https://github.com/tmux/tmux/wiki/Clipboard#the-clipboard
if vim.env.SSH_TTY and not is_tmux_session then
  local function paste()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end
  local osc52 = require("vim.ui.clipboard.osc52")
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = osc52.copy("+"),
      ["*"] = osc52.copy("*"),
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
  }
end

vim.opt.clipboard = 'unnamedplus'
-- end Configuration

-- start Plugins & their configuration
vim.call('plug#begin')

vim.call('plug#', 'catppuccin/nvim', { as = 'catppuccin' })
vim.call('plug#', 'ibhagwan/fzf-lua')
vim.call('plug#', 'echasnovski/mini.icons')
vim.call('plug#', 'brenoprata10/nvim-highlight-colors')
vim.call('plug#', 'nvim-tree/nvim-tree.lua')
vim.call('plug#', 'nvim-tree/nvim-web-devicons')
vim.call('plug#', 'tpope/vim-sensible')
vim.call('plug#', 'tpope/vim-surround')

vim.call('plug#end')

require('nvim-highlight-colors').setup({})
require('theme')
require('fzf')
require('tree')
-- end Plugins
