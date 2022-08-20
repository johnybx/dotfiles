require("illuminate").configure({
    delay = 500,
    filetypes_denylist = { "NvimTree", "nerdtree", "dbui", "git" },
    providers = {
        "lsp",
        "treesitter",
        "regex",
    },
})
vim.api.nvim_exec(
    [[
    hi def IlluminatedWordText gui=none guibg=#393f4a
    hi def IlluminatedWordRead gui=none guibg=#393f4a
    hi def IlluminatedWordWrite gui=none guibg=#393f4a
]],
    false
)
