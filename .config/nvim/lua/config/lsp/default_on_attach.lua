local signature_on_attach = require("config.lsp.lsp_signature").signature_on_attach
local highlight = require("config.lsp.highlight").highlight
local formatting_setup = require("config.lsp.formatting").setup
local code_lens = require("config.lsp.codelens").setup

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    signature_on_attach(bufnr)
    highlight(client)
    formatting_setup(client)
    code_lens(client)
end

M = {
    on_attach = on_attach,
}

return M
