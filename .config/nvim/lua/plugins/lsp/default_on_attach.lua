local signature_on_attach = require("plugins.lsp.lsp_signature").signature_on_attach
local highlight = require("plugins.lsp.highlight").highlight
local code_lens = require("plugins.lsp.codelens").setup

local on_attach = function(client, bufnr)
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    -- Disable setting formatexpr=v:lua.vim.lsp.formatexpr()
    -- allow to use built in 'gq' in combination with format on save
    vim.bo[bufnr].formatexpr = nil

    signature_on_attach(bufnr)
    highlight(client)
    code_lens(client, bufnr)
end

M = {
    on_attach = on_attach,
}

return M
