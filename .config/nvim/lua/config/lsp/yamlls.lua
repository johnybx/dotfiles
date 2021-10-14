local function setup(on_attach, capabilities)
    -- Note: yamlls -> support different schemas out of the box but for example docker compose schema specify just
    --              keywords but almost none of the keywords has documentation
    -- By default schemas are pulled from https://www.schemastore.org/api/json/catalog.json
    -- Disable schema per file # yaml-language-server: $schema=none
    -- In order to disable schemas for files globaly the empty schema can be mapped to
    -- filename e.g. schemas = { [".empty-schema.yaml"] = {"deploy.yaml"} }
    require("lspconfig").yamlls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
        settings = {
            yaml = {
                schemas = {
                    kubernetes = { "*.k8s.yaml", "*.k8s.yml" },
                },
            },
        },
    })
end

M = {
    setup = setup,
}

return M
