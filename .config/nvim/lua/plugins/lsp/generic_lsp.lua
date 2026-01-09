local function setup(servers, on_attach, capabilities)
    for _, lsp in ipairs(servers) do
        vim.lsp.config(lsp, {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
        })
        vim.lsp.enable(lsp, true)
    end
end

M = {
    setup = setup,
}

return M
