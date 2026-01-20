-- ============================================================================
-- Core Options
-- ============================================================================
-- Neovim editor settings for a modern development experience
-- ============================================================================

local opt = vim.opt

-- ============================================================================
-- UI Settings
-- ============================================================================

opt.number = true              -- Show line numbers
opt.relativenumber = true      -- Relative line numbers for easy navigation
opt.cursorline = true          -- Highlight current line
opt.signcolumn = "yes"         -- Always show sign column (prevents text shift)
opt.termguicolors = true       -- True color support
opt.showmode = false           -- Don't show mode (shown in statusline)
opt.showcmd = false            -- Don't show partial command
opt.cmdheight = 1              -- Command line height
opt.laststatus = 3             -- Global statusline
opt.scrolloff = 8              -- Lines of context above/below cursor
opt.sidescrolloff = 8          -- Columns of context left/right of cursor
opt.splitbelow = true          -- Horizontal splits go below
opt.splitright = true          -- Vertical splits go right
opt.splitkeep = "screen"       -- Keep text on screen when splitting
opt.pumheight = 10             -- Max items in popup menu
opt.pumblend = 10              -- Popup menu transparency
opt.winblend = 10              -- Floating window transparency
opt.fillchars = {
  foldopen = "-",
  foldclose = "+",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",                   -- Hide ~ at end of buffer
}
opt.list = true                -- Show invisible characters
opt.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "›",
  precedes = "‹",
  nbsp = "␣",
}

-- ============================================================================
-- Editor Behavior
-- ============================================================================

opt.mouse = "a"                -- Enable mouse in all modes
opt.clipboard = "unnamedplus"  -- Use system clipboard
opt.virtualedit = "block"      -- Allow cursor beyond line end in visual block
opt.inccommand = "split"       -- Preview substitutions live
opt.jumpoptions = "view"       -- Preserve view when jumping
opt.confirm = true             -- Confirm to save changes before closing
opt.autowrite = true           -- Auto save before running commands
opt.undofile = true            -- Persistent undo history
opt.undolevels = 10000         -- Maximum undo levels
opt.updatetime = 200           -- Faster completion/swap file write
opt.timeoutlen = 300           -- Time to wait for mapped sequence (ms)
opt.ttimeoutlen = 10           -- Time to wait for key code sequence (ms)

-- ============================================================================
-- Indentation
-- ============================================================================

opt.expandtab = true           -- Use spaces instead of tabs
opt.shiftwidth = 2             -- Spaces per indentation level
opt.tabstop = 2                -- Spaces per tab
opt.softtabstop = 2            -- Spaces per tab when editing
opt.smartindent = true         -- Smart auto-indentation
opt.shiftround = true          -- Round indent to multiple of shiftwidth
opt.breakindent = true         -- Preserve indentation in wrapped lines

-- ============================================================================
-- Search
-- ============================================================================

opt.ignorecase = true          -- Ignore case in search
opt.smartcase = true           -- Case-sensitive if uppercase present
opt.hlsearch = true            -- Highlight search matches
opt.incsearch = true           -- Show matches as you type
opt.grepformat = "%f:%l:%c:%m" -- Grep output format
-- Use ripgrep for :grep if available
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep"
end

-- ============================================================================
-- Folding (using Treesitter)
-- ============================================================================

opt.foldlevel = 99             -- Start with all folds open
opt.foldlevelstart = 99        -- Same for new buffers
opt.foldenable = true          -- Enable folding
opt.foldmethod = "expr"        -- Expression-based folding
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"  -- Use Treesitter for folding

-- ============================================================================
-- Completion
-- ============================================================================

opt.completeopt = "menu,menuone,noselect"  -- Completion options
opt.wildmode = "longest:full,full"         -- Command-line completion mode
opt.wildignorecase = true                   -- Ignore case in wildmenu

-- ============================================================================
-- Performance
-- ============================================================================

opt.lazyredraw = false         -- Don't redraw while executing macros (can cause issues)
opt.synmaxcol = 240            -- Max column for syntax highlighting
opt.redrawtime = 1500          -- Time for highlighting (ms)

-- Disable builtin plugins we don't need (performance)
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_tutor = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_spellfile_plugin = 1

-- ============================================================================
-- File Handling
-- ============================================================================

opt.encoding = "utf-8"         -- Default encoding
opt.fileencoding = "utf-8"     -- File encoding
opt.backup = false             -- Don't create backup files
opt.writebackup = false        -- Don't create backup before overwriting
opt.swapfile = false           -- Don't use swapfiles

-- ============================================================================
-- Wrap and Formatting
-- ============================================================================

opt.wrap = false               -- Don't wrap lines by default
opt.linebreak = true           -- Wrap at word boundaries when wrap is on
opt.textwidth = 0              -- No automatic line breaking
opt.formatoptions = "jcroqlnt" -- Format options for text formatting
