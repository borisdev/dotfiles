# My Neovim Manual

## Quick Reference - All AI Keystrokes

| Key | Mode | Action |
|-----|------|--------|
| **GitHub Copilot (Autocomplete)** |||
| `<C-Space>` | Insert | Open completion menu |
| `<C-j>` | Insert | Navigate down through suggestions |
| `<C-k>` | Insert | Navigate up through suggestions |
| `<CR>` | Insert | Accept highlighted suggestion |
| `<C-e>` | Insert | Cancel menu without inserting |
| `<Space>tc` | Normal | Toggle Copilot on/off |
| **CodeCompanion (AI Chat & Actions)** |||
| `<Space>ac` | Normal | Open AI chat buffer (agent mode) |
| `<Space>as` | Visual | Chat with selected text |
| `<Space>aa` | Normal/Visual | AI actions palette (fix/refactor/docs/tests) |
| **Cursor Agent (Bonus)** |||
| `<Space>ca` | Normal | Toggle Cursor Agent terminal |
| `<Space>ca` | Visual | Send selection to Cursor Agent |
| `<Space>cA` | Normal | Send entire buffer to Cursor Agent |

---

## Overview

**Two AI systems working together:**

1. **GitHub Copilot** → Inline autocomplete via `nvim-cmp`
   - Suggestions appear as you type
   - No ghost text, integrated into completion menu
   - Works alongside LSP, snippets, buffer completions

2. **CodeCompanion** → Zed/Cursor-style editing + chat
   - Chat for questions and explanations
   - Actions for code transformations (fix/refactor/docs/tests)
   - Workspace-aware agent mode

---

## GitHub Copilot (Autocomplete)

### How It Works

Copilot suggestions appear in your normal completion menu (alongside LSP, snippets, buffer). No ghost text, no conflicts.

**Workflow:**
1. Start typing → suggestions appear automatically
2. Navigate: `<C-j>` (down) / `<C-k>` (up)
3. Accept: `<CR>` or cancel: `<C-e>`
4. Toggle: `<Space>tc` to turn on/off

**Reverting:**
- `u` - Standard Vim undo
- `<C-e>` - Cancel menu before accepting

**Disabled in:** markdown files (enabled in git commits)

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

**Copilot not showing suggestions:**
- Check: `:Copilot status`
- Enable: `:Copilot enable` or `<Space>tc`
- Restart Neovim if needed

**CodeCompanion not working:**
- Verify API key in `~/workspace/sindri-mono/.env`
- Check format: `OPENAI_API_KEY=sk-...`
- Restart Neovim after adding key

**Completion menu issues:**
- Copilot is integrated into cmp, no conflicts expected
- Check: `:checkhealth copilot` and `:checkhealth cmp`

---

## Mental Model

**Two complementary AI systems:**

1. **Inline/Autocomplete** → Copilot + cmp
   - Quick suggestions as you type
   - No special UI, just works

2. **Editing/Refactor/Explain** → CodeCompanion
   - Deeper edits and conversations
   - Zed/Cursor-style workflow

**When to use what:**
- **Copilot** → Quick inline suggestions while coding
- **CodeCompanion** → Questions, explanations, code transformations
