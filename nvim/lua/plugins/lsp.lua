return {
    'neovim/nvim-lspconfig',
    config = function()
        require'lspconfig'.gopls.setup{}

        -- vim.lsp.buf.code_action()
    end,
}
