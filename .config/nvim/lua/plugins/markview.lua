return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
        modes = { "n", "no", "c" },
        -- This is nice to have
        callbacks = {
            on_enable = function(_, win)
                vim.wo[win].conceallevel = 2
                vim.wo[win].concealcursor = "nc"
            end,
        },
    },

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
}
