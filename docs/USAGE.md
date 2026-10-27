# How to use claude-toolkit

🇺🇦 [Українська версія](USAGE.uk.md)

## 1. Daily commands

| Type | What happens |
|---|---|
| `/task <anything>` | Claude classifies the request (inline / agent / skill / parallel / sub-tickets), shows the decision in 2–3 lines, then does it. Sub-tickets in Linear are only created after you say yes. |
| `/pickup CDP-123` | Reads the Linear ticket (+ linked Sentry/Figma) → restates it → creates a branch → implements → runs the local checks (`yarn build` in cdp2) → hands over the commit message, PR text and a Linear comment. Posts to Linear / moves to In Review only when you say yes. |
| *anything, in plain words* | The routing rules in `~/.claude/CLAUDE.md` still apply: ticket id → Linear first, Sentry link → Sentry first, wide search → Explore agent, independent parts → parallel agents. |
| `/sentry-sweep [24h\|7d]` | Finds this project in Sentry, fixes the urgent and frequent errors, returns what changed + commit message. Needs Sentry logged in (`/mcp`). |
| `/slack-scan [today\|3d\|this week] [#channel]` | Lists problems reported in Slack that this repo can fix, asks which ones to fix. |

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

**A project agent with the same name wins.** cdp2-frontend has its own, more specific versions of all six (plus `ds-docs` and the `/ticket` and `/commit-msg` commands), so there those run; everywhere else these do.

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

Edits to existing toolkit files work immediately (they are symlinked). A **new** command or agent file needs `~/code/claude-toolkit/install.sh` once on each machine.

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
