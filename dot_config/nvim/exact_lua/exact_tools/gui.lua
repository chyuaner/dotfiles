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

return M
