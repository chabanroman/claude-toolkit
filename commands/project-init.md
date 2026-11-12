---
description: Create or complete this repo's CLAUDE.md (what it is, stack, checks, Git policy, Linear binding, rules, project agents), enable the commit-msg hook, list what's still missing.
argument-hint: [notes about the project]
---

Set up this repo for Claude. Notes: $ARGUMENTS

1. **Read first, ask only for what the repo can't tell you.** Read the existing `CLAUDE.md` (if any), `README.md`, `package.json` / lockfiles / other manifests (`pyproject.toml`, `go.mod`, `Cargo.toml`, `Gemfile`, …), the top-level folders, CI config (`.github/workflows/`, …), `.claude/` (agents, commands, skills, settings, `.mcp.json`) and any docs folder.

2. **Draft these sections** (keep each short):
   - **What it is** — 2–3 lines: the product and who uses it.
   - **Stack** — language, framework, package manager (from the lockfile), key libraries.
   - **Structure** — the top-level folders that matter, one line each.
   - **Checks** — the exact local gate commands, in order: lint, typecheck, test, build. Only the ones that exist (from scripts / Makefile / CI); never invent one.
   - **Git policy** — a line `Git policy: hand-over | ask | autonomous` (see `~/.claude/CLAUDE.md`). Ask me; default `ask`.
   - **Linear** — the line `Linear: workspace <name> · teams <KEY,…> · server <mcp-server-name>`, or `Linear: not used`. Ask me; if it's a second workspace, point to `~/code/claude-toolkit/MCP.md` ("A second Linear workspace").
   - **Rules / design docs** — the files the `rules-review` agent must read (lint config, style guides, design-system docs, ADRs).
   - **Project agents and commands** — what `.claude/` adds on top of the toolkit and why; note any that override a toolkit agent by name.

3. **Ask in one go.** Put every open question (Git policy, Linear, anything you couldn't infer) in a single question round, each with a recommended answer.

4. **Write.** No `CLAUDE.md` yet → create it with these sections. One exists → add only the missing sections. **Never overwrite an existing section silently:** if you'd change one, show the diff and ask first.

5. **Enable the hook:** run `claude-hook-enable` in the repo root.

6. **Print what's still missing:** sections left empty or "unknown", checks that don't exist (e.g. no tests), MCP servers the project would need but aren't connected, a Linear binding without its server in `.mcp.json`.

`/project-init` only writes files (and the local hook, which is not committed). Committing the new `CLAUDE.md` follows the Git policy just chosen.
