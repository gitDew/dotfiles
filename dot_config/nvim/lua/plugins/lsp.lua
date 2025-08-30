return {
    'neovim/nvim-lspconfig',
    config = function()
        local on_attach = function(client, bufnr)
            local opts = { noremap=true, silent=true, buffer=bufnr }

            -- Go to definition
            vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)        

            -- Find references
            vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)        

            -- Go to implementation
            vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)    

            -- Rename symbol
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)            

            -- Code actions
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)       

            -- Hover documentation
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)                      

        end        
        require'lspconfig'.gopls.setup{
            on_attach = on_attach,
        }
        require'lspconfig'.pyright.setup{
            on_attach = on_attach,
        }
        require'lspconfig'.clangd.setup{
            on_attach = on_attach,
        }
    end,
}
