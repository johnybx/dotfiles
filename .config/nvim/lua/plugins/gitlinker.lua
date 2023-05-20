return {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
        { "<leader>gy", nil, desc = "GitLinker" },
    },
    config = function()
        local paths = package.path
        package.path = vim.fn.expand("~/.local/share/nvim/") .. "gitlinker_callbacks.lua"
        local status, callbacks = pcall(require, "gitlinker_callbacks")
        package.path = paths
        if not status then
            callbacks = {}
        end
        require("gitlinker").setup({
            callbacks = callbacks,
        })
    end,
}
