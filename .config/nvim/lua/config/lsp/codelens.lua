local M = {}

function M.setup(client)
    if client.resolved_capabilities.code_lens then
        vim.api.nvim_exec(
            [[
            augroup lsp_code_lens
            autocmd! * <buffer>
            autocmd BufEnter ++once <buffer> lua vim.lsp.codelens.refresh()
            autocmd CursorHold,BufWritePost <buffer> lua vim.lsp.codelens.refresh()
            augroup END
            ]],
            false
        )
    end
end

return M
