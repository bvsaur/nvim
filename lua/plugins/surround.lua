-- ============================================================================
-- nvim-surround
-- ============================================================================
-- Add, change, and delete surrounding pairs
-- ============================================================================

return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },

    opts = {
      -- ========================================================================
      -- Keymaps
      -- ========================================================================
      -- The default keymaps are:
      --
      -- Normal mode:
      --   ys{motion}{char} - Add surrounding
      --   ds{char}         - Delete surrounding
      --   cs{from}{to}     - Change surrounding
      --
      -- Visual mode:
      --   S{char}          - Add surrounding to selection
      --
      -- Examples:
      --   ysiw"    - Surround word with quotes: hello -> "hello"
      --   ds"      - Delete surrounding quotes: "hello" -> hello
      --   cs"'     - Change " to ': "hello" -> 'hello'
      --   yss)     - Surround entire line with parentheses
      --   VS{      - Surround visual selection with braces
      --   ysip}    - Surround paragraph with braces (no spaces)
      --   ysip{    - Surround paragraph with braces (with spaces)
      --
      -- ========================================================================

      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
        change_line = "cS",
      },

      -- ========================================================================
      -- Aliases
      -- ========================================================================
      aliases = {
        ["a"] = ">",              -- Alias 'a' for angle brackets
        ["b"] = ")",              -- Alias 'b' for parentheses
        ["B"] = "}",              -- Alias 'B' for braces
        ["r"] = "]",              -- Alias 'r' for square brackets
        ["q"] = { '"', "'", "`" }, -- Alias 'q' for quotes (searches for any)
        ["s"] = { "}", "]", ")", ">", '"', "'", "`" },  -- Any surrounding
      },

      -- ========================================================================
      -- Highlight settings
      -- ========================================================================
      highlight = {
        duration = 0,  -- Disable highlight (0 = no highlight)
      },

      -- Move cursor to the beginning of the action
      move_cursor = "begin",

      -- Indent nested surrounds
      indent_lines = function(start, stop)
        local b = vim.bo
        -- Only indent if file uses indentation
        if b.expandtab or b.shiftwidth > 0 then
          vim.cmd(string.format("silent normal! %dG=%dG", start, stop))
        end
      end,
    },

    config = function(_, opts)
      require("nvim-surround").setup(opts)
    end,
  },
}
