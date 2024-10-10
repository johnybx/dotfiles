return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "ray-x/lsp_signature.nvim" },
        { "mrcjkb/rustaceanvim", ft = { "rust" } },
        {
            "j-hui/fidget.nvim",
            opts = {
                notification = {
                    window = {
                        winblend = 0,
                        border = "rounded",
                        border_hl = "FloatermBorder",
                    },
                },
            },
            event = "LspAttach",
        },
        {
            "folke/neodev.nvim",
            opts = {
                override = function(root_dir, library)
                    if root_dir:match("/workspace/nvim/") then
                        library.enabled = true
                        library.plugins = true
                    end
                end,
            },
        },
    },

    config = function()
        require("fidget")
        require("plugins.lsp.diagnostic_sign").setup()
        require("plugins.lsp.formatting").setup()
        -- require("plugins.lsp.fswatch").setup()

        local on_attach = require("plugins.lsp.default_on_attach").on_attach
        local capabilities = require("plugins.lsp.capabilities").get()

        -- Lua
        require("plugins.lsp.neodev").setup(on_attach, capabilities)
        -- Yamlls
        require("plugins.lsp.yamlls").setup(on_attach, capabilities)
        -- Ccls
        require("plugins.lsp.ccls").setup(on_attach, capabilities)
        -- Clang
        -- https://github.com/p00f/clangd_extensions.nvim
        -- Ruff lsp
        require("plugins.lsp.ruff_lsp").setup(on_attach, capabilities)

        -- Rust analyzer
        local status, _ = pcall(require, "rustaceanvim")
        if status then
            require("plugins.lsp.rustaceanvim").setup(on_attach, capabilities)
        else
            require("plugins.lsp.rust-analyzer").setup(on_attach, capabilities)
        end

        -- Others
        local servers = {
            "pyright",
            "dockerls",
            "bashls",
            "vimls",
            "intelephense",
            "html",
            "marksman",
            "gopls",
            "ts_ls",
            "eslint",
            "vuels",
            "emmet_language_server",
        }
        require("plugins.lsp.generic_lsp").setup(servers, on_attach, capabilities)

        -- Setup lsp diagnostics
        require("plugins.lsp.diagnostics").setup()
    end,
}
