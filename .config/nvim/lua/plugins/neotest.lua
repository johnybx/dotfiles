local group = vim.api.nvim_create_augroup("NeotestConfig", {})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "neotest-output",
    group = group,
    callback = function(opts)
        vim.keymap.set("n", "q", function()
            pcall(vim.api.nvim_win_close, 0, true)
        end, {
            buffer = opts.buf,
        })
    end,
})

return {
    {
        "nvim-neotest/neotest",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-python",
            "nvim-neotest/neotest-plenary",
        },
        opts = function()
            return {
                adapters = {
                    require("neotest-python")({ pytest_discover_instances = true }),
                    require("neotest-plenary"),
                },
                output = { open_on_run = false },
                quickfix = {
                    open = false,
                },
                discovery = {
                    filter_dir = function(name, rel_path, root)
                        local ignore_dirs = {
                            "venv",
                            "env",
                            "__pycache__",
                            "build",
                            "dist",
                            ".",
                            -- ".tox",
                            -- ".git",
                            -- ".pytype",
                            -- ".mypy_cache",
                        }
                        for _, ignore_dir in ipairs(ignore_dirs) do
                            if name:sub(1, #ignore_dir) == ignore_dir then
                                return false
                            end
                        end
                        return true
                    end,
                },
            }
        end,
    },
}
