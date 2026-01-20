-- ============================================================================
-- Telescope
-- ============================================================================
-- Fuzzy finder for files, buffers, grep, and more
-- ============================================================================

return {
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Native FZF sorter for better performance
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      -- UI select replacement
      "nvim-telescope/telescope-ui-select.nvim",
      -- File browser
      "nvim-telescope/telescope-file-browser.nvim",
    },

    -- ========================================================================
    -- Keybindings
    -- ========================================================================
    keys = {
      -- File pickers
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope git_files<CR>", desc = "Find git files (fast)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>fe", "<cmd>Telescope file_browser<CR>", desc = "File browser" },

      -- Search
      { "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "Grep (live)" },
      { "<leader>sw", "<cmd>Telescope grep_string<CR>", desc = "Search word under cursor" },
      { "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Search in buffer" },

      -- Git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
      { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Git branches" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git status" },

      -- LSP
      { "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
      { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Workspace symbols" },

      -- Vim pickers
      { "<leader>:", "<cmd>Telescope command_history<CR>", desc = "Command history" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
      { "<leader>fc", "<cmd>Telescope commands<CR>", desc = "Commands" },
      { "<leader>fm", "<cmd>Telescope marks<CR>", desc = "Marks" },
      { "<leader>fj", "<cmd>Telescope jumplist<CR>", desc = "Jumplist" },
      { "<leader>fR", "<cmd>Telescope registers<CR>", desc = "Registers" },

      -- Resume last picker
      { "<leader>f.", "<cmd>Telescope resume<CR>", desc = "Resume last picker" },

      -- Quick access (shorter bindings) - uses git_files in git repos (faster)
      {
        "<leader><space>",
        function()
          local builtin = require("telescope.builtin")
          -- Use git_files if in a git repo, otherwise find_files
          local ok = pcall(builtin.git_files, { show_untracked = true })
          if not ok then
            builtin.find_files()
          end
        end,
        desc = "Find files (smart)",
      },
      { "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "Grep" },
      { "<leader>,", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
    },

    -- ========================================================================
    -- Configuration
    -- ========================================================================
    opts = function()
      local actions = require("telescope.actions")
      local themes = require("telescope.themes")

      return {
        defaults = {
          -- Appearance
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "  ",
          multi_icon = " ",

          -- Layout
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },

          -- Sorting
          sorting_strategy = "ascending",
          file_sorter = require("telescope.sorters").get_fuzzy_file,
          generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,

          -- Ignore patterns
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "%.lock",
            "%.png",
            "%.jpg",
            "%.jpeg",
            "%.gif",
            "%.svg",
            "%.ico",
            "%.webp",
            "%.mp3",
            "%.mp4",
            "%.mkv",
            "%.pdf",
            "__pycache__",
            "%.pyc",
            ".venv",
            "vendor/",
            "dist/",
            "build/",
            "target/",
          },

          -- Mappings
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,

              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,

              ["<C-c>"] = actions.close,
              ["<Esc>"] = actions.close,

              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.complete_tag,
            },

            n = {
              ["<Esc>"] = actions.close,
              ["q"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,

              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },

          -- Performance
          path_display = { "truncate" },
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" },
        },

        -- ======================================================================
        -- Picker-specific configurations
        -- ======================================================================
        pickers = {
          find_files = {
            hidden = true,
            -- Use fd if available (MUCH faster for large projects)
            find_command = vim.fn.executable("fd") == 1
              and {
                "fd",
                "--type", "f",
                "--strip-cwd-prefix",
                "--hidden",
                "--follow",
                "--exclude", ".git",
                "--exclude", "node_modules",
                "--exclude", ".venv",
                "--exclude", "venv",
                "--exclude", "__pycache__",
                "--exclude", ".cache",
                "--exclude", "dist",
                "--exclude", "build",
                "--exclude", "target",
                "--exclude", ".next",
                "--exclude", ".nuxt",
                "--exclude", "vendor",
              }
              or nil,
          },
          live_grep = {
            additional_args = vim.fn.executable("rg") == 1
              and function()
                return {
                  "--hidden",
                  "--glob", "!.git",
                  "--glob", "!node_modules",
                  "--glob", "!.venv",
                  "--glob", "!venv",
                  "--glob", "!__pycache__",
                  "--glob", "!dist",
                  "--glob", "!build",
                  "--glob", "!target",
                  "--glob", "!*.lock",
                  "--glob", "!package-lock.json",
                }
              end
              or nil,
          },
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["d"] = actions.delete_buffer,
              },
            },
          },
          help_tags = {
            theme = "dropdown",
          },
          colorscheme = {
            enable_preview = true,
          },
        },

        -- ======================================================================
        -- Extensions
        -- ======================================================================
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          ["ui-select"] = {
            themes.get_dropdown({}),
          },
          file_browser = {
            hijack_netrw = true,
            hidden = true,
            respect_gitignore = false,
          },
        },
      }
    end,

    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      -- Load extensions
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")
      pcall(telescope.load_extension, "file_browser")
    end,
  },
}
