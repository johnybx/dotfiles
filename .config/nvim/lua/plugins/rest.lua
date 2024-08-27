-- better json parsing
vim.cmd([[
    augroup http_files 
        au FileType httpResult set filetype=http
        au FileType http set commentstring=#\ %s
    augroup END
]])

vim.g.rest_nvim = { request = { skip_ssl_verification = true } }

return {
    "rest-nvim/rest.nvim",
    ft = "http",
}
