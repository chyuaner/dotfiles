return {
  {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    -- cond = not vim.g.neovide and not vim.fn.has("goneovim") == 1 and not vim.fn.has("gui_running") == 1,
    cond = function()
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
    end,
    lazy = false,
    opts = {
      backend = "ueberzug",
      processor = "magick_cli", -- or "magick_rock"
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          only_render_image_at_cursor_mode = "popup",
          floating_windows = false, -- if true, images will be rendered in floating markdown windows
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
        neorg = {
          enabled = true,
          filetypes = { "norg" },
        },
        typst = {
          enabled = true,
          filetypes = { "typst" },
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
      editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
    }
  }
}
