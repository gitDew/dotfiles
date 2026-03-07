return {
  'github/copilot.vim',
  init = function()
    vim.g.copilot_filetypes = {
      markdown = false,
    }

    vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      silent = true,
      replace_keycodes = false
    })
    vim.g.copilot_no_tab_map = true
  end,
}
