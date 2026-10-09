return {
  cmd = { "phpactor", "language-server" },
  -- phpactor 的 twig extension 也能處理 Twig 樣板
  filetypes = { "php", "twig" },
  init_options = {
    ["language_server_phpstan.enabled"] = true,
    ["language_server_psalm.enabled"] = false,
  },
  -- 可選：如有額外設定
  -- settings = {
  --   -- 這裡可以填寫 phpactor 的其他設定
  -- },
}

-- 僅對照用
-- require("lspconfig").phpactor.setup({
--   init_options = {
--     ["language_server_phpstan.enabled"] = true,
--     ["language_server_psalm.enabled"] = false,
--   }
-- })
