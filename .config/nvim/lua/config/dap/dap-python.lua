local dap = require("dap")
local dap_widgets = require("dap.ui.widgets")
local dap_python = require("dap-python")
local M = {}

dap_python.setup("~/.local/share/env/bin/python")

local local_root = "${workspaceFolder}"
local remote_root = "."

table.insert(dap.configurations.python, {
    type = "python",
    request = "attach",
    name = "Attach remote docker",
    connect = function()
        local env_config = vim.fn["DotenvRead"](".debugpy.env")
        local host = env_config["DEBUGPY_HOST"]
        local port = env_config["DEBUGPY_PORT"]
        host = host or vim.fn.input("Host [127.0.0.1]: ")
        host = host ~= "" and host or "127.0.0.1"
        port = port or tonumber(vim.fn.input("Port [5678]: ")) or 5678
        return {
            host = host,
            port = port,
        }
    end,
    pathMappings = function()
        local env_config = vim.fn["DotenvRead"](".debugpy.env")
        return {
            {
                localRoot = env_config["DEBUGPY_LOCAL_ROOT"] or local_root,
                remoteRoot = env_config["DEBUGPY_REMOTE_ROOT"] or remote_root,
            },
        }
    end,
})

return M
