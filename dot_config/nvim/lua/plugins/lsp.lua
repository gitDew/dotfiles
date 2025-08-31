return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Allows extra capabilities provided by nvim-cmp
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        require'lspconfig'.pyright.setup{}
        require'lspconfig'.clangd.setup{}
        require'lspconfig'.gopls.setup{
            on_attach = function(client, bufnr)
                -- format on save (only for this buffer)
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end,
        }

    end,
}
