local saga = require("lspsaga")

saga.init_lsp_saga({
	code_action_icon = "💡",
	code_action_prompt = {
		enable = true,
		sign = true,
		sign_priority = 20,
		virtual_text = false,
	},
	code_action_keys = { quit = { "q", "<ESC>" }, exec = "<CR>" },
	border_style = "round",
	max_preview_lines = 100,
	definition_preview_icon = "  ",
})
