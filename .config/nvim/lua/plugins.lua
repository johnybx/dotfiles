return require("packer").startup(function()
	-- Packer can manage itself as an optional plugin
	use({ "wbthomason/packer.nvim", opt = true })
	-- Fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
	})
	-- LSP and completion
	use({ "neovim/nvim-lspconfig" })
	use({ "hrsh7th/nvim-compe" })
	use({ "p00f/nvim-ts-rainbow" })
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "nvim-treesitter/nvim-treesitter-textobjects", after = { "nvim-treesitter" } })
	use({ "RRethy/vim-illuminate" })
	-- Visual hint for textobjects
	-- https://github.com/mfussenegger/nvim-ts-hint-textobject
	use({ "nvim-treesitter/playground" })
	use({ "hrsh7th/vim-vsnip" })
	use({ "SirVer/ultisnips", requires = "honza/vim-snippets" })
	use({ "ray-x/lsp_signature.nvim" })
	use({ "glepnir/lspsaga.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } })

	-- Editor
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({ "b3nj5m1n/kommentary" })
	use({ "mg979/vim-visual-multi" })
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
	})
	use({ "karb94/neoscroll.nvim" })
	use({ "pechorin/any-jump.vim" })
	use({ "norcalli/nvim-colorizer.lua" })
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "https://github.com/windwp/nvim-autopairs" })
	use({ "moll/vim-bbye" }) -- better delete buffer
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

	-- Easy align
	use({ "junegunn/vim-easy-align" })

	-- Symbols Outline
	use({ "https://github.com/simrat39/symbols-outline.nvim" })

	-- Startify
	use({ "mhinz/vim-startify" })

	-- Lua
	use({ "folke/lua-dev.nvim" })

	-- Rust
	use({ "rust-lang/rust.vim" })
	-- 'simrat39/rust-tools.nvim'

	-- Yaml
	use({ "stephpy/vim-yaml" })

	-- Nginx
	use({ "chr4/nginx.vim" })

	-- Markdown
	use({ "plasticboy/vim-markdown", requires = "godlygeek/tabular" })
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

	-- Galaxyline
	use({
		"glepnir/galaxyline.nvim",
		branch = "main",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Nvim Tree
	use({ "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons" } })

	-- Themes
	use({ "navarasu/onedark.nvim" })
	use({ "arcticicestudio/nord-vim" })
	use({ "folke/tokyonight.nvim" })

	-- Icons
	use({ "ryanoasis/vim-devicons" })

	-- DB
	use({ "tpope/vim-dadbod" })
	use({ "kristijanhusak/vim-dadbod-ui" })
	use({ "kristijanhusak/vim-dadbod-completion" })

	-- TODO:
	-- https://github.com/easymotion/vim-easymotion --> move quickly
	-- https://awesomeopensource.com/project/wellle/targets.vim --> move with f,F,t,T easier
	--
	--
	-- https://github.com/itchyny/calendar.vim
	-- https://github.com/junegunn/fzf.vim
	-- https://github.com/yuki-yano/fzf-preview.vim
	-- https://github.com/kevinhwang91/rnvimr - Ranger in floating window
	-- https://github.com/voldikss/vim-browser-search
	-- https://github.com/windwp/nvim-spectre - Spectre find the enemy and replace them with dark power.
	-- https://github.com/kevinhwang91/nvim-bqf - better quickfix window
	-- https://github.com/rcarriga/vim-ultest - running tests easily
	-- https://github.com/folke/which-key.nvim - shortcut hints
	-- https://github.com/sbdchd/neoformat - if null-ls is not good enough
	-- https://github.com/kkoomen/vim-doge - Documentation generation
	-- https://github.com/vim-test/vim-test --> running tests easily
	-- https://awesomeopensource.com/project/wellle/context.vim
	-- https://github.com/kristijanhusak/orgmode.nvim - notes
	-- https://github.com/pearofducks/ansible-vim
	-- https://github.com/vim-ctrlspace/vim-ctrlspace
	-- https://github.com/unblevable/quick-scope - show header of current function, class, condition...
	-- https://github.com/liuchengxu/vista.vim - View and search LSP symbols, tags
	--
end)
