return {
    "cshuaimin/ssr.nvim",
    keys = {
        {
            "<leader>sr",
            '<cmd>lua require("ssr").open()<CR>',
            desc = "Structural search and replace",
            mode = { "n", "x" },
        },
    },
}
