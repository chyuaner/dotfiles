local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
  end
  map("n", "gd", vim.lsp.buf.definition)
  map("n", "K", vim.lsp.buf.hover)
end

-- 程式語言所需要的與語言伺服器名稱對照表
-- <https://wiki.archlinux.org/title/Language_Server_Protocol>
local servers = {
  "phpactor", -- PHP
  "sqls",     -- SQL
  "pyright",  -- Python
  "gopls",    -- Go
  "html",     -- HTML
  "cssls",    -- CSS
  "volar",    -- Vue3
  -- "ts_ls", -- TypeScript，目前暫時不需要，先註解掉
  "marksman", -- Markdown
  "yamlls",   -- YAML
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
