local function setup(on_attach, capabilities)
    local function _on_attach(client, bufnr)
        vim.lsp.inlay_hint.enable(bufnr, true)
        on_attach(client, bufnr)
    end

    vim.g.rustaceanvim = {

        tools = {
            inlay_hints = {
                show_variable_name = true,
            },
        },
        server = {
            on_attach = _on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
            settings = {
                -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                ["rust-analyzer"] = {
                    checkOnSave = {
                        command = "clippy",
                        allFeatures = nil,
                    },
                    diagnostics = {
                        enableExperimental = true,
                    },
                    cargo = {
                        allFeatures = true,
                        -- features = {},
                    },
                },
            },
        },
    }
end

local M = {
    setup = setup,
}

return M
