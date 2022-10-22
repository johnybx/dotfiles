local neotest = require("neotest")
neotest.setup({
    adapters = {
        require("neotest-python"),
        require("neotest-plenary"),
    },
    output = { open_on_run = false },
    icons = {
        passed = "✔",
        running = "🗘",
        failed = "✖",
        skipped = "ﰸ",
        unknown = "?",
    },
})
