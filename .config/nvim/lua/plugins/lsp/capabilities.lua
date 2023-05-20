local function get()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if status then
        capabilities = cmp_nvim_lsp.default_capabilities()
    else
        capabilities.textDocument.completion.completionItem = {
            documentationFormat = { "markdown", "plaintext" },
            snippetSupport = true,
            preselectSupport = true,
            insertReplaceSupport = true,
            labelDetailsSupport = true,
            deprecatedSupport = true,
            commitCharactersSupport = true,
            tagSupport = { valueSet = { 1 } },
            resolveSupport = {
                properties = {
                    "documentation",
                    "detail",
                    "additionalTextEdits",
                },
            },
        }
    end

    return capabilities
end

M = {
    get = get,
}

return M
