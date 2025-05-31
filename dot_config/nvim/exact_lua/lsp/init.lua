vim.g.lsp_position_encoding = 'utf-16'
require("lsp.config.mason")
require("lsp.config.lspconfig")
require("lsp.config.cmp")

-- 處理nvim一直都會跳警告：
-- position_encoding param is required in vim.lsp.util.make_position_params. Defaulting to position encoding of the first client.
-- 目前無法處理，需要等待大多數來自 plugin 尚未更新以配合 Neovim 0.10+的套件修正，先手動抑制
-- 臨時抑制這類 LSP 訊息
vim.notify = function(msg, log_level, _)
  if msg:match("position_encoding param is required") then
    return
  end
  vim.api.nvim_notify(msg, log_level, {})
end

