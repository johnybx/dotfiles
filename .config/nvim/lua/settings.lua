vim.g.python3_host_prog = vim.fn.expand("~/.local/share/env/bin/python")
local utils = require("utils")

local cmd = vim.cmd
local indent = 4

vim.opt.updatetime = 500
vim.opt.spelllang = "en,cjk"
vim.opt.spellfile = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add")

cmd("syntax enable")
cmd("filetype plugin indent on")

utils.opt("b", "expandtab", true)
utils.opt("b", "shiftwidth", indent)
utils.opt("o", "autoindent", true)
utils.opt("b", "tabstop", indent)
utils.opt("o", "smarttab", true)
utils.opt("o", "hidden", true)
utils.opt("o", "ignorecase", true)
utils.opt("o", "scrolloff", 4)
utils.opt("o", "shiftround", true)
utils.opt("o", "smartcase", true)
utils.opt("o", "splitbelow", true)
utils.opt("o", "splitright", true)
utils.opt("o", "wildmode", "list:longest")
utils.opt("w", "number", true)
utils.opt("w", "relativenumber", true)
utils.opt("o", "clipboard", "unnamed,unnamedplus")
utils.opt("o", "completeopt", "menu,menuone,noselect")
utils.opt("o", "pumheight", 20)
utils.opt("o", "listchars", "tab:→\\ ,nbsp:␣,trail:•,eol:↲,precedes:«,extends:»")
utils.opt("b", "textwidth", 98)
-- support also letter lists (e.g. "a)" ) and unordered bullets
utils.opt("b", "formatlistpat", [[^\s*\(\d\+\|\w\{1,3\}\)[\]:.)}\t]\s\+\|^\s*[-+]\s\+]])
-- remove default 't' option
utils.opt("b", "formatoptions", "cqj")

-- fix for SQLComplete: The debxt plugin must be loaded for dynamic SQL completion
-- vim.g.omni_sql_default_compl_type = "syntax"
vim.g.omni_sql_no_default_maps = 1

cmd("autocmd FileType * setlocal shortmess+=c")
-- Options for files with FileType
cmd(
    "autocmd FileType * setlocal formatoptions-=t formatoptions-=o formatoptions+=c formatoptions+=r formatoptions+=l formatoptions+=n"
)

-- Startify + nvim-tree => do not save empty windows to session
-- TODO: https://github.com/kyazdani42/nvim-tree.lua/issues/488
cmd("set sessionoptions-=blank")

-- More precise diff
cmd("set diffopt+=linematch:60")

-- Highlight on yank
cmd("au TextYankPost * lua vim.highlight.on_yank {on_visual = false}")

-- yaml, json, markdown and similar should expand tab as 2 spaces
cmd("autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab")
cmd("autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab")
cmd("autocmd FileType markdown setlocal ts=2 sts=2 sw=2 expandtab nofoldenable comments=n:>")
cmd("autocmd FileType org setlocal ts=2 sts=2 sw=2 expandtab")
cmd("autocmd FileType norg setlocal ts=2 sts=2 sw=2 expandtab")

-- set correct file type for salt files
cmd([[
    augroup salt_file
        au BufNewFile,BufRead *.sls set filetype=sls.yaml
    augroup END
]])

-- Dockerfiles with extension like Dockerfile.dev and so on
cmd([[
    augroup dockerfile
        au BufNewFile,BufRead Dockerfile.*,dockerfile,dockerfile.* set filetype=dockerfile
    augroup END
]])

-- Automatically jump to the last place you've visited.
-- vim.api.nvim_create_autocmd('BufReadPost', {
--   callback = function()
--     local mark = vim.api.nvim_buf_get_mark(0, '"')
--     local lcount = vim.api.nvim_buf_line_count(0)
--     if mark[1] > 0 and mark[1] <= lcount then
--       pcall(vim.api.nvim_win_set_cursor, 0, mark)
--     end
--   end,
-- })
