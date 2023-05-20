local M = {}

function M.setup(client, bufnr)
    if client.server_capabilities.codeLensProvider then
        vim.api.nvim_exec(
            string.format(
                [[
            augroup lsp_code_lens
            autocmd! * <buffer=%s>
            autocmd BufEnter ++once <buffer=%s> lua vim.lsp.codelens.refresh()
            autocmd CursorHold,InsertLeave <buffer=%s> lua vim.lsp.codelens.refresh()
            augroup END
            ]],
                bufnr,
                bufnr,
                bufnr
            ),
            false
        )
        -- trigger reset codelens with delay to make sure that codelens is not deadlocked
        -- vim.defer_fn(function()
        --     M.reset_codelens(bufnr)
        -- end, 5000)
        -- debug
        -- local default_handler = vim.lsp.codelens.on_codelens
        -- vim.lsp.codelens.on_codelens = function(err, result, ctx, ...)
        --     print(vim.inspect(err))
        --     print(vim.inspect(result))
        --     default_handler(err, result, ctx, ...)
        -- end
    end
end

function M.reset_codelens(bufnr)
    -- Currently if the codelens request fails the active_refreshed is never reset for buffer which
    -- means that no codelens refresh is possible.
    -- Calling codelens manually triggers on_codelens func which resets active_refreshed for buffer
    -- on success.
    -- https://github.com/neovim/neovim/blob/233014f92b5d4d5bf8a6f019241aafd1b05dd383/runtime/lua/vim/lsp/codelens.lua#L7
    -- https://github.com/neovim/neovim/issues/18008
    local _bufnr = bufnr or vim.api.nvim_get_current_buf()
    vim.lsp.buf_request(
        _bufnr,
        "textDocument/codeLens",
        { textDocument = vim.lsp.util.make_text_document_params(_bufnr) },
        vim.lsp.codelens.on_codelens
    )
end

return M
