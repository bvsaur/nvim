-- ============================================================================
-- Comment.nvim
-- ============================================================================
-- Smart and powerful commenting plugin
-- ============================================================================

return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },

    opts = {
      -- Add a space between comment and the line
      padding = true,

      -- Whether the cursor should stay at its position
      sticky = true,

      -- Lines to be ignored while (un)commenting
      ignore = "^$",

      -- Key mappings
      toggler = {
        -- Line-comment toggle
        line = "gcc",
        -- Block-comment toggle
        block = "gbc",
      },

      -- Operator-pending mappings
      opleader = {
        -- Line-comment operator
        line = "gc",
        -- Block-comment operator
        block = "gb",
      },

      -- Extra mappings
      extra = {
        -- Add comment on the line above
        above = "gcO",
        -- Add comment on the line below
        below = "gco",
        -- Add comment at the end of line
        eol = "gcA",
      },

      -- Enable keybindings
      mappings = {
        -- Operator-pending mapping (gcc, gc{motion}, etc.)
        basic = true,
        -- Extra mapping (gco, gcO, gcA)
        extra = true,
      },
    },
  },
}
