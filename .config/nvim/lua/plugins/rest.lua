-- Example of custom config
-- if pcall(require, "nvim-treesitter.parsers") then
--     local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
--     parser_configs.http = {
--         install_info = {
--             -- url = "https://github.com/johnybx/tree-sitter-http",
--             url = "https://github.com/NTBBloodbath/tree-sitter-http",
--             -- url = "~/workspace/tree-sitter-http",
--             files = { "src/parser.c" },
--             branch = "main",
--             -- generate_requires_npm = true,
--         },
--     }
-- end
-- better json parsing
vim.cmd([[
    augroup http_files 
        au FileType httpResult set filetype=http
        au FileType http set commentstring=#\ %s
    augroup END
]])

return {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        skip_ssl_verification = false,
    },
}
