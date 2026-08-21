return {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    config = function()
        require("mason").setup({
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry",
            },
        })
    end,
}
