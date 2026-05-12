-- ============================================================================
-- Neotest
-- ============================================================================
-- Test runner integrated with the editor: run nearest, debug, watch failures
-- Adapters: Vitest, Jest, pytest, Go test
-- ============================================================================

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/nvim-nio",
      -- Adapters
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
    },
    keys = {
      { "<leader>rt", function() require("neotest").run.run() end,                                              desc = "Run nearest test" },
      { "<leader>rT", function() require("neotest").run.run(vim.fn.expand("%")) end,                            desc = "Run file tests" },
      { "<leader>ra", function() require("neotest").run.run(vim.uv.cwd()) end,                                  desc = "Run all tests" },
      { "<leader>rl", function() require("neotest").run.run_last() end,                                         desc = "Run last test" },
      { "<leader>rd", function() require("neotest").run.run({ strategy = "dap" }) end,                          desc = "Debug nearest test" },
      { "<leader>rs", function() require("neotest").summary.toggle() end,                                       desc = "Toggle summary" },
      { "<leader>ro", function() require("neotest").output.open({ enter = true, auto_close = true }) end,       desc = "Show output" },
      { "<leader>rO", function() require("neotest").output_panel.toggle() end,                                  desc = "Toggle output panel" },
      { "<leader>rS", function() require("neotest").run.stop() end,                                             desc = "Stop running test" },
      { "<leader>rw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end,                       desc = "Toggle watch" },
      { "[r",         function() require("neotest").jump.prev({ status = "failed" }) end,                       desc = "Previous failed test" },
      { "]r",         function() require("neotest").jump.next({ status = "failed" }) end,                       desc = "Next failed test" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-jest")({
            jestCommand = "npm test --",
            env = { CI = true },
            cwd = function() return vim.fn.getcwd() end,
          }),
          require("neotest-vitest"),
          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "pytest",
          }),
          require("neotest-go"),
        },
        status = { virtual_text = true, signs = true },
        output = { open_on_run = true },
        quickfix = {
          open = function()
            local ok, trouble = pcall(require, "trouble")
            if ok then
              trouble.open({ mode = "quickfix", focus = false })
            else
              vim.cmd("copen")
            end
          end,
        },
        icons = {
          passed = "",
          running = "",
          failed = "",
          skipped = "",
          unknown = "",
        },
      })
    end,
  },
}
