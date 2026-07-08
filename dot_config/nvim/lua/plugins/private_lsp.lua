return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local capabilities = vim.tbl_deep_extend('force',
            vim.lsp.protocol.make_client_capabilities(),
            require('cmp_nvim_lsp').default_capabilities()
        )

        local function setup(name, opts)
            opts = vim.tbl_deep_extend('force', opts or {}, {
                capabilities = capabilities,
            })
            vim.lsp.config(name, opts)
            vim.lsp.enable(name)
        end

        local on_attach_format = function(args)
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end

        setup('dartls', {
            cmd = { 'fvm', 'dart', 'language-server', '--protocol=lsp' },
        })
        setup('basedpyright')
        setup('clangd')
        setup('ts_ls')
        setup('bashls')
        setup('openscad_lsp', { on_attach = on_attach_format })
        setup('gopls', { on_attach = on_attach_format })

        local open_external_docs = function()
            local bufnr = vim.api.nvim_get_current_buf()
            local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'rust_analyzer' })[1]
            if not client then
                vim.notify('rust_analyzer is not attached', vim.log.levels.ERROR)
                return
            end
            local encoding = client.offset_encoding or 'utf-16'
            local cursor_params = vim.lsp.util.make_position_params(0, encoding)

            local open_url = function(url)
                if url then
                    vim.ui.open(url)
                    return true
                end
                return false
            end

            local request_external_docs = function(uri, position, cb)
                client.request('experimental/externalDocs', {
                    textDocument = { uri = uri },
                    position = position,
                }, function(err, url)
                    if err then
                        vim.notify(tostring(err), vim.log.levels.ERROR)
                        cb(nil)
                    else
                        cb(url)
                    end
                end)
            end

            request_external_docs(cursor_params.textDocument.uri, cursor_params.position, function(url)
                if open_url(url) then
                    return
                end

                client.request('textDocument/typeDefinition', cursor_params, function(t_err, type_loc)
                    if t_err or not type_loc then
                        vim.notify('No external documentation found', vim.log.levels.INFO)
                        return
                    end

                    local first = type_loc
                    if type(first) == 'table' and type_loc[1] then
                        first = type_loc[1]
                    end
                    if not first then
                        vim.notify('No external documentation found', vim.log.levels.INFO)
                        return
                    end

                    local uri, position
                    if first.targetUri then
                        uri = first.targetUri
                        position = first.targetSelectionRange and first.targetSelectionRange.start or first.targetRange.start
                    else
                        uri = first.uri
                        position = first.range.start
                    end

                    request_external_docs(uri, position, function(type_url)
                        if not open_url(type_url) then
                            vim.notify('No external documentation found', vim.log.levels.INFO)
                        end
                    end)
                end)
            end)
        end

        setup('rust_analyzer', {
            on_attach = function(args)
                on_attach_format(args)
                vim.keymap.set('n', 'gk', open_external_docs, { buffer = args.buf, desc = 'Open external documentation' })
            end,
            commands = {
                RustOpenDocs = {
                    open_external_docs,
                    description = 'Open documentation for the symbol under the cursor in default browser',
                },
            },
        })
    end,
}
