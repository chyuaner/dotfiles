-- ### **邏輯說明**
-- 1. **測試檔案建立**：
--    - 嘗試在當前資料夾中建立一個測試檔案（`.nvim_swap_test`）。
--    - 如果成功，則將 `directory` 設定為 `.`（當前資料夾）。
--    - 如果失敗（例如因為權限問題），則回退到 Neovim 的預設暫存檔位置。

-- 2. **回退位置**：
--    - 使用 `vim.fn.stdpath("data")`，這是 Neovim 的資料目錄（通常是 `~/.local/share/nvim/swap/`）。
--    - 確保回退位置存在，並且不會影響正常使用。

-- 3. **通知使用者**：
--    - 如果回退到預設位置，會透過 `vim.notify` 提醒使用者。

-- 嘗試將暫存檔存放在當前資料夾中
local function set_swap_directory()
  local current_dir = "."
  local test_file = current_dir .. "/.nvim_swap_test"

  -- 嘗試建立測試檔案
  local file, err = io.open(test_file, "w")
  if file then
    file:close()
    os.remove(test_file) -- 刪除測試檔案
    vim.opt.directory = current_dir -- 成功，將暫存檔存放在當前資料夾
  else
    -- 無法建立測試檔案，回退到 Neovim 預設位置
    vim.opt.directory = vim.fn.stdpath("data") .. "/swap//"
    vim.notify("無法在當前資料夾建立暫存檔，改用預設位置: " .. vim.opt.directory:get(), vim.log.levels.WARN)
  end
end

set_swap_directory()
