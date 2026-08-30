return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
    },
  },
  config = function()
    local parsers = {
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
    }

    require("nvim-treesitter").setup()
    require("nvim-treesitter").install(parsers)

    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
      },
    })

    local filetypes = {
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
      "sh",
      "bash",
      "markdown",
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    local textobject_select = require("nvim-treesitter-textobjects.select")
    local keymaps = {
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
    }

    for keymap, query in pairs(keymaps) do
      vim.keymap.set({ "x", "o" }, keymap, function()
        textobject_select.select_textobject(query, "textobjects")
      end)
    end
  end,
}
