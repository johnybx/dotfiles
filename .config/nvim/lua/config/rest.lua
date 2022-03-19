if pcall(require, "nvim-treesitter.parsers") then
    local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
    parser_configs.http = {
        install_info = {
            url = "https://github.com/johnybx/tree-sitter-http",
            -- url = "https://github.com/NTBBloodbath/tree-sitter-http",
            -- url = "~/workspace/tree-sitter-http",
            files = { "src/parser.c" },
            branch = "main",
            -- generate_requires_npm = true,
        },
    }
end
require("rest-nvim").setup({
    skip_ssl_verification = false,
})

-- better json parsing
vim.cmd("au FileType httpResult set filetype=http")
