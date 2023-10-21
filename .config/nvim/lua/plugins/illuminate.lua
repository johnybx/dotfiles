return {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
        require("illuminate").configure({
            delay = 500,
            filetypes_denylist = { "NvimTree", "nerdtree", "dbui", "git" },
            providers = {
                "lsp",
                "treesitter",
                "regex",
            },
        })
        vim.api.nvim_exec2(
            [[
    hi IlluminatedWordText gui=NONE guibg=#393f4a
    hi IlluminatedWordRead gui=NONE guibg=#393f4a
    hi IlluminatedWordWrite gui=NONE guibg=#393f4a
]],
            { output = false }
        )
    end,
}
