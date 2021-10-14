local function setup(servers, on_attach, capabilities)
    for _, lsp in ipairs(servers) do
        require("lspconfig")[lsp].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
        })
    end
end

M = {
    setup = setup,
}

return M
