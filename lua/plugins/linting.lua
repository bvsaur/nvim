-- ============================================================================
-- Linting Configuration
-- ============================================================================
-- ESLint and other linters using nvim-lint
-- ============================================================================

return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },

    config = function()
      local lint = require("lint")

      -- Configure linters by filetype
      lint.linters_by_ft = {
        -- JavaScript/TypeScript
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },

        -- Vue/Svelte
        vue = { "eslint_d" },
        svelte = { "eslint_d" },

        -- Python
        python = { "ruff" },

        -- Shell
        sh = { "shellcheck" },
        bash = { "shellcheck" },

        -- Markdown
        markdown = { "markdownlint" },
      }

      -- Helper function to check if a linter is available
      local function linter_available(linter_name)
        local linter = lint.linters[linter_name]
        if not linter then
          return false
        end

        local cmd = linter.cmd
        if type(cmd) == "function" then
          local ok, result = pcall(cmd)
          if not ok or type(result) ~= "string" then
            return false
          end
          cmd = result
        end

        if type(cmd) ~= "string" then
          return false
        end

        return vim.fn.executable(cmd) == 1
      end

      -- Safe lint function that only runs available linters
      local function try_lint()
        -- Only lint if the buffer is modifiable
        if not vim.opt_local.modifiable:get() then
          return
        end

        local ft = vim.bo.filetype
        local linters = lint.linters_by_ft[ft] or {}

        -- Filter to only available linters
        local available_linters = {}
        for _, linter_name in ipairs(linters) do
          if linter_available(linter_name) then
            table.insert(available_linters, linter_name)
          end
        end

        -- Only try to lint if we have available linters
        if #available_linters > 0 then
          lint.try_lint(available_linters)
        end
      end

      -- Create autocommand for linting
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          -- Debounce linting slightly to avoid running too often
          vim.defer_fn(try_lint, 100)
        end,
      })

      -- Keymap to trigger linting manually
      vim.keymap.set("n", "<leader>cl", function()
        lint.try_lint()
      end, { desc = "Trigger linting" })
    end,
  },
}
