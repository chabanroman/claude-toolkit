# Personal rules (all projects)

Installed by `claude-toolkit` as `~/.claude/CLAUDE.md`. A project's own CLAUDE.md wins where they disagree.

## Routing — decide before starting

| Situation | Do |
|---|---|
| Small, local change (≈1–3 files, one concern) | Inline, no agents. |
| Need to find things across many files, only the conclusion matters | `Explore` agent (or the project's research agent, e.g. `neckbeard`). |
| Several independent parts (API + UI + docs) | One subagent per part, launched in the same message; merge results. |
| Bug unrelated to the current feature | The project's side-fix agent (e.g. `sidequest`), keep this context clean. |
| Diff is done | The project's review agent (e.g. `rules-review`) before writing a commit message. |
| UI or data-flow change | Verify in the browser (e.g. `browser-verify`), don't stop at "it compiles". |
| Ticket id (`ABC-123`) or Linear URL mentioned | Read it via Linear first (issue + comments + images). |
| Sentry issue / error / stack trace mentioned | Read it via Sentry first; for a sweep use the project's Sentry agent. |
| Library API you're unsure of | Context7 docs for the installed version, not memory. |
| Bigger than one PR, or a separate scope that should be reviewed on its own | Propose Linear sub-tickets (title, description, acceptance criteria). Create them only after I say yes. |

Prefer a project command when one exists for the job (`/ticket`, `/commit-msg`, …) over re-deriving its steps.

## Git

- Commits are authored by me only: no `Co-Authored-By: Claude`, no "Generated with Claude Code".
- If the project forbids Claude from committing, hand over a paste-ready message instead. Otherwise still ask before `git commit` / `git push`.
- Message: imperative subject under ~70 chars, blank line, short body on the why, ticket id on its own last line when known.

## Changing the Claude setup itself

When I ask to change how Claude works (a rule, command, agent, skill, hook), first decide where it belongs:

- **Only one project** (its code, rules, Sentry/Slack, design system) → that project's `.claude/` or `CLAUDE.md`. It ships with the project's normal work; the project's git rules apply (in cdp2-frontend: never commit, hand over a message).
- **Any project** → `~/code/claude-toolkit/` (`CLAUDE.md`, `commands/`, `bin/`, `hooks/`, `docs/`). Edit there, add a line to `CHANGELOG.md`, update `docs/USAGE.md` **and** `docs/USAGE.uk.md` if usage changed, then commit and push with `~/code/claude-toolkit/bin/toolkit-sync "<message>"`, no need to ask. If a new file was added under `commands/`, also run `~/code/claude-toolkit/install.sh`.

Never mix the two: a toolkit commit contains toolkit files only. If a request needs both, do both parts and say which went where.

## Hand-over

End every piece of work with: what changed (file, one line each) · what was verified and how · what was NOT verified · the commit message.
