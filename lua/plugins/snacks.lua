-- ============================================================================
-- Snacks
-- ============================================================================
-- Utility library used by claudecode.nvim (and very nice on its own)
-- ============================================================================

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Most features off — we have dedicated plugins for them
      bigfile     = { enabled = false }, -- our own large-file autocmd handles this
      dashboard   = { enabled = false }, -- alpha-nvim handles this
      notifier    = { enabled = false }, -- nvim-notify via noice handles this
      quickfile   = { enabled = true },
      statuscolumn = { enabled = false },
      words       = { enabled = true },
      -- Required by claudecode.nvim
      input       = { enabled = true },
      picker      = { enabled = false }, -- telescope handles this
      terminal    = { enabled = true },
      win         = { enabled = true },
    },
  },
}
