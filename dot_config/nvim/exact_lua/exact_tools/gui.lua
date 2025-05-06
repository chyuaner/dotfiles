local M = {}

--- 當前終端機環境是否在圖形環境裡面（Linux / macOS）
--- @return boolean is_gui
function M.is_graphical()
  local env = vim.env
  local term_program = env.TERM_PROGRAM -- macOS GUI 終端機常見
  local display = env.DISPLAY           -- Linux X11
  local wayland = env.WAYLAND_DISPLAY  -- Linux Wayland
  local ssh = env.SSH_CONNECTION or env.SSH_CLIENT

  if ssh then
    return false
  end

  return term_program or display or wayland and true or false
end

--- 當前終端機環境是否在圖形環境裡面，並不使用專用GUI APP(NeoVide)
--- @return boolean is_enable_sixel
function M.is_enable_sixel()
  -- 如果是在 GUI（如 NeoVide、Goneovim）中，則不啟用插件
  if vim.g.neovide or vim.fn.has("goneovim") == 1 or vim.fn.has("gui_running") == 1 then
    return false
  end

  -- 獲取 TERM 環境變數
  local term = vim.fn.getenv("TERM")
  -- 檢查是否是常見的文字終端
  local is_terminal = term and (term:match("xterm") or term:match("screen") or term:match("tmux") or term:match("linux"))

  -- 如果是文字終端，則啟用插件
  return is_terminal ~= nil
end

return M
