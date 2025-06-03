-- if true then return {} end

return {
  -- If you want neo-tree's file operations to work with LSP (updating imports, etc.), you can use a plugin like
  -- https://github.com/antosha417/nvim-lsp-file-operations:
  -- {
  --   "antosha417/nvim-lsp-file-operations",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-neo-tree/neo-tree.nvim",
  --   },
  --   config = function()
  --     require("lsp-file-operations").setup()
  --   end,
  -- },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- 先註解，因為已經由 nvim/lua/plugins/components/image.lua 處理了
      {
        "s1n7ax/nvim-window-picker", -- for open_with_window_picker keymaps
        version = "2.*",
        config = function()
          require("window-picker").setup({
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal", "quickfix" },
              },
            },
          })
        end,
      },
    },
    keys = {
      { "<F9>", function()
          vim.cmd("Neotree toggle")
          vim.cmd("wincmd p")
        end,
        desc = "NeoTree"
      },
      { "<A-b>", function()
          vim.cmd("Neotree toggle")
          vim.cmd("wincmd p")
        end,
        desc = "NeoTree"
      },
      { "<F8>", "<cmd>Neotree toggle buffers<cr>", desc = "NeoTree Buffers" },
      { "<F7>", "<cmd>Neotree document_symbols right toggle<cr>", desc = "NeoTree document_symbols" },

      { "<leader>e", "<Cmd>Neotree reveal<CR>" },
      { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
      { "<leader>fT", "<cmd>Neotree float<cr>", desc = "NeoTree Float" },
      { "<leader>fF", "<cmd>Neotree filesystem float<cr>", desc = "NeoTree Filesystem Float" },
      { "<leader>fG", "<cmd>Neotree git_status float<cr>", desc = "NeoTree Git Status Float" },
      { "<S-F9>", "<cmd>Neotree git_status float<cr>", desc = "NeoTree Git Status Float" }, --警告!在標準終端無法使用
      { "<leader>fB", "<cmd>Neotree buffers float<cr>", desc = "NeoTree Buffers Float" },
      { "<leader>fD", "<cmd>Neotree document_symbols float<cr>", desc = "NeoTree Document Symbols Float" },
    },
    lazy = false,
    -----Instead of using `config`, you can use `opts` instead, if you'd like:
    -----@module "neo-tree"
    -----@type neotree.Config
    opts = {
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      },
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = "NC", -- or "" to use 'winborder' on Neovim v0.11+
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
      open_files_using_relative_paths = false,
      sort_case_insensitive = false, -- used when sorting files and directories in the tree
      sort_function = nil, -- use a custom function for sorting files and directories in the tree
      -- sort_function = function (a,b)
      --       if a.type == b.type then
      --           return a.path > b.path
      --       else
      --           return a.type > b.type
      --       end
      --   end , -- this sorts files and directories descendantly
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1, -- extra padding on left hand side
          -- indent guides
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          -- expander config, needed for nesting files
          with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰜌",
          provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
            if node.type == "file" or node.type == "terminal" then
              local success, web_devicons = pcall(require, "nvim-web-devicons")
              local name = node.type == "terminal" and "terminal" or node.name
              if success then
                local devicon, hl = web_devicons.get_icon(name)
                icon.text = devicon or icon.text
                icon.highlight = hl or icon.highlight
              end
            end
          end,
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = "*",
          highlight = "NeoTreeFileIcon",
        },
        modified = {
          symbol = "[+]",
          highlight = "NeoTreeModified",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName",
        },
        git_status = {
          symbols = {
            -- Change type
            added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "✖", -- this can only be used in the git_status source
            renamed = "󰁕", -- this can only be used in the git_status source
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
        },
        -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
        file_size = {
          enabled = true,
          width = 12, -- width of the column
          required_width = 64, -- min width of window required to show this column
        },
        type = {
          enabled = true,
          width = 10, -- width of the column
          required_width = 122, -- min width of window required to show this column
        },
        last_modified = {
          enabled = true,
          width = 20, -- width of the column
          required_width = 88, -- min width of window required to show this column
        },
        created = {
          enabled = true,
          width = 20, -- width of the column
          required_width = 110, -- min width of window required to show this column
        },
        symlink_target = {
          enabled = false,
        },
      },
      -- A list of functions, each representing a global custom command
      -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
      -- see `:h neo-tree-custom-commands-global`
      commands = {},
      window = {
        position = "left",
        width = 40,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        -- mappings = {
        --   ["<space>"] = {
        --     "toggle_node",
        --     nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
        --   },
        --   ["<2-LeftMouse>"] = "open",
        --   ["<cr>"] = "open",
        --   ["<esc>"] = "cancel", -- close preview or floating neo-tree window
        --   ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = false } },
        --   -- Read `# Preview Mode` for more information
        --   ["l"] = "focus_preview",
        --   ["S"] = "open_split",
        --   ["s"] = "open_vsplit",
        --   -- ["S"] = "split_with_window_picker",
        --   -- ["s"] = "vsplit_with_window_picker",
        --   ["t"] = "open_tabnew",
        --   -- ["<cr>"] = "open_drop",
        --   -- ["t"] = "open_tab_drop",
        --   ["w"] = "open_with_window_picker",
        --   --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
        --   ["C"] = "close_node",
        --   -- ['C'] = 'close_all_subnodes',
        --   ["z"] = "close_all_nodes",
        --   --["Z"] = "expand_all_nodes",
        --   --["Z"] = "expand_all_subnodes",
        --   ["a"] = {
        --     "add",
        --     -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        --     -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        --     config = {
        --       show_path = "none", -- "none", "relative", "absolute"
        --     },
        --   },
        --   ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
        --   ["d"] = "delete",
        --   ["r"] = "rename",
        --   ["b"] = "rename_basename",
        --   ["y"] = "copy_to_clipboard",
        --   ["x"] = "cut_to_clipboard",
        --   ["p"] = "paste_from_clipboard",
        --   ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
        --   -- ["c"] = {
        --   --  "copy",
        --   --  config = {
        --   --    show_path = "none" -- "none", "relative", "absolute"
        --   --  }
        --   --}
        --   ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
        --   ["q"] = "close_window",
        --   ["R"] = "refresh",
        --   ["?"] = "show_help",
        --   ["<"] = "prev_source",
        --   [">"] = "next_source",
        --   ["i"] = "show_file_details",
        --   -- ["i"] = {
        --   --   "show_file_details",
        --   --   -- format strings of the timestamps shown for date created and last modified (see `:h os.date()`)
        --   --   -- both options accept a string or a function that takes in the date in seconds and returns a string to display
        --   --   -- config = {
        --   --   --   created_format = "%Y-%m-%d %I:%M %p",
        --   --   --   modified_format = "relative", -- equivalent to the line below
        --   --   --   modified_format = function(seconds) return require('neo-tree.utils').relative_date(seconds) end
        --   --   -- }
        --   -- },
        -- },
      },
      nesting_rules = {},
      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_hidden = false, -- only works on Windows for hidden files/directories
          hide_by_name = {
            --"node_modules"
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
          },
          always_show = { -- remains visible even if other settings would normally hide it
            --".gitignored",
          },
          always_show_by_pattern = { -- uses glob style patterns
            --".env*",
          },
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            ".git",
            ".DS_Store",
            ".directory",
            "thumbs.db",
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
          },
        },
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = false, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
        -- in whatever position is specified in window.position
        -- "open_current",  -- netrw disabled, opening a directory opens within the
        -- window like netrw would, regardless of window.position
        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
        use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
        window = {
          mappings = {
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["/"] = "fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
            -- ["D"] = "fuzzy_sorter_directory",
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
            ["[g"] = "prev_git_modified",
            ["]g"] = "next_git_modified",
            ["o"] = {
              "show_help",
              nowait = false,
              config = { title = "Order by", prefix_key = "o" },
            },
            ["oc"] = { "order_by_created", nowait = false },
            ["od"] = { "order_by_diagnostics", nowait = false },
            ["og"] = { "order_by_git_status", nowait = false },
            ["om"] = { "order_by_modified", nowait = false },
            ["on"] = { "order_by_name", nowait = false },
            ["os"] = { "order_by_size", nowait = false },
            ["ot"] = { "order_by_type", nowait = false },
            -- ['<key>'] = function(state) ... end,
          },
          fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
            ["<down>"] = "move_cursor_down",
            ["<C-n>"] = "move_cursor_down",
            ["<up>"] = "move_cursor_up",
            ["<C-p>"] = "move_cursor_up",
            ["<esc>"] = "close",
            -- ['<key>'] = function(state, scroll_padding) ... end,
          },
        },

        commands = {}, -- Add a custom command or override a global one using the same function name
      },
      buffers = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --              -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        show_unloaded = true,
        window = {
          mappings = {
            ["d"] = "buffer_delete",
            ["bd"] = "buffer_delete",
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["o"] = {
              "show_help",
              nowait = false,
              config = { title = "Order by", prefix_key = "o" },
            },
            ["oc"] = { "order_by_created", nowait = false },
            ["od"] = { "order_by_diagnostics", nowait = false },
            ["om"] = { "order_by_modified", nowait = false },
            ["on"] = { "order_by_name", nowait = false },
            ["os"] = { "order_by_size", nowait = false },
            ["ot"] = { "order_by_type", nowait = false },
          },
        },
      },
      git_status = {
        window = {
          position = "float",
          mappings = {
            ["A"] = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
            ["gp"] = "git_push",
            ["gg"] = "git_commit_and_push",
            ["o"] = {
              "show_help",
              nowait = false,
              config = { title = "Order by", prefix_key = "o" },
            },
            ["oc"] = { "order_by_created", nowait = false },
            ["od"] = { "order_by_diagnostics", nowait = false },
            ["om"] = { "order_by_modified", nowait = false },
            ["on"] = { "order_by_name", nowait = false },
            ["os"] = { "order_by_size", nowait = false },
            ["ot"] = { "order_by_type", nowait = false },
          },
        },
      },
      document_symbols = {
        follow_cursor = true,
        client_filters = "first",
        renderers = {
          root = {
            {"indent"},
            {"icon", default="C" },
            {"name", zindex = 10},
          },
          symbol = {
            {"indent", with_expanders = true},
            {"kind_icon", default="?" },
            {"container",
            content = {
              {"name", zindex = 10},
              {"kind_name", zindex = 20, align = "right"},
              }
            }
          },
        },
        window = {
          mappings = {
            ["<cr>"] = "jump_to_symbol",
            ["o"] = "jump_to_symbol",
            ["A"] = "noop", -- also accepts the config.show_path and config.insert_as options.
            ["d"] = "noop",
            ["y"] = "noop",
            ["x"] = "noop",
            ["p"] = "noop",
            ["c"] = "noop",
            ["m"] = "noop",
            ["a"] = "noop",
            ["/"] = "filter",
            ["f"] = "filter_on_submit",
          },
        },
        custom_kinds = {
          -- define custom kinds here (also remember to add icon and hl group to kinds)
          -- ccls
          -- [252] = 'TypeAlias',
          -- [253] = 'Parameter',
          -- [254] = 'StaticMethod',
          -- [255] = 'Macro',
        },
        kinds = {
          Unknown = { icon = "?", hl = "" },
          Root = { icon = "", hl = "NeoTreeRootName" },
          File = { icon = "󰈙", hl = "Tag" },
          Module = { icon = "", hl = "Exception" },
          Namespace = { icon = "󰌗", hl = "Include" },
          Package = { icon = "󰏖", hl = "Label" },
          Class = { icon = "󰌗", hl = "Include" },
          Method = { icon = "", hl = "Function" },
          Property = { icon = "󰆧", hl = "@property" },
          Field = { icon = "", hl = "@field" },
          Constructor = { icon = "", hl = "@constructor" },
          Enum = { icon = "󰒻", hl = "@number" },
          Interface = { icon = "", hl = "Type" },
          Function = { icon = "󰊕", hl = "Function" },
          Variable = { icon = "", hl = "@variable" },
          Constant = { icon = "", hl = "Constant" },
          String = { icon = "󰀬", hl = "String" },
          Number = { icon = "󰎠", hl = "Number" },
          Boolean = { icon = "", hl = "Boolean" },
          Array = { icon = "󰅪", hl = "Type" },
          Object = { icon = "󰅩", hl = "Type" },
          Key = { icon = "󰌋", hl = "" },
          Null = { icon = "", hl = "Constant" },
          EnumMember = { icon = "", hl = "Number" },
          Struct = { icon = "󰌗", hl = "Type" },
          Event = { icon = "", hl = "Constant" },
          Operator = { icon = "󰆕", hl = "Operator" },
          TypeParameter = { icon = "󰊄", hl = "Type" },

          -- ccls
          -- TypeAlias = { icon = ' ', hl = 'Type' },
          -- Parameter = { icon = ' ', hl = '@parameter' },
          -- StaticMethod = { icon = '󰠄 ', hl = 'Function' },
          -- Macro = { icon = ' ', hl = 'Macro' },
        }
      },

      -- 自行加入的
      source_selector = {
        winbar = true,
        statusline = false,
      }
    },
    config = function(_, opts)
      -- If you want icons for diagnostic errors, you'll need to define them somewhere.
      -- In Neovim v0.10+, you can configure them in vim.diagnostic.config(), like:
      --
      -- vim.diagnostic.config({
      --   signs = {
      --     text = {
      --       [vim.diagnostic.severity.ERROR] = '',
      --       [vim.diagnostic.severity.WARN] = '',
      --       [vim.diagnostic.severity.INFO] = '',
      --       [vim.diagnostic.severity.HINT] = '󰌵',
      --     },
      --   }
      -- })
      --
      -- In older versions, you can define the signs manually:
      -- vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
      -- vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
      -- vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
      -- vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

      require("neo-tree").setup(opts)

      -- 打Patch：暫時解決winbar與nui.nvim 不完全兼容錯誤
      -- [Neo-tree ERROR] debounce  neo-tree-follow  error:  ~/.local/share/nvim/lazy/nui.nvim/lua/nui/tree/init.lua:261: Invalid 'window': Expected Lua number
      local Tree = require("nui.tree")
      local old_set_win = Tree.set_win
      Tree.set_win = function(self, window)
        if type(window) ~= "number" or not vim.api.nvim_win_is_valid(window) then
          return
        end
        return old_set_win(self, window)
      end


      -- 調整展開後tree線條顏色
      vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#3c3c3c" })
      -- vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = "#00FF00" })
      -- vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = "#FFFFFF" })

      -- vim.keymap.set("n", "<leader>e", "<Cmd>Neotree reveal<CR>")


      -- 讓document_symbols不要出現winbar
      -- vim.api.nvim_create_autocmd("WinNew", {
      --   callback = function(args)
      --     vim.defer_fn(function()
      --       local state = require("neo-tree.sources.manager").get_state("document_symbols")
      --       if state and state.winid and vim.api.nvim_win_is_valid(state.winid) then
      --         vim.api.nvim_win_set_option(state.winid, "winbar", "")
      --       end
      --     end, 100)
      --   end,
      -- })

      local function keep_clear_winbar()
        local state = require("neo-tree.sources.manager").get_state("document_symbols")
        if state and state.winid and vim.api.nvim_win_is_valid(state.winid) then
          vim.api.nvim_win_set_option(state.winid, "winbar", "")
          vim.api.nvim_win_set_option(state.winid, "statusline", "")
        end
        vim.defer_fn(keep_clear_winbar, 100)  -- 300ms 後再執行自己一次
      end
      keep_clear_winbar() -- 啟動


      -- 自動命令：啟動時自動顯示 Neo-tree
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.defer_fn(function()
            if vim.fn.winheight(0) > 20 and vim.fn.winwidth(0) > 140 then
              vim.cmd("Neotree show")
              vim.cmd("Neotree reveal")
            end
          end, 0)
        end,
      })

      -- -- 自動命令：當進入緩衝區(開啟文件)時自動顯示 Neo-tree
      -- -- PS. 在neo-tree做`:q`關閉時，會報錯crash。先關閉此功能
      -- vim.api.nvim_create_autocmd("BufEnter", {
      --   callback = function()
      --     -- 檢查是否為普通文件類型，避免在特殊緩衝區（如 terminal 或 quickfix）中啟動
      --     local buf_ft = vim.bo.filetype
      --     if buf_ft ~= "neo-tree" and buf_ft ~= "terminal" and buf_ft ~= "quickfix" then
      --       -- 確保當前分頁是否已經有 Neo-tree
      --       local neo_tree_open = false
      --       for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      --         local buf = vim.api.nvim_win_get_buf(win)
      --         if vim.api.nvim_buf_get_option(buf, "filetype") == "neo-tree" then
      --           neo_tree_open = true
      --           break
      --         end
      --       end

      --       -- 如果當前分頁沒有 Neo-tree，則打開
      --       if not neo_tree_open then
      --         vim.cmd("Neotree show")
      --         vim.cmd("Neotree reveal")
      --         vim.cmd("wincmd p") -- 將焦點切回到之前的窗口
      --       end
      --     end
      --   end,
      -- })
    end,
  },
}
