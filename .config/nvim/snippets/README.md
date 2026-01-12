# Custom Snippets for LuaSnip

This directory contains VSCode-style snippet files that are loaded by LuaSnip.

## How to Use Snippets

### In Insert Mode:
1. Type the snippet prefix (e.g., `cl` for console.log)
2. The snippet should appear in your autocomplete menu
3. Select it and press Enter or Tab
4. Use `Ctrl+j` to jump to the next placeholder
5. Use `Ctrl+k` to jump to the previous placeholder

### Current Keybindings:
- `Ctrl+j` - Jump forward to next placeholder
- `Ctrl+k` - Jump backward to previous placeholder
- `Ctrl+l` - Cycle through choices (if available)
- `Ctrl+h` - Cycle back through choices

## Available Snippet Files

- **javascript.json** - JavaScript and React snippets
- **typescript.json** - TypeScript-specific snippets
- **lua.json** - Lua snippets
- **python.json** - Python snippets
- **go.json** - Go snippets
- **rust.json** - Rust snippets

## How to Add New Snippets

### VSCode-Style JSON Format (Recommended):

Edit the appropriate language file (e.g., `javascript.json`):

```json
{
  "snippet name": {
    "prefix": "trigger",
    "body": [
      "line 1 with $1 placeholder",
      "line 2 with ${2:default text}",
      "line 3 with $0 (final cursor position)"
    ],
    "description": "What this snippet does"
  }
}
```

### Placeholder Syntax:
- `$1`, `$2`, etc. - Tab stops (jump positions)
- `${1:default}` - Tab stop with default text
- `$0` - Final cursor position (optional, defaults to end)
- `$TM_SELECTED_TEXT` - Selected text (for visual mode snippets)

### Example: Adding a new JavaScript snippet

Add to `javascript.json`:

```json
{
  "forEach loop": {
    "prefix": "fore",
    "body": [
      "${1:array}.forEach((${2:item}) => {",
      "\t$3",
      "})"
    ],
    "description": "forEach loop"
  }
}
```

## Add New Language Support

1. Create a new JSON file (e.g., `java.json`)
2. Add your snippets using the VSCode format
3. Update `package.json` to register the new file:

```json
{
  "language": "java",
  "path": "./java.json"
}
```

4. Restart Neovim or run `:source %` in your config

## Additional Resources

- You already have **friendly-snippets** installed with hundreds of snippets
- Custom snippets in this directory override or extend friendly-snippets
- Check LuaSnip docs: https://github.com/L3MON4D3/LuaSnip
- VSCode snippet syntax: https://code.visualstudio.com/docs/editor/userdefinedsnippets
