-- ============================================================================
-- GitHub Copilot (AI completion)
-- ============================================================================
-- Inline suggestions (ghost text) AND completion source for nvim-cmp
-- After install run :Copilot auth to sign in
-- ============================================================================

return {
  -- ============================================================================
  -- Copilot core (Lua implementation, ghost-text inline)
  -- ============================================================================
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-l>",      -- Alt+l accept suggestion
          accept_word = "<M-w>", -- Alt+w accept word
          accept_line = "<M-j>", -- Alt+j accept line
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        markdown = true,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
        TelescopePrompt = false,
        ["dap-repl"] = false,
      },
      copilot_node_command = "node",
      server_opts_overrides = {},
    },
  },

  -- ============================================================================
  -- Copilot completion source for nvim-cmp
  -- ============================================================================
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    event = "InsertEnter",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
