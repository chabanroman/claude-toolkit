---
description: "A ticket came in, take it" — Linear issue → branch → implement → local checks → commit message, PR text and a Linear update ready to send.
argument-hint: <TICKET-ID or Linear URL> [notes]
---

Take this ticket: $ARGUMENTS

1. **Read it.** Linear issue + comments + images, through the project's Linear binding (`~/.claude/CLAUDE.md`): if the project declares one and the ticket prefix isn't in its teams, say it isn't this project's ticket and stop. If it links a Sentry issue, read that issue and its latest event too. If it links Figma, read the frame.
2. **Restate** in 3–5 lines: what to build, the acceptance criteria verbatim, and what is out of scope. If anything is ambiguous, ask ONE question with a recommended answer and stop.
3. **Branch.** Locally, first run `wt-clean --yes` (removes merged worktrees and branches; see `~/.claude/CLAUDE.md`). If the working tree is clean, create `<ticket-id>-<short-slug>` from the up-to-date default branch (`git switch -c`). If it isn't clean, ask first.
4. **Implement.** If this project has a `/ticket` command, follow its steps from "pin the scope" on: it carries the project's rules. Otherwise route the work by the table in `~/.claude/CLAUDE.md`.
5. **Local gate.** Run the local gate even if the project has CI. Use the project's `CLAUDE.md` **Checks** if listed; otherwise run whatever the project has, in this order, and don't skip any that exist: lint, typecheck, tests, build (read the project's scripts: `package.json`, `Makefile`, `pyproject.toml`, …). Fix failures. Report each one as passed / failed / not present. If you pushed and `gh` is available, report the CI run status for the branch (`gh run list --branch <branch> --limit 1`); don't wait more than a few minutes.
6. **Hand over.** For the commit, push and PR, follow the project's Git policy (the `Git policy:` line in its `CLAUDE.md`, default `ask`; see `~/.claude/CLAUDE.md`); that covers cloud sessions too.
   - the commit message
   - a PR title + body (or the PR link, if the policy opened it): summary, acceptance criteria as a checked list, how it was verified, the ticket link
   - a 3–5 line Linear comment summarizing the change
7. **Ask once, whatever the Git policy:** "Post the Linear comment and move the issue to In Review?" Do it only on yes, after checking the workspace and team match the project's Linear binding.
