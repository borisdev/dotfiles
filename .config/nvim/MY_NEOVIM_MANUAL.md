# My Neovim Manual

## Quick Reference - All AI Keystrokes

| Key | Mode | Action |
|-----|------|--------|
| **Completion Menu** |||
| `<C-Space>` | Insert | Open completion menu |
| `<C-j>` / `<Down>` | Insert | Navigate down through suggestions |
| `<C-k>` / `<Up>` | Insert | Navigate up through suggestions |
| `<CR>` | Insert | Accept highlighted suggestion |
| `<C-e>` | Insert | Cancel menu without inserting |
| **CodeCompanion (AI Chat & Actions)** |||
| `<Space>ac` | Normal | Open AI chat buffer (agent mode) |
| `<Space>as` | Visual | Chat with selected text |
| `<Space>aa` | Normal/Visual | AI actions palette (fix/refactor/docs/tests) |
| `<Space>da` | Normal | Accept inline diff (safe mode) |
| `<Space>dr` | Normal | Reject inline diff (safe mode) |
| **Cursor Agent (Bonus)** |||
| `<Space>ca` | Normal | Toggle Cursor Agent terminal |
| `<Space>ca` | Visual | Send selection to Cursor Agent |
| `<Space>cA` | Normal | Send entire buffer to Cursor Agent |

---

## Overview

**AI-powered editing with CodeCompanion:**

**CodeCompanion** → Zed/Cursor-style editing + chat
- Chat for questions and explanations
- Actions for code transformations (fix/refactor/docs/tests)
- Workspace-aware agent mode

**Completion** → Standard nvim-cmp with LSP, snippets, and buffer completions
- Suggestions appear as you type
- Integrated completion menu
- Works with all language servers

---

## Completion Menu (nvim-cmp)

### How It Works

The completion menu shows suggestions from:
- **LSP** - Language server suggestions
- **Snippets** - Code snippets (LuaSnip)
- **Buffer** - Words from open buffers

### Using Completion

**Workflow:**
1. Start typing → suggestions appear automatically
2. Navigate: `<C-j>` / `<Down>` (down) or `<C-k>` / `<Up>` (up)
3. Accept: `<CR>` or cancel: `<C-e>`

**Reverting:**
- `u` - Standard Vim undo
- `<C-e>` - Cancel menu before accepting

---

## CodeCompanion (Zed/Cursor-Style Editing)

### Chat Mode

**`<Space>ac`** - Open AI chat buffer
- Conversational assistant with workspace context
- Ask questions, debug, plan refactors

**`<Space>as`** - Chat with selection (visual mode)
1. Select text with `v`
2. Press `<Space>as`
3. Chat opens with selection in context
4. Ask: "Refactor this", "Explain this", "Add TODOs", etc.

### Actions Mode

**`<Space>aa`** - AI actions palette
- Works in normal mode (on current function/file) or visual mode (on selection)
- Available actions:
  - **Fix this** - Fix errors and issues
  - **Refactor** - Rewrite into idiomatic code
  - **Add tests** - Generate tests
  - **Document this** - Add docstrings/comments
  - **Extract function** - Extract code into new function
  - **Clean up** - General cleanup and formatting

**Workflow:**
1. Put cursor on code OR visually select
2. Press `<Space>aa`
3. Choose action from palette
4. Review diff → accept/reject

### Inline Diff Mode (Safe Mode)

When CodeCompanion shows inline diffs (after actions or edits):

**`<Space>da`** - Accept the inline diff
- Explicit, leader-based keybinding
- Safe: no accidental accepts

**`<Space>dr`** - Reject the inline diff
- Explicit, leader-based keybinding
- Safe: no accidental rejects

**Safety features:**
- `gdy` (always accept everything) is **disabled** to prevent accidental mass-accepts
- All diff actions require explicit leader-based keybindings

---

## Configuration

### API Key

CodeCompanion automatically loads `OPENAI_API_KEY` from:
```
~/workspace/sindri-mono/.env
```

Format: `OPENAI_API_KEY=sk-...`

### Model

Default: `gpt-4o`

To change, edit `init.lua`:
```lua
schema = {
  model = { default = "gpt-4o" },
},
```

---

## Troubleshooting

**CodeCompanion not working:**
- Verify API key in `~/workspace/sindri-mono/.env`
- Check format: `OPENAI_API_KEY=sk-...`
- Restart Neovim after adding key

**Completion menu issues:**
- Check: `:checkhealth cmp`
- Ensure LSP servers are installed via Mason
- Check: `:LspInfo` to see active language servers

---

## Mental Model

**AI-powered editing workflow:**

1. **Completion** → Standard LSP + snippets + buffer
   - Quick suggestions as you type
   - Integrated completion menu

2. **Editing/Refactor/Explain** → CodeCompanion
   - Deeper edits and conversations
   - Zed/Cursor-style workflow

**When to use what:**
- **Completion** → Quick inline suggestions while coding
- **CodeCompanion** → Questions, explanations, code transformations
