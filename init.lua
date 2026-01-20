-- ============================================================================
-- Neovim Configuration
-- ============================================================================
-- A modern, modular Neovim configuration using lazy.nvim
-- Requires: Neovim >= 0.11
-- ============================================================================

-- Set leader key before loading plugins (required for correct mappings)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load core configuration
require("config.options")    -- Editor options and settings
require("config.lazy")       -- Plugin manager bootstrap and setup
require("config.keymaps")    -- Global keybindings
require("config.autocmds")   -- Autocommands
