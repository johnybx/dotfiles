return {
    "sourcegraph/sg.nvim",
    cmd = { "CodyChat", "CodyToggle", "CodyAsk", "SourcegraphSearch" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    opts = function()
        return {
            on_attach = function(client, bufnr)
                local utils = require("utils")
                local opts = { silent = true, buffer = bufnr }
                utils.map("n", "<leader>gr", "<cmd>lua require('sg.extensions.telescope').sg_references()<CR>", opts)
                require("plugins.lsp.default_on_attach").on_attach(client, bufnr)
            end,
        }
    end,
}
