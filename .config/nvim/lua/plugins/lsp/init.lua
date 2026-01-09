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
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },

    config = function()
        require("fidget")
        require("plugins.lsp.diagnostic_sign").setup()
        require("plugins.lsp.formatting").setup()

        local on_attach = require("plugins.lsp.default_on_attach").on_attach
        local capabilities = require("plugins.lsp.capabilities").get()

        -- Enable on type formating
        vim.lsp.on_type_formatting.enable()

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
            "basedpyright",
            -- "pyrefly",
            -- "ty",
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
            "lua_ls",
        }
        require("plugins.lsp.generic_lsp").setup(servers, on_attach, capabilities)
    end,
}
