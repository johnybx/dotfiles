vim.g.mkdp_echo_preview_url = 0
vim.g.mkdp_open_ip = "127.0.0.1"
vim.g.mkdp_port = "9999"
vim.g.mkdp_browserfunc = "MarkdownPreviewBrowserStart"

vim.api.nvim_exec2(
    [[
function! MarkdownPreviewBrowserStart(url)
    call v:lua.require'plugins.markdown_preview.open'.open_browser(a:url)
endfunction
]],
    { output = false }
)

return {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
    config = function()
        vim.fn["mkdp#util#install"]()
    end,
}
