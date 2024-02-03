return {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        -- Treesitter queries are not perfect for example regex code in python
        -- `r = re.compile(r"^([a-zA-Z0-9_$]{2,}|\*)$")` or multiple chained commands in lua in
        -- vim.cmd in autocmd (at the end of keymappings.lua) cause errors. Prevent reporting
        -- every treesitter query problem - these does not cause ( most often ) any visible or
        -- usability issues at all ( after all these are just colors of paranteses.
        local setup = require("rainbow-delimiters.setup")
        local lib = require("rainbow-delimiters.lib")
        local get_query = lib.get_query
        lib.get_query = function(lang)
            local status, result = pcall(get_query, lang)
            if status then
                return result
            end
            return nil
        end
        setup.setup({
            log = {
                level = vim.log.levels.OFF,
            },
        })
    end,
}
