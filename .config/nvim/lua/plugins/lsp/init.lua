return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "ray-x/lsp_signature.nvim" },
        { "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
        { "simrat39/rust-tools.nvim" },
        { "folke/lua-dev.nvim" },
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        require("plugins.lsp.diagnostic_sign").setup()

        local on_attach = require("plugins.lsp.default_on_attach").on_attach
        local capabilities = require("plugins.lsp.capabilities").get()

        -- Lua
        require("plugins.lsp.neodev").setup(on_attach, capabilities)
        -- Null lsp
        require("plugins.lsp.null-ls").setup(on_attach)
        -- Yamlls
        require("plugins.lsp.yamlls").setup(on_attach, capabilities)
        -- Ccls
        require("plugins.lsp.ccls").setup(on_attach, capabilities)
        -- Clang
        -- https://github.com/p00f/clangd_extensions.nvim

        -- Rust analyzer
        local status, _ = pcall(require, "rust-tools")
        if status then
            require("plugins.lsp.rust-tools").setup(on_attach, capabilities)
        else
            require("plugins.lsp.rust-analyzer").setup(on_attach, capabilities)
        end

        -- Others
        local servers = { "pyright", "dockerls", "bashls", "vimls", "intelephense", "tsserver", "marksman" }
        require("plugins.lsp.generic_lsp").setup(servers, on_attach, capabilities)

        -- Setup lsp diagnostics
        require("plugins.lsp.diagnostics").setup()
    end,
}
