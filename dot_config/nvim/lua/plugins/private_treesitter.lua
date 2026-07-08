return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  main = "nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
  },
  init = function()
    local ensure = {
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
    local ok, installed = pcall(function()
      return require("nvim-treesitter.config").get_installed()
    end)
    if not ok then
      installed = {}
    end
    local to_install = vim.iter(ensure):filter(function(p)
      return not vim.list_contains(installed, p)
    end):totable()
    if #to_install > 0 then
      require("nvim-treesitter").install(to_install)
    end

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
      },
    })

    vim.keymap.set({ "x", "o" }, "af", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@function.outer")
    end)
    vim.keymap.set({ "x", "o" }, "if", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@function.inner")
    end)
    vim.keymap.set({ "x", "o" }, "aC", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@class.outer")
    end)
    vim.keymap.set({ "x", "o" }, "iC", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@class.inner")
    end)
    vim.keymap.set({ "x", "o" }, "al", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer")
    end)
    vim.keymap.set({ "x", "o" }, "il", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner")
    end)
    vim.keymap.set({ "x", "o" }, "ac", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer")
    end)
    vim.keymap.set({ "x", "o" }, "ic", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner")
    end)
    vim.keymap.set({ "x", "o" }, "aA", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer")
    end)
    vim.keymap.set({ "x", "o" }, "iA", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner")
    end)
  end,
}