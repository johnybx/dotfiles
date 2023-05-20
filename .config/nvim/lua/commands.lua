vim.cmd(':command Isort execute "%!isort -q --profile black --stdout -"')
vim.cmd(':command AutoFormatToggle execute "lua require(\\"plugins.lsp.formatting\\").toggle()"')
