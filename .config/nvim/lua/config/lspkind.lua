local lspkind = require("lspkind")
lspkind.init({
    mode = "symbol",
    preset = "default",

    -- override preset symbols
    -- can override only default symbols
    -- symbol_map = {
    -- },
})
lspkind.symbol_map["TabNine"] = "🤖"
