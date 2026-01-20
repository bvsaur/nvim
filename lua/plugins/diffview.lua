-- ============================================================================
-- Diffview Configuration
-- ============================================================================
-- Enhanced diff viewing for files and git history
-- ============================================================================

return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Open diff view" },
      { "<leader>gD", "<cmd>DiffviewOpen HEAD~1<CR>", desc = "Diff with previous commit" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history (current)" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "File history (repo)" },
      { "<leader>gq", "<cmd>DiffviewClose<CR>", desc = "Close diff view" },
    },

    opts = {
      diff_binaries = false,
      enhanced_diff_hl = true,
      use_icons = true,

      -- Icons for file status
      icons = {
        folder_closed = "",
        folder_open = "",
      },

      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },

      view = {
        -- Configure the default diff view
        default = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
        },
        file_history = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
      },

      file_panel = {
        listing_style = "tree",
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "left",
          width = 35,
        },
      },

      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              diff_merges = "combined",
            },
            multi_file = {
              diff_merges = "first-parent",
            },
          },
        },
        win_config = {
          position = "bottom",
          height = 16,
        },
      },

      commit_log_panel = {
        win_config = {},
      },

      default_args = {
        DiffviewOpen = {},
        DiffviewFileHistory = {},
      },

      hooks = {},

      keymaps = {
        disable_defaults = false,
        view = {
          { "n", "<tab>", "<cmd>DiffviewToggleFiles<CR>", { desc = "Toggle file panel" } },
          { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diff view" } },
        },
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diff view" } },
        },
        file_history_panel = {
          { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diff view" } },
        },
      },
    },
  },
}
