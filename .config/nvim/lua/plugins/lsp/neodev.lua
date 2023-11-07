local function setup(on_attach, capabilities)
    local function _on_attach(client, ...)
        client.server_capabilities.documentFormattingProvider = false
        on_attach(client, ...)
    end

    require("neodev").setup({
        override = function(root_dir, library)
            if root_dir:match("/workspace/nvim/") then
                library.enabled = true
                library.plugins = true
            end
        end,
    })

    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup({
        cmd = { "lua-language-server" },
        single_file_support = true,
        capabilities = capabilities,
        on_attach = _on_attach,
        settings = {
            Lua = {
                telemetry = { enable = false },
                format = {
                    enable = false,
                },
            },
        },
    })
end

M = {
    setup = setup,
}
return M
