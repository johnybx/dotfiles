-- Isort command for python files - null_ls does not support chain of formatters yet
vim.cmd(':command Isort execute "%!isort -q --profile black --stdout -"')
vim.cmd(':command AutoSaveToggle execute "lua require(\\"config.lsp.formatting\\").toggle()"')
