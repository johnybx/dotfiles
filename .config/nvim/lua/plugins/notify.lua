return {
    "rcarriga/nvim-notify",
    config = function()
        require("notify").setup({ background_colour = "#000000" })

        local log = require("plenary.log").new({
            plugin = "notify",
            level = "debug",
            use_console = "async",
        })

        vim.notify = function(msg, level, opts)
            log.info(msg, level, opts)
            if string.match(msg or "", "Defaulting to position encoding of the first client") then
                return
            end
            require("notify")(msg, level, opts)
        end
    end,
}
