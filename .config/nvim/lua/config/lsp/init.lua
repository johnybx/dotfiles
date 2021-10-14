require("config.lsp.diagnostic_sign").setup()

local on_attach = require("config.lsp.default_on_attach").on_attach
local capabilities = require("config.lsp.capabilities").get()

-- Lua
require("config.lsp.lua-dev").setup(on_attach, capabilities)
-- Null lsp
require("config.lsp.null-ls").setup(on_attach)
-- Yamlls
require("config.lsp.yamlls").setup(on_attach, capabilities)

-- Rust analyzer
local status, _ = pcall(require, "rust-tools")
if status then
    require("config.lsp.rust-tools").setup(on_attach, capabilities)
else
    require("config.lsp.rust-analyzer").setup(on_attach, capabilities)
end

-- Others
local servers = { "pyright", "dockerls", "bashls", "vimls", "intelephense" }
require("config.lsp.generic_lsp").setup(servers, on_attach, capabilities)

-- Setup lsp diagnostics
require("config.lsp.diagnostics").setup()
