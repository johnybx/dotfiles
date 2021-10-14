-- Setting
require("settings")

vim.cmd([[packadd packer.nvim]])
vim.cmd("autocmd BufWritePost plugins.lua PackerCompile")

-- Install plugins
require("plugins")

-- Another option is to groups configuration in one folder
require("config")

-- Key mappings
require("keymappings")

-- Customer commands
require("commands")
