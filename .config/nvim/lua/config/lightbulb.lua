require("nvim-lightbulb").update_lightbulb({
	sign = {
		enabled = true,
		-- Priority of the gutter sign
		priority = 10,
	},
	float = {
		enabled = false,
	},
	virtual_text = {
		enabled = false,
	},
	status_text = {
		enabled = false,
	},
})
vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
