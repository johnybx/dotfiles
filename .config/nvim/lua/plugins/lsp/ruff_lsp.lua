local function setup(on_attach, capabilities)
    local function _on_attach(client, ...)
        client.server_capabilities.hoverProvider = false
        on_attach(client, ...)
    end

    vim.lsp.config("ruff", {
        on_attach = _on_attach,
        capabilities = capabilities,
    })
    vim.lsp.enable("ruff", true)
end

return {
    setup = setup,
}
