return {
    "akinsho/toggleterm.nvim",
    branch = "main",
    keys = {
        { "<M-d>", nil, desc = "Toggle Term" },
    },
    cmd = "ToggleTerm",
    opts = {
        -- size can be a number or function which is passed the current terminal
        size = function(term)
            if term.direction == "float" then
                return vim.o.columns * 0.8
            end
            return vim.o.lines * 0.4
        end,
        open_mapping = [[<M-d>]],
        hide_numbers = false, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        persist_size = true,
        direction = "float",
        close_on_exit = true, -- close the terminal window when the process exits
        shell = vim.o.shell, -- change the default shell
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
            -- The border key is *almost* the same as 'nvim_open_win'
            -- see :h nvim_open_win for details on borders however
            -- the 'curved' border is a custom border type
            -- not natively supported but implemented in this plugin.
            border = "single",
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
            winblend = 0,
            highlights = {
                border = "Normal",
                background = "Normal",
            },
        },
    },
}
