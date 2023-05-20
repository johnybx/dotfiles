return {
    {
        "mfussenegger/nvim-dap",
        cmd = { "DapContinue", "DapShowLog", "DapLoadLaunchJSON" },
        dependencies = { "mfussenegger/nvim-dap-python", "rcarriga/nvim-dap-ui" },
        config = function()
            require("plugins.dap.dap-python")
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        lazy = true,
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("plugins.dap.dap-ui")
        end,
    },
    { "mfussenegger/nvim-dap-python", lazy = true, dependencies = { "mfussenegger/nvim-dap", "tpope/vim-dotenv" } },
}
