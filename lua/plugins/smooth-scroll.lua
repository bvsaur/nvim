-- ============================================================================
-- Smooth Scrolling
-- ============================================================================
-- Provides smooth animated scrolling for a better visual experience
-- ============================================================================

return {
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",

    opts = {
      -- All these keys will be mapped to their corresponding default scrolling animation
      mappings = {
        "<C-u>", "<C-d>",
        "<C-b>", "<C-f>",
        "<C-y>", "<C-e>",
        "zt", "zz", "zb",
      },
      hide_cursor = true,           -- Hide cursor while scrolling
      stop_eof = true,              -- Stop at <EOF> when scrolling downwards
      respect_scrolloff = false,    -- Stop scrolling when the cursor reaches the scrolloff margin
      cursor_scrolls_alone = true,  -- Cursor will keep on scrolling even if the window cannot scroll further
      easing = "quadratic",         -- Easing function: linear, quadratic, cubic, quartic, quintic, circular, sine
      pre_hook = nil,
      post_hook = nil,
      performance_mode = false,     -- Disable "Performance Mode" on all buffers
    },

    config = function(_, opts)
      require("neoscroll").setup(opts)

      -- Custom scroll distances
      local neoscroll = require("neoscroll")
      local keymap = {
        -- Scroll by percentage of window height
        ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 150 }) end,
        ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 150 }) end,
        -- Full page scroll
        ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 250 }) end,
        ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 250 }) end,
        -- Small scrolls (3 lines)
        ["<C-y>"] = function() neoscroll.scroll(-3, { move_cursor = false, duration = 50 }) end,
        ["<C-e>"] = function() neoscroll.scroll(3, { move_cursor = false, duration = 50 }) end,
        -- Center commands
        ["zt"] = function() neoscroll.zt({ half_win_duration = 100 }) end,
        ["zz"] = function() neoscroll.zz({ half_win_duration = 100 }) end,
        ["zb"] = function() neoscroll.zb({ half_win_duration = 100 }) end,
      }

      local modes = { "n", "v", "x" }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func, { silent = true })
      end
    end,
  },
}
