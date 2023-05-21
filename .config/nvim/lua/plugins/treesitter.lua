return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/playground",
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { -- one of "all", "maintained" (parsers with maintainers), or a list of language
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
                "jsonc",
                "julia",
                "latex",
                "llvm",
                "lua",
                "make",
                "markdown",
                "org",
                "norg",
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
            },
            ignore_install = {}, -- List of parsers to ignore installing
            highlight = {
                enable = true, -- false will disable the whole extension
                disable = {}, -- list of language that will be disabled
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = { "org" },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
            -- seems that this quite break indentation
            indent = {
                enable = false,
                disable = { "yaml" },
            },
            rainbow = {
                enable = true,
                extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = 5000, -- Do not enable for files with more than 1000 lines, int
            },
            textobjects = {
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["am"] = "@comment.outer",
                        ["ar"] = "@parameter.outer",
                        ["ir"] = "@parameter.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["at"] = "@statement.outer",
                        ["ak"] = "@call.outer",
                        ["ik"] = "@call.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]]"] = "@function.outer",
                        ["]a"] = "@class.outer",
                        ["]p"] = "@parameter.outer",
                    },
                    goto_next_end = {
                        ["]["] = "@function.outer",
                        ["]A"] = "@class.outer",
                        ["]P"] = "@parameter.outer",
                    },
                    goto_previous_start = {
                        ["[["] = "@function.outer",
                        ["[a"] = "@class.outer",
                        ["[p"] = "@parameter.outer",
                    },
                    goto_previous_end = {
                        ["[]"] = "@function.outer",
                        ["[A"] = "@class.outer",
                        ["[P"] = "@parameter.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>sp"] = "@parameter.inner",
                        ["<leader>sf"] = "@function.outer",
                    },
                    swap_previous = {
                        ["<leader>sP"] = "@parameter.inner",
                        ["<leader>sF"] = "@function.outer",
                    },
                },
                lsp_interop = {
                    enable = true,
                    border = "none",
                    peek_definition_code = {
                        ["<leader>df"] = "@function.outer",
                        ["<leader>dF"] = "@class.outer",
                    },
                },
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = "o",
                        toggle_hl_groups = "i",
                        toggle_injected_languages = "t",
                        toggle_anonymous_nodes = "a",
                        toggle_language_display = "I",
                        focus_language = "f",
                        unfocus_language = "F",
                        update = "R",
                        goto_node = "<cr>",
                        show_help = "?",
                    },
                },
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
            autopairs = { enable = true },
        })
    end,
}