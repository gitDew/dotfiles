-- Exit insert mode with jk
vim.keymap.set('i', 'jk', '<ESC>')

-- Clear highlights on search when pressing <Enter> in normal mode
vim.keymap.set('n', '<Cr>', '<cmd>nohlsearch<CR>')

-- Keybinds to make split navigation easier.
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<leader>h', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>l', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>j', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>k', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Scroll and center
vim.keymap.set('n', '<C-u>', '<C-u>zz',{ desc = 'Scroll up' })
vim.keymap.set('n', '<C-d>', '<C-d>zz',{ desc = 'Scroll down' })

-- See `:help lua-guide-autocommands`
-- Highlight when yanking (copying) text
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Don't move cursor when joining lines
vim.keymap.set('n', 'J', "mzJ`z")

-- Paste without overwriting register
vim.keymap.set('x', '<leader>p', '\"_dP')

-- Delete without overwriting register
vim.keymap.set('n', '<leader>d', '\"_d')
vim.keymap.set('n', '<leader>d', '\"_d')

-- Yank to system clipboard
vim.keymap.set('n', '<leader>y', '\"+y')
vim.keymap.set('v', '<leader>y', '\"+y')
vim.keymap.set('n', '<leader>Y', '\"+Y')

-- Substitute word under cursor in line only
vim.keymap.set("n", "<leader>s", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Substitute word under cursor in whole file
vim.keymap.set("n", "S", "<Nop>")
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Substitute selected in whole file
vim.keymap.set("v", "<leader>S", [["hy:%s/<C-r>h/<C-r>h/gI<Left><Left><left>]])


-- Code actions
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
