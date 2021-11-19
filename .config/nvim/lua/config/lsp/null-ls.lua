local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

local function setup(on_attach)
    null_ls.config({
        debounce = 150,
        sources = {
            null_ls.builtins.formatting.isort,
            null_ls.builtins.formatting.black,
            -- null_ls.builtins.diagnostics.flake8,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.prettier,
        },
    })

    lspconfig["null-ls"].setup({
        on_attach = function(...)
            on_attach(...)
        end,
    })
end

M = {
    setup = setup,
}
return M
