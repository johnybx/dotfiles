---@diagnostic disable: missing-fields
return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "f3fora/cmp-spell",
            "rcarriga/cmp-dap",
            "tzachar/cmp-tabnine",
            "Exafunction/codeium.nvim",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local types = require("cmp.types")
            local lspkind = require("lspkind")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local function tab_complete(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                    -- elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                    --     vim.fn.feedkeys(t("<C-j>"), "")
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end

            local function s_tab_complete(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()

                    -- elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                    -- vim.fn.feedkeys(t("<C-k>"), "")
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end

            cmp.setup({
                mapping = {
                    ["<Down>"] = {
                        i = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
                    },
                    ["<Up>"] = {
                        i = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
                    },
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }),
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete({}),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-q>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                    ["<Tab>"] = cmp.mapping(tab_complete, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(s_tab_complete, { "i", "s" }),
                },
                formatting = {
                    format = function(entry, vim_item)
                        local sources = {
                            nvim_lsp = "[LSP]",
                            nvim_lua = "[Lua]",
                            path = "[Path]",
                            buffer = "[Buffer]",
                            luasnip = "[LuaSnip]",
                            ultisnips = "[UltiSnips]",
                            calc = "[Calc]",
                            orgmode = "[Orgmode]",
                            emoji = "[Emoji]",
                            ["vim-dadbod-completion"] = "[Dadbod]",
                            spell = "[Spell]",
                            dap = "[Dap]",
                            neorg = "[Neorg]",
                            cmp_tabnine = "[Tabnine]",
                            codeium = "[Codeium]",
                            cody = "[Cody]",
                        }
                        if lspkind.symbol_map[vim_item.kind] then
                            vim_item.kind = lspkind.symbol_map[vim_item.kind] .. "  " .. vim_item.kind
                        end
                        vim_item.menu = sources[entry.source.name] or entry.source.name
                        local maxwidth = 80
                        vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
                        return vim_item
                    end,
                },
                snippet = {
                    expand = function(args)
                        -- vim.fn["UltiSnips#Anon"](args.body)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = { documentation = {
                    border = "rounded",
                } },
                confirmation = {
                    default_behavior = types.cmp.ConfirmBehavior.Replace,
                },
                preselect = types.cmp.PreselectMode.Item,
                sources = cmp.config.sources({
                    { name = "codeium" },
                    { name = "cmp_tabnine" },
                    { name = "cody" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "path" },
                    { name = "vim-dadbod-completion" },
                    { name = "neorg" },
                    { name = "buffer", keyword_length = 3 },
                    { name = "luasnip" },
                    { name = "spell" },
                    { name = "emoji" },
                    { name = "calc" },
                    { name = "orgmode" },
                }),
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.recently_used,
                        cmp.config.locality,
                        cmp.config.scopes,
                        cmp.config.compare.length,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.order,
                    },
                },
                enabled = function()
                    return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
                        or require("cmp_dap").is_dap_buffer()
                end,
                experimental = {
                    ghost_text = false,
                },
            })

            cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
                mapping = cmp.mapping.preset.insert(),
                sources = {
                    { name = "dap" },
                },
            })

            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "nvim_lsp_document_symbol" },
                }, {
                    { name = "buffer" },
                }),
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "nvim_lua" },
                    { name = "cmdline" },
                },
            })
        end,
    },
    -- NOTE: These cannot be lazy loaded othewise will not get properly registered 🤔
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-nvim-lua" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-calc" },
    { "hrsh7th/cmp-emoji" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-nvim-lsp-document-symbol" },
    { "f3fora/cmp-spell" },
    { "rcarriga/cmp-dap" },
    {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
        cond = false,
        config = function()
            local tabnine = require("cmp_tabnine.config")
            tabnine:setup({
                max_lines = 1000,
                max_num_results = 20,
                sort = true,
                run_on_every_keystroke = true,
                snippet_placeholder = "..",
                ignored_file_types = {
                    -- default is not to ignore
                    -- uncomment to ignore in lua:
                    -- lua = true
                },
                show_prediction_strength = false,
            })
        end,
    },
    {
        "Exafunction/codeium.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {},
        cond = false,
    },
    {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
    },
}
