local function setup()
    local catppuccino = require("catppuccino")
    catppuccino.setup({
        colorscheme = "neon_latte",
        transparency = false,
        styles = {
            comments = "italic",
            functions = "NONE",
            keywords = "NONE",
            strings = "NONE",
            variables = "NONE",
        },
        integrations = {
            treesitter = true,
            native_lsp = {
                enabled = true,
                styles = {
                    errors = "italic",
                    hints = "italic",
                    warnings = "italic",
                    information = "italic",
                },
            },
            lsp_trouble = true,
            lsp_saga = true,
            gitgutter = false,
            gitsigns = false,
            telescope = true,
            nvimtree = true,
            which_key = false,
            indent_blankline = true,
            dashboard = false,
            neogit = false,
            vim_sneak = false,
            fern = false,
            barbar = false,
            bufferline = false,
            markdown = false,
        },
    })
    catppuccino.load()
end

local M = {
    setup = setup,
}

return M
