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

-- For multisession (subprocesses) https://github.com/mfussenegger/nvim-dap-python/pull/21
-- https://github.com/microsoft/debugpy/issues/655
-- until https://github.com/microsoft/debug-adapter-protocol/issues/79 is done
local root_session
local sessions = {}
local initialized_session_widget = nil

local function refresh_listeners(session)
    -- trigger other ui elements mainly from dapui to refresh
    -- when session is changed (listeners hooks)
    if not session then
        return
    end
    if session.current_frame then
        session:update_threads(function(...) end)
        session:request("scopes", { frameId = session.current_frame.id }, function() end)
        if session.stopped_thread_id then
            session:_frame_set(session.current_frame)
        else
            vim.fn.sign_unplace("dap_pos")
        end
    end
end

local sessions_widget = {
    refresh_listener = { "event_initialized", "event_stopped", "event_terminated", "event_continued", "event_pause" },
    new_buf = function()
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
        vim.api.nvim_buf_set_name(buf, "dap-sessions")
        vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "<Cmd>lua require('dap.ui').trigger_actions()<CR>", {})
        vim.api.nvim_buf_set_keymap(buf, "n", "<2-LeftMouse>", "<Cmd>lua require('dap.ui').trigger_actions()<CR>", {})
        return buf
    end,
    render = function(view)
        local layer = view.layer()
        local render_session = function(session)
            local suffix
            if session.current_frame then
                suffix = "Stopped at line " .. session.current_frame.line
            elseif session.stopped_thread_id then
                suffix = "Stopped"
            else
                suffix = "Running"
            end
            local config_name = (session.config or {}).name or "No name"
            local prefix = session == dap.session() and "→ " or "  "
            return prefix .. config_name .. " (" .. suffix .. ")"
        end
        local context = {}
        context.actions = {
            {
                label = "Activate session",
                fn = function(_, session)
                    if session and session ~= dap.session() then
                        dap.set_session(session)
                        if vim.bo.bufhidden == "wipe" then
                            view.close()
                        else
                            view.refresh()
                        end
                        refresh_listeners(session)
                    end
                end,
            },
        }
        layer.render(vim.tbl_keys(sessions), render_session, context, 0, -1)
    end,
}
dap.listeners.after["event_debugpyAttach"]["dap-python"] = function(_, config)
    local adapter = {
        host = config.connect.host,
        port = config.connect.port,
    }
    local session
    local connect_opts = {}
    if not initialized_session_widget then
        M.sessions_toggle()
    else
        initialized_session_widget.open()
    end
    session = require("dap.session"):connect(adapter, connect_opts, function(err)
        if err then
            vim.notify("Error connecting to subprocess session: " .. vim.inspect(err), vim.log.levels.WARN)
        elseif session then
            session:initialize(config)
        end
    end)
end

dap.listeners.after.event_initialized["dap-python"] = function(session)
    sessions[session] = true
    if not root_session then
        root_session = session
    else
        refresh_listeners(dap.session())
    end
end

-- hijack the dapui listeners to properly work with multiple sessions.
local dupui_listener_id = "dapui_state"
local dapui_scopes_func = dap.listeners.after.scopes[dupui_listener_id]
dap.listeners.after.scopes[dupui_listener_id] = function(session, ...)
    if session ~= dap.session() then
        return
    end
    dapui_scopes_func(session, ...)
end

local dapui_variables_func = dap.listeners.after.variables[dupui_listener_id]
dap.listeners.after.variables[dupui_listener_id] = function(session, ...)
    if session ~= dap.session() then
        return
    end
    dapui_variables_func(session, ...)
end

-- Cleanup sessions and close sessions widget.
local cleanup = function(session)
    sessions[session] = nil
    if session == root_session then
        root_session = nil
        M.sessions_close()
    elseif dap.session() == session or dap.session() == nil then
        dap.set_session(root_session)
        refresh_listeners(root_session)
    end
    M.sessions_refresh()
end

dap.listeners.after.event_exited["dap-python"] = cleanup
dap.listeners.after.event_terminated["dap-python"] = cleanup
dap.listeners.after.disconnected["dap-python"] = cleanup

-- this can be ignored
dap.listeners.after["event_debugpyWaitingForServer"]["dap-python"] = function(_, config) end

function M.sessions_toggle()
    if not initialized_session_widget then
        initialized_session_widget = dap_widgets.sidebar(sessions_widget, nil, "leftabove 30 vsplit")
    end

    initialized_session_widget.toggle()
end

function M.sessions_refresh()
    if initialized_session_widget then
        initialized_session_widget.refresh()
    end
end

function M.sessions_close()
    if initialized_session_widget then
        initialized_session_widget.close()
    end
    initialized_session_widget = nil
end

return M
