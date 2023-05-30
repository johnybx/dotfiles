vim.g.VM_set_statusline = 0
-- :VMDebug - b8: Overwritten imap: <BS> (I BS)  ->  v:lua.MPairs.autopairs_bs(8)
vim.g.VM_show_warnings = 0
-- <CR> mapping conficts with nvim-cmp -> basically this remaps insert mode <CR>
-- with nvim-cmp mapping still everything seem to work as expected ¯\_(ツ)_/¯
vim.g.VM_maps = {
    ["I Return"] = "",
}
return {
    "mg979/vim-visual-multi",
    keys = { {
        "<C-n>",
        nil,
        mode = { "n", "v" },
        desc = "Vim Visual Multi",
    } },
}
