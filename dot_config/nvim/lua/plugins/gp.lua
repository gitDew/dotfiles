return {
    "robitx/gp.nvim",
    config = function()
        local function env_bool(var, default)
            local val = os.getenv(var)
            if val == nil then return default end
            return val ~= ""
        end

        local conf = {
            providers = {
                -- secrets can be strings or tables with command and arguments
                -- secret = { "cat", "path_to/openai_api_key" },
                -- secret = { "bw", "get", "password", "OPENAI_API_KEY" },
                -- secret : "sk-...",
                -- secret = os.getenv("env_name.."),
                openai = {},
                azure = {},
                ollama = {},
                lmstudio = {},
                pplx = {},
                anthropic = {
                    disable = not env_bool("ANTHROPIC_API_KEY", false),
                    endpoint = "https://lab-coding.services.ai.azure.com/anthropic/v1/messages",
                    secret = os.getenv("ANTHROPIC_API_KEY"),
                },
                opencodego = {
                    disable = not env_bool("OPENCODE_GO_API_KEY", false),
                    endpoint = "https://opencode.ai/zen/go/v1/chat/completions",
                    secret = os.getenv("OPENCODE_GO_API_KEY"),
                },
                labcoding = {
                    disable = not env_bool("LAB_CODING_API_KEY", false),
                    endpoint = "https://lab-coding.openai.azure.com/openai/v1/chat/completions",
                    secret = os.getenv("LAB_CODING_API_KEY"),
                },
            },
            agents = {
                {
                    provider = "anthropic",
                    name = "ChatClaude-Opus-4-8",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = { model = "claude-opus-4-8"},
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = "Keep your answers concise and to the point.",
                },
                {
                    provider = "labcoding",
                    name = "ChatDeepSeek-V4-Pro",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = {
                        model = "DeepSeek-V4-Pro",
                        reasoning_effort = "max",
                    },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = "Keep your answers concise and to the point.",
                },
                {
                    provider = "anthropic",
                    name = "CodeClaude-Opus-4-8",
                    chat = false,
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = { model = "claude-opus-4-8"},
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
                {
                    provider = "labcoding",
                    name = "CodeDeepSeek-V4-Pro",
                    chat = false,
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = {
                        model = "DeepSeek-V4-Pro",
                        reasoning_effort = "max",
                    },
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
                {
                    provider = "opencodego",
                    name = "ChatKimiK2.6",
                    chat = true,
                    command = false,
                    model = { model = "kimi-k2.6", temperature = 1.1, top_p = 1 },
                    system_prompt = "Keep your answers concise and to the point."
                },
                {
                    provider = "opencodego",
                    name = "CodeKimiK2.6",
                    chat = false,
                    command = true,
                    model = { model = "kimi-k2.6", temperature = 0.8, top_p = 1 },
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
                {
                    provider = "opencodego",
                    name = "ChatDeepSeekV4Pro",
                    chat = true,
                    command = false,
                    model = { model = "deepseek-v4-pro", temperature = 1.1, top_p = 1, reasoning_effort = "max" },
                    system_prompt = "Keep your answers concise and to the point."
                },
                {
                    provider = "opencodego",
                    name = "CodeDeepSeekV4Pro",
                    chat = false,
                    command = true,
                    model = { model = "deepseek-v4-pro", temperature = 0.8, top_p = 1, reasoning_effort = "max" },
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
                {
                    provider = "opencodego",
                    name = "ChatDeepSeekV4Flash",
                    chat = true,
                    command = false,
                    model = { model = "deepseek-v4-flash", temperature = 1.1, top_p = 1 },
                    system_prompt = "Keep your answers concise and to the point."
                },
                {
                    provider = "opencodego",
                    name = "CodeDeepSeekV4Flash",
                    chat = false,
                    command = true,
                    model = { model = "deepseek-v4-flash", temperature = 0.8, top_p = 1 },
                    system_prompt = require("gp.defaults").code_system_prompt,
                },

            },
            chat_shortcut_respond = { modes = { "n" }, shortcut = "<CR>" },
            chat_free_cursor = true,
            chat_confirm_delete = false,
            chat_template = require("gp.defaults").short_chat_template,
        }
        require("gp").setup(conf)
        local function keymapOptions(desc)
            return {
                noremap = true,
                silent = true,
                nowait = true,
                desc = "GPT prompt " .. desc,
            }
        end

        -- Chat commands
        -- vim.keymap.set({"n", "i"}, "<C-g>c", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
        vim.keymap.set('n', "<leader>a", "<cmd>GpChatToggle vsplit<cr>", keymapOptions("Toggle Chat"))
        -- vim.keymap.set('v', "<leader>a", ":<C-u>'<,'>GpChatToggle tabnew<cr>", keymapOptions("Visual Toggle Chat"))
        vim.keymap.set('n', "<leader>fa", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

        -- vim.keymap.set("v", "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
        vim.keymap.set("v", "<leader>a", ":<C-u>'<,'>GpChatPaste vsplit<cr>", keymapOptions("Visual Chat Paste"))

        -- vim.keymap.set({ "n", "i" }, "<C-g><C-x>", "<cmd>GpChatNew split<cr>", keymapOptions("New Chat split"))
        -- vim.keymap.set({ "n", "i" }, "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat vsplit"))
        -- vim.keymap.set({ "n", "i" }, "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions("New Chat tabnew"))

        -- vim.keymap.set("v", "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions("Visual Chat New split"))
        -- vim.keymap.set("v", "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions("Visual Chat New vsplit"))
        -- vim.keymap.set("v", "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions("Visual Chat New tabnew"))

        -- -- Prompt commands
        -- vim.keymap.set("v", "<leader>rt", "<cmd>GpRewrite<cr>", keymapOptions("Inline [R]ewrite [t]his"))
        vim.keymap.set("v", "<leader>rt", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual [R]ewrite [t]his"))
        vim.keymap.set("v", "<leader>it", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("[I]mplement [t]his selection"))
        -- vim.keymap.set({"n", "i"}, "<C-g>a", "<cmd>GpAppend<cr>", keymapOptions("Append (after)"))
        -- vim.keymap.set({"n", "i"}, "<C-g>b", "<cmd>GpPrepend<cr>", keymapOptions("Prepend (before)"))

        -- vim.keymap.set("v", "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
        -- vim.keymap.set("v", "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
        -- vim.keymap.set("v", "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend (before)"))

        -- vim.keymap.set({"n", "i"}, "<C-g>gp", "<cmd>GpPopup<cr>", keymapOptions("Popup"))
        -- vim.keymap.set({"n", "i"}, "<C-g>ge", "<cmd>GpEnew<cr>", keymapOptions("GpEnew"))
        -- vim.keymap.set({"n", "i"}, "<C-g>gn", "<cmd>GpNew<cr>", keymapOptions("GpNew"))
        -- vim.keymap.set({"n", "i"}, "<C-g>gv", "<cmd>GpVnew<cr>", keymapOptions("GpVnew"))
        -- vim.keymap.set({"n", "i"}, "<C-g>gt", "<cmd>GpTabnew<cr>", keymapOptions("GpTabnew"))

        -- vim.keymap.set("v", "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions("Visual Popup"))
        -- vim.keymap.set("v", "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", keymapOptions("Visual GpEnew"))
        -- vim.keymap.set("v", "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", keymapOptions("Visual GpNew"))
        -- vim.keymap.set("v", "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", keymapOptions("Visual GpVnew"))
        -- vim.keymap.set("v", "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", keymapOptions("Visual GpTabnew"))

        -- vim.keymap.set({"n", "i"}, "<C-g>x", "<cmd>GpContext<cr>", keymapOptions("Toggle Context"))
        -- vim.keymap.set("v", "<C-g>x", ":<C-u>'<,'>GpContext<cr>", keymapOptions("Visual Toggle Context"))

        -- vim.keymap.set({"n", "i", "v", "x"}, "<C-g>s", "<cmd>GpStop<cr>", keymapOptions("Stop"))
        -- vim.keymap.set({"n", "i", "v", "x"}, "<C-g>n", "<cmd>GpNextAgent<cr>", keymapOptions("Next Agent"))
        -- vim.keymap.set({"n", "i", "v", "x"}, "<C-g>l", "<cmd>GpSelectAgent<cr>", keymapOptions("Select Agent"))
    --
        -- vim.keymap.set("n", "<CR>", "<cmd>GpChatRespond<CR>", { noremap = true })
    end,
}
