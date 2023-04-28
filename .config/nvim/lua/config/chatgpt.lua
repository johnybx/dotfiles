if os.getenv("OPENAI_API_KEY") then
    require("chatgpt").setup({
        keymaps = {
            submit = "<A-Enter>",
        },
    })
end
