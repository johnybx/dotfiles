require("telescope").setup({
	defaults = {
		layout_strategy = "horizontal",
		layout_config = { horizontal = { width = 0.9, preview_width = 0.5 } },
		dynamic_preview_title = true,
	},
	pickers = {
		buffers = {
			mappings = {
				i = { ["<M-q>"] = require("telescope.actions").delete_buffer },
				n = { ["<M-q>"] = require("telescope.actions").delete_buffer },
			},
		},
	},
})
