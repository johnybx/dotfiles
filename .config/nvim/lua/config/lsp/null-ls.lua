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
            null_ls.builtins.diagnostics.shellcheck,
        },
        on_attach = function(client, bufnr, ...)
            if vim.api.nvim_buf_get_option(bufnr, "filetype") == "sh" then
                client.server_capabilities.documentFormattingProvider = false
            end
            on_attach(client, bufnr, ...)
        end,
    })
end

M = {
    setup = setup,
}
return M
