-- https://github.com/kristijanhusak/vim-dadbod-completion
vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_execute_on_save = 0
vim.cmd("autocmd FileType dbout setlocal nofoldenable")

return {
    { "tpope/vim-dadbod", cmd = "DB" },
    {
        "kristijanhusak/vim-dadbod-ui",
        cmd = { "DBUI", "DBUIAddConnection", "DBUIToggle" },
        dependencies = {
            { "kristijanhusak/vim-dadbod-completion" },
            { "tpope/vim-dadbod" },
        },
    },
}
