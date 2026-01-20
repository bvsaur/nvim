# Neovim Configuration

A modern, modular Neovim configuration built for professional development.

**Requires:** Neovim >= 0.11

## Features

- **Lazy Loading**: Fast startup with lazy.nvim plugin manager
- **LSP Support**: Full language server integration with auto-installation
- **Modern UI**: Catppuccin theme, bufferline tabs, smooth scrolling
- **Fuzzy Finding**: Telescope for files, grep, and more
- **Git Integration**: Gitsigns, git status in file explorer
- **Treesitter**: Syntax highlighting and code navigation
- **Auto-completion**: nvim-cmp with snippets support

## Requirements

### Required

- **Neovim** >= 0.11
- **Git** (for plugin installation)
- **Nerd Font** (for icons) - e.g., FiraCode Nerd Font, JetBrainsMono Nerd Font

### Recommended (for best performance)

```bash
# macOS (Homebrew)
brew install fd ripgrep

# Ubuntu/Debian
sudo apt install fd-find ripgrep

# Arch Linux
sudo pacman -S fd ripgrep
```

- **fd**: Fast file finder (makes Telescope much faster)
- **ripgrep**: Fast grep (for live grep search)

## Installation

1. **Backup existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this configuration**:
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```
   
   On first launch, lazy.nvim will automatically install all plugins.

4. **Install LSP servers**:
   ```vim
   :Mason
   ```
   
   Servers are auto-installed, but you can manage them here.

## Directory Structure

```
~/.config/nvim/
├── init.lua                    # Entry point - loads all modules
├── lua/
│   ├── config/
│   │   ├── options.lua         # Neovim options and settings
│   │   ├── keymaps.lua         # Global keybindings
│   │   ├── autocmds.lua        # Autocommands
│   │   └── lazy.lua            # Plugin manager setup
│   └── plugins/
│       ├── autopairs.lua       # Auto bracket/quote pairing
│       ├── bufferline.lua      # Tab-like buffer bar
│       ├── cmp.lua             # Autocompletion
│       ├── colorscheme.lua     # Catppuccin theme
│       ├── comment.lua         # Code commenting
│       ├── gitsigns.lua        # Git signs in gutter
│       ├── indent-blankline.lua # Indent guides
│       ├── lsp.lua             # Language Server Protocol
│       ├── lualine.lua         # Statusline
│       ├── nvim-tree.lua       # File explorer
│       ├── smooth-scroll.lua   # Smooth scrolling
│       ├── surround.lua        # Surround operations
│       ├── telescope.lua       # Fuzzy finder
│       ├── treesitter.lua      # Syntax highlighting
│       └── which-key.lua       # Keybinding hints
└── .gitignore
```

## Keybindings

**Leader key:** `<Space>`

### General

| Key | Mode | Description |
|-----|------|-------------|
| `jk` or `jj` | Insert | Exit insert mode |
| `<Esc>` | Normal | Clear search highlight |
| `<C-s>` | Any | Save file |
| `<leader>qq` | Normal | Quit all |

### File Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `<leader><space>` | Normal | Find files (smart - uses git in repos) |
| `<leader>ff` | Normal | Find files |
| `<leader>fg` | Normal | Find git files (fast) |
| `<leader>fr` | Normal | Recent files |
| `<leader>fb` | Normal | Open buffers |
| `<leader>fe` | Normal | File browser |
| `<leader>e` | Normal | Toggle file explorer |
| `<leader>E` | Normal | Focus file explorer |

### Search

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>/` | Normal | Live grep |
| `<leader>sg` | Normal | Live grep |
| `<leader>sw` | Normal | Search word under cursor |
| `<leader>ss` | Normal | Search in current buffer |

### Buffers (Tabs)

| Key | Mode | Description |
|-----|------|-------------|
| `Shift+H` | Normal | Previous buffer |
| `Shift+L` | Normal | Next buffer |
| `<leader>1-9` | Normal | Go to buffer 1-9 |
| `<leader>bd` | Normal | Delete buffer |
| `<leader>bo` | Normal | Close other buffers |
| `<leader>bp` | Normal | Pin buffer |
| `<leader>bb` | Normal | Switch to alternate buffer |

### Windows

| Key | Mode | Description |
|-----|------|-------------|
| `<C-h/j/k/l>` | Normal | Navigate windows |
| `<C-Up/Down/Left/Right>` | Normal | Resize windows |
| `<leader>wv` | Normal | Split vertically |
| `<leader>ws` | Normal | Split horizontally |
| `<leader>wq` | Normal | Close split |
| `<leader>we` | Normal | Equalize splits |

### Scrolling

| Key | Mode | Description |
|-----|------|-------------|
| `<C-d>` | Normal | Scroll half page down (smooth) |
| `<C-u>` | Normal | Scroll half page up (smooth) |
| `<C-e>` | Normal | Scroll 3 lines down |
| `<C-y>` | Normal | Scroll 3 lines up |
| `5j` / `10k` | Normal | Move N lines (use relative numbers) |

### LSP (Language Server)

