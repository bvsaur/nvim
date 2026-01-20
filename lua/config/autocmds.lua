-- ============================================================================
-- Autocommands
-- ============================================================================
-- Automatic actions triggered by Neovim events
-- ============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ============================================================================
-- General Autocommands
-- ============================================================================

-- Highlight on yank (briefly flash yanked text)
autocmd("TextYankPost", {
  group = augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
  desc = "Highlight yanked text",
})

-- Check if we need to reload the file when it changes
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("CheckTime", { clear = true }),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
  desc = "Check for file changes",
})

-- Resize splits when window is resized
autocmd("VimResized", {
  group = augroup("ResizeSplits", { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
  desc = "Resize splits on window resize",
})

-- ============================================================================
-- Buffer-specific Settings
-- ============================================================================

-- Go to last location when opening a buffer
autocmd("BufReadPost", {
  group = augroup("LastLocation", { clear = true }),
  callback = function(event)
    local exclude = { "gitcommit", "gitrebase", "svn", "hgcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Go to last location when opening buffer",
})

-- Close some filetypes with just 'q'
autocmd("FileType", {
  group = augroup("CloseWithQ", { clear = true }),
  pattern = {
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "startuptime",
    "checkhealth",
    "spectre_panel",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
  desc = "Close certain filetypes with q",
})

-- Set wrap and spell for text filetypes
autocmd("FileType", {
  group = augroup("WrapSpell", { clear = true }),
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  desc = "Enable wrap and spell for text files",
})

-- Fix conceallevel for JSON files
autocmd("FileType", {
  group = augroup("JsonConceal", { clear = true }),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
  desc = "Disable conceal for JSON files",
})

-- ============================================================================
-- Auto-create Directories
-- ============================================================================

-- Create directories when saving a file in a non-existent directory
autocmd("BufWritePre", {
  group = augroup("AutoCreateDir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
  desc = "Auto-create parent directories",
})

-- ============================================================================
-- Terminal Settings
-- ============================================================================

-- Enter insert mode when opening terminal
autocmd("TermOpen", {
  group = augroup("TerminalSettings", { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
  desc = "Terminal settings",
})

-- ============================================================================
-- Large File Handling
-- ============================================================================

-- Disable features for large files (>1.5MB)
autocmd("BufReadPre", {
  group = augroup("LargeFile", { clear = true }),
  callback = function(event)
    local file = event.match
    local size = vim.fn.getfsize(file)
    if size > 1.5 * 1024 * 1024 then
      vim.b.large_file = true
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.syntax = "off"
      vim.cmd("syntax clear")
    end
  end,
  desc = "Disable features for large files",
})
