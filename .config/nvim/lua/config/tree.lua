local tree_cb = require("nvim-tree.config").nvim_tree_callback
local setup = require("nvim-tree").setup

setup({
    disable_netrw = false,
    hijack_netrw = false,
    filters = { dotfiles = false, custom = { "__pycache__" } },
    view = {
        mappings = {
            list = { { key = "<C-s>", cb = tree_cb("split") } },
        },
    },
    git = {
        enable = true,
        ignore = false,
    },
})
