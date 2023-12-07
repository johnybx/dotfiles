local function setup(on_attach, capabilities)
    local function _on_attach(client, ...)
        client.server_capabilities.hoverProvider = false
        on_attach(client, ...)
    end

    require("lspconfig").ruff_lsp.setup({
        on_attach = _on_attach,
        capabilities = capabilities,
    })
end

return {
    setup = setup,
}
