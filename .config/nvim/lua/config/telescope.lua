local actions = require("telescope.actions")
local layout = require("telescope.actions.layout")

local function normalize_path(path)
    return require("plenary.path"):new(path):make_relative(vim.loop.cwd())
end

require("telescope").setup({
    defaults = {
        -- preview = { hide_on_startup = true },
        layout_strategy = "horizontal",
        layout_config = { horizontal = { width = 0.9, preview_width = 0.5 } },
        dynamic_preview_title = true,
        path_display = function(opts, path)
            path = normalize_path(path)
            if string.len(path) > 0.4 * vim.o.columns then
                path = require("plenary.path"):new(path):shorten(3)
            end
            return path
        end,
        mappings = {
            n = {
                ["<C-s>"] = actions.select_horizontal,
                ["<C-h>"] = layout.toggle_preview,
                -- ["<C-j>"] = actions.toggle_results_and_prompt,
            },
            i = {
                ["<C-s>"] = actions.select_horizontal,
                ["<C-h>"] = layout.toggle_preview,
                -- ["<C-j>"] = actions.toggle_results_and_prompt,
            },
        },
    },
    pickers = {
        buffers = {
            mappings = {
                i = { ["<M-q>"] = actions.delete_buffer },
                n = { ["<M-q>"] = actions.delete_buffer },
            },
        },
        jumplist = {
            layout_strategy = "vertical",
            layout_config = {
                width = 0.9,
                height = 0.95,
                preview_height = 0.4,
            },
            path_display = function(opts, path)
                path = normalize_path(path)
                if string.len(path) > 0.5 * vim.o.columns then
                    path = require("plenary.path"):new(path):shorten(3)
                end
                return path
            end,
        },
        live_grep = {
            layout_strategy = "vertical",
            layout_config = {
                width = 0.9,
                height = 0.95,
                preview_height = 0.4,
            },
        },
        grep_string = {
            layout_strategy = "vertical",
            layout_config = {
                width = 0.9,
                height = 0.95,
                preview_height = 0.4,
            },
        },
        lsp_references = {
            layout_strategy = "vertical",
            layout_config = {
                width = 0.9,
                height = 0.95,
                preview_height = 0.4,
            },
            path_display = function(opts, path)
                path = normalize_path(path)
                if string.len(path) > 0.5 * vim.o.columns then
                    path = require("plenary.path"):new(path):shorten(3)
                end
                return path
            end,
        },
    },
})

-- Extensions
require("telescope").load_extension("file_browser")
