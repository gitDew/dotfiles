return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Install parsers for these languages
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "python",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "bash",
        "markdown",
        "markdown_inline",
      },

      -- Install missing parsers automatically
      auto_install = true,

      highlight = {
        enable = true,            -- Enable syntax highlighting
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,            -- Better indentation
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["aC"] = "@class.outer",
            ["iC"] = "@class.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",
            ["aA"] = "@parameter.outer",
            ["iA"] = "@parameter.inner",
          },
        },
      }
    })
  end,
}

