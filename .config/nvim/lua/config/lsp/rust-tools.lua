local function setup(on_attach, capabilities)
    require("rust-tools").setup({
        server = {
            cmd = { "rustup", "run", "nightly", "rust-analyzer" },
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
        },
    })
end

local M = {
    setup = setup,
}

return M
