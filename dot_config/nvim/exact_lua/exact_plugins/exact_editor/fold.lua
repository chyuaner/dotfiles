local ftMap = {
    vim = 'indent',
    python = {'indent'},
    git = ''
}

return {
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async'
    },
    event = "VeryLazy",
    opts = {
        open_fold_hl_timeout = 150,
        close_fold_kinds_for_ft = {
            default = {'imports', 'comment'},
            json = {'array'},
            c = {'comment', 'region'}
        },
        preview = {
            win_config = {
                border = {'', '─', '', '', '', '─', '', ''},
                winhighlight = 'Normal:Folded',
                winblend = 0
            },
            mappings = {
                scrollU = '<C-u>',
                scrollD = '<C-d>',
                jumpTop = '[',
                jumpBot = ']'
            }
        },
        provider_selector = function(bufnr, filetype, buftype)
            -- if you prefer treesitter provider rather than lsp,
            -- return ftMap[filetype] or {'treesitter', 'indent'}
            return ftMap[filetype]

            -- refer to ./doc/example.lua for detail
        end
    },
    init = function()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function(_, opts)
      local handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local totalLines = vim.api.nvim_buf_line_count(0)
          local foldedLines = endLnum - lnum
          local suffix = ("  %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          for _, chunk in ipairs(virtText) do
              local chunkText = chunk[1]
              local chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if targetWidth > curWidth + chunkWidth then
                  table.insert(newVirtText, chunk)
              else
                  chunkText = truncate(chunkText, targetWidth - curWidth)
                  local hlGroup = chunk[2]
                  table.insert(newVirtText, { chunkText, hlGroup })
                  chunkWidth = vim.fn.strdisplaywidth(chunkText)
                  if curWidth + chunkWidth < targetWidth then
                      suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                  end
                  break
              end
              curWidth = curWidth + chunkWidth
          end
          local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
          suffix = (" "):rep(rAlignAppndx) .. suffix
          table.insert(newVirtText, { suffix, "MoreMsg" })
          return newVirtText
      end
      opts["fold_virt_text_handler"] = handler

      -- ufo官方範例：
      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      -- Option 1: coc.nvim as LSP client
      -- use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}
      -- require('ufo').setup(opts)
      --

      -- Option 2: nvim lsp as LSP client
      -- Tell the server the capability of foldingRange,
      -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true
      }
      local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
          require('lspconfig')[ls].setup({
              capabilities = capabilities
              -- you can add other fields for setting up lsp server in this table
          })
      end
      require('ufo').setup(opts)
      --

      -- Option 3: treesitter as a main provider instead
      -- (Note: the `nvim-treesitter` plugin is *not* needed.)
      -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
      -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
      -- require('ufo').setup({
      --     provider_selector = function(bufnr, filetype, buftype)
      --         return {'treesitter', 'indent'}
      --     end
      -- })
      --

      -- Option 4: disable all providers for all buffers
      -- Not recommend, AFAIK, the ufo's providers are the best performance in Neovim
      -- require('ufo').setup({
      --     provider_selector = function(bufnr, filetype, buftype)
      --         return ''
      --     end
      -- })
    end,
  }
}
