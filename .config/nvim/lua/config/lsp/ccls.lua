local function setup(on_attach, capabilities)
    require("lspconfig")["ccls"].setup({
        init_options = {
            compilationDatabaseDirectory = "build",
            index = {
                threads = 0,
            },
            clang = {
                excludeArgs = { "-frounding-math" },
            },
        },
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
    })
end

M = {
    setup = setup,
}

return M
