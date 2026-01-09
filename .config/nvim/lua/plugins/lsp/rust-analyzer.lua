local function setup(on_attach, capabilities)
    vim.lsp.config("rust_analyzer", {
        cmd = { "rustup", "run", "nightly", "rust-analyzer" },
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
    })
    vim.lsp.enable("rust_analyzer", true)
end

M = {
    setup = setup,
}

return M
