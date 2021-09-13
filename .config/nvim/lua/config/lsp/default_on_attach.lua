local signature_on_attach = require("config.lsp.lsp_signature").signature_on_attach
local highlight = require("config.lsp.highlight").highlight
local set_null_ls_formatting = require("config.lsp.null-ls").set_formatting_capability
local formatting_setup = require("config.lsp.formatting").setup

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	signature_on_attach(bufnr)
	highlight(client)
	set_null_ls_formatting(client, bufnr)
	formatting_setup(client)
end

M = {
	on_attach = on_attach,
}

return M
