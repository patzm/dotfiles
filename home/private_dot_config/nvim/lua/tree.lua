local keymap = vim.keymap
local nvim_tree = require("nvim-tree")

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- vim.opt.termguicolors = true

nvim_tree.setup {
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
}

keymap.set("n", "<C-n>", require("nvim-tree.api").tree.toggle, {
  silent = true,
  desc = "toggle nvim-tree",
})