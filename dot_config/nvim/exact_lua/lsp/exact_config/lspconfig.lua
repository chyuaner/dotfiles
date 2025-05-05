local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
  end
  map("n", "gd", vim.lsp.buf.definition)
  map("n", "K", vim.lsp.buf.hover)
end

local servers = {
  "phpactor",
  "pyright",
  "gopls",
  "html",
  "cssls",
  -- "tsserver", -- TODO: tsserver is deprecated, use ts_ls instead.
}

-- 載入所有的對應的 LSP server 設定
--
-- 相關設定請看
-- <https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md>
for _, name in ipairs(servers) do
  local ok, config = pcall(require, "lsp.servers." .. name)
  if not ok then config = {} end
  config.capabilities = capabilities
  config.on_attach = on_attach
  lspconfig[name].setup(config)
end
