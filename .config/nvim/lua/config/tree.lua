local setup = require("nvim-tree").setup

local function on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
end

setup({
    disable_netrw = false,
    hijack_netrw = false,
    filters = { dotfiles = false, custom = { "__pycache__" } },
    on_attach = on_attach,
    git = {
        enable = true,
        ignore = false,
    },
})
