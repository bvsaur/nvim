-- ============================================================================
-- NvimTree
-- ============================================================================
-- File explorer sidebar
-- ============================================================================

return {
  -- ============================================================================
  -- Web Devicons (required for file/folder icons)
  -- ============================================================================
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,  -- Load immediately to ensure icons are available
    config = function()
      require("nvim-web-devicons").setup({
        color_icons = true,
        default = true,
        strict = true,
      })
    end,
  },

  -- ============================================================================
  -- NvimTree File Explorer
  -- ============================================================================
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
      { "<leader>E", "<cmd>NvimTreeFocus<CR>", desc = "Focus file explorer" },
    },

    opts = {
      -- ========================================================================
      -- General settings
      -- ========================================================================
      hijack_cursor = true,
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },

      -- ========================================================================
      -- View settings
      -- ========================================================================
      view = {
        width = 35,
        side = "left",
        preserve_window_proportions = true,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
      },

      -- ========================================================================
      -- Renderer settings (appearance)
      -- ========================================================================
      renderer = {
        root_folder_label = ":~:s?$?/..?",
        add_trailing = false,
        group_empty = true,
        highlight_git = true,
        full_name = false,
        highlight_opened_files = "name",
        highlight_modified = "name",
        indent_width = 2,
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          modified_placement = "after",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
            diagnostics = true,
            bookmarks = false,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            modified = "●",
            folder = {
              arrow_closed = ">",
              arrow_open = "v",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "●",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "✗",
              ignored = "◌",
            },
          },
        },
        special_files = {
          "Cargo.toml",
          "Makefile",
          "README.md",
          "readme.md",
          "package.json",
        },
        symlink_destination = true,
      },

      -- ========================================================================
      -- Git settings
      -- ========================================================================
      git = {
        enable = true,
        ignore = false,
        show_on_dirs = true,          -- Show git status on folders
        show_on_open_dirs = false,    -- Hide when folder is expanded
        timeout = 400,
      },

      -- ========================================================================
      -- Modified files (shows ● on folders with modified content)
      -- ========================================================================
      modified = {
        enable = true,
        show_on_dirs = true,          -- Show dot on folders with modified files
        show_on_open_dirs = true,
      },

      -- ========================================================================
      -- Filters
      -- ========================================================================
      filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = {
          "^\\.git$",
          "node_modules",
          "^\\.cache",
          "__pycache__",
        },
        exclude = {},
      },

      -- ========================================================================
      -- Filesystem watchers
      -- ========================================================================
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {},
      },

      -- ========================================================================
      -- Actions
      -- ========================================================================
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "rounded",
            style = "minimal",
          },
        },
        open_file = {
          quit_on_open = false,
          resize_window = true,
          window_picker = {
            enable = true,
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = {
                "notify",
                "packer",
                "qf",
                "diff",
                "fugitive",
                "fugitiveblame",
              },
              buftype = {
                "nofile",
                "terminal",
                "help",
              },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },

      -- ========================================================================
      -- Diagnostics (disabled to avoid sign errors)
      -- ========================================================================
      diagnostics = {
        enable = false,
      },

      -- ========================================================================
      -- UI settings
      -- ========================================================================
      ui = {
        confirm = {
          remove = true,
          trash = true,
        },
      },

      -- ========================================================================
      -- Trash support
      -- ========================================================================
      trash = {
        cmd = "trash",
      },
    },

    config = function(_, opts)
      require("nvim-tree").setup(opts)

      -- Auto close nvim-tree when it's the last window
      vim.api.nvim_create_autocmd("QuitPre", {
        callback = function()
          local tree_wins = {}
          local floating_wins = {}
          local wins = vim.api.nvim_list_wins()
          for _, w in ipairs(wins) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
            if bufname:match("NvimTree_") ~= nil then
              table.insert(tree_wins, w)
            end
            if vim.api.nvim_win_get_config(w).relative ~= "" then
              table.insert(floating_wins, w)
            end
          end
          if 1 == #wins - #floating_wins - #tree_wins then
            for _, w in ipairs(tree_wins) do
              vim.api.nvim_win_close(w, true)
            end
          end
        end,
      })
    end,
  },
}
