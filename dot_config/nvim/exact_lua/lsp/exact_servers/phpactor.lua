return {
  init_options = {
    ["language_server_phpstan.enabled"] = true,
    ["language_server_psalm.enabled"] = false,
  }
  -- settings = {
  --   -- 自訂 PHPactor 設定（如果有的話）
  -- },
}

-- 僅對照用
-- require("lspconfig").phpactor.setup({
--   init_options = {
--     ["language_server_phpstan.enabled"] = true,
--     ["language_server_psalm.enabled"] = false,
--   }
-- })
