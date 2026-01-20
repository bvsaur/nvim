-- ============================================================================
-- Treesitter
-- ============================================================================
-- Syntax highlighting and parser management for Neovim >= 0.11
-- Note: Highlighting is built-in, we just need parser management
-- ============================================================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    cmd = { "TSInstall", "TSUpdate", "TSUpdateSync" },
    lazy = vim.fn.argc(-1) == 0,

    config = function()
      -- ========================================================================
      -- Parsers to install
      -- ========================================================================
      local parsers = {
        "bash",
        "c",
        "cpp",
        "css",
        "dockerfile",
        "go",
        "gomod",
        "gosum",
        "graphql",
        "html",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "ruby",
        "rust",
        "scss",
        "sql",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "xml",
        "yaml",
      }

      -- Use nvim-treesitter's install module to ensure parsers are installed
      local install = require("nvim-treesitter.install")

      -- Prefer git for installation
      install.prefer_git = true

      -- Install missing parsers (only once, tracked by nvim-treesitter internally)
      local to_install = {}
      for _, parser in ipairs(parsers) do
        -- Check if parser is already available
        local ok = pcall(vim.treesitter.language.add, parser)
        if not ok then
          table.insert(to_install, parser)
        end
      end

      -- Install missing parsers asynchronously
      if #to_install > 0 then
        -- Only show notification once per session
        local installed_key = "ts_parsers_installed"
        if not vim.g[installed_key] then
          vim.g[installed_key] = true
          vim.schedule(function()
            for _, parser in ipairs(to_install) do
              install.install(parser)
            end
          end)
        end
      end

      -- ========================================================================
      -- Incremental selection keymaps
      -- ========================================================================
      local map = vim.keymap.set

      -- Simple incremental selection using treesitter
      local function start_select()
        local node = vim.treesitter.get_node()
        if node then
          local sr, sc, er, ec = node:range()
          vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
          vim.cmd("normal! v")
          vim.api.nvim_win_set_cursor(0, { er + 1, ec - 1 })
        end
      end

      local function expand_select()
        local node = vim.treesitter.get_node()
        if node then
          local parent = node:parent()
          if parent then
            local sr, sc, er, ec = parent:range()
            vim.cmd("normal! \027") -- Escape first
            vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
            vim.cmd("normal! v")
            vim.api.nvim_win_set_cursor(0, { er + 1, ec > 0 and ec - 1 or 0 })
          end
        end
      end

      map("n", "<C-space>", start_select, { desc = "Start treesitter selection" })
      map("x", "<C-space>", expand_select, { desc = "Expand treesitter selection" })

      -- ========================================================================
      -- Text object keymaps (simple implementation without textobjects plugin)
      -- ========================================================================

      -- Helper to select treesitter node by type
      local function select_node(types)
        local node = vim.treesitter.get_node()
        while node do
          local node_type = node:type()
          for _, t in ipairs(types) do
            if node_type:match(t) then
              local sr, sc, er, ec = node:range()
              vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
              vim.cmd("normal! v")
              vim.api.nvim_win_set_cursor(0, { er + 1, ec > 0 and ec - 1 or 0 })
              return
            end
          end
          node = node:parent()
        end
      end

      -- Function text objects
      map({ "x", "o" }, "af", function()
        select_node({ "function", "method", "function_definition", "method_definition", "function_declaration", "arrow_function" })
      end, { desc = "Select outer function" })

      map({ "x", "o" }, "if", function()
        select_node({ "function_body", "block", "statement_block" })
      end, { desc = "Select inner function" })

      -- Class text objects
      map({ "x", "o" }, "ac", function()
        select_node({ "class", "class_definition", "class_declaration", "struct", "impl_item" })
      end, { desc = "Select outer class" })

      -- Block text objects
      map({ "x", "o" }, "ab", function()
        select_node({ "block", "statement_block", "table", "object", "array" })
      end, { desc = "Select outer block" })

      map({ "x", "o" }, "ib", function()
        local node = vim.treesitter.get_node()
        while node do
          local node_type = node:type()
          if node_type:match("block") or node_type:match("statement") or node_type == "table" or node_type == "object" then
            -- Try to get inner content (skip braces)
            local child_count = node:child_count()
            if child_count > 2 then
              -- Select from first non-brace child to last non-brace child
              local first_child = node:child(1)
              local last_child = node:child(child_count - 2)
              if first_child and last_child then
                local sr, sc = first_child:range()
                local _, _, er, ec = last_child:range()
                vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
                vim.cmd("normal! v")
                vim.api.nvim_win_set_cursor(0, { er + 1, ec > 0 and ec - 1 or 0 })
                return
              end
            end
            -- Fallback to whole node
            local sr, sc, er, ec = node:range()
            vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
            vim.cmd("normal! v")
            vim.api.nvim_win_set_cursor(0, { er + 1, ec > 0 and ec - 1 or 0 })
            return
          end
          node = node:parent()
        end
      end, { desc = "Select inner block" })

      -- ========================================================================
      -- Navigation between functions/classes
      -- ========================================================================

      local function goto_node(types, direction)
        local cursor = vim.api.nvim_win_get_cursor(0)
        local row = cursor[1] - 1

        local ok, parser = pcall(vim.treesitter.get_parser)
        if not ok or not parser then return end

        local tree = parser:parse()[1]
        if not tree then return end

        local root = tree:root()
        local best_node = nil
        local best_row = direction == "next" and math.huge or -1

        local function find_nodes(node)
          for child in node:iter_children() do
            local child_type = child:type()
            for _, t in ipairs(types) do
              if child_type:match(t) then
                local sr = child:range()
                if direction == "next" and sr > row and sr < best_row then
                  best_row = sr
                  best_node = child
                elseif direction == "prev" and sr < row and sr > best_row then
                  best_row = sr
                  best_node = child
                end
              end
            end
            find_nodes(child)
          end
        end

        find_nodes(root)

        if best_node then
          local sr, sc = best_node:range()
          vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
        end
      end

      local function_types = { "function", "method", "function_definition", "function_declaration", "arrow_function" }
      local class_types = { "class", "class_definition", "class_declaration", "struct", "impl_item" }

      map({ "n", "x", "o" }, "]f", function() goto_node(function_types, "next") end, { desc = "Next function" })
      map({ "n", "x", "o" }, "[f", function() goto_node(function_types, "prev") end, { desc = "Previous function" })
      map({ "n", "x", "o" }, "]c", function() goto_node(class_types, "next") end, { desc = "Next class" })
      map({ "n", "x", "o" }, "[c", function() goto_node(class_types, "prev") end, { desc = "Previous class" })
    end,
  },
}
