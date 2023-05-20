return {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    opts = {
        char = "|",
        buftype_exclude = { "terminal", "NvimTree", "help", "sagahover" },
    },
}
