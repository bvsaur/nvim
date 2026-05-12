-- ============================================================================
-- Trouble
-- ============================================================================
-- Pretty diagnostics, references, telescope results, quickfix and location
-- list in a workspace-wide panel
-- ============================================================================

return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        diagnostics = {
          auto_open = false,
          auto_close = true,
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                       desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location list" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix list" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>",                               desc = "TODO list" },
      { "<leader>xr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP refs/defs/impls" },
    },
  },
}
