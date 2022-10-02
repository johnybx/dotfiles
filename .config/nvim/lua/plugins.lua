return require("packer").startup(function()
    -- Packer can manage itself as an optional plugin
    use({ "wbthomason/packer.nvim", opt = true })
    -- Fuzzy finder
    use({
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    })
    use({ "nvim-telescope/telescope-file-browser.nvim", requires = { { "nvim-telescope/telescope.nvim" } } })
    use({ "stevearc/dressing.nvim", requires = { { "nvim-telescope/telescope.nvim" } } })
    -- LSP and completion
    use({ "neovim/nvim-lspconfig" })
    -- CMP plugings
    use({ "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-buffer" })
    use({ "hrsh7th/cmp-nvim-lua" })
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-path" })
    use({ "hrsh7th/cmp-calc" })
    use({ "hrsh7th/cmp-vsnip" })
    use({ "hrsh7th/cmp-emoji" })
    use({ "hrsh7th/cmp-cmdline" })
    use({ "hrsh7th/cmp-nvim-lsp-document-symbol" })
    use({ "f3fora/cmp-spell" })
    -- Snippets
    use({ "L3MON4D3/LuaSnip" })
    use({ "rafamadriz/friendly-snippets" })
    use({ "saadparwaiz1/cmp_luasnip" })
    -- use({ "hrsh7th/vim-vsnip" })
    -- use({ "quangnguyen30192/cmp-nvim-ultisnips" })
    -- use({ "SirVer/ultisnips", requires = "honza/vim-snippets" })
    --- CMP plugins END
    use({ "p00f/nvim-ts-rainbow" })
    use({ "RRethy/vim-illuminate" })
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use({ "nvim-treesitter/nvim-treesitter-textobjects", after = { "nvim-treesitter" } })
    -- Visual hint for textobjects
    -- https://github.com/mfussenegger/nvim-ts-hint-textobject
    use({ "nvim-treesitter/playground" })
    use({ "ray-x/lsp_signature.nvim" })
    use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } })

    -- Editor
    -- https://github.com/ThePrimeagen/refactoring.nvim
    use({ "JoosepAlviste/nvim-ts-context-commentstring" })
    use({ "b3nj5m1n/kommentary" })
    use({ "mg979/vim-visual-multi" })
    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
    })
    use({ "karb94/neoscroll.nvim" })
    -- use({ "norcalli/nvim-colorizer.lua" })
    use({ "NvChad/nvim-colorizer.lua" })
    use({ "lukas-reineke/indent-blankline.nvim" })
    use({ "windwp/nvim-autopairs" })
    use({ "moll/vim-bbye" })
    use({ "alvarosevilla95/luatab.nvim", requires = "kyazdani42/nvim-web-devicons" })
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    })
    use({ "onsails/lspkind-nvim" })
    use({ "kosayoda/nvim-lightbulb" })
    use({ "rcarriga/nvim-notify" })
    use({ "andythigpen/nvim-coverage" })

    -- Float term
    use({ "akinsho/toggleterm.nvim", branch = "main" })

    -- Easy align
    use({ "junegunn/vim-easy-align" })

    -- Startify
    use({ "mhinz/vim-startify" })

    -- Lua
    use({ "folke/lua-dev.nvim" })

    -- Rust
    use({ "simrat39/rust-tools.nvim" })

    -- Yaml
    use({ "stephpy/vim-yaml" })

    -- Nginx
    use({ "chr4/nginx.vim" })

    -- Markdown
    use({ "preservim/vim-markdown", requires = "godlygeek/tabular" })
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
    })
    use({ "npxbr/glow.nvim" })

    -- Better quoting
    use({ "tpope/vim-surround" })

    -- Git
    use({ "tpope/vim-fugitive" })
    use({ "sindrets/diffview.nvim" })
    use({ "lewis6991/gitsigns.nvim" })
    use({ "ruifm/gitlinker.nvim", requires = "nvim-lua/plenary.nvim" })

    -- Github reviews / MR
    use({
        "pwntester/octo.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "kyazdani42/nvim-web-devicons",
        },
    })

    -- Galaxyline
    use({
        "NTBBloodbath/galaxyline.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    -- Nvim Tree
    use({ "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons" } })

    -- Themes
    use({ "navarasu/onedark.nvim" })
    use({ "EdenEast/nightfox.nvim" })
    use({ "Pocco81/Catppuccino.nvim" })
    use({ "ellisonleao/gruvbox.nvim" })
    -- use({ "arcticicestudio/nord-vim" })
    -- use({ "folke/tokyonight.nvim" })
    -- use({ "patstockwell/vim-monokai-tasty" })

    -- Icons
    use({ "ryanoasis/vim-devicons" })

    -- DB
    use({ "tpope/vim-dadbod" })
    use({ "kristijanhusak/vim-dadbod-ui" })
    use({ "kristijanhusak/vim-dadbod-completion" })

    -- Debug / Tests
    use({
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
        },
    })
    use({ "nvim-neotest/neotest-python", requires = { "nvim-neotest/neotest" } })
    use({ "nvim-neotest/neotest-plenary", requires = { "nvim-neotest/neotest" } })
    use({ "mfussenegger/nvim-dap" })
    use({ "mfussenegger/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
    use({ "mfussenegger/nvim-dap-python", requires = { "mfussenegger/nvim-dap" } })

    -- ENV variables
    use({ "tpope/vim-dotenv" })

    -- HTTP requests
    use({ "rest-nvim/rest.nvim", requires = { "nvim-lua/plenary.nvim" } })

    -- ORG mode
    use({ "kristijanhusak/orgmode.nvim", requires = { "nvim-treesitter/nvim-treesitter" } })

    -- TODO:
    -- https://github.com/ggandor/lightspeed.nvim --> move quickly
    -- https://awesomeopensource.com/project/wellle/targets.vim --> move with f,F,t,T easier
    -- https://github.com/Pocco81/true-zen.nvim
    -- https://github.com/kkoomen/vim-doge - Documentation generation
    -- https://github.com/kristijanhusak/orgmode.nvim - notes
    --
    -- https://github.com/williamboman/mason.nvim
    --
    -- https://github.com/itchyny/calendar.vim
    -- https://github.com/junegunn/fzf.vim
    -- https://github.com/yuki-yano/fzf-preview.vim
    -- https://github.com/kevinhwang91/rnvimr - Ranger in floating window
    -- https://github.com/voldikss/vim-browser-search
    -- https://github.com/windwp/nvim-spectre - Spectre find the enemy and replace them with dark power.
    -- https://github.com/kevinhwang91/nvim-bqf - better quickfix window
    -- https://github.com/folke/which-key.nvim - shortcut hints
    -- https://github.com/sbdchd/neoformat - if null-ls is not good enough
    -- https://awesomeopensource.com/project/wellle/context.vim
    -- https://github.com/pearofducks/ansible-vim
    -- https://github.com/vim-ctrlspace/vim-ctrlspace
    -- https://github.com/unblevable/quick-scope - show header of current function, class, condition...
    -- https://github.com/liuchengxu/vista.vim - View and search LSP symbols, tags
    -- https://github.com/simrat39/symbols-outline.nvim
    -- https://github.com/tjdevries/sg.nvim
end)
