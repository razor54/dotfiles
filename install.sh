#!/usr/bin/env bash
set -euo pipefail

# Resolve dotfiles directory from script location
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
HOME_DIR="$HOME"

linked=0
skipped=0
backed_up=0

link_file() {
  local src="$1"
  local dest="$2"

  # Create parent directory if needed
  mkdir -p "$(dirname "$dest")"

  # Already correctly linked
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    printf "  skip  %s (already linked)\n" "$dest"
    skipped=$((skipped + 1))
    return
  fi

  # Existing file/dir/broken symlink — back it up
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mv "$dest" "${dest}.backup"
    printf "  backup %s → %s.backup\n" "$dest" "$dest"
    backed_up=$((backed_up + 1))
  fi

  ln -s "$src" "$dest"
  printf "  link  %s → %s\n" "$dest" "$src"
  linked=$((linked + 1))
}

echo "Dotfiles: $DOTFILES_DIR"
echo ""

# ── Home directory ──────────────────────────────────────────────
echo "Home directory:"
link_file "$DOTFILES_DIR/.aliases"           "$HOME_DIR/.aliases"
link_file "$DOTFILES_DIR/.functions"         "$HOME_DIR/.functions"
link_file "$DOTFILES_DIR/.gitconfig"         "$HOME_DIR/.gitconfig"
link_file "$DOTFILES_DIR/.gitignore_global"  "$HOME_DIR/.gitignore_global"
link_file "$DOTFILES_DIR/.osx"               "$HOME_DIR/.osx"
link_file "$DOTFILES_DIR/.vim"               "$HOME_DIR/.vim"
link_file "$DOTFILES_DIR/.vimrc"             "$HOME_DIR/.vimrc"
link_file "$DOTFILES_DIR/.zshrc"             "$HOME_DIR/.zshrc"
link_file "$DOTFILES_DIR/.tmux.conf"         "$HOME_DIR/.tmux.conf"
link_file "$DOTFILES_DIR/CLAUDE.md"          "$HOME_DIR/CLAUDE.md"

# ── ~/.config ───────────────────────────────────────────────────
echo ""
echo "~/.config:"
link_file "$DOTFILES_DIR/.config/alacritty"       "$HOME_DIR/.config/alacritty"
link_file "$DOTFILES_DIR/.config/nvim"             "$HOME_DIR/.config/nvim"
link_file "$DOTFILES_DIR/.config/wezterm"          "$HOME_DIR/.config/wezterm"
link_file "$DOTFILES_DIR/.config/.mcp.json"        "$HOME_DIR/.config/.mcp.json"
link_file "$DOTFILES_DIR/starship.toml"            "$HOME_DIR/.config/starship.toml"
link_file "$DOTFILES_DIR/.config/zellij"           "$HOME_DIR/.config/zellij"
link_file "$DOTFILES_DIR/.config/eza/theme.yml"    "$HOME_DIR/.config/eza/theme.yml"
link_file "$DOTFILES_DIR/.config/bat/config"       "$HOME_DIR/.config/bat/config"
link_file "$DOTFILES_DIR/.config/bat/themes"       "$HOME_DIR/.config/bat/themes"
link_file "$DOTFILES_DIR/.config/ghostty/config"   "$HOME_DIR/.config/ghostty/config"
link_file "$DOTFILES_DIR/.config/oh-my-posh"       "$HOME_DIR/.config/oh-my-posh"

# ── ~/.claude ──────────────────────────────────────────────────
echo ""
echo "~/.claude:"
link_file "$DOTFILES_DIR/.claude/settings.json"        "$HOME_DIR/.claude/settings.json"
link_file "$DOTFILES_DIR/.claude/settings.local.json"  "$HOME_DIR/.claude/settings.local.json"
link_file "$DOTFILES_DIR/.claude/CLAUDE.md"            "$HOME_DIR/.claude/CLAUDE.md"
link_file "$DOTFILES_DIR/.config/.mcp.json"            "$HOME_DIR/.claude/.mcp.json"

# ── Claude MCP servers ────────────────────────────────────────
echo ""
echo "Claude MCP servers:"

if command -v claude &>/dev/null; then
  add_mcp() {
    local name="$1"
    shift
    # Check if server already exists in ~/.claude.json
    if [ -f "$HOME_DIR/.claude.json" ] && python3 -c "
import json, sys
with open('$HOME_DIR/.claude.json') as f:
    data = json.load(f)
sys.exit(0 if '$name' in data.get('mcpServers', {}) else 1)
" 2>/dev/null; then
      printf "  skip  %s (already registered)\n" "$name"
    else
      if CLAUDECODE= claude mcp add "$name" "$@" 2>/dev/null; then
        printf "  add   %s\n" "$name"
      else
        printf "  FAIL  %s (claude mcp add returned an error)\n" "$name"
      fi
    fi
  }

  add_mcp memory -- npx -y @modelcontextprotocol/server-memory
  add_mcp fetch -- uvx mcp-server-fetch
  add_mcp terraform --disabled -- docker run -i --rm hashicorp/terraform-mcp-server:0.2.3
  add_mcp opentofu --disabled -- npx -y @opentofu/opentofu-mcp-server
  add_mcp atlassian -- npx -y mcp-remote https://mcp.atlassian.com/v1/mcp
  add_mcp aws-mcp --disabled -- uvx mcp-proxy-for-aws@latest https://aws-mcp.us-east-1.api.aws/mcp --metadata AWS_REGION=eu-west-2
  add_mcp skillsmp --disabled -- npx -y mcp-remote https://skillsmp.com/mcp

  # code-search requires code-search-mcp binary
  if command -v code-search-mcp &>/dev/null; then
    add_mcp code-search -- code-search-mcp
  else
    printf "  skip  code-search (code-search-mcp not installed)\n"
  fi
else
  echo "  skip  (claude CLI not found — install Claude Code first)"
fi

# ── Summary ─────────────────────────────────────────────────────
echo ""
echo "Done: $linked linked, $skipped skipped, $backed_up backed up"
