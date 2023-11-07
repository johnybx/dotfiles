return {
    cmd = { "Oil" },
    event = "VeryLazy",
    "stevearc/oil.nvim",
    opts = {
        keymaps = {
            ["<C-v>"] = "actions.select_vsplit",
            ["<C-s>"] = "actions.select_split",
            ["q"] = "actions.close",
        },
        float = {
            padding = 10,
            win_options = {
                winblend = 0,
            },
        },
        view_options = {
            show_hidden = true,
        },
    },
}
