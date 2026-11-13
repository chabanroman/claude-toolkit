# How to use claude-toolkit

🇺🇦 [Українська версія](USAGE.uk.md)

## 1. Daily commands

| Type | What happens |
|---|---|
| `/task <anything>` | Claude classifies the request (inline / agent / skill / parallel / sub-tickets), shows the decision in 2–3 lines, then does it. Sub-tickets in Linear are only created after you say yes. |
| `/pickup CDP-123` | Reads the Linear ticket (+ linked Sentry/Figma) → restates it → creates a branch → implements → runs the local gate (even with CI; reports the CI run if pushed) → commits / pushes / opens the PR as the project's **Git policy** says → drafts a Linear comment. Posts to Linear / moves to In Review only when you say yes. |
| *anything, in plain words* | The routing rules in `~/.claude/CLAUDE.md` still apply: ticket id → Linear first, Sentry link → Sentry first, wide search → Explore agent, independent parts → parallel agents. |
| `/sentry-sweep [24h\|7d]` | Finds this project in Sentry, fixes the urgent and frequent errors, returns what changed + commit message. Needs Sentry logged in (`/mcp`). |
| `/slack-scan [today\|3d\|this week] [#channel]` | Lists problems reported in Slack that this repo can fix, asks which ones to fix. |
| `/project-init` | In a new repo: creates or completes its `CLAUDE.md` (what it is, stack, checks, Git policy, Linear binding, rules), enables the commit-msg hook, lists what's missing. Asks before changing an existing section. |

## 1a. Per-project settings (in the project's `CLAUDE.md`)

| Line | Options | Default |
|---|---|---|
| `Git policy: <name>` | `hand-over` (never commits locally, gives the message) · `ask` (asks before commit / push) · `autonomous` (commits after the local gate, pushes the work branch, opens the PR with `gh`) | `ask` |
| `Improvements: <path>` | Where Claude writes gaps it notices outside the task (errors & logs, security, tests, performance, UX, ops), each with why and a rough priority; listed in every hand-over | `docs/improvements.md` |
| `Linear: workspace <name> · teams <KEY,…> · server <mcp-server>` | Claude uses only that server, checks workspace + team before writing, ignores tickets from other teams. Second workspace setup: [MCP.md](../MCP.md) | the claude.ai Linear connector |

Always, whatever the policy: no direct commits to `main` / `master` / `dev` / `develop`, no force-push, branch named after the work, and no AI mention in commits, PRs, branches, comments, changelogs or Linear. In a cloud session `hand-over` and `ask` still commit and push the work branch without asking (the VM is thrown away). Posting to Linear is always asked, whatever the policy.
`browser-verify` also checks mobile (390×844: overflow, tap targets, safe area) when you ask for it or the project's `CLAUDE.md` says it's mobile-first.

## 1b. Agents (in every project)

Claude picks them by itself (routing rules); you can also name one: "ask neckbeard how auth works".

| Agent | Use it for | Edits code? |
|---|---|---|
| `neckbeard` | "How does X work?" answered from the source with `file:line` citations | no |
| `sidequest` | Fix an unrelated bug mid-feature without spending the main context | yes, never commits |
| `rules-review` | Check the diff against the project's CLAUDE.md before the commit message | no |
| `browser-verify` | Click through the change on localhost in Chrome: render, console, network | no |
| `sentry-fix` | Behind `/sentry-sweep` | yes, never commits |
| `slack-scout` | Behind `/slack-scan` | no |

**A project agent (or skill, from `skills/`) with the same name wins.** cdp2-frontend has its own, more specific versions of all six (plus `ds-docs` and the `/ticket` and `/commit-msg` commands), so there those run; everywhere else these do.

## 2. Terminal helpers

| Command | What it does |
|---|---|
| `crc` | Claude with Remote Control (drive it from the phone). |
| `crcb` | Same, session named `<folder>:<branch>`. |
| `wt CDP-123 [slug]` | New worktree `../<repo>-wt/cdp-123[-slug]` + branch + deps + Claude running `/pickup CDP-123`. Run it in several terminals for parallel tickets. `WT_BASE=origin/dev wt …` branches off dev. |
| `wt-clean` | Shows merged, clean worktrees; `wt-clean --yes` removes them. |
| `claude-hook-enable` | In a repo: strip Claude attribution from every commit. |
| `toolkit-sync "msg"` | Commit + push all toolkit changes. |

## 3. From the phone

- **Laptop on:** `crc` (or `wt CDP-123`) on the laptop → Claude app → **Code** → open the session. Keep the laptop awake.
- **Laptop off:** Claude app → **Code** → New session → choose the repo. The toolkit arrives through the setup script (README).

Details: [MOBILE.md](../MOBILE.md).

## 4. Changing the setup

Just tell Claude what to change, from any project. It decides where the change goes:

| The change is about… | It goes to | Commit |
|---|---|---|
| one project only (its rules, agents, Sentry/Slack) | that project's `.claude/` | you, with the project's work |
| every project | `~/code/claude-toolkit/` | **Claude commits and pushes it** (`toolkit-sync`) |

Edits to existing toolkit files work immediately (they are symlinked). A **new** command, agent or skill needs `~/code/claude-toolkit/install.sh` once on each machine. The installed version is in `~/.claude/toolkit-version`.

## 5. Another machine

```bash
git clone git@github.com:chabanroman/claude-toolkit.git ~/code/claude-toolkit
~/code/claude-toolkit/install.sh && source ~/.zshrc
```
Update later with `git -C ~/code/claude-toolkit pull`.

## 6. One-time manual steps

- Sentry: `/mcp` → "claude.ai Sentry" → Authenticate.
- Cloud sessions: add the setup script from the README on claude.ai/code.
- Optional: `brew install gh && gh auth login` if Claude should open PRs itself.

See also: [README](../README.md) · [MCP.md](../MCP.md) · [MOBILE.md](../MOBILE.md) · [CHANGELOG](../CHANGELOG.md)
