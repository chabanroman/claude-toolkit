#!/usr/bin/env bash
# claude-toolkit installer. Safe to re-run; updates are `git pull` (files are symlinked, not copied).
#
#   ./install.sh            macOS / Linux: symlink into ~/.claude, merge settings, add shell aliases, add Context7 MCP
#   ./install.sh --cloud    cloud session setup script: same files, no shell rc, no MCP (connectors come from claude.ai)
set -euo pipefail

toolkit="$(cd "$(dirname "$0")" && pwd)"
claude_dir="$HOME/.claude"
backup="$claude_dir/backup-$(date +%Y%m%d-%H%M%S)"
cloud="${1:-}"

mkdir -p "$claude_dir/commands"

# Back up a real file before replacing it with a symlink; leave our own symlinks alone.
link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    return
  fi
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mkdir -p "$backup"
    mv "$dst" "$backup/"
    echo "backed up $dst -> $backup/"
  fi
  ln -s "$src" "$dst"
  echo "linked $dst"
}

link "$toolkit/CLAUDE.md" "$claude_dir/CLAUDE.md"
for f in "$toolkit"/commands/*.md; do
  link "$f" "$claude_dir/commands/$(basename "$f")"
done

# Commits and PRs carry no Claude attribution.
settings="$claude_dir/settings.json"
[ -f "$settings" ] || echo '{}' > "$settings"
if [ "$(jq -c '.attribution // null' "$settings")" != '{"commit":"","pr":""}' ]; then
  mkdir -p "$backup"
  cp "$settings" "$backup/settings.json"
  tmp="$(mktemp)"
  jq '.attribution = {"commit": "", "pr": ""}' "$settings" > "$tmp" && mv "$tmp" "$settings"
  echo "set attribution off in $settings"
fi

if [ "$cloud" = "--cloud" ]; then
  echo "cloud install done"
  exit 0
fi

# Shell aliases + bin/ on PATH.
line="[ -f \"$toolkit/shell/aliases.sh\" ] && source \"$toolkit/shell/aliases.sh\""
for rc in "$HOME/.zshrc" "$HOME/.bashrc"; do
  if [ -f "$rc" ] && ! grep -qF "$toolkit/shell/aliases.sh" "$rc"; then
    printf '\n# claude-toolkit\n%s\n' "$line" >> "$rc"
    echo "added aliases to $rc"
  fi
done

# Context7: current docs for the library versions a project actually uses. No auth needed.
if command -v claude >/dev/null && ! claude mcp get context7 >/dev/null 2>&1; then
  claude mcp add --scope user --transport http context7 https://mcp.context7.com/mcp
fi

echo
echo "Done. Open a new terminal (or: source ~/.zshrc). Remaining manual steps: MCP.md"
