local formatTab = require("luatab").formatTab
local extract_highlight_colors = require("luatab.highlight").extract_highlight_colors

local function tabline()
	local i = 1
	local line = ""
	local selected = vim.fn.tabpagenr()
	while i <= vim.fn.tabpagenr("$") do
		local hl = (selected == i and "%#TabNumSel#" or "%#TabNum#")
		line = line .. hl .. " " .. i .. ":" .. formatTab(i)
		i = i + 1
	end
	return line .. "%T%#TabLineFill#%="
end

local M = {
	tabline = tabline,
}

local bg = extract_highlight_colors("TabLine", "bg")
local bg_sel = extract_highlight_colors("TabLineSel", "bg")
local fg = "#dd7f47"

vim.cmd("hi TabNum term=bold guifg=" .. fg .. " guibg=" .. bg)
vim.cmd("hi TabNumSel term=bold guifg=" .. fg .. " guibg=" .. bg_sel)

vim.o.tabline = "%!v:lua.require'config.luatab'.tabline()"

return M
