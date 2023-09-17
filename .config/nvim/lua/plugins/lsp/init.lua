return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "ray-x/lsp_signature.nvim" },
        { "simrat39/rust-tools.nvim" },
        { "folke/lua-dev.nvim" },
        { "j-hui/fidget.nvim", opts = {}, event = "LspAttach", tag = "legacy" },
    },
    config = function()
        require("plugins.lsp.diagnostic_sign").setup()
        require("plugins.lsp.formatting").setup()
        require("plugins.lsp.fswatch").setup()

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
