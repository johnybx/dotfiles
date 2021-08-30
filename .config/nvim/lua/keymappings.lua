local utils = require("utils")

utils.map("", "<F3>", ":set invpaste paste?<CR>:%s/\\s\\+$//g<CR>")
utils.map("c", "w!!", "w !sudo tee > /dev/null %")
utils.map("n", "<A-x>", ":NvimTreeToggle<CR>")
utils.map("n", "<A-z>", ":NvimTreeFindFile<CR>")

-- Floating terminal
utils.map("n", "<A-d>", ":Lspsaga open_floaterm<CR>")
utils.map("t", "<A-d>", "<C-\\><C-n>:Lspsaga close_floaterm<CR>")

-- Better window movement
utils.map("n", "<A-h>", "<C-w>h", { silent = true })
utils.map("n", "<A-j>", "<C-w>j", { silent = true })
utils.map("n", "<A-k>", "<C-w>k", { silent = true })
utils.map("n", "<A-l>", "<C-w>l", { silent = true })

-- Resize
utils.map("n", "<C-h>", "<C-w><", { silent = true })
utils.map("n", "<C-l>", "<C-w>>", { silent = true })
utils.map("n", "<C-k>", "<C-w>+", { silent = true })
utils.map("n", "<C-j>", "<C-w>-", { silent = true })

-- Enter new line without breaking current one - this works only in alacritty or kitty because
-- the correct char is sent -> - { key: Return,   mods: Control, chars: "\x1b[13;5u" }
utils.map("i", "<C-Enter>", "<C-o>o", { silent = true })

-- Save file by CTRL-S
utils.map("n", "<C-s>", ":w<CR>", { silent = true })
utils.map("i", "<C-s>", "<ESC> :w<CR>", { silent = true })

-- Remove highlights
utils.map("n", "<CR>", '<cmd>let @/=""<CR><CR>', { silent = true })
utils.map("n", "<ESC>", '<ESC><cmd>let @/=""<CR>')
utils.map("n", "<leader>/", '<cmd>let @/=""<CR>', { silent = true })

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

-- Plugins

-- Telescope
utils.map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').git_files()<CR>", { silent = true })
utils.map("n", "<leader>fr", "<cmd>lua require('telescope.builtin').find_files()<CR>", { silent = true })
utils.map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", { silent = true })
utils.map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", { silent = true })
utils.map("n", "<leader>ft", "<cmd>lua require('telescope.builtin').help_tags()<CR>", { silent = true })
utils.map("n", "<leader>fe", "<cmd>lua require('telescope.builtin').file_browser()<CR>", { silent = true })
utils.map("n", "<leader>fc", "<cmd>lua require('telescope.builtin').git_bcommits()<CR>", { silent = true })
utils.map("n", "<leader>fs", "<cmd>lua require('telescope.builtin').git_status()<CR>", { silent = true })
utils.map("n", "<leader>fj", "<cmd>lua require('telescope.builtin').jumplist()<CR>", { silent = true })
utils.map("n", "<leader>fd", "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>", { silent = true })

-- LSP
utils.map("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true })
utils.map("n", "gd", "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", { silent = true })
utils.map("n", "<leader>gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", { silent = true })
utils.map("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", { silent = true })
utils.map("n", "gh", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", { silent = true })
utils.map("n", "<C-Space>", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", { silent = true })
utils.map("n", "<leader>ca", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", { silent = true })
utils.map("v", "<leader>ca", "<cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>", { silent = true })
utils.map("i", "<C-.>", "<Esc><cmd>lua require('lspsaga.codeaction').code_action()<CR>", { silent = true, expr = true })
utils.map("n", "<C-.>", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", { silent = true })
utils.map("n", "<leader>cr", "<cmd>lua require('lspsaga.rename').rename()<CR>", { silent = true })
utils.map("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", { silent = true })
utils.map("v", "<leader>cf", "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", { silent = true })
utils.map("n", "K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", { silent = true })
utils.map("n", "gs", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", { silent = true })
utils.map("n", "[d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", { silent = true })
utils.map("n", "]d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", { silent = true })
utils.map("n", "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", { silent = true })
utils.map("n", "<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", { silent = true })
utils.map("n", "<leader>cd", "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", { silent = true })

-- kommentary
vim.g.kommentary_create_default_mappings = false
utils.map("n", "<C-_>", "<Plug>kommentary_line_default", { noremap = false })
utils.map("n", "gc", "<Plug>kommentary_motion_default", { noremap = false })
utils.map("v", "<C-_>", "<Plug>kommentary_visual_default<C-c>", { noremap = false })

-- Trouble
utils.map("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true })
utils.map("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", { silent = true })
utils.map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", { silent = true })
utils.map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true })
utils.map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true })
utils.map("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true })

-- Illuminate
utils.map("n", "<a-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>')
utils.map("n", "<a-p>", '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>')

-- https://github.com/kristijanhusak/vim-dadbod-ui
-- Unmap C-k, C-j in dbui
vim.cmd("autocmd FileType dbui nunmap <buffer> <c-j>")
vim.cmd("autocmd FileType dbui nunmap <buffer> <c-k>")

-- Easy Align
utils.map("n", "ga", "<Plug>(EasyAlign)", { noremap = false })
utils.map("x", "ga", "<Plug>(EasyAlign)", { noremap = false })
