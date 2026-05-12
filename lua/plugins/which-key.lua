-- ============================================================================
-- Which-Key
-- ============================================================================
-- Shows pending keybindings in a popup
-- ============================================================================

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",

    opts = {
      -- ========================================================================
      -- Appearance
      -- ========================================================================
      preset = "modern",
      delay = 300,

      -- ========================================================================
      -- Icons
      -- ========================================================================
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
        ellipsis = "…",
        mappings = true,
        rules = {},
        colors = true,
        keys = {
          Up = " ",
          Down = " ",
          Left = " ",
          Right = " ",
          C = "󰘴 ",
          M = "󰘵 ",
          D = "󰘳 ",
          S = "󰘶 ",
          CR = "󰌑 ",
          Esc = "󱊷 ",
          ScrollWheelDown = "󱕐 ",
          ScrollWheelUp = "󱕑 ",
          NL = "󰌑 ",
          BS = "󰁮",
          Space = "󱁐 ",
          Tab = "󰌒 ",
          F1 = "󱊫",
          F2 = "󱊬",
          F3 = "󱊭",
          F4 = "󱊮",
          F5 = "󱊯",
          F6 = "󱊰",
          F7 = "󱊱",
          F8 = "󱊲",
          F9 = "󱊳",
          F10 = "󱊴",
          F11 = "󱊵",
          F12 = "󱊶",
        },
      },

      -- ========================================================================
      -- Window settings
      -- ========================================================================
      win = {
        no_overlap = true,
        border = "rounded",
        padding = { 1, 2 },
        title = true,
        title_pos = "center",
        zindex = 1000,
      },

      -- ========================================================================
      -- Layout
      -- ========================================================================
      layout = {
        width = { min = 20 },
        spacing = 3,
      },

      -- ========================================================================
      -- Show options
      -- ========================================================================
      show_help = true,
      show_keys = true,

      -- ========================================================================
      -- Triggers
      -- ========================================================================
      triggers = {
        { "<auto>", mode = "nxso" },
      },
    },

    -- ========================================================================
    -- Key group definitions
    -- ========================================================================
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- Register key groups for better organization
      wk.add({
        -- Top-level groups
        { "<leader>a", group = "AI/Claude" },
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>cw", group = "Workspace" },
        { "<leader>d", group = "Debug" },
        { "<leader>dP", group = "Python Debug" },
        { "<leader>f", group = "Find/File" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Git Hunk" },
        { "<leader>l", group = "LSP" },
        { "<leader>q", group = "Quit/Session" },
        { "<leader>r", group = "Run/Test" },
        { "<leader>s", group = "Search" },
        { "<leader>sn", group = "Noice" },
        { "<leader>t", group = "Terminal" },
        { "<leader>u", group = "UI/Toggle" },
        { "<leader>w", group = "Window" },
        { "<leader>x", group = "Diagnostics/Quickfix" },
        { "<leader><tab>", group = "Tab" },
        { "<leader>1", hidden = true },
        { "<leader>2", hidden = true },
        { "<leader>3", hidden = true },
        { "<leader>4", hidden = true },
        { "<leader>5", hidden = true },
        { "<leader>6", hidden = true },
        { "<leader>7", hidden = true },
        { "<leader>8", hidden = true },
        { "<leader>9", hidden = true },

        -- Visual mode
        { "<leader>h", group = "Git Hunk", mode = "v" },

        -- Bracket mappings
        { "[", group = "Previous" },
        { "]", group = "Next" },

        -- g prefix
        { "g", group = "Goto" },

        -- z prefix
        { "z", group = "Fold/Scroll" },
      })
    end,
  },
}