| Key | Mode | Description |
|-----|------|-------------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gr` | Normal | Go to references |
| `gI` | Normal | Go to implementation |
| `gy` | Normal | Go to type definition |
| `K` | Normal | Hover documentation |
| `gK` | Normal | Signature help |
| `<leader>cr` | Normal | Rename symbol |
| `<leader>ca` | Normal/Visual | Code action |
| `<leader>cf` | Normal/Visual | Format |
| `<leader>cd` | Normal | Line diagnostics |
| `<leader>uh` | Normal | Toggle inlay hints |

### Git

| Key | Mode | Description |
|-----|------|-------------|
| `]h` / `[h` | Normal | Next/previous hunk |
| `<leader>hs` | Normal/Visual | Stage hunk |
| `<leader>hr` | Normal/Visual | Reset hunk |
| `<leader>hS` | Normal | Stage buffer |
| `<leader>hR` | Normal | Reset buffer |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hp` | Normal | Preview hunk |
| `<leader>hb` | Normal | Blame line |
| `<leader>hB` | Normal | Toggle line blame |
| `<leader>hd` | Normal | Diff this |
| `<leader>gc` | Normal | Git commits |
| `<leader>gb` | Normal | Git branches |
| `<leader>gs` | Normal | Git status |

### Editing

| Key | Mode | Description |
|-----|------|-------------|
| `gcc` | Normal | Toggle line comment |
| `gc{motion}` | Normal | Comment motion |
| `gbc` | Normal | Toggle block comment |
| `<A-j>` / `<A-k>` | Normal/Insert/Visual | Move line(s) up/down |
| `<` / `>` | Visual | Indent (stays in visual mode) |
| `<leader>d` | Normal/Visual | Duplicate line/selection |

### Surround

| Key | Mode | Description |
|-----|------|-------------|
| `ys{motion}{char}` | Normal | Add surround |
| `ds{char}` | Normal | Delete surround |
| `cs{from}{to}` | Normal | Change surround |
| `S{char}` | Visual | Surround selection |

**Examples:**
- `ysiw"` - Surround word with quotes: `hello` → `"hello"`
- `ds"` - Delete quotes: `"hello"` → `hello`
- `cs"'` - Change quotes: `"hello"` → `'hello'`

### Text Objects

| Key | Mode | Description |
|-----|------|-------------|
| `af` / `if` | Visual/Operator | Outer/inner function |
| `ac` / `ic` | Visual/Operator | Outer/inner class |
| `ab` / `ib` | Visual/Operator | Outer/inner block |
| `ih` | Visual/Operator | Git hunk |

### Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `]f` / `[f` | Normal | Next/previous function |
| `]c` / `[c` | Normal | Next/previous class |
| `]d` / `[d` | Normal | Next/previous diagnostic |
| `]h` / `[h` | Normal | Next/previous git hunk |
| `]b` / `[b` | Normal | Next/previous buffer |

### Diagnostics & Quickfix

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>xq` | Normal | Open quickfix list |
| `<leader>xl` | Normal | Open location list |
| `]q` / `[q` | Normal | Next/previous quickfix |
| `]l` / `[l` | Normal | Next/previous location |

### Terminal

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>tt` | Normal | Open terminal |
| `<leader>tv` | Normal | Terminal (vertical split) |
| `<leader>ts` | Normal | Terminal (horizontal split) |
| `<Esc><Esc>` | Terminal | Exit terminal mode |

### UI Toggles

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>uw` | Normal | Toggle word wrap |
| `<leader>ul` | Normal | Toggle relative numbers |
| `<leader>us` | Normal | Toggle spell check |

### Completion (Insert Mode)

| Key | Description |
|-----|-------------|
| `<C-n>` / `<C-p>` | Next/previous item |
| `<C-Space>` | Trigger completion |
| `<CR>` | Confirm selection |
| `<Tab>` | Next item or expand snippet |
| `<S-Tab>` | Previous item or previous snippet placeholder |
| `<C-e>` | Cancel completion |
| `<C-b>` / `<C-f>` | Scroll docs |

## Installed Plugins

| Plugin | Description |
|--------|-------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [catppuccin](https://github.com/catppuccin/nvim) | Color scheme |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configuration |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP/tool installer |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git integration |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding hints |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto bracket pairing |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Commenting |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Surround operations |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides |
| [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) | Smooth scrolling |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP progress |

## LSP Servers

Pre-configured language servers (auto-installed via Mason):

- **lua_ls** - Lua (with Neovim API support)
- **ts_ls** - TypeScript/JavaScript
- **pyright** - Python
- **rust_analyzer** - Rust
- **gopls** - Go
- **jsonls** - JSON
- **yamlls** - YAML
- **html** - HTML
- **cssls** - CSS
- **tailwindcss** - Tailwind CSS
- **bashls** - Bash/Shell

## Customization

### Adding a new plugin

Create a new file in `lua/plugins/`:

```lua
-- lua/plugins/my-plugin.lua
return {
  {
    "author/plugin-name",
    event = "VeryLazy",  -- Lazy load
    opts = {
      -- Plugin options
    },
  },
}
```

### Adding local settings

Create `lua/config/local.lua` (gitignored) for machine-specific settings:

```lua
-- lua/config/local.lua
vim.opt.shell = "/bin/zsh"
-- Add your local overrides here
```

### Changing the color scheme

Edit `lua/plugins/colorscheme.lua` and change the `flavour`:

```lua
opts = {
  flavour = "mocha",  -- latte, frappe, macchiato, mocha
}
```

## Troubleshooting

### Plugins not installing
```vim
:Lazy sync
```

### LSP not working
```vim
:Mason
:LspInfo
```

### Icons not showing
Make sure your terminal is using a Nerd Font. Install one:
```bash
brew install --cask font-fira-code-nerd-font
```

### Slow file finding in large projects
Install fd and ripgrep:
```bash
brew install fd ripgrep
```

Use `<leader>fg` (git files) instead of `<leader>ff` for even faster results in git repos.

### Check health
```vim
:checkhealth
```

## License

MIT
