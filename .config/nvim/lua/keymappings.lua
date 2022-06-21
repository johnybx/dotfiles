local utils = require("utils")

utils.map("", "<F3>", ":set invpaste paste?<CR>:%s/\\s\\+$//g<CR>")
utils.map("c", "w!!", "w !sudo tee > /dev/null %")
utils.map("n", "<A-x>", ":NvimTreeToggle<CR>")
utils.map("n", "<A-z>", ":NvimTreeFindFile<CR>")

-- Better window movement
utils.map("n", "<A-h>", "<C-w>h", { silent = true })
utils.map("n", "<A-j>", "<C-w>j", { silent = true })
utils.map("n", "<A-k>", "<C-w>k", { silent = true })
utils.map("n", "<A-l>", "<C-w>l", { silent = true })

-- Move lines
utils.map("n", "<C-j>", ":m .+1<CR>==", { silent = true })
utils.map("n", "<C-k>", ":m .-2<CR>==", { silent = true })
utils.map("i", "<C-j>", "<Esc>:m .+1<CR>==gi", { silent = true })
utils.map("i", "<C-k>", "<Esc>:m .-2<CR>==gi", { silent = true })
utils.map("v", "<C-j>", ":m '>+1<CR>gv=gv", { silent = true })
utils.map("v", "<C-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- Resize
utils.map("n", "<leader>h", "<C-w><", { silent = true })
utils.map("n", "<leader>l", "<C-w>>", { silent = true })
utils.map("n", "<leader>k", "<C-w>+", { silent = true })
utils.map("n", "<leader>j", "<C-w>-", { silent = true })

utils.map("n", "<A-S-h>", "5<C-w><", { silent = true })
utils.map("n", "<A-S-l>", "5<C-w>>", { silent = true })
utils.map("n", "<A-S-k>", "5<C-w>+", { silent = true })
utils.map("n", "<A-S-j>", "5<C-w>-", { silent = true })

-- Enter new line without breaking current one - this works only in alacritty or kitty because
-- the correct char is sent -> - { key: Return,   mods: Control, chars: "\x1b[13;5u" }
-- utils.map("i", "<C-Enter>", "<C-o>o", { silent = true })

-- Save file by CTRL-S
utils.map("n", "<C-s>", ":w<CR>", { silent = true })
utils.map("i", "<C-s>", "<ESC> :w<CR>", { silent = true })

-- Remove highlights
utils.map("n", "<CR>", '<cmd>let @/=""<CR><CR>', { silent = true })
utils.map("n", "<ESC>", '<ESC><cmd>let @/=""<CR>')
utils.map("n", "<leader>/", '<cmd>let @/=""<CR>', { silent = true })

-- Show hidden characters
utils.map("n", "<leader>h", "<cmd>if &list == 0 |  set list | else | set nolist | endif<CR>")

-- Tabs - <C-Tab> does not work
utils.map("n", "<S-Tab>", ":tabnext<CR>", { silent = true })
utils.map("n", "<leader><S-Tab>", ":tabprevious<CR>", { silent = true })
-- utils.map("n", "<C-S-Tab>", ":tabmove<CR>", { silent = true })
-- utils.map("n", "<leader><C-S-Tab>", ":tabrewind<CR>", { silent = true })
utils.map("n", "<S-q>", ":tabclose<CR>", { silent = true })

-- Buffers
utils.map("n", "<A-Tab>", ":bprevious<CR>", { silent = true })
utils.map("n", "<leader><A-Tab>", ":bnext<CR>", { silent = true })
utils.map("n", "<A-q>", ":Bdelete<CR>", { silent = true })

-- Terminal mode
utils.map("t", "<A-h>", "<C-\\><C-N><C-w>h", { silent = true })
utils.map("t", "<A-j>", "<C-\\><C-N><C-w>j", { silent = true })
utils.map("t", "<A-k>", "<C-\\><C-N><C-w>k", { silent = true })
utils.map("t", "<A-l>", "<C-\\><C-N><C-w>l", { silent = true })

-- Spell
utils.map("n", "<F11>", "<cmd>lua vim.wo.spell = not vim.wo.spell<CR>")

-- Plugins

-- Telescope
utils.map("n", "<leader>tr", "<cmd>lua require('telescope.builtin').resume()<CR>", { silent = true })
utils.map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').git_files()<CR>", { silent = true })
utils.map("n", "<leader>fr", "<cmd>lua require('telescope.builtin').find_files({hidden = true})<CR>", { silent = true })
utils.map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", { silent = true })
utils.map("n", "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string()<CR>", { silent = true })
utils.map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", { silent = true })
utils.map("n", "<leader>ft", "<cmd>lua require('telescope.builtin').help_tags()<CR>", { silent = true })
utils.map(
    "n",
    "<leader>fe",
    "<cmd>lua require('telescope').extensions.file_browser.file_browser({ respect_gitignore = false })<CR>",
    { silent = true }
)
utils.map("n", "<leader>fc", "<cmd>lua require('telescope.builtin').git_bcommits()<CR>", { silent = true })
utils.map("n", "<leader>fs", "<cmd>lua require('telescope.builtin').git_status()<CR>", { silent = true })
utils.map("n", "<leader>fj", "<cmd>lua require('telescope.builtin').jumplist()<CR>", { silent = true })
utils.map("n", "<leader>fd", "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>", { silent = true })
utils.map("n", "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<CR>", { silent = true })

-- ¯\_(ツ)_/¯
utils.map("i", ",shrug", "¯\\_(ツ)_/¯", { silent = true })

-- LSP - TODO: these should be mapped only if there is active LSP
-- Border styl - not really mapping but diagnostics need also style here anyway so at least it is
-- in one place.
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})
--------------------
utils.map("n", "gD", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", { silent = true })
utils.map(
    "n",
    "gd",
    "<cmd>lua require('config.lsp.preview_definition').open('textDocument/definition', 'LSP Definitions')<CR>",
    { silent = true }
)
utils.map("n", "<leader>gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", { silent = true })
utils.map("n", "<leader>gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", { silent = true })
utils.map("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", { silent = true })
utils.map(
    "n",
    "<leader>ca",
    "<cmd>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor({winblend=10}))<CR>",
    { silent = true }
)
-- TODO: using lua require current visual range as parameter.
utils.map("v", "<leader>ca", "<cmd>Telescope lsp_range_code_actions themes=get_cursor<CR>", { silent = true })
utils.map(
    "n",
    "<C-.>",
    "<cmd>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor({winblend=10}))<CR>",
    { silent = true }
)
utils.map("n", "<leader>cl", "<cmd>lua vim.lsp.codelens.run()<CR>", { silent = true })
utils.map("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = true })
utils.map("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", { silent = true })
utils.map("v", "<leader>cf", "<cmd>'<,'>lua vim.lsp.buf.range_formatting()<CR>", { silent = true })
utils.map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true })
utils.map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { silent = true })
utils.map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded' }})<CR>", { silent = true })
utils.map("n", "]d", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded' }})<CR>", { silent = true })
utils.map(
    "n",
    "<leader>cd",
    "<cmd>lua vim.diagnostic.open_float(0, {scope='line', border = 'rounded'})<CR>",
    { silent = true }
)

-- kommentary
vim.g.kommentary_create_default_mappings = false
utils.map("n", "<C-_>", "<Plug>kommentary_line_default", { noremap = false })
utils.map("n", "gc", "<Plug>kommentary_motion_default", { noremap = false })
utils.map("v", "<C-_>", "<Plug>kommentary_visual_default<C-c>", { noremap = false })

-- Trouble
utils.map("n", "<leader>xx", "<cmd>Trouble<CR>", { silent = true })
utils.map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>", { silent = true })
utils.map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<CR>", { silent = true })
utils.map("n", "<leader>xl", "<cmd>Trouble loclist<CR>", { silent = true })
utils.map("n", "<leader>xq", "<cmd>Trouble quickfix<CR>", { silent = true })
utils.map("n", "gR", "<cmd>Trouble lsp_references<CR>", { silent = true })

-- Illuminate
utils.map("n", "<a-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<CR>')
utils.map("n", "<a-p>", '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>')

-- https://github.com/kristijanhusak/vim-dadbod-ui
-- Unmap C-k, C-j in dbui
vim.cmd("autocmd FileType dbui nunmap <buffer> <c-j>")
vim.cmd("autocmd FileType dbui nunmap <buffer> <c-k>")
utils.map("n", "<leader>db", "<cmd>DBUIToggle<CR>")

-- Easy Align
utils.map("n", "ga", "<Plug>(EasyAlign)", { noremap = false })
utils.map("x", "ga", "<Plug>(EasyAlign)", { noremap = false })

-- Diffview
utils.map("n", "<leader>go", "<cmd>DiffviewOpen<CR>", { silent = true })
utils.map("n", "<leader>g<Space>", ":DiffviewOpen<Space>")
utils.map("n", "<leader>gf", "<cmd>DiffviewFileHistory<CR>", { silent = true })
utils.map("n", "<leader>gc", "<cmd>DiffviewClose<CR>", { silent = true })

-- Markdown preview
utils.map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>")
-- Markdown Glow
utils.map("n", "<leader>mg", "<cmd>Glow<CR>")

-- Tests / Debug
-- Neotest
utils.map("n", "<leader>ts", '<cmd>lua require("neotest").summary.toggle()<CR>', { noremap = false })
utils.map("n", "<leader>tf", '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { noremap = false })
utils.map("n", "<leader>tn", '<cmd>lua require("neotest").run.run()<CR>', { noremap = false })
utils.map("n", "<leader>to", '<cmd>lua require("neotest").output.open()<CR>', { noremap = false })
utils.map("n", "<leader>tj", '<cmd>lua require("neotest").output.open({ enter = true })<CR>', { noremap = false })
utils.map("n", "]t", '<cmd>lua require("neotest").jump.prev({ status = "failed" })<CR>', { noremap = false })
utils.map("n", "[t", '<cmd>lua require("neotest").jump.next({ status = "failed" })<CR>', { noremap = false })

-- HTTP requests
vim.cmd([[
     augroup HTTPRequests
         autocmd! * <buffer>
         autocmd FileType http nmap <buffer> <CR> <Plug>RestNvim
         autocmd FileType http nmap <buffer> <A-CR> <Plug>RestNvimPreview
         autocmd FileType http nnoremap <buffer> <C-S> <cmd>lua c=require("rest-nvim.config");c.set({skip_ssl_verification = not c.get("skip_ssl_verification")});print("ssl verification: "..tostring(c.get("skip_ssl_verification")))<CR>
     augroup END
]])
