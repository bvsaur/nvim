-- ============================================================================
-- Render Markdown
-- ============================================================================
-- Inline read-mode rendering for markdown buffers (headings, lists, code
-- blocks, tables, checkboxes). Toggle with <leader>um.
-- ============================================================================

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown", "markdown.mdx", "Avante" },
    cmd = { "RenderMarkdown" },
    keys = {
      { "<leader>um", "<cmd>RenderMarkdown buf_toggle<cr>", desc = "Toggle markdown render" },
    },
    opts = {
      file_types = { "markdown", "markdown.mdx", "Avante" },
      completions = { lsp = { enabled = true } },
      heading = {
        sign = false,
        icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
      },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      checkbox = {
        unchecked = { icon = "󰄱 " },
        checked = { icon = "󰱒 " },
      },
    },
  },
}
