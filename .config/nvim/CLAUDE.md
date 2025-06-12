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