local signature_on_attach = require("config.lsp.lsp_signature").signature_on_attach
local highlight = require("config.lsp.highlight").highlight
local formatting_setup = require("config.lsp.formatting").setup
local code_lens = require("config.lsp.codelens").setup

local on_attach = function(client, bufnr)
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    -- Disable setting formatexpr=v:lua.vim.lsp.formatexpr()
    -- allow to use built in 'gq' in combination with format on save
    vim.bo[bufnr].formatexpr = nil

    signature_on_attach(bufnr)
    highlight(client)
    formatting_setup(client)
    code_lens(client, bufnr)
end

M = {
    on_attach = on_attach,
}

return M
