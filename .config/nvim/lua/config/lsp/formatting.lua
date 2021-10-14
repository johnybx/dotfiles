local M = {}

M.autoformat = true

function M.format()
    if M.autoformat then
        vim.lsp.buf.formatting_sync()
    end
end

function M.status()
    if M.autoformat then
        print("enabled format on save", "Formatting")
    else
        print("disabled format on save", "Formatting")
    end
end

function M.toggle()
    M.autoformat = not M.autoformat
    M.status()
end

function M.setup(client)
    if client.resolved_capabilities.document_formatting then
        vim.cmd([[
            augroup LspFormat
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua require("config.lsp.formatting").format()
            augroup END
        ]])
    end
end

return M
