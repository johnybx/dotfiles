vim.g.skip_ts_context_commentstring_module = true
local supported_languages = {
    "bash",
    "c",
    "cmake",
    "comment",
    "commonlisp",
    "cpp",
    "css",
    "dockerfile",
    "dot",
    "fish",
    "go",
    "graphql",
    "hjson",
    "html",
    "http",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "julia",
    "latex",
    "llvm",
    "lua",
    "make",
    "markdown",
    "pascal",
    "perl",
    "php",
    "phpdoc",
    "python",
    "query",
    "r",
    "regex",
    "ruby",
    "rust",
    "scala",
    "scss",
    "todotxt",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
    "helm",
}

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    -- event = "VeryLazy",
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            branch = "main",
            config = function()
                require("nvim-treesitter-textobjects").setup({
                    select = {
                        lookahead = true,
                    },
                    move = {
                        set_jumps = true,
                    },
                })

                -- Keymaps
                -- Select
                vim.keymap.set({ "x", "o" }, "af", function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
                end)
                vim.keymap.set({ "x", "o" }, "if", function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
                end)
                vim.keymap.set({ "x", "o" }, "ac", function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
                end)
                vim.keymap.set({ "x", "o" }, "ic", function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
                end)
                vim.keymap.set({ "x", "o" }, "am", function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@comment.outer", "textobjects")
                end)
                vim.keymap.set({ "x", "o" }, "ar", function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
                end)
                vim.keymap.set({ "x", "o" }, "ir", function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
                end)
                vim.keymap.set({ "x", "o" }, "al", function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects")
                end)
                vim.keymap.set({ "x", "o" }, "il", function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects")
                end)
                vim.keymap.set({ "x", "o" }, "at", function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@statement.outer", "textobjects")
                end)
                vim.keymap.set({ "x", "o" }, "ak", function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@call.outer", "textobjects")
                end)
                vim.keymap.set({ "x", "o" }, "ik", function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@call.inner", "textobjects")
                end)
                vim.keymap.set({ "x", "o" }, "ao", function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects")
                end)
                vim.keymap.set({ "x", "o" }, "io", function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects")
                end)

                -- Move
                vim.keymap.set({ "n", "x", "o" }, "]]", function()
                    require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "]a", function()
                    require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "]p", function()
                    require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "]k", function()
                    require("nvim-treesitter-textobjects.move").goto_next_start("@call.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "]v", function()
                    require("nvim-treesitter-textobjects.move").goto_next_start("@assignment.outer", "textobjects")
                end)

                vim.keymap.set({ "n", "x", "o" }, "][", function()
                    require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "]A", function()
                    require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "]P", function()
                    require("nvim-treesitter-textobjects.move").goto_next_end("@parameter.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "]K", function()
                    require("nvim-treesitter-textobjects.move").goto_next_end("@call.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "]V", function()
                    require("nvim-treesitter-textobjects.move").goto_next_end("@assignment.outer", "textobjects")
                end)

                vim.keymap.set({ "n", "x", "o" }, "[[", function()
                    require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "[a", function()
                    require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "[p", function()
                    require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "[k", function()
                    require("nvim-treesitter-textobjects.move").goto_previous_start("@call.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "[v", function()
                    require("nvim-treesitter-textobjects.move").goto_previous_start("@assignment.outer", "textobjects")
                end)

                vim.keymap.set({ "n", "x", "o" }, "[]", function()
                    require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "[A", function()
                    require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "[P", function()
                    require("nvim-treesitter-textobjects.move").goto_previous_end("@parameter.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "[K", function()
                    require("nvim-treesitter-textobjects.move").goto_previous_end("@call.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "[V", function()
                    require("nvim-treesitter-textobjects.move").goto_previous_end("@assignment.outer", "textobjects")
                end)

                -- Swap
                vim.keymap.set({ "n", "x", "o" }, "<leader>sp", function()
                    require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "<leader>sf", function()
                    require("nvim-treesitter-textobjects.swap").swap_next("@function.outer", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "<leader>sP", function()
                    require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner", "textobjects")
                end)
                vim.keymap.set({ "n", "x", "o" }, "<leader>sF", function()
                    require("nvim-treesitter-textobjects.swap").swap_previous("@function.outer", "textobjects")
                end)

                -- local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
                -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
                -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
            end,
        },
        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            opts = { enable = true, enable_autocmd = false },
        },
        "OXY2DEV/markview.nvim",
    },
    config = function()
        require("nvim-treesitter").install(supported_languages)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = supported_languages,
            callback = function(ev)
                vim.treesitter.start(ev.buf)
                if ev.match == "markdown" then
                    vim.bo[ev.buf].syntax = "ON" -- only if additional legacy syntax is needed
                end
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
