return {
    "robitx/gp.nvim",
    config = function()
        local conf = {
            providers = {
                -- secrets can be strings or tables with command and arguments
                -- secret = { "cat", "path_to/openai_api_key" },
                -- secret = { "bw", "get", "password", "OPENAI_API_KEY" },
                -- secret : "sk-...",
                -- secret = os.getenv("env_name.."),
                openai = {},
                azure = {},
                copilot = {},
                ollama = {},
                lmstudio = {},
                googleai = {
                    disable = false,
                    endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
                    secret = os.getenv("GOOGLEAI_API_KEY"),
                },
                pplx = {},
                anthropic = {},
            },
            agents = {
                {
                    name = "ExampleDisabledAgent",
                    disable = true,
                },
                {
                    name = "ChatGPT4o",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").chat_system_prompt,
                },
                {
                    provider = "openai",
                    name = "ChatGPT4o-mini",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").chat_system_prompt,
                },
                {
                    provider = "openai",
                    name = "ChatGPT-o3-mini",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = { model = "o3-mini", temperature = 1.1, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").chat_system_prompt,
                },
                {
                    provider = "copilot",
                    name = "ChatCopilot",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").chat_system_prompt,
                },
                {
                    provider = "googleai",
                    name = "ChatGemini",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = { model = "gemini-2.5-flash", temperature = 1.1, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    -- system_prompt = require("gp.defaults").chat_system_prompt,
                    system_prompt = "You are a general AI assistant. Keep your answers concise and to the point."
                },
                {
                    provider = "pplx",
                    name = "ChatPerplexityLlama3.1-8B",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = { model = "llama-3.1-sonar-small-128k-chat", temperature = 1.1, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").chat_system_prompt,
                },
                {
                    provider = "anthropic",
                    name = "ChatClaude-3-7-Sonnet",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = { model = "claude-3-7-sonnet-latest", temperature = 0.8, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").chat_system_prompt,
                },
                {
                    provider = "anthropic",
                    name = "ChatClaude-Sonnet-4-Thinking",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = { model = "claude-sonnet-4-20250514", thinking_budget = 1024 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").chat_system_prompt,
                },
                {
                    provider = "anthropic",
                    name = "ChatClaude-3-5-Haiku",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = { model = "claude-3-5-haiku-latest", temperature = 0.8, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").chat_system_prompt,
                },
                {
                    provider = "ollama",
                    name = "ChatOllamaLlama3.1-8B",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = {
                        model = "llama3.1",
                        temperature = 0.6,
                        top_p = 1,
                        min_p = 0.05,
                    },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = "You are a general AI assistant.",
                },
                {
                    provider = "lmstudio",
                    name = "ChatLMStudio",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = {
                        model = "dummy",
                        temperature = 0.97,
                        top_p = 1,
                        num_ctx = 8192,
                    },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = "You are a general AI assistant.",
                },
                {
                    provider = "openai",
                    name = "CodeGPT4o",
                    chat = false,
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = { model = "gpt-4o", temperature = 0.8, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
                {
                    provider = "openai",
                    name = "CodeGPT-o3-mini",
                    chat = false,
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = { model = "o3-mini", temperature = 0.8, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
                {
                    provider = "openai",
                    name = "CodeGPT4o-mini",
                    chat = false,
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = { model = "gpt-4o-mini", temperature = 0.7, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = "Please return ONLY code snippets.\nSTART AND END YOUR ANSWER WITH:\n\n```",
                },
                {
                    provider = "copilot",
                    name = "CodeCopilot",
                    chat = false,
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = { model = "gpt-4o", temperature = 0.8, top_p = 1, n = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
                {
                    provider = "googleai",
                    name = "CodeGemini",
                    chat = false,
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = { model = "gemini-pro", temperature = 0.8, top_p = 1 },
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
                {
                    provider = "pplx",
                    name = "CodePerplexityLlama3.1-8B",
                    chat = false,
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = { model = "llama-3.1-sonar-small-128k-chat", temperature = 0.8, top_p = 1 },
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
                {
                    provider = "anthropic",
                    name = "CodeClaude-3-7-Sonnet",
                    chat = false,
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = { model = "claude-3-7-sonnet-latest", temperature = 0.8, top_p = 1 },
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
                {
                    provider = "anthropic",
                    name = "CodeClaude-3-5-Haiku",
                    chat = false,
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = { model = "claude-3-5-haiku-latest", temperature = 0.8, top_p = 1 },
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
                {
                    provider = "ollama",
                    name = "CodeOllamaLlama3.1-8B",
                    chat = false,
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = {
                        model = "llama3.1",
                        temperature = 0.4,
                        top_p = 1,
                        min_p = 0.05,
                    },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
            },
            chat_free_cursor = true,
            chat_confirm_delete = false,

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
        vim.keymap.set('n', "<leader>a", "<cmd>GpChatToggle tabnew<cr>", keymapOptions("Toggle Chat"))
        vim.keymap.set('v', "<leader>a", ":<C-u>'<,'>GpChatToggle tabnew<cr>", keymapOptions("Visual Toggle Chat"))
        vim.keymap.set('n', "<leader>fa", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

        -- vim.keymap.set("v", "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
        -- vim.keymap.set("v", "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))

        -- vim.keymap.set({ "n", "i" }, "<C-g><C-x>", "<cmd>GpChatNew split<cr>", keymapOptions("New Chat split"))
        -- vim.keymap.set({ "n", "i" }, "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat vsplit"))
        -- vim.keymap.set({ "n", "i" }, "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions("New Chat tabnew"))

        -- vim.keymap.set("v", "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions("Visual Chat New split"))
        -- vim.keymap.set("v", "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions("Visual Chat New vsplit"))
        -- vim.keymap.set("v", "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions("Visual Chat New tabnew"))

        -- -- Prompt commands
        -- vim.keymap.set({"n", "i"}, "<C-g>r", "<cmd>GpRewrite<cr>", keymapOptions("Inline Rewrite"))
        -- vim.keymap.set({"n", "i"}, "<C-g>a", "<cmd>GpAppend<cr>", keymapOptions("Append (after)"))
        -- vim.keymap.set({"n", "i"}, "<C-g>b", "<cmd>GpPrepend<cr>", keymapOptions("Prepend (before)"))

        -- vim.keymap.set("v", "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
        -- vim.keymap.set("v", "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
        -- vim.keymap.set("v", "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend (before)"))
        -- vim.keymap.set("v", "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement selection"))

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
    end,
}
