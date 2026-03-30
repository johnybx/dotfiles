local function setup(on_attach, capabilities)
    vim.lsp.config("helm_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
        settings = {
            ["helm-ls"] = {
                valuesFiles = {
                    mainValuesFile = "values.yaml",
                    lintOverlayValuesFile = "values.lint.yaml",
                    additionalValuesFilesGlobPattern = "*values*.yaml",
                },
            },
        },
    })
    vim.lsp.enable("helm_ls", true)
end

M = {
    setup = setup,
}

return M
