local null_ls = require("null-ls")

local function setup(on_attach)
    null_ls.setup({
        debounce = 150,
        sources = {
            null_ls.builtins.formatting.isort,
            null_ls.builtins.formatting.black,
            -- null_ls.builtins.diagnostics.flake8,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.prettier,
        },
        on_attach = function(...)
            on_attach(...)
        end,
    })
end

M = {
    setup = setup,
}
return M
