-- ============================================================================
-- Spectre
-- ============================================================================
-- Project-wide search and replace UI with regex and live preview
-- ============================================================================

return {
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>sr", function() require("spectre").open() end,                                  desc = "Search & replace (Spectre)" },
      { "<leader>sR", function() require("spectre").open_visual({ select_word = true }) end,     desc = "Replace word under cursor" },
      { "<leader>sp", function() require("spectre").open_file_search({ select_word = true }) end, desc = "Replace in current file" },
    },
    opts = {
      open_cmd = "noswapfile vnew",
      live_update = true,
    },
  },
}
