return {
  { 'plasticboy/vim-markdown',
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    cond = function()
      -- 檢查是否有 gcc 或 clang 或 cc（任一存在就啟用）
      return vim.fn.executable("gcc") == 1
          or vim.fn.executable("cc") == 1
          or vim.fn.executable("clang") == 1
          or vim.fn.executable("cl") == 1
          or vim.fn.executable("zig") == 1
    end,
    build = ":TSUpdate",
    config = function()
      -- nvim-treesitter 在 main 分支主要提供 parser 安裝與升級管理。
      -- Neovim 0.12+ 內建原生 Treesitter 支援（包含語法高亮、折疊等）。
      local ts = require("nvim-treesitter")

      -- 設定要自動安裝/更新的 parser 語言
      local ensure_installed = {
        "regex",
        "bash",
        "html",
        "blade",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "php",
        "go",
        "css",
      }

      -- 當 parser 缺失時，自動背景排程安裝
      local installed = ts.get_installed()
      local to_install = {}
      for _, lang in ipairs(ensure_installed) do
        if not vim.list_contains(installed, lang) then
          table.insert(to_install, lang)
        end
      end

      if #to_install > 0 then
        vim.schedule(function()
          pcall(ts.install, to_install)
        end)
      end

      -- 自動啟用 Treesitter 高亮與縮排
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TSHighlightSetup", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if lang and pcall(vim.treesitter.start, args.buf, lang) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
