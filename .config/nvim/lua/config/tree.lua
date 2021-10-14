local tree_cb = require("nvim-tree.config").nvim_tree_callback
local setup = require("nvim-tree").setup
vim.g.nvim_tree_ignore = { "__pycache__" }

setup({
    auto_close = true,
    open_on_setup = false,
    ignore_ft_on_setup = { "startify", "dashboard" },
    view = {
        mappings = {
            list = { { key = "<C-s>", cb = tree_cb("split") } },
        },
    },
})
