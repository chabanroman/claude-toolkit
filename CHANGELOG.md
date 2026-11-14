# Changelog

## Unreleased
- `logo.svg` at the root: the toolkit's logo, shown in the owner's dashboard.

## Planned
- Cross-project `orbita-connect` skill (how a product reports `/health`, metrics and deploys to the owner's dashboard), once that SDK exists.

## 0.6.0 — 2026-11-13
- Gaps noticed outside the task (errors & logs, Sentry, security, tests, performance, UX, ops) go into the project's improvements backlog (`Improvements: <path>` in the project's `CLAUDE.md`, default `docs/improvements.md`) instead of being fixed in passing or forgotten; the hand-over lists what was added.

## 0.5.0 — 2026-11-12
- Git policy per project (`Git policy: hand-over | ask | autonomous` in the project's `CLAUDE.md`, default `ask`); `/pickup`, `/sentry-sweep`, `/slack-scan` follow it. Always: no direct commits to main / master / dev / develop, no force-push, branch named after the work.
- No AI mention in commits, PRs, branch names, code comments, changelogs or Linear comments; `commit-msg` hook also strips 🤖 lines.
- `/pickup`: run the local gate even with CI; report the branch's CI run if pushed and `gh` is available.
- Linear binding per project (`Linear: workspace … · teams … · server …`); `MCP.md` explains a second workspace.
- `skills/` folder, linked into `~/.claude/skills/` by `install.sh`.
- `VERSION` file, written to `~/.claude/toolkit-version` on install.
- New `/project-init` command.
- `browser-verify`: optional mobile pass at 390×844 (overflow, tap targets, safe area).

## 0.4.1 — 2026-10-28
- Cloud branches are named after the work (`<ticket-id>-<slug>`, `fix-sentry-<slug>`, `fix-slack-<slug>`), never `claude/…`; if that push is refused, push the session's own branch and say so.
- `install.sh`: attribution also sets `sessionUrl: false`.

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
