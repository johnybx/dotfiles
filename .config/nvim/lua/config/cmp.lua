local cmp = require("cmp")
local types = require("cmp.types")
local lspkind = require("lspkind")

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function check_back_space()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

local function tab_complete(fallback)
    -- if vim.fn.pumvisible() == 1 then
    -- 	vim.fn.feedkeys(t("<C-n>"), "n")
    if cmp.visible() then
        cmp.select_next_item()
        -- elseif vim.fn["vsnip#available"](1) == 1 then
        -- 	vim.fn.feedkeys(t("<Plug>(vsnip-expand-or-jump)"), "")
    elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        vim.fn.feedkeys(t("<C-j>"), "")
    elseif check_back_space() then
        vim.fn.feedkeys(t("<Tab>"), "n")
    else
        fallback()
    end
end

local function s_tab_complete(fallback)
    -- if vim.fn.pumvisible() == 1 then
    -- vim.fn.feedkeys(t("<C-p>"), "n")
    if cmp.visible() then
        cmp.select_prev_item()
        -- elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        -- 	vim.fn.feedkeys(t("<Plug>(vsnip-jump-prev)"), "")
    elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        vim.fn.feedkeys(t("<C-k>"), "")
    else
        fallback()
    end
end

cmp.setup({
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
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
                ultisnips = "[UltiSnips]",
                calc = "[Calc]",
                vsnip = "[Vsnip]",
                emoji = "[Emoji]",
                ["vim-dadbod-completion"] = "[Dadbod]",
                spell = "[Spell]",
            }
            vim_item.kind = lspkind.presets.default[vim_item.kind] .. "  " .. vim_item.kind
            vim_item.menu = sources[entry.source.name] or entry.source.name
            return vim_item
        end,
    },
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
    confirmation = {
        default_behavior = types.cmp.ConfirmBehavior.Replace,
    },
    preselect = types.cmp.PreselectMode.Item,
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "vim-dadbod-completion" },
        { name = "buffer", keyword_length = 3 },
        { name = "ultisnips" },
        { name = "spell" },
        { name = "emoji" },
        { name = "calc" },
        -- { name = "vsnip" },
    },
    sorting = {
        priority_weight = 2,
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.length,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.order,
        },
    },
})
