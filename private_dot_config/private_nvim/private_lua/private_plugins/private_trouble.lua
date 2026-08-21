return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  opts = { focus = true }, -- focus trouble window on open; closing restores focus to main
  keys = {
    { "<leader>fd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "[F]ind [D]iagnostics (buffer)" },
    { "<leader>fD", "<cmd>Trouble diagnostics toggle<cr>",              desc = "[F]ind [D]iagnostics (workspace)" },
  },
}
