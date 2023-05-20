return {
    "jackMort/ChatGPT.nvim",
    cmd = "ChatGPT",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "rcarriga/nvim-notify",
    },
    opts = {
        popup_input = {
            submit = "<A-Enter>",
        },
    },
    cond = function(...)
        if os.getenv("OPENAI_API_KEY") then
            return true
        end
        vim.api.nvim_create_user_command("ChatGPT", function(...)
            require("notify")("OpenAI API key not found", "warn")
        end, {})
        return false
    end,
}
