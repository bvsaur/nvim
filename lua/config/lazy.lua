-- ============================================================================
-- lazy.nvim Bootstrap and Configuration
-- ============================================================================
-- Automatically installs lazy.nvim if not present and loads all plugins
-- ============================================================================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- Plugin Specifications
-- ============================================================================
-- All plugins are defined in lua/plugins/*.lua files
-- Each file returns a table (or list of tables) with plugin specs
-- ============================================================================

require("lazy").setup({
  spec = {
    -- Import all plugin configurations from lua/plugins/
    { import = "plugins" },
  },

  -- ============================================================================
  -- lazy.nvim Options
  -- ============================================================================

  defaults = {
    lazy = false,          -- Plugins are NOT lazy-loaded by default
    version = false,       -- Always use the latest git commit
  },

  install = {
    colorscheme = { "catppuccin", "habamax" },  -- Colorschemes to use during install
  },

  checker = {
    enabled = true,        -- Automatically check for plugin updates
    notify = false,        -- Don't notify on updates (check manually with :Lazy)
  },

  change_detection = {
    enabled = true,        -- Auto-reload on config change
    notify = false,        -- Don't notify on config change
  },

  performance = {
    rtp = {
      -- Disable some built-in plugins we don't need
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },

  ui = {
    -- Border style for lazy.nvim floating windows
    border = "rounded",
    icons = {
      cmd = " ",
      config = "",
      event = " ",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      require = "󰢱 ",
      source = " ",
      start = " ",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },
})
