require("kommentary.config").configure_language("default", {
    prefer_single_line_comments = true,
    use_consistent_indentation = true,
    ignore_whitespace = true,
    hook_function = function()
        require("ts_context_commentstring.internal").update_commentstring({})
    end,
})
