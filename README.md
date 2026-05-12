# Neovim IDE Configuration

A modular Neovim configuration that turns Neovim into a full IDE — LSP, debugging, testing, AI completion, Claude Code integration, and the usual modern editor amenities.

**Requires:** Neovim >= 0.11

---

## Table of contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [First-time setup checklist](#first-time-setup-checklist)
- [Directory structure](#directory-structure)
- [Keybindings](#keybindings)
- [Common workflows](#common-workflows)
- [Installed plugins](#installed-plugins)
- [LSP servers, formatters, linters](#lsp-servers-formatters-linters)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)

---

## Features

### Editing & navigation
- Lazy-loaded plugin manager (lazy.nvim)
- Treesitter syntax highlighting, folding, and text-objects
- Telescope fuzzy finder (files, grep, symbols, git, marks, registers, …)
- nvim-tree file explorer with git status
- Aerial symbol outline
- Buffer tabs (bufferline) + global statusline (lualine)
- Smooth scrolling, indent guides, auto-pairs, surround, comment toggling
- Persistent undo, system clipboard, mouse, terminal in-window

### Language tooling
- LSP via `nvim-lspconfig` + `mason.nvim` (auto-install servers)
- Inlay hints, signature help, hover docs, code actions, rename, codelens
- Diagnostics via `nvim-lint` (ESLint, ruff, shellcheck, markdownlint)
- Format on save via `conform.nvim` (Prettier, stylua, ruff, gofumpt, …)

### Completion & AI
- nvim-cmp (LSP / snippets / buffer / path / cmdline)
- **GitHub Copilot** — inline ghost-text + cmp source
- **Claude Code** integration — chat, send selections, accept/reject diffs from inside the editor

### Debugging & testing
- **nvim-dap** debugger with full UI (breakpoints, step, scopes, watches, REPL)
- DAP adapters: vscode-js-debug (JS/TS), debugpy (Python), delve (Go), codelldb (Rust/C/C++)
- **neotest** runner with Jest, Vitest, pytest, go test adapters
- Run nearest test / file / project, debug a test, watch for failures

### Quality of life
- **Trouble** workspace diagnostics / refs panel
- **Todo-comments** highlighting + Telescope/Trouble search
- **Spectre** project search-and-replace UI
- **Toggleterm** floating/split terminals + LazyGit
- **Persistence** session save/restore per directory
- **Alpha** dashboard
- **Noice** + **nvim-notify** for prettier cmdline / messages / notifications
- **Gitsigns** + **diffview** for line/hunk staging, blame, file history
- **Which-key** keybinding hints
- **Render-markdown** inline read mode for `.md` buffers (headings, lists, code, tables, checkboxes)

---

## Requirements

### Required

| Tool | Purpose |
|---|---|
| Neovim ≥ 0.11 | Editor |
| git | Plugin install |
| A Nerd Font | UI icons (FiraCode / JetBrainsMono / etc.) |
| Node.js | Copilot + JS LSP + js-debug |
| `claude` CLI | Claude Code integration — `npm i -g @anthropic-ai/claude-code` |

### Strongly recommended

```bash
# macOS
brew install fd ripgrep lazygit

# Linux (Debian/Ubuntu)
sudo apt install fd-find ripgrep
# lazygit: https://github.com/jesseduffield/lazygit#installation
```

| Tool | Why |
|---|---|
| `fd` | Faster file finding (Telescope) |
| `rg` (ripgrep) | Faster live grep |
| `lazygit` | Used by `<leader>tg` floating UI |
| `trash` | `nvim-tree` uses it for safe deletes |

---

## Installation

```bash
# 1. Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null

# 2. Clone
git clone <your-repo-url> ~/.config/nvim

# 3. Start nvim — lazy.nvim auto-installs every plugin
nvim
```

Wait for lazy.nvim to finish (you'll see progress in the floating window). Then close and re-open Neovim once so all `BufReadPre`/`InsertEnter` plugins are in a clean state.

---

## First-time setup checklist

After the first `nvim` launch:

1. **Verify plugin install:** `:Lazy` — everything should be green.
2. **Install LSP servers, formatters, linters, debug adapters:**
   ```vim
   :Mason
   :MasonToolsInstall
   ```
   Wait for `js-debug-adapter`, `debugpy`, `delve`, `codelldb`, `prettierd`, `stylua`, `eslint_d`, etc. to install.
3. **Authenticate Copilot:**
   ```vim
   :Copilot auth
   ```
   Follow the device-code flow in your browser. Then `:Copilot status` to confirm.
4. **Install Claude Code CLI (if not already):**
   ```bash
   npm install -g @anthropic-ai/claude-code
   claude --version
   ```
5. **Optional:** `brew install lazygit` if you want `<leader>tg`.
6. **Check health:**
   ```vim
   :checkhealth
   ```

---

## Directory structure

```
~/.config/nvim/
├── init.lua                       # Entry — loads core modules
├── lazy-lock.json                 # Plugin version lockfile
├── lua/
│   ├── config/
│   │   ├── options.lua            # vim.opt settings
│   │   ├── keymaps.lua            # Global keybindings
│   │   ├── autocmds.lua           # Autocommands
│   │   └── lazy.lua               # lazy.nvim bootstrap
│   └── plugins/
│       ├── aerial.lua             # Symbol outline
│       ├── alpha.lua              # Dashboard
│       ├── autopairs.lua          # Auto bracket / quote
│       ├── bufferline.lua         # Buffer tabs
│       ├── claudecode.lua         # Claude Code integration
│       ├── cmp.lua                # Completion engine
│       ├── colorscheme.lua        # Catppuccin
│       ├── comment.lua            # gcc / gc{motion}
│       ├── copilot.lua            # GitHub Copilot
│       ├── dap.lua                # Debugger + adapters
│       ├── diffview.lua           # Git diff viewer
│       ├── formatting.lua         # Conform (format on save)
│       ├── gitsigns.lua           # Git gutter + blame
│       ├── indent-blankline.lua   # Indent guides
│       ├── linting.lua            # nvim-lint
│       ├── lsp.lua                # LSP servers
│       ├── lualine.lua            # Statusline
│       ├── neotest.lua            # Test runner
│       ├── noice.lua              # Cmdline / messages / notify
│       ├── nvim-tree.lua          # File explorer
│       ├── persistence.lua        # Session restore
│       ├── render-markdown.lua    # Inline markdown read mode
│       ├── smooth-scroll.lua      # Neoscroll
│       ├── snacks.lua             # Utilities (claudecode dep)
│       ├── spectre.lua            # Search & replace UI
│       ├── surround.lua           # ys / ds / cs
│       ├── telescope.lua          # Fuzzy finder
│       ├── todo-comments.lua      # TODO highlighting
│       ├── toggleterm.lua         # Terminals + LazyGit
│       ├── treesitter.lua         # Parsers + folding
│       ├── trouble.lua            # Diagnostics panel
│       └── which-key.lua          # Keybinding hints
└── README.md
```

---

## Keybindings

**Leader:** `<Space>` &nbsp;&nbsp;•&nbsp;&nbsp; **Local leader:** `\`

> Press `<Space>` and pause — which-key shows what's available.

### General

| Key | Mode | Description |
|---|---|---|
| `jk`, `jj` | Insert | Exit insert mode |
| `<Esc>` | Normal | Clear search highlight |
| `<C-s>` | Any | Save file |
| `<leader>W` | Normal | Save without autoformat |
| `<leader>qq` | Normal | Quit all |
| `<C-a>` | Normal | Select all |
| `<leader>fn` | Normal | New file |

### File navigation

| Key | Description |
|---|---|
| `<leader><space>` | Find files (smart — git when in repo) |
| `<leader>ff` | Find files |
| `<leader>fg` | Git files |
| `<leader>fr` | Recent files |
| `<leader>fb` | Open buffers |
| `<leader>fe` | File browser |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |
| `<leader>fc` | Commands |
| `<leader>fm` | Marks |
| `<leader>fj` | Jumplist |
| `<leader>fR` | Registers |
| `<leader>f.` | Resume last picker |
| `<leader>e` | Toggle file explorer |
| `<leader>E` | Focus file explorer |

### Search

| Key | Description |
|---|---|
| `<leader>/`, `<leader>sg` | Live grep |
| `<leader>sw` | Grep word under cursor |
| `<leader>ss` | Search in current buffer |
| `<leader>sr` | **Spectre** — search & replace UI |
| `<leader>sR` | Spectre on word under cursor |
| `<leader>sp` | Spectre on current file |
| `<leader>st` | TODO comments (Telescope) |
| `<leader>sT` | TODO/FIX/FIXME only |
| `<leader>:` | Command history |

### Buffers / tabs

| Key | Description |
|---|---|
| `[b` / `]b` | Previous / next buffer |
| `<leader>bb` | Alternate buffer |
| `<leader>bd` | Delete buffer |
| `<leader>bD` | Delete buffer (force) |
| `<leader><tab>n` | New tab |
| `<leader><tab>q` | Close tab |
| `<leader><tab>l` / `h` | Next / prev tab |

### Windows

| Key | Description |
|---|---|
| `<C-h/j/k/l>` | Navigate windows |
| `<C-Up/Down/Left/Right>` | Resize windows |
| `<leader>wv` | Split vertical |
| `<leader>ws` | Split horizontal |
| `<leader>we` | Equalize splits |
| `<leader>wq` | Close split |

### LSP

| Key | Description |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `K` | Hover docs |
| `gK` | Signature help |
| `<leader>cr` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>cf` | Format (LSP) |
| `<leader>cF` | Format (Conform / Prettier) |
| `<leader>cd` | Line diagnostics |
| `<leader>cc` / `cC` | Run / refresh codelens |
| `<leader>cm` | Open Mason |
| `<leader>uh` | Toggle inlay hints |
| `<leader>ls` / `lS` | Document / workspace symbols |
| `]d` / `[d` | Next / prev diagnostic |

### AI — Copilot (insert mode)

| Key | Description |
|---|---|
| `Alt-l` | Accept Copilot ghost-text suggestion |
| `Alt-w` | Accept next word |
| `Alt-j` | Accept next line |
| `Alt-]` / `Alt-[` | Next / previous suggestion |
| `C-]` | Dismiss suggestion |

Copilot also appears as a source in the cmp popup (kind icon ``).

### AI — Claude Code (`<leader>a`)

| Key | Description |
|---|---|
| `<leader>ac` | Toggle Claude Code split |
| `<leader>af` | Focus Claude split |
| `<leader>ar` | Resume Claude session |
| `<leader>aC` | Continue last session |
| `<leader>am` | Select Claude model |
| `<leader>ab` | Add current buffer to context |
| `<leader>as` (visual) | Send selection to Claude |
| `<leader>as` (tree) | Add file from explorer |
| `<leader>aa` | Accept Claude's diff |
| `<leader>ad` | Reject Claude's diff |

### Debugging (`<leader>d`)

| Key | Description |
|---|---|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dP` | Log point |
| `<leader>dc` | Continue / start |
| `<leader>dC` | Run to cursor |
| `<leader>di` | Step into |
| `<leader>dO` | Step over |
| `<leader>do` | Step out |
| `<leader>dj` / `dk` | Up / down stack frame |
| `<leader>dl` | Run last config |
| `<leader>dp` | Pause |
| `<leader>dr` | Toggle REPL |
| `<leader>ds` | Show session |
| `<leader>dT` | Terminate |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` | Evaluate expression (n / v) |
| `<leader>dw` | Hover widget |
| `<leader>dPt` | Debug Python test method |
| `<leader>dPc` | Debug Python test class |

### Testing (`<leader>r`)

| Key | Description |
|---|---|
| `<leader>rt` | Run nearest test |
| `<leader>rT` | Run file tests |
| `<leader>ra` | Run all tests |
| `<leader>rl` | Run last test |
| `<leader>rd` | Debug nearest test |
| `<leader>rs` | Toggle test summary |
| `<leader>ro` | Show test output |
| `<leader>rO` | Toggle output panel |
| `<leader>rS` | Stop running test |
| `<leader>rw` | Toggle watch on file |
| `[r` / `]r` | Previous / next failed test |

### Symbol outline

| Key | Description |
|---|---|
| `<leader>o` | Toggle Aerial outline |
| `<leader>O` | Aerial nav |

### Terminal (`<C-\>` + `<leader>t`)

| Key | Description |
|---|---|
| `<C-\>` | Toggle terminal |
| `<leader>tf` | Floating terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tV` | Vertical terminal |
| `<leader>tg` | LazyGit (floating) |
| `<Esc><Esc>`, `jk` | Exit terminal mode |

### Git

| Key | Description |
|---|---|
| `]h` / `[h` | Next / prev hunk |
| `<leader>hs` (n/v) | Stage hunk |
| `<leader>hr` (n/v) | Reset hunk |
| `<leader>hS` / `hR` | Stage / reset buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line (full) |
| `<leader>hB` | Toggle inline blame |
| `<leader>hd` | Diff this |
| `<leader>gc` | Git commits (Telescope) |
| `<leader>gb` | Git branches |
| `<leader>gs` | Git status |
| `<leader>gd` | Diffview (all changes) |
| `<leader>gD` | Diff with previous commit |
| `<leader>gh` | File history (current) |
| `<leader>gH` | File history (repo) |
| `<leader>gq` | Close diffview |

### Diagnostics — Trouble (`<leader>x`)

| Key | Description |
|---|---|
| `<leader>xx` | Workspace diagnostics |
| `<leader>xX` | Buffer diagnostics |
| `<leader>xs` | Symbols |
| `<leader>xt` | TODO list |
| `<leader>xr` | LSP refs / defs / impls |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |
| `<leader>xq` | Open quickfix |
| `<leader>xl` | Open location list |
| `]q` / `[q` | Next / prev quickfix |
| `]l` / `[l` | Next / prev location |

### Sessions (`<leader>q`)

| Key | Description |
|---|---|
| `<leader>qs` | Restore session for cwd |
| `<leader>qS` | Select session |
| `<leader>ql` | Restore last session |
| `<leader>qd` | Stop saving session |
| `<leader>qq` | Quit all |

### Noice / notifications

| Key | Description |
|---|---|
| `<leader>snl` | Last message |
| `<leader>snh` | Message history |
| `<leader>sna` | All messages |
| `<leader>snd` | Dismiss all |
| `<leader>un` | Dismiss notifications |
| `<S-Enter>` (cmdline) | Redirect cmdline output |
| `<C-f>` / `<C-b>` | Scroll LSP hover docs |

### Editing

| Key | Mode | Description |
|---|---|---|
| `gcc` | Normal | Toggle line comment |
| `gc{motion}` | Normal | Comment motion |
| `gbc` | Normal | Toggle block comment |
| `<A-j>` / `<A-k>` | n/i/v | Move line(s) up/down |
| `<` / `>` | Visual | Indent (stays in visual) |
| `<leader>D` | n/v | Duplicate line/selection |
| `<leader>x` | n/v | Delete without yank |
| `Y` | Normal | Yank to end of line |
| `J` | Normal | Join lines (cursor stays) |
| `H` / `L` | n/o/x | Line start / end |

### Surround

| Key | Description |
|---|---|
| `ys{motion}{char}` | Add surround — `ysiw"` → `"word"` |
| `ds{char}` | Delete — `ds"` → strips quotes |
| `cs{from}{to}` | Change — `cs"'` → `"`→`'` |
| `S{char}` (visual) | Surround selection |

### Text objects (treesitter)

| Key | Description |
|---|---|
| `af` / `if` | Outer / inner function |
| `ac` / `ic` | Outer / inner class |
| `ab` / `ib` | Outer / inner block |
| `ih` | Git hunk |
| `]f` / `[f` | Next / prev function |
| `]c` / `[c` | Next / prev class |
| `]t` / `[t` | Next / prev TODO comment |

### UI toggles (`<leader>u`)

| Key | Description |
|---|---|
| `<leader>uw` | Toggle word wrap |
| `<leader>ul` | Toggle relative line numbers |
| `<leader>us` | Toggle spell check |
| `<leader>uf` | Toggle format on save |
| `<leader>uh` | Toggle inlay hints |
| `<leader>un` | Dismiss notifications |
| `<leader>um` | Toggle markdown render (read mode) |

### Completion popup (insert mode)

| Key | Description |
|---|---|
| `<C-n>` / `<C-p>` | Next / prev item |
| `<C-Space>` | Trigger completion |
| `<CR>` | Confirm |
| `<Tab>` / `<S-Tab>` | Next/prev item or snippet jump |
| `<C-e>` | Cancel |
| `<C-b>` / `<C-f>` | Scroll docs |

---

## Common workflows

### Debugging a TypeScript file

1. Open a `.ts` / `.tsx` file.
2. Place cursor on a line, press `<leader>db` to set a breakpoint.
3. Press `<leader>dc` to start. Pick a configuration (Launch file, Attach, Launch Chrome, Debug Jest test).
4. DAP UI opens automatically with **scopes**, **breakpoints**, **stacks**, **watches** on the left and **REPL** / **console** at the bottom.
5. Use `<leader>di` step into, `<leader>dO` step over, `<leader>do` step out, `<leader>dc` continue.
6. Hover over a variable in normal mode then press `<leader>dw` for a hover widget, or `<leader>de` to evaluate.
7. `<leader>dT` to terminate; UI closes automatically.

Languages with adapters out of the box: **JS/TS** (via vscode-js-debug), **Python** (debugpy), **Go** (delve), **Rust / C / C++** (codelldb).

### Running tests

1. Open a test file (e.g. `*.test.ts`, `test_*.py`, `*_test.go`).
2. `<leader>rt` runs the nearest test, `<leader>rT` runs the whole file.
3. Test status (✓ / ✗) appears as virtual text and signs in the gutter.
4. `<leader>rs` opens a summary tree of all tests; pick one and press `<CR>` to run it.
5. `<leader>ro` opens the captured output for the test under the cursor.
6. `<leader>rd` debugs the nearest test (uses DAP — set breakpoints first).
7. `<leader>rw` enables watch mode for the current file — saves re-run automatically.
8. Jump between failures with `[r` / `]r`.

### Using Claude Code from inside Neovim

1. `<leader>ac` opens the Claude Code split on the right.
2. Type your request (use `↑` for history, just like in the terminal).
3. To give Claude file context:
   - `<leader>ab` adds the current buffer.
   - Select text in visual mode then `<leader>as` to send a selection.
   - With cursor in nvim-tree, `<leader>as` adds the highlighted file.
4. When Claude proposes edits, the diff opens in a new tab/split. Inspect, then:
   - `<leader>aa` to accept.
   - `<leader>ad` to reject.
5. `<leader>ar` resumes a prior session, `<leader>aC` continues the last one, `<leader>am` switches model.

### Copilot ghost text

- Start typing — gray ghost text appears.
- `Alt-l` accepts the whole suggestion.
- `Alt-w` accepts one word, `Alt-j` one line.
- `Alt-]` / `Alt-[` cycle alternatives.
- `C-]` dismisses.
- Copilot also appears in the `<Tab>` completion popup with a `` icon — the comparator boosts it above LSP when ranked high.

### Project-wide search and replace

1. `<leader>sr` opens Spectre in a vertical split.
2. Type the search term in the top field; the live preview updates.
3. Tab to the replace field, type the replacement.
4. `<leader>R` (inside Spectre) runs the replacement; `dd` on a line excludes it.

### Restoring a project session

- Run `nvim` in your project root.
- Press `s` on the dashboard (or `<leader>qs` once a buffer is open) — your previous buffer layout, splits, and cursor positions come back.

---

## Installed plugins

### Core / editor
| Plugin | Purpose |
|---|---|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [catppuccin](https://github.com/catppuccin/nvim) | Color scheme |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Parsers / highlighting / folding |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding hints |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Bracket pairing |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Comment toggling |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Surround operations |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides |
| [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) | Smooth scroll |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Dashboard |
| [persistence.nvim](https://github.com/folke/persistence.nvim) | Session restore |
| [noice.nvim](https://github.com/folke/noice.nvim) | Cmdline / popups |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | Notifications |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | Utility lib |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Inline markdown read mode |

### Language tooling
| Plugin | Purpose |
|---|---|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP servers |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | Install LSP / DAP / linters / formatters |
| [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) | Bridge mason ↔ lspconfig |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Auto-install tools |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP progress |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Format on save |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Linting |
| [aerial.nvim](https://github.com/stevearc/aerial.nvim) | Symbol outline |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics panel |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | TODO highlighting |

### Completion & AI
| Plugin | Purpose |
|---|---|
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippets |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | Copilot inline |
| [copilot-cmp](https://github.com/zbirenbaum/copilot-cmp) | Copilot in cmp |
| [claudecode.nvim](https://github.com/coder/claudecode.nvim) | Claude Code integration |

### Debugging & testing
| Plugin | Purpose |
|---|---|
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug engine |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | Debug UI |
| [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text) | Inline variable values |
| [mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim) | Install adapters |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | Python adapter |
| [nvim-dap-go](https://github.com/leoluz/nvim-dap-go) | Go adapter |
| [neotest](https://github.com/nvim-neotest/neotest) | Test runner |
| [neotest-jest](https://github.com/nvim-neotest/neotest-jest) | Jest |
| [neotest-vitest](https://github.com/marilari88/neotest-vitest) | Vitest |
| [neotest-python](https://github.com/nvim-neotest/neotest-python) | pytest |
| [neotest-go](https://github.com/nvim-neotest/neotest-go) | Go test |

### Git & terminals
| Plugin | Purpose |
|---|---|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Gutter signs + blame |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Diff viewer |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Terminals + LazyGit |
| [nvim-spectre](https://github.com/nvim-pack/nvim-spectre) | Search / replace UI |

---

## LSP servers, formatters, linters

### LSP servers (Mason auto-install)

`lua_ls` · `ts_ls` · `pyright` · `rust_analyzer` · `gopls` · `jsonls` · `yamlls` · `html` · `cssls` · `tailwindcss` · `bashls`

### Formatters (Conform — format on save)

| Filetype | Formatter |
|---|---|
| JS / TS / JSX / TSX / Vue / Svelte / HTML / CSS / JSON / YAML / Markdown / GraphQL | `prettierd` → `prettier` |
| Lua | `stylua` |
| Python | `ruff_format` → `black` |
| Go | `gofumpt` + `goimports` |
| Rust | `rustfmt` |
| Shell | `shfmt` |
| _fallback_ | `trim_whitespace` |

Disable per-buffer: `:FormatDisable!` &nbsp;•&nbsp; per-session: `:FormatDisable` &nbsp;•&nbsp; toggle: `<leader>uf`

### Linters (nvim-lint — on save / leave-insert)

| Filetype | Linter |
|---|---|
| JS / TS / Vue / Svelte | `eslint_d` |
| Python | `ruff` |
| Shell | `shellcheck` |
| Markdown | `markdownlint` |

Trigger manually: `<leader>cl`

### Debug adapters

`js-debug-adapter` (JS/TS), `debugpy` (Python), `delve` (Go), `codelldb` (Rust/C/C++)

---

## Customization

### Add a plugin

Create a new file under `lua/plugins/`:

```lua
-- lua/plugins/my-plugin.lua
return {
  {
    "author/plugin-name",
    event = "VeryLazy",
    opts = {
      -- options here
    },
  },
}
```

Lazy detects it on next launch.

### Change the colorscheme

`lua/plugins/colorscheme.lua` — set `flavour` to `latte`, `frappe`, `macchiato`, or `mocha`.

### Add machine-specific overrides

Create `lua/config/local.lua` (gitignored) and require it from `init.lua`:

```lua
-- init.lua tail
pcall(require, "config.local")
```

### Disable format on save globally

```vim
:FormatDisable
```

### Disable Copilot in a buffer

```vim
:Copilot disable
```

Or in a filetype, set `vim.g.copilot_filetypes = { yaml = false }` etc.

---

## Troubleshooting

### Plugins not loading
```vim
:Lazy sync
:Lazy log
```

### Mason tool missing
```vim
:Mason            " browse / install manually
:MasonToolsInstall  " run the configured ensure_installed list
```

### LSP not attaching
```vim
:LspInfo
:checkhealth lsp
```
Make sure the LSP binary exists in `~/.local/share/nvim/mason/bin/` or on your `$PATH`.

### Copilot says "not authenticated"
```vim
:Copilot auth
:Copilot status
```

### `claude` command not found
```bash
npm install -g @anthropic-ai/claude-code
which claude
```

### Debugger says "adapter not found"
```vim
:Mason
" install js-debug-adapter / debugpy / delve / codelldb
:DapShowLog       " inspect dap logs after a failed session
```

### Test adapter not picking up tests
- Jest / Vitest: must have a `package.json` with the framework installed.
- pytest: must be runnable from project root (`pytest` on `$PATH` or in a venv).
- go: `go test ./...` must work from the project root.

### Icons not showing
Install a Nerd Font and configure your terminal to use it:
```bash
brew install --cask font-fira-code-nerd-font
```

### Slow find / grep on large projects
```bash
brew install fd ripgrep
```
Use `<leader>fg` (git files) for the fastest find in git repos.

### Check overall health
```vim
:checkhealth
```

---

## License

MIT
