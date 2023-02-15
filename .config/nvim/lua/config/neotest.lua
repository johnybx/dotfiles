local neotest = require("neotest")
neotest.setup({
    adapters = {
        require("neotest-python"),
        require("neotest-plenary"),
    },
    output = { open_on_run = false },
    quickfix = {
        open = false,
    },
    icons = {
        passed = "✔",
        running = "🗘",
        failed = "✖",
        skipped = "ﰸ",
        unknown = "?",
    },
})

local group = vim.api.nvim_create_augroup("NeotestConfig", {})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "neotest-output",
    group = group,
    callback = function(opts)
        vim.keymap.set("n", "q", function()
            pcall(vim.api.nvim_win_close, 0, true)
        end, {
            buffer = opts.buf,
        })
    end,
})
