-- ============================================================================
-- Claude Code
-- ============================================================================
-- Integrates the Claude Code CLI directly inside Neovim:
--   - Toggle Claude in a split, focus, resume, continue sessions
--   - Add buffers / selections / files from the tree to Claude's context
--   - Accept or reject diffs that Claude proposes
--
-- Requirements:
--   - claude CLI installed and authenticated (npm i -g @anthropic-ai/claude-code)
-- ============================================================================

return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    cmd = {
      "ClaudeCode",
      "ClaudeCodeFocus",
      "ClaudeCodeSend",
      "ClaudeCodeOpen",
      "ClaudeCodeClose",
      "ClaudeCodeAdd",
      "ClaudeCodeTreeAdd",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
      "ClaudeCodeSelectModel",
    },
    opts = {
      -- Use snacks for the terminal split (falls back to native if missing)
      terminal = {
        split_side = "right",
        split_width_percentage = 0.40,
        provider = "auto",
        auto_close = false,
      },
      diff_opts = {
        layout = "vertical",
        open_in_new_tab = false,
        keep_terminal_focus = false,
      },
    },
    config = function(_, opts)
      require("claudecode").setup(opts)
    end,
    keys = {
      { "<leader>a",  nil,                            desc = "AI / Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>",          desc = "Toggle Claude Code" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",     desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude session" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue last session" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",     desc = "Add buffer to Claude" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",      mode = "v", desc = "Send selection to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file from tree",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
      },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Reject Claude diff" },
    },
  },
}
