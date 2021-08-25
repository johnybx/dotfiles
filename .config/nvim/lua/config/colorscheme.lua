local utils = require("utils")

utils.opt("o", "termguicolors", true)

-- vim.g.onedark_style = 'warm'
-- vim.g.nightfox_italic_comments = true
-- vim.g.nightfox_style = "nordfox"
-- cmd("colorscheme nightfox")
local nightfox = require("nightfox")
nightfox.setup({
	fox = "nightfox",
	styles = {
		comments = "italic",
	},
})
nightfox.load()

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
