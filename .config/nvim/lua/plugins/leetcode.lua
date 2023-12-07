local leet_arg = "leetcode.nvim"
return {
    "kawre/leetcode.nvim",
    lazy = leet_arg ~= vim.fn.argv()[1],
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-treesitter/nvim-treesitter",
        "rcarriga/nvim-notify",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        arg = leet_arg,
        lang = "python3",
        directory = vim.fn.expand("~/workspace/leetcode"),
    },
}
