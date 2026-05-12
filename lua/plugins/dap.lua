-- ============================================================================
-- DAP (Debug Adapter Protocol)
-- ============================================================================
-- Full IDE-style debugging: breakpoints, step, inspect, REPL, variables
-- Adapters for JS/TS, Python, Go, Rust/C/C++
-- ============================================================================

return {
  -- ============================================================================
  -- Core DAP
  -- ============================================================================
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                          desc = "Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,       desc = "Conditional breakpoint" },
      { "<leader>dP", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "Log point" },
      { "<leader>dc", function() require("dap").continue() end,                                                    desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                               desc = "Run to cursor" },
      { "<leader>dg", function() require("dap").goto_() end,                                                       desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end,                                                   desc = "Step into" },
      { "<leader>dj", function() require("dap").down() end,                                                        desc = "Down frame" },
      { "<leader>dk", function() require("dap").up() end,                                                          desc = "Up frame" },
      { "<leader>dl", function() require("dap").run_last() end,                                                    desc = "Run last" },
      { "<leader>do", function() require("dap").step_out() end,                                                    desc = "Step out" },
      { "<leader>dO", function() require("dap").step_over() end,                                                   desc = "Step over" },
      { "<leader>dp", function() require("dap").pause() end,                                                       desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                                 desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end,                                                     desc = "Session" },
      { "<leader>dT", function() require("dap").terminate() end,                                                   desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                            desc = "Hover widget" },
    },
    config = function()
      local dap = require("dap")

      require("mason-nvim-dap").setup({
        ensure_installed = {
          "js-debug-adapter",
          "python",
          "delve",
          "codelldb",
        },
        automatic_installation = true,
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      })

      -- ========================================================================
      -- JS / TS adapters (vscode-js-debug via Mason)
      -- ========================================================================
      for _, adapter in ipairs({ "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }) do
        dap.adapters[adapter] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
      end

      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Chrome (localhost:3000)",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest test",
            runtimeExecutable = "node",
            runtimeArgs = { "./node_modules/jest/bin/jest.js", "--runInBand" },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
        }
      end

      -- ========================================================================
      -- Visual: breakpoint / stopped line signs
      -- ========================================================================
      vim.fn.sign_define("DapBreakpoint",          { text = "●", texthl = "DiagnosticError", linehl = "",               numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn",  linehl = "",               numhl = "" })
      vim.fn.sign_define("DapLogPoint",            { text = "◆", texthl = "DiagnosticInfo",  linehl = "",               numhl = "" })
      vim.fn.sign_define("DapStopped",             { text = "▶", texthl = "DiagnosticOk",    linehl = "Visual",         numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected",  { text = "○", texthl = "DiagnosticHint",  linehl = "",               numhl = "" })
    end,
  },

  -- ============================================================================
  -- DAP UI
  -- ============================================================================
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      { "<leader>du", function() require("dapui").toggle({}) end,                desc = "Toggle DAP UI" },
      { "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "Evaluate expression" },
    },
    opts = {
      icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
      layouts = {
        {
          elements = {
            { id = "scopes",      size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks",      size = 0.25 },
            { id = "watches",     size = 0.25 },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            { id = "repl",    size = 0.5 },
            { id = "console", size = 0.5 },
          },
          position = "bottom",
          size = 10,
        },
      },
      floating = {
        max_height = nil,
        max_width = nil,
        border = "rounded",
        mappings = { close = { "q", "<Esc>" } },
      },
      controls = {
        enabled = true,
        element = "repl",
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)

      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({}) end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end
    end,
  },

  -- ============================================================================
  -- Inline variable values shown next to assignments
  -- ============================================================================
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      virt_text_pos = "eol",
      all_frames = false,
    },
  },

  -- ============================================================================
  -- Python (debugpy)
  -- ============================================================================
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      if vim.fn.executable(path) == 1 then
        require("dap-python").setup(path)
      else
        require("dap-python").setup("python3")
      end
    end,
    keys = {
      { "<leader>dPt", function() require("dap-python").test_method() end, desc = "Debug Python test method" },
      { "<leader>dPc", function() require("dap-python").test_class() end,  desc = "Debug Python test class" },
    },
  },

  -- ============================================================================
  -- Go (delve)
  -- ============================================================================
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {},
  },
}
