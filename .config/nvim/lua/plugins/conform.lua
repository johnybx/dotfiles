return {
    "https://github.com/stevearc/conform.nvim",
    ft = {
        "lua",
        "luau",
        "python",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "jsonc",
        "yaml",
        "markdown",
        "markdown.mdx",
        "graphql",
    },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                luau = { "stylua" },
                python = function(bufnr)
                    if require("conform").get_formatter_info("ruff_format", bufnr).available then
                        return { "ruff_fix", "ruff_format" }
                    else
                        return { "isort", "black" }
                    end
                end,
                javascript = { { "prettierd", "prettier" } },
                javascriptreact = { { "prettierd", "prettier" } },
                typescript = { { "prettierd", "prettier" } },
                typescriptreact = { { "prettierd", "prettier" } },
                vue = { { "prettierd", "prettier" } },
                css = { { "prettierd", "prettier" } },
                scss = { { "prettierd", "prettier" } },
                less = { { "prettierd", "prettier" } },
                html = { { "prettierd", "prettier" } },
                json = { { "prettierd", "prettier" } },
                jsonc = { { "prettierd", "prettier" } },
                yaml = { { "prettierd", "prettier" } },
                markdown = { { "prettierd", "prettier" } },
                ["markdown.mdx"] = { { "prettierd", "prettier" } },
                graphql = { { "prettierd", "prettier" } },
                go = { "goimports", "gofmt" },
            },
        })
    end,
}
