return {
    "https://github.com/mfussenegger/nvim-lint",
    ft = {
        "sh",
        "bash",
    },
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            sh = { "shellcheck" },
            bash = { "shellcheck" },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
