return {
  {
    "airblade/vim-gitgutter",
    lazy = false,
    config = function()
      vim.g.gitgutter_enabled = 1
      vim.g.gitgutter_highlight_lines = 0

      -- Keymaps for gitgutter commands
      vim.keymap.set('n', '<leader>gp', ':GitGutterPreviewHunk<CR>', { silent = true, desc = "GitGutter: Preview Hunk" })
      vim.keymap.set('n', '<leader>gu', ':GitGutterUndoHunk<CR>', { silent = true, desc = "GitGutter: Undo Hunk" })
      vim.keymap.set('n', '<leader>gs', ':GitGutterStageHunk<CR>', { silent = true, desc = "GitGutter: Stage Hunk" })

      -- Set sign colors
      vim.cmd [[
        highlight GitGutterAdd    guifg=#87ff87 ctermfg=Green
        highlight GitGutterChange guifg=#ffd75f ctermfg=Yellow
        highlight GitGutterDelete guifg=#ff5f5f ctermfg=Red
      ]]
    end,
  }
}

