# Personal rules (all projects)

Installed by `claude-toolkit` as `~/.claude/CLAUDE.md`. A project's own CLAUDE.md wins where they disagree.

## Routing — decide before starting

| Situation | Do |
|---|---|
| Small, local change (≈1–3 files, one concern) | Inline, no agents. |
| Need to find things across many files, only the conclusion matters | `Explore` agent; for "how does X work" with citations, `neckbeard`. |
| Several independent parts (API + UI + docs) | One subagent per part, launched in the same message; merge results. |
| Bug unrelated to the current feature | `sidequest` agent, keep this context clean. |
| Diff is done | `rules-review` agent before writing a commit message. |
| UI or data-flow change | `browser-verify` agent on localhost, don't stop at "it compiles". |
| Ticket id (`ABC-123`) or Linear URL mentioned | Read it via Linear first (issue + comments + images), through the project's Linear binding (below). |
| Sentry issue / error / stack trace mentioned | Read it via Sentry first; for a sweep, `/sentry-sweep` (`sentry-fix` agent). |
| "What's broken according to Slack" | `/slack-scan <period>` (`slack-scout` agent, read-only; asks before fixing). |
| Library API you're unsure of | Context7 docs for the installed version, not memory. |
| Bigger than one PR, or a separate scope that should be reviewed on its own | Propose Linear sub-tickets (title, description, acceptance criteria). Create them only after I say yes. |

Prefer a project command when one exists for the job (`/ticket`, `/commit-msg`, …) over re-deriving its steps.

## Git

A project declares its policy in its own `CLAUDE.md` with a line `Git policy: <name>`. Nothing declared → `ask`.

| Policy | Commit | Push | PR |
|---|---|---|---|
| `hand-over` | never locally — give a paste-ready message (cloud: see below) | never locally (cloud: see below) | give the PR text |
| `ask` (**default**) | ask first (cloud: no ask, see below) | ask first (cloud: no ask) | give the PR text |
| `autonomous` | after the local gate passes, without asking | to the work branch, without asking | `gh pr create` if `gh` is authenticated, else give the text |

Whatever the policy:
- Never commit or push to `main` / `master` / `dev` / `develop` directly. Never force-push.
- Name the branch after the work: `<ticket-id>-<slug>` or `fix-<slug>` without a ticket — never a `claude/` prefix.
- In a cloud session (`CLAUDE_CODE_REMOTE=true`) the VM is thrown away, so `hand-over` and `ask` commit and push to the work branch when the work is done, then give me the PR link or the branch name. If the push to that name is refused, push the session's own branch instead and tell me its name, so nothing is lost. `autonomous` is unchanged.
- Message: imperative subject under ~70 chars, blank line, short body on the why, ticket id on its own last line when known.

## No AI mention

Commit messages, PR titles and bodies, branch names, code comments, changelogs and Linear comments read as written by me. Never put "Claude", "AI-generated", `Co-Authored-By`, "Generated with …", a robot emoji or a session link there. (The `commit-msg` hook is a safety net, not the rule.)

## Linear binding

A project may bind Linear in its own `CLAUDE.md`:
```
Linear: workspace <name> · teams <KEY,…> · server <mcp-server-name>
```
- If declared: use only that MCP server for Linear in this project. Before any write (comment, status, new issue), check that the workspace and the team match; if they don't, stop and say what you see.
- A ticket id whose prefix is not in the declared teams is not this project's ticket: say so instead of reading it.
- Nothing declared: use the claude.ai Linear connector.

## Changing the Claude setup itself

When I ask to change how Claude works (a rule, command, agent, skill, hook), first decide where it belongs:

- **Only one project** (its code, rules, Sentry/Slack, design system) → that project's `.claude/` or `CLAUDE.md`. It ships with the project's normal work; the project's Git policy applies.
- **Any project** → `~/code/claude-toolkit/` (`CLAUDE.md`, `agents/`, `commands/`, `skills/`, `bin/`, `hooks/`, `docs/`). Edit there, add a line to `CHANGELOG.md` (on a release also bump `VERSION`), update `docs/USAGE.md` **and** `docs/USAGE.uk.md` if usage changed, then commit and push with `~/code/claude-toolkit/bin/toolkit-sync "<message>"`, no need to ask. If a new file was added under `commands/`, `agents/` or `skills/`, also run `~/code/claude-toolkit/install.sh`.

Never mix the two: a toolkit commit contains toolkit files only. If a request needs both, do both parts and say which went where.

## Hand-over

End every piece of work with: what changed (file, one line each) · what was verified and how · what was NOT verified · the commit message.
