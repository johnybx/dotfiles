local tree_cb = require("nvim-tree.config").nvim_tree_callback
local setup = require("nvim-tree").setup

setup({
    auto_close = true,
    open_on_setup = false,
    ignore_ft_on_setup = { "startify", "dashboard" },
    filters = { dotfiles = false, custom = { "__pycache__" } },
    view = {
        mappings = {
            list = { { key = "<C-s>", cb = tree_cb("split") } },
        },
    },
})
