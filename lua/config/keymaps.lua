-- ============================================================================
-- Global Keymaps
-- ============================================================================
-- Core keybindings that don't depend on plugins
-- Plugin-specific keymaps are defined in their respective plugin files
-- ============================================================================

local map = vim.keymap.set

-- ============================================================================
-- General
-- ============================================================================

-- Better escape (also works in terminal mode)
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Clear search highlighting with Escape
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Save file with Ctrl+S (works in all modes)
map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>w<CR><Esc>", { desc = "Save file" })

-- Save file without formatting
map("n", "<leader>W", "<cmd>noautocmd w<CR>", { desc = "Save without formatting" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })

-- Better up/down (respects wrapped lines)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- ============================================================================
-- Window Management
-- ============================================================================

-- Navigate between windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows with arrows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Split windows
map("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>wq", "<cmd>close<CR>", { desc = "Close current split" })

-- ============================================================================
-- Buffer Management
-- ============================================================================

-- Buffer navigation is handled by bufferline plugin (see plugins/bufferline.lua)
-- Fallback mappings if bufferline is not loaded
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- Switch to alternate buffer
map("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Switch to alternate buffer" })

-- Delete buffer
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>bdelete!<CR>", { desc = "Delete buffer (force)" })

-- ============================================================================
-- Tab Management
-- ============================================================================

map("n", "<leader><tab>n", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader><tab>q", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader><tab>l", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<leader><tab>h", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

-- ============================================================================
-- Text Manipulation
-- ============================================================================

-- Move lines up/down
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Duplicate line/selection (moved to <leader>D — <leader>d is the Debug group)
map("n", "<leader>D", "<cmd>t.<CR>", { desc = "Duplicate line" })
map("v", "<leader>D", ":t'><CR>gv", { desc = "Duplicate selection" })

-- Join lines without moving cursor
map("n", "J", "mzJ`z", { desc = "Join lines" })

-- ============================================================================
-- Search and Navigation
-- ============================================================================

-- Center screen after search navigation
map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Center screen after page up/down
map("n", "<C-d>", "<C-d>zz", { desc = "Page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Page up" })

-- Scroll a few lines up/down (without moving cursor)
map({ "n", "v" }, "<C-e>", "3<C-e>", { desc = "Scroll down" })
map({ "n", "v" }, "<C-y>", "3<C-y>", { desc = "Scroll up" })

-- Note: For moving multiple lines, use relative line numbers + count
-- Example: 5j moves down 5 lines, 10k moves up 10 lines
-- The line numbers on the left show how many lines away each line is

-- Go to beginning/end of line (easier than ^ and $)
map({ "n", "o", "x" }, "H", "^", { desc = "Go to line start" })
map({ "n", "o", "x" }, "L", "$", { desc = "Go to line end" })

-- ============================================================================
-- Yank and Paste
-- ============================================================================

-- Paste without losing register content
map("x", "p", [["_dP]], { desc = "Paste without losing register" })

-- Yank to end of line (consistent with D and C)
map("n", "Y", "y$", { desc = "Yank to end of line" })

-- Delete without yanking
map({ "n", "v" }, "<leader>x", [["_d]], { desc = "Delete without yank" })

-- ============================================================================
-- Quick Actions
-- ============================================================================

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- New file
map("n", "<leader>fn", "<cmd>enew<CR>", { desc = "New file" })

-- Toggle options
map("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle word wrap" })
map("n", "<leader>ul", "<cmd>set relativenumber!<CR>", { desc = "Toggle relative numbers" })
map("n", "<leader>us", "<cmd>set spell!<CR>", { desc = "Toggle spell check" })

-- ============================================================================
-- Quickfix and Location List
-- ============================================================================

map("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })
map("n", "[l", "<cmd>lprev<CR>", { desc = "Previous location" })
map("n", "]l", "<cmd>lnext<CR>", { desc = "Next location" })
map("n", "<leader>xq", "<cmd>copen<CR>", { desc = "Open quickfix list" })
map("n", "<leader>xl", "<cmd>lopen<CR>", { desc = "Open location list" })

-- ============================================================================
-- Terminal
-- ============================================================================

-- Better terminal escape
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Go to right window" })

-- Terminal opening is handled by toggleterm.nvim:
--   <C-\>         Toggle (default)
--   <leader>tf    Floating terminal
--   <leader>th    Horizontal terminal
--   <leader>tV    Vertical terminal
--   <leader>tg    LazyGit

-- ============================================================================
-- Diagnostic Navigation
-- ============================================================================

map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
