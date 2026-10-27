# Changelog

## 0.4.0 — 2026-10-27
- Cloud sessions: `/pickup`, `/sentry-sweep`, `/slack-scan` and the git rule in `CLAUDE.md` commit and push to Claude's own branch when `CLAUDE_CODE_REMOTE=true` (the VM is thrown away); locally nothing changes.

## 0.3.0 — 2026-10-27
- Generic agents, adapted from cdp2-frontend: `neckbeard`, `sidequest`, `rules-review`, `browser-verify`, `sentry-fix`, `slack-scout`. They read the project's CLAUDE.md for its rules; a project agent with the same name overrides them.
- `/sentry-sweep` and `/slack-scan` commands for any project.
- `install.sh` links `agents/` into `~/.claude/agents/`.

## 0.2.0 — 2026-10-27
- `toolkit-sync`: Claude commits and pushes toolkit-only changes itself.
- `CLAUDE.md`: rule for where a setup change goes (project `.claude/` vs toolkit).
- Usage guide in English and Ukrainian (`docs/USAGE.md`, `docs/USAGE.uk.md`), linked from README.

## 0.1.0 — 2026-10-27
- Global routing rules (`CLAUDE.md`), `/task`, `/pickup`.
- `wt` / `wt-clean` worktree helpers, `crc` / `crcb` Remote Control aliases.
- commit-msg hook that strips Claude attribution + `claude-hook-enable`.
- `install.sh` (local + `--cloud`), attribution off, Context7 MCP.
- Docs: README, MCP.md, MOBILE.md.
