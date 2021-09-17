local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		layout_strategy = "horizontal",
		layout_config = { horizontal = { width = 0.9, preview_width = 0.5 } },
		dynamic_preview_title = true,
		path_display = function(opts, path)
			if string.len(path) > 0.4 * vim.o.columns then
				return require("plenary.path"):new(path):shorten(3)
			end
			return path
		end,
		mappings = {
			i = { ["<C-s>"] = actions.select_horizontal },
			n = { ["<C-s>"] = actions.select_horizontal },
		},
	},
	pickers = {
		buffers = {
			mappings = {
				i = { ["<M-q>"] = actions.delete_buffer },
				n = { ["<M-q>"] = actions.delete_buffer },
			},
		},
	},
})
