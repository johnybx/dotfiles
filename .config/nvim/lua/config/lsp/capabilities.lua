local function get()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if status then
        capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
    else
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.textDocument.completion.completionItem.resolveSupport = {
            properties = { "documentation", "detail", "additionalTextEdits" },
        }
    end

    -- Code actions
    capabilities.textDocument.codeAction = {
        dynamicRegistration = true,
        codeActionLiteralSupport = {
            codeActionKind = {
                valueSet = (function()
                    local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
                    table.sort(res)
                    return res
                end)(),
            },
        },
    }
    return capabilities
end

M = {
    get = get,
}

return M
