# AI Setup Guide

## TLDR - Quick Commands

```
<C-Space>          Open completion menu
<C-j> / <C-k>      Navigate down/up through suggestions
<CR>               Accept highlighted suggestion
<C-e>              Cancel menu
<Space>tc          Toggle Copilot on/off
<Space>ac          Open AI chat buffer
<Space>as          Chat with selected text (visual mode)
<Space>aa          Zed-style actions palette (/fix, /refactor, etc)
<Space>ca          Cursor Agent (normal: toggle, visual: send selection)
<Space>cA          Send entire buffer to Cursor Agent
```

---

## Overview

This Neovim setup includes two AI-powered features:

1. **GitHub Copilot** - Integrated into nvim-cmp for inline autocomplete
2. **CodeCompanion** - Zed/Cursor-style editing with chat and action commands

Both work together seamlessly without conflicts.

---

## 1. GitHub Copilot (Autocomplete)

### How It Works

Copilot is integrated into your existing `nvim-cmp` completion system. It appears as suggestions in the completion menu alongside LSP, snippets, and buffer completions.

**Key points:**
- No ghost text - Copilot suggestions appear in the normal completion menu
- No plugin clashes - works cleanly with cmp
- Disabled in markdown files (enabled in git commits)

### Using Copilot

1. **Start typing** - Copilot suggestions appear automatically in the completion menu
2. **Navigate suggestions:**
   - `<C-j>` - Move down through items
   - `<C-k>` - Move up through items
   - `<C-Space>` - Manually open completion menu
3. **Accept a suggestion:**
   - `<CR>` - Accept the highlighted suggestion
   - `<C-e>` - Cancel menu without inserting anything
4. **Toggle Copilot:**
   - `<Space>tc` - Toggle Copilot on/off

### Reverting Autocomplete

Once a suggestion is accepted, it's just text in your buffer:
- `u` - Standard Vim undo
- If you opened the menu by accident: `<C-e>` to cancel
- To toggle Copilot: `<Space>tc` (or `:Copilot disable` / `:Copilot enable`)

### Mental Model

- **cmp** = The UI (completion menu)
- **Copilot** = One of the brains feeding suggestions to cmp
- Other sources: LSP, snippets, buffer completions

---

## 2. CodeCompanion (Zed/Cursor-Style Editing)

### What It Does

CodeCompanion provides two main features:
1. **Chat** - Conversational AI assistant with workspace context
2. **Actions** - Command palette for common tasks (fix, refactor, document, etc.)

### Chat Commands

#### Open Chat Buffer
```
<leader>ac
```
Opens a chat buffer where you can have a conversation with the AI about your codebase. It has access to workspace context and can help with:
- Explaining code
- Debugging issues
- Planning refactors
- General questions about your project

#### Chat with Selection
1. **Visual select** text (`v` and select lines)
2. Press `<leader>as`
3. Chat buffer opens with your selection in context
4. Ask questions like:
   - "Refactor this"
   - "Add TODOs"
   - "Explain this"
   - "What's wrong with this code?"

### Zed-Style Actions

#### Action Palette
```
<leader>aa
```
Opens a command palette with AI-powered actions. Works in:
- Normal mode (on current function/file)
- Visual mode (on selected text)

#### Available Actions

- **Fix this** - Fix errors and issues
- **Refactor** - Rewrite into idiomatic code
- **Add tests** - Generate tests for function/file
- **Document this** - Add docstrings/comments
- **Extract function** - Extract code into new function
- **Clean up** - General cleanup and formatting

#### Workflow

1. Put cursor on function/file OR visually select code
2. Press `<leader>aa`
3. Choose an action from the palette
4. Review the diff that appears
5. Accept or reject the changes

### "Agent Mode"

In CodeCompanion terms, "agent mode" means the AI has access to:
- Your workspace files
- Tools for editing
- Context about your codebase

You enter agent mode whenever you:
- Open chat: `<leader>ac`
- Run actions: `<leader>aa`

No special command needed - those two are your "enter agent" buttons.

---

## 3. Configuration

### API Key Setup

CodeCompanion automatically loads your `OPENAI_API_KEY` from:
```
~/workspace/sindri-mono/.env
```

The key is loaded on startup. If it's not found, CodeCompanion will use the `OPENAI_API_KEY` environment variable if set.

### Model

Default model: `gpt-4o`

To change, edit the `codecompanion.nvim` config in `init.lua`:
```lua
schema = {
  model = { default = "gpt-4o" },  -- Change this
},
```

---

## 4. Key Mappings Summary

### GitHub Copilot (Autocomplete)

| Key | Mode | Action |
|-----|------|--------|
| `<C-Space>` | Insert | Open completion menu |
| `<C-j>` | Insert | Next completion item (down) |
| `<C-k>` | Insert | Previous completion item (up) |
| `<CR>` | Insert | Accept completion |
| `<C-e>` | Insert | Cancel completion menu |
| `<Space>tc` | Normal | Toggle Copilot on/off |

### CodeCompanion (AI Chat & Actions)

| Key | Mode | Action |
|-----|------|--------|
| `<Space>ac` | Normal | Open AI chat buffer |
| `<Space>as` | Visual | Chat with selected text |
| `<Space>aa` | Normal/Visual | AI actions palette (fix/refactor/docs/tests) |

### Cursor Agent (Bonus AI Tool)

| Key | Mode | Action |
|-----|------|--------|
| `<Space>ca` | Normal | Toggle Cursor Agent terminal |
| `<Space>ca` | Visual | Send selection to Cursor Agent |
| `<Space>cA` | Normal | Send entire buffer to Cursor Agent |

---

## 5. Troubleshooting

### Copilot not showing suggestions
- Check: `:Copilot status`
- Enable: `:Copilot enable`
- Restart Neovim if needed

### CodeCompanion not working
- Verify API key is in `.env` file: `~/workspace/sindri-mono/.env`
- Check format: `OPENAI_API_KEY=sk-...`
- Restart Neovim after adding key

### Completion menu conflicts
- Copilot is integrated into cmp, so no conflicts should occur
- If issues persist, check `:checkhealth copilot` and `:checkhealth cmp`

---

## 6. Mental Model Summary

**Two AI systems working together:**

1. **Inline/Autocomplete brain** → `copilot.lua` + `cmp`
   - Provides suggestions as you type
   - Integrated into normal completion flow
   - No special UI, just works

2. **Editing/Refactor/Explain brain** → `CodeCompanion`
   - Chat for questions and explanations
   - Actions for code transformations
   - Zed/Cursor-style workflow

Both complement each other:
- Copilot for quick inline suggestions
- CodeCompanion for deeper edits and conversations

