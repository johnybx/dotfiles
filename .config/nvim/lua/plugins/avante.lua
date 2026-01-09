local function copilot_cond(...)
    if os.getenv("ENABLE_COPILOT") then
        return true
    end
    return false
end
return {
    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
        -- provider = "ollama",
        provider = "copilot",
        providers = {
            ollama = {
                endpoint = "http://127.0.0.1:11434",
                model = "hf.co/unsloth/Mistral-Small-3.2-24B-Instruct-2506-GGUF:UD-Q4_K_XL",
            },
            copilot = {
                model = "gpt-5-codex",
            },
        },
        auto_suggestions_provider = nil,
        selector = {
            provider = "telescope",
        },
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        {
            "zbirenbaum/copilot.lua",
            cond = copilot_cond,
            config = function()
                require("copilot").setup({
                    suggestion = { enabled = false },
                    panel = { enabled = false },
                    -- nes = {
                    --     enabled = true,
                    --     keymap = {
                    --         accept_and_goto = "<leader>p",
                    --         accept = false,
                    --         dismiss = "<Esc>",
                    --     },
                    -- },
                })
            end,
            -- dependencies = {
            --     {
            --         "copilotlsp-nvim/copilot-lsp",
            --         config = function()
            --             vim.g.copilot_nes_debounce = 500
            --         end,
            --         cond = copilot_cond,
            --     },
            -- },
        },
    },
    cond = copilot_cond,
}
