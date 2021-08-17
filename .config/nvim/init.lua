-- Setting
require("settings")

vim.cmd([[packadd packer.nvim]])
vim.cmd("autocmd BufWritePost plugins.lua PackerCompile") -- Auto compile when there are changes in plugins.lua

-- Install plugins
require("plugins")

-- Another option is to groups configuration in one folder
require("config")

-- Key mappings
require("keymappings")

-- Customer commands
require("commands")
