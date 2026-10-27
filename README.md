# claude-toolkit

My personal Claude Code setup: the same routing rules, commands and helpers on every machine and in cloud sessions.
Project-specific agents and skills stay in each project's `.claude/` (e.g. `cdp2-frontend/.claude/`).

## What's inside

| Path | What it does | Lands in |
|---|---|---|
| `CLAUDE.md` | Routing table (inline / agent / parallel / sub-tickets), git and hand-over rules | `~/.claude/CLAUDE.md` |
| `commands/task.md` | `/task <request>`: classify the request, say the decision in 2–3 lines, then do it | `~/.claude/commands/` |
| `commands/pickup.md` | `/pickup CDP-123`: Linear → branch → implement → local gate → commit msg + PR text + Linear update (sent only on yes) | `~/.claude/commands/` |
| `bin/wt` | `wt CDP-123 [slug]`: worktree + deps + Claude with Remote Control, running `/pickup` | `PATH` |
| `bin/wt-clean` | Remove merged, clean worktrees (`--yes` to really do it) | `PATH` |
| `bin/claude-hook-enable` | Enable the commit-msg hook in the current repo | `PATH` |
| `hooks/commit-msg` | Strips `Co-Authored-By: Claude`, `Claude-Session:`, "Generated with Claude Code" | per repo |
| `shell/aliases.sh` | `crc` = `claude --remote-control`, `crcb` = the same, named after the folder and branch | `~/.zshrc` |
| `install.sh` | Symlinks all of the above, sets `attribution` off, adds Context7 MCP | – |

Why not a plugin: plugins don't load in cloud sessions (claude.ai/code, the phone), while `~/.claude/` files written by a setup script do. Symlinks also mean `git pull` is the whole update.

## Install on a new machine (macOS / Linux)

```bash
git clone git@github.com:chabanroman/claude-toolkit.git ~/code/claude-toolkit
~/code/claude-toolkit/install.sh
source ~/.zshrc
```
Needs `jq` and `git`. Re-running is safe. Anything it replaces goes to `~/.claude/backup-<date>/` first.

**Update:** `cd ~/code/claude-toolkit && git pull` (re-run `install.sh` only when a new command file is added).

## Cloud sessions (phone / claude.ai/code)

claude.ai → Code → environment settings → **Setup script**:
```bash
git clone --depth 1 https://github.com/chabanroman/claude-toolkit.git ~/code/claude-toolkit && ~/code/claude-toolkit/install.sh --cloud
```
For that the repo must be cloneable without auth (it holds no secrets, so it can be public). A private repo needs a token in the environment, which I'd rather avoid.
The project's `.claude/` (agents, skills, project commands, hooks) comes with the repo clone by itself.

## Per repo

- `claude-hook-enable`: strips Claude trailers from every commit in this repo (it respects husky / `core.hooksPath` and keeps an existing hook as `commit-msg.local`).
- Parallel tickets: `wt CDP-123`, `wt CDP-124` in two terminals, each its own branch and session. `WT_BASE=origin/dev wt …` branches off dev.

See `MCP.md` for servers and auth, and `MOBILE.md` for the phone.
