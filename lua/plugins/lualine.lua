-- ============================================================================
-- Lualine
-- ============================================================================
-- Fast and customizable statusline
-- ============================================================================

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    opts = function()
      -- ========================================================================
      -- Custom components
      -- ========================================================================

      -- Show macro recording indicator
      local function macro_recording()
        local reg = vim.fn.reg_recording()
        if reg == "" then
          return ""
        end
        return "Recording @" .. reg
      end

      -- Show search count
      local function search_count()
        if vim.v.hlsearch == 0 then
          return ""
        end
        local result = vim.fn.searchcount({ maxcount = 999, timeout = 500 })
        if result.total == 0 then
          return ""
        end
        return string.format("[%d/%d]", result.current, result.total)
      end

      -- LSP client names
      local function lsp_clients()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then
          return ""
        end
        local names = {}
        for _, client in ipairs(clients) do
          table.insert(names, client.name)
        end
        return " " .. table.concat(names, ", ")
      end

      return {
        options = {
          theme = "catppuccin",
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = { "dashboard", "alpha", "starter" },
            winbar = {},
          },
        },

        sections = {
          -- ====================================================================
          -- Left side
          -- ====================================================================
          lualine_a = {
            { "mode", separator = { left = "" }, right_padding = 2 },
          },

          lualine_b = {
            { "branch", icon = "" },
            {
              "diff",
              symbols = {
                added = " ",
                modified = " ",
                removed = " ",
              },
            },
          },

          lualine_c = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = " ",
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              "filename",
              path = 1,  -- Relative path
              symbols = {
                modified = "●",
                readonly = "",
                unnamed = "[No Name]",
                newfile = "[New]",
              },
            },
          },

          -- ====================================================================
          -- Right side
          -- ====================================================================
          lualine_x = {
            {
              macro_recording,
              color = { fg = "#f38ba8" },
            },
            {
              search_count,
              color = { fg = "#f9e2af" },
            },
            { lsp_clients },
          },

          lualine_y = {
            { "encoding" },
            { "fileformat" },
            { "filetype" },
          },

          lualine_z = {
            { "location", separator = { right = "" }, left_padding = 2 },
          },
        },

        -- ======================================================================
        -- Inactive windows
        -- ======================================================================
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              "filename",
              path = 1,
              symbols = {
                modified = "●",
                readonly = "",
              },
            },
          },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },

        -- ======================================================================
        -- Extensions
        -- ======================================================================
        extensions = {
          "nvim-tree",
          "lazy",
          "mason",
          "quickfix",
          "fugitive",
          "man",
        },
      }
    end,
  },
}
