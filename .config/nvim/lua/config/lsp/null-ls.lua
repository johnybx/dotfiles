local lspconfig = require("lspconfig")
local null_ls = require("null-ls")


local function set_formatting_capability(client, bufnr)
    if client.name ~= "null-ls" then
        return
    end
    local null_ls_config = require("null-ls.config")
	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
	if vim.tbl_contains(null_ls_config.get()._filetypes, filetype) then
        client.resolved_capabilities.document_formatting = true
	end
end

local function setup (on_attach)
    null_ls.config({
        debounce = 150,
        sources = {
            null_ls.builtins.formatting.isort,
            null_ls.builtins.formatting.black,
            -- null_ls.builtins.diagnostics.flake8,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.prettier,
        },
    })

    lspconfig["null-ls"].setup({
        on_attach = on_attach,
    })

end


M = {
    setup = setup,
    set_formatting_capability = set_formatting_capability,
}
return M

