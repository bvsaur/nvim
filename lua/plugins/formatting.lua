-- ============================================================================
-- Formatting Configuration
-- ============================================================================
-- Format on save using conform.nvim with Prettier and other formatters
-- ============================================================================

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer (Conform)",
      },
    },

    opts = {
      -- Define formatters by filetype
      formatters_by_ft = {
        -- JavaScript/TypeScript/React
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },

        -- Web languages
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        less = { "prettierd", "prettier", stop_after_first = true },

        -- Data formats
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },

        -- Markdown
        markdown = { "prettierd", "prettier", stop_after_first = true },
        ["markdown.mdx"] = { "prettierd", "prettier", stop_after_first = true },

        -- GraphQL
        graphql = { "prettierd", "prettier", stop_after_first = true },

        -- Vue/Svelte
        vue = { "prettierd", "prettier", stop_after_first = true },
        svelte = { "prettierd", "prettier", stop_after_first = true },

        -- Lua
        lua = { "stylua" },

        -- Python
        python = { "ruff_format", "black", stop_after_first = true },

        -- Go
        go = { "gofumpt", "goimports" },

        -- Rust
        rust = { "rustfmt" },

        -- Shell
        sh = { "shfmt" },
        bash = { "shfmt" },

        -- Fallback for all filetypes
        ["_"] = { "trim_whitespace" },
      },

      -- Format on save configuration
      format_on_save = function(bufnr)
        -- Disable format on save for certain filetypes
        local ignore_filetypes = { "sql", "java" }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end

        -- Disable with a global variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        return {
          timeout_ms = 3000,
          lsp_fallback = true,
        }
      end,

      -- Customize formatters
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" }, -- 2 space indentation
        },
      },
    },

    init = function()
      -- Create commands to toggle format on save
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! disables for current buffer only
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
        vim.notify("Format on save disabled", vim.log.levels.INFO)
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
        vim.notify("Format on save enabled", vim.log.levels.INFO)
      end, {
        desc = "Re-enable autoformat-on-save",
      })

      -- Toggle format on save keymap
      vim.keymap.set("n", "<leader>uf", function()
        if vim.g.disable_autoformat then
          vim.g.disable_autoformat = false
          vim.notify("Format on save enabled", vim.log.levels.INFO)
        else
          vim.g.disable_autoformat = true
          vim.notify("Format on save disabled", vim.log.levels.INFO)
        end
      end, { desc = "Toggle format on save" })
    end,
  },

  -- Mason tool installer for formatters and linters
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        -- Formatters
        "prettierd",
        "prettier",
        "stylua",
        "shfmt",

        -- Linters
        "eslint_d",
      },
      auto_update = false,
      run_on_start = true,
    },
  },
}
