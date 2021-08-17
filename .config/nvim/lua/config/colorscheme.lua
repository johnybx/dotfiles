local utils = require("utils")
local cmd = vim.cmd

utils.opt("o", "termguicolors", true)
-- vim.g.onedark_style = 'warm'

cmd("colorscheme onedark")

-- Explicitly set these for yaml and json because some themes break syntax highlighting for example nord + yaml
cmd("autocmd FileType yaml colorscheme onedark")
cmd("autocmd FileType json colorscheme onedark")

-- Nice undercurl
vim.api.nvim_exec(
	[[
	hi LspDiagnosticsUnderlineWarning gui=undercurl guisp=#e0af68
	hi LspDiagnosticsUnderlineError gui=undercurl guisp=#db4b4b
	hi LspDiagnosticsUnderlineHint gui=undercurl guisp=#1abc9c
	hi LspDiagnosticsUnderlineInformation gui=undercurl guisp=#0db9d7
    hi SpellBad gui=undercurl
    hi SpellCap gui=undercurl
    hi SpellLocal gui=undercurl
    hi SpellRare gui=undercurl
    ]],
	false
)
