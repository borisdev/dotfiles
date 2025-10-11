# Neovim Configuration Guide

## Commands
- Format Python: `:Black` (on save)
- Sort Python imports: `:Isort` (on save)
- Lint Python: `Flake8` (on save)
- Format JS/HTML/CSS/JSON/MD: `Prettier` (on save)
- Run Python file: `:!python3 %`
- Run single Python test: `:!python3 -m pytest <file>::<test_name> -v`
- Language server log: `:LspLog`
- Install language servers: `:Mason` or `:MasonInstall <server>`
- Open file explorer: `:Oil`
- Toggle terminal: `<leader>tt`

## Code Style Guidelines
- **Indentation**: 4 spaces (no tabs)
- **Line Length**: ~88 characters (Black default)
- **Plugins**: Use lazy.nvim for plugin management
- **Module Structure**: Place custom configs in `lua/borisdev/`
- **Plugin Configs**: Place in `lua/plugins/` directory
- **Lua Style**: 
  - Use `vim.keymap.set()` for keybindings
  - Use `vim.opt` for settings
  - Favor Lua over VimScript when possible
- **Python Style**: 
  - Follow Black formatting
  - Use isort for import ordering
  - Follow flake8 linting rules
- **Comments**: Use `--` for Lua, `#` for Python
- **Error Handling**: Use `pcall()` for error-prone Lua operations
- **Keybindings**: Use `<leader>` (spacebar) as prefix for custom mappings
- **LSP**: Use Mason to manage language servers (pyright, html)

## Plugin Interactions
- **Copilot + nvim-cmp Tab Handling**: 
  - Tab: Reserved for Copilot suggestions and LuaSnip snippet expansion
  - Ctrl+j/k: Navigate nvim-cmp completion menu (instead of Tab/Shift+Tab)
  - This prevents Tab conflicts between Copilot and completion plugins
  - Configuration in `lua/plugins/cmp.lua:48-77`
- **Floating Completion Hints**:
  - Shows floating window with `[C-j/k: navigate]` and `[Enter: confirm]` when nvim-cmp menu opens
  - Appears in top-right corner, auto-hides when menu closes
  - Uses readable colors (white on dark background) 
  - No plugins required - uses nvim-cmp events and native floating windows
  - Configuration in `lua/borisdev/settings.lua:104-136`