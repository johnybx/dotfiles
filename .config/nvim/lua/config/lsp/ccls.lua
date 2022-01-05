-- ccls require compilation database https://github.com/MaskRay/ccls/wiki/Project-Setup#compile_commandsjson
-- or ccls file https://github.com/MaskRay/ccls/wiki/Project-Setup#ccls-file
-- in root directory
local function setup(on_attach, capabilities)
    require("lspconfig")["ccls"].setup({
        init_options = {
            compilationDatabaseDirectory = "",
            index = {
                threads = 0,
            },
            clang = {
                excludeArgs = { "-frounding-math" },
            },
        },
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
    })
end

M = {
    setup = setup,
}

return M
