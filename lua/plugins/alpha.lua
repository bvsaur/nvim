-- ============================================================================
-- Alpha
-- ============================================================================
-- Dashboard / startup screen with recent files, sessions, quick actions
-- ============================================================================

return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file",        "<cmd>Telescope find_files<CR>"),
        dashboard.button("n", "  New file",         "<cmd>ene <BAR> startinsert<CR>"),
        dashboard.button("r", "  Recent files",     "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("g", "  Find text",        "<cmd>Telescope live_grep<CR>"),
        dashboard.button("s", "  Restore session",  "<cmd>lua require('persistence').load()<CR>"),
        dashboard.button("S", "  Select session",   "<cmd>lua require('persistence').select()<CR>"),
        dashboard.button("c", "  Configuration",    "<cmd>edit " .. vim.fn.stdpath("config") .. "/init.lua<CR>"),
        dashboard.button("l", "󰒲  Lazy",             "<cmd>Lazy<CR>"),
        dashboard.button("m", "  Mason",            "<cmd>Mason<CR>"),
        dashboard.button("a", "  Claude Code",      "<cmd>ClaudeCode<CR>"),
        dashboard.button("q", "  Quit",             "<cmd>qa<CR>"),
      }

      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8

      alpha.setup(dashboard.opts)

      -- Footer with plugin load stats
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "VeryLazy",
        callback = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
          dashboard.section.footer.val = "⚡ "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins loaded in "
            .. ms
            .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
