vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
-- vim.g.have_nerd_font = false

require 'options'
require 'keymaps'
require 'lazy-bootstrap' -- install lazy.nvim plugin manager

-- load plugins from ./lua/plugins/
require("lazy").setup("plugins")

vim.cmd.colorscheme "catppuccin-macchiato"
vim.cmd("language en_US.UTF-8")
vim.cmd("syntax off")


-- paths to check for project.godot file
local paths_to_check = {'/', '/../'}
local is_godot_project = false
local godot_project_path = ''
local cwd = vim.fn.getcwd()

-- iterate over paths and check
for key, value in pairs(paths_to_check) do
    if vim.uv.fs_stat(cwd .. value .. 'project.godot') then
        is_godot_project = true
        godot_project_path = cwd .. value
        break
    end
end

-- check if server is already running in godot project path
local is_server_running = vim.uv.fs_stat(godot_project_path .. '/server.pipe')

-- start server, if not already running
if is_godot_project and not is_server_running then
    vim.fn.serverstart(godot_project_path .. '/server.pipe')
end

-- Only for GDScript
local on_attach = function(client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
        local group = vim.api.nvim_create_augroup("gdscript_lsp_highlight", { clear = true })

        vim.api.nvim_create_autocmd("CursorHold", {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd("CursorMoved", {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

vim.lsp.config('gdscript', {
    on_attach = on_attach,
})

vim.lsp.enable('gdscript')

-- make gdscript urls green and remove annoying underline
vim.cmd('highlight @string.special.url.gdscript gui=NONE guifg=#279c09')

-- faster CursorHold (important)
vim.o.updatetime = 300

