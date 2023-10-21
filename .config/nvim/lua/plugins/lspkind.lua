return {
    "onsails/lspkind-nvim",
    event = "VeryLazy",
    config = function()
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
        lspkind.symbol_map["Codeium"] = "🤖"
        lspkind.symbol_map["Cody"] = "🤖"
    end,
}
