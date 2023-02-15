local nm = require("neo-minimap")

nm.source_on_save(vim.fn.expand("~/.config/nvim/lua/config/neo-minimap.lua"))

nm.set({ "mi", "mo" }, "*.py", {
    width = 100,
    height = 50,
    query = {
        [[
    ;; query
    ((class_definition) @cap)
    ]],
        [[
    ;; query
    ((class_definition) @cap)
    ((function_definition) @cap)
    ]],
        [[
    ;; query
    ((class_definition) @cap)
    ((function_definition) @cap)
    ((for_statement) @cap)
    ]],
        [[
    ;; query
    ((class_definition) @cap)
    ((function_definition) @cap)
    ((for_statement) @cap)
    ((if_statement) @cap)
    ]],
    },

    regex = {},

    search_patterns = {},

    win_opts = { scrolloff = 1 },
})
