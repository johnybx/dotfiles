local function setup()
    local lsp_method = "textDocument/publishDiagnostics"
    vim.lsp.handlers[lsp_method] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        underline = true,
        signs = true,
        update_in_insert = false, -- ?
    })

    -- Send diagnostics to quickfix list
    do
        local default_handler = vim.lsp.handlers[lsp_method]
        vim.lsp.handlers[lsp_method] = function(err, result, ctx, config)
            default_handler(err, result, ctx, config)
            vim.diagnostic.setqflist({ open = false })
        end
    end
end

M = {
    setup = setup,
}

return M
