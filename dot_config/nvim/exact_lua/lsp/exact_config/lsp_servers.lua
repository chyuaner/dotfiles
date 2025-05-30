-- 統一管理要啟用的語言伺服器
local M = {}

-- 依主機功能篩選條件（可選）
local has_go = vim.fn.executable("go") == 1

-- 程式語言所需要的與語言伺服器名稱對照表
-- <https://wiki.archlinux.org/title/Language_Server_Protocol>
M.lsp_servers = {
  -- "lua_ls", "rust_analyzer" -- 官方範例

  "phpactor",                -- PHP
  has_go and "sqls" or nil,  -- SQL
  "pyright",                 -- Python
  has_go and "gopls" or nil, -- Go
  "html",                    -- HTML
  "cssls",                   -- CSS
  -- "vue-language-server",     -- Vue3
  -- "ts_ls",                -- TypeScript，目前暫時不需要，先註解掉
  "marksman",                -- Markdown
  "yamlls",                  -- YAML
}

-- 過濾 nil 值
M.lsp_servers = vim.tbl_filter(function(item)
  return item ~= nil
end, M.lsp_servers)

return M
