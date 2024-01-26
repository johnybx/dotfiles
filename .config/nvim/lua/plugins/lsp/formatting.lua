local M = {}

M.autoformat = true

function M.format(bufnr)
    if M.autoformat then
        -- vim.lsp.buf.format({ timeout_ms = 5000, async = false })
        require("conform").format({ timeout_ms = 5000, async = false, lsp_fallback = true, bufnr = bufnr })
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

function M.setup()
    local group_id = vim.api.nvim_create_augroup("LspFormat", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
            require("plugins.lsp.formatting").format(args.buf)
        end,
        group = group_id,
    })
end

return M
