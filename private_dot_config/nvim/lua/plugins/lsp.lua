return {
    'neovim/nvim-lspconfig',
    config = function()
        require'lspconfig'.gopls.setup{}
        require'lspconfig'.pyright.setup{}
        -- require'lspconfig'.jdtls.setup{
        --     on_attach = function()
        --         vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, {buffer=0})
        --         vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=0})
        --     end,
        -- }

    end,
}
