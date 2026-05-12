-- ============================================================================
-- Aerial
-- ============================================================================
-- Symbol outline sidebar (functions, classes, methods, etc.)
-- ============================================================================

return {
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen", "AerialNavOpen" },
    keys = {
      { "<leader>o",  "<cmd>AerialToggle!<cr>",   desc = "Symbol outline" },
      { "<leader>O",  "<cmd>AerialNavToggle<cr>", desc = "Symbol nav" },
    },
    opts = {
      attach_mode = "global",
      backends = { "lsp", "treesitter", "markdown", "man" },
      show_guides = true,
      filter_kind = false,
      layout = {
        resize_to_content = false,
        win_opts = {
          winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
          signcolumn = "yes",
          statuscolumn = " ",
        },
      },
      keymaps = {
        ["<CR>"] = "actions.jump",
        ["<2-LeftMouse>"] = "actions.jump",
        ["o"] = "actions.jump",
        ["q"] = "actions.close",
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
