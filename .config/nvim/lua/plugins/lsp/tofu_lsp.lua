local function setup(on_attach, capabilities)
    vim.lsp.config("tofu_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
        root_dir = function(bufnr, on_dir)
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if bufname:match("^diffview://") then
                return -- don't call on_dir at all -> no root found -> client won't start/attach
            end

            local root = vim.fs.root(bufnr, { ".terraform", "*.tf", "*.tofu" })
            if root then
                on_dir(root)
            end
        end,
    })
    vim.lsp.enable("tofu_ls", true)
end

M = {
    setup = setup,
}

return M
