-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      local actions = require("telescope.actions")
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          path_display = { "smart" },
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["qq"] = actions.close,
              ["<C-s>"] = actions.select_horizontal,
              ["<C-d>"] = actions.select_vertical
            },
            n = {
              ["q"] = actions.close,
              ["<C-s>"] = actions.select_horizontal,
              ["<C-d>"] = actions.select_vertical
            },
          },
        },
        pickers = {
          diagnostics = {
            initial_mode = "normal",
            theme = "ivy",
            layout_strategy = "vertical",
            layout_config = {
              width = 0.95,
              height = 0.9,
            },
          },
          lsp_definitions = {
            initial_mode = "normal",
          },
          lsp_references = {
            initial_mode = "normal",
          },
          lsp_implementations = {
            initial_mode = "normal",
          },
          lsp_type_definitions = {
            initial_mode = "normal",
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fp', builtin.git_files, { desc = '[F]ind in [P]project (git repo)' })
      -- vim.keymap.set('n', '<leader>fp', "<cmd>Telescope projects<cr>", { desc = '[F]ind in [P]project (git repo)' })
      vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
      vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = '[F]ind [Old] Files' })
      vim.keymap.set('n', '<leader><leader>', builtin.resume, { desc = '[ ] Resume last search' })
      vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = "Go to definition" })
      vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = "Find references" })
      vim.keymap.set('n', 'gi', builtin.lsp_implementations, { desc = "Go to implementation" })
      vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, { desc = "Go to type definition" })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[F]ind [N]eovim files' })


      vim.keymap.set('n', '<leader>fh', function()
        builtin.find_files { cwd = '/home/krisz/', hidden = true}
      end, { desc = '[F]ind in [H]ome' })
    end,

  },
}
-- vim: ts=2 sts=2 sw=2 et
