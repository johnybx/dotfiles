vim.g.mkdp_echo_preview_url = 0
vim.g.mkdp_open_ip = "127.0.0.1"
vim.g.mkdp_port = "9999"
vim.g.mkdp_browserfunc = "MarkdownPreviewBrowserStart"

local Job = require("plenary.job")

local M = {}

function M.open_browser(url)
    if not vim.bo[vim.api.nvim_get_current_buf()].filetype == "markdown" then
        return
    end
    if M.job then
        M.stop_browser()
    end

    local current_window = vim.api.nvim_get_current_win()
    local scrolloff = vim.wo[current_window].scrolloff
    M.job = Job:new({
        command = "/usr/bin/firefox",
        args = { "--no-remote", "-P", "default", "--class", "markdown-preview", url },
        cwd = "/usr/bin",
        on_exit = vim.schedule_wrap(function()
            M.job = nil
            vim.wo[current_window].scrolloff = scrolloff
        end),
    })
    M.job:start()

    -- keep cursor in the middle
    vim.wo[current_window].scrolloff = 999
end

function M.close_browser()
    if not M.job then
        return
    end
    local pid = M.job.pid
    M.job:shutdown()
    -- https://github.com/nvim-lua/plenary.nvim/issues/156
    vim.loop.kill(pid, vim.loop.constants.SIGQUIT)
end

function M.toggle_browser()
    if not vim.bo[vim.api.nvim_get_current_buf()].filetype == "markdown" then
        return
    end

    if M.job then
        M.close_browser()
    else
        vim.api.nvim_exec("MarkdownPreview", false)
    end
end

vim.api.nvim_exec(
    [[
function! MarkdownPreviewBrowserStart(url)
    call v:lua.require'config.markdown_preview'.open_browser(a:url)
endfunction
]],
    false
)

return M
