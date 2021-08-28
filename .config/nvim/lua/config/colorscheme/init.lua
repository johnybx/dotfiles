---@diagnostic disable: unused-local
local utils = require("utils")
utils.opt("o", "termguicolors", true)

local onedark = require("config.colorscheme.onedark")
local nightfox = require("config.colorscheme.nightfox")
local catppuccino = require("config.colorscheme.catppuccino")

nightfox.setup()
-- catppuccino.setup()

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
