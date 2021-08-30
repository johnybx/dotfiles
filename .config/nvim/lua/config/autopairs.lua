require("nvim-autopairs").setup({
	enable_check_bracket_line = false,
	disable_filetype = { "TelescopePrompt", "vim", "NvimTree" },
	ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
	fast_wrap = {},
	check_ts = false,
})

-- require("nvim-autopairs.completion.compe").setup({
-- 	map_cr = true, --  map <CR> on insert mode
-- 	map_complete = true, -- it will auto insert `(` after select function or method item
-- })

local status, _ = pcall(require, "cmp")
if status then
	require("nvim-autopairs.completion.cmp").setup({
		map_cr = true, --  map <CR> on insert mode
		map_complete = true, -- it will auto insert `(` after select function or method item
		auto_select = false,
	})
end
