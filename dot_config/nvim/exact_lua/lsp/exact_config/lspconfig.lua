local servers = require("lsp.config.lsp_servers").lsp_servers

local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
  config.capabilities = capabilities
  config.on_attach = on_attach

  if vim.lsp.config then
    -- Neovim 0.11+
    vim.lsp.config(name, config)
  else
    -- Neovim 0.10.x 與舊版 nvim-lspconfig
    require("lspconfig")[name].setup(config)
  end
end
