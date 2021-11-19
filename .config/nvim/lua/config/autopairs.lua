require("nvim-autopairs").setup({
    enable_check_bracket_line = false,
    disable_filetype = { "TelescopePrompt", "vim", "NvimTree" },
    ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
    fast_wrap = {},
    check_ts = false,
})

local status, cmp = pcall(require, "cmp")
if status then
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done({
            map_char = { tex = "" },
            kind = {
                cmp.lsp.CompletionItemKind.Method,
                cmp.lsp.CompletionItemKind.Function,
                -- cmp.lsp.CompletionItemKind.Class,
            },
        })
    )
end
