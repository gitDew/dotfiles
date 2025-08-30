vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
-- vim.g.have_nerd_font = false

require 'options'
require 'keymaps'
require 'lazy-bootstrap' -- install lazy.nvim plugin manager

-- load plugins from ./lua/plugins/
require("lazy").setup("plugins")

vim.cmd.colorscheme "catppuccin-macchiato"
vim.cmd("language en_US.UTF-8")
