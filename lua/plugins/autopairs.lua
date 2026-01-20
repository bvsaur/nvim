-- ============================================================================
-- Autopairs
-- ============================================================================
-- Automatic bracket/quote pairing
-- ============================================================================

return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },

    opts = {
      -- Check for closing pairs on same line
      check_ts = true,

      -- Treesitter integration
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },

      -- Don't add pair if the next char matches this pattern
      disable_filetype = { "TelescopePrompt", "spectre_panel" },

      -- Disable when recording/executing macros
      disable_in_macro = true,

      -- Disable when in visualblock mode
      disable_in_visualblock = false,

      -- Disable when inside a replacement operation
      disable_in_replace_mode = true,

      -- Mapping for inserting ignored pairs
      ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],

      -- Enable checking bracket in same line
      enable_check_bracket_line = true,

      -- Enable moveright
      enable_moveright = true,

      -- Enable afterquote
      enable_afterquote = true,

      -- Map the <BS> key to delete pairs
      map_bs = true,

      -- Map <C-h> key to delete pairs
      map_c_h = false,

      -- Map <C-w> to delete a pair
      map_c_w = false,

      -- Map <CR> to confirm completion
      map_cr = true,

      -- Fast wrap settings
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        before_key = "h",
        after_key = "l",
        cursor_pos_before = true,
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        manual_position = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    },

    config = function(_, opts)
      local autopairs = require("nvim-autopairs")
      autopairs.setup(opts)

      -- Integration with nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
