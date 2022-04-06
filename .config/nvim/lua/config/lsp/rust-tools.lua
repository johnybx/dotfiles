local function setup(on_attach, capabilities)
    require("rust-tools").setup({
        tools = {
            inlay_hints = {
                show_variable_name = true,
            },
        },
        server = {
            -- for some reason running rust-analyzer using rustup does not show diagnostics.
            -- cmd = { "rustup", "run", "nightly", "rust-analyzer" },
            -- cmd = { vim.fn.expand("~/workspace/rust/rust-analyzer/target/release/rust-analyzer") },
            cmd = { vim.fn.expand("~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rust-analyzer") },
            on_attach = on_attach,
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
    })
end

local M = {
    setup = setup,
}

return M
