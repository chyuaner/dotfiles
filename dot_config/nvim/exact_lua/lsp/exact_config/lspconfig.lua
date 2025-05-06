local servers = require("lsp.config.lsp_servers").lsp_servers
local lspconfig = require("lspconfig")

-- Neovim 版本要在 0.10 以上才啟用
local is_nvim_010 = vim.fn.has("nvim-0.10") == 1
local capabilities = is_nvim_010 and require("cmp_nvim_lsp").default_capabilities() or nil

local on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
  end
  map("n", "gd", vim.lsp.buf.definition)
  map("n", "K", vim.lsp.buf.hover)
end

-- 載入所有的對應的 LSP server 設定
--
-- 相關設定請看
-- <https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md>
for _, name in ipairs(servers) do
  local ok, config = pcall(require, "lsp.servers." .. name)
  if not ok then config = {} end
  if capabilities then
    config.capabilities = capabilities
  end
  config.on_attach = on_attach
  lspconfig[name].setup(config)
end
