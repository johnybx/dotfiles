return {
    "kylechui/nvim-surround",
    opts = {
        surrounds = {
            ["d"] = {
                add = function()
                    local config = require("nvim-surround.config")
                    local result = config.get_input('Enter surround characters (default: """): ')
                    if result ~= "" then
                        return { { result }, { result } }
                    else
                        return { { '"""' }, { '"""' } }
                    end
                end,
            },
        },
    },
    event = "VeryLazy",
    version = "*",
}
