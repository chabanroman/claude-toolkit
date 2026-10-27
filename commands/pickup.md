---
description: "A ticket came in, take it" — Linear issue → branch → implement → local checks → commit message, PR text and a Linear update ready to send.
argument-hint: <TICKET-ID or Linear URL> [notes]
---

Take this ticket: $ARGUMENTS

1. **Read it.** Linear issue + comments + images. If it links a Sentry issue, read that issue and its latest event too. If it links Figma, read the frame.
2. **Restate** in 3–5 lines: what to build, the acceptance criteria verbatim, and what is out of scope. If anything is ambiguous, ask ONE question with a recommended answer and stop.
3. **Branch.** If the working tree is clean, create `<ticket-id-lowercase>-<short-slug>` from the up-to-date default dev branch (`git switch -c`). If it isn't clean, ask first.
4. **Implement.** If this project has a `/ticket` command, follow its steps from "pin the scope" on: it carries the project's rules. Otherwise route the work by the table in `~/.claude/CLAUDE.md`.
5. **Local gate.** There is no CI, so this is the only check. Run whatever the project has, in this order, and don't skip any that exist: lint, typecheck, tests, build (read `package.json` scripts). Fix failures. Report each one as passed / failed / not present.
6. **Hand over. Don't send anything yet:**
   - the commit message. Locally, the project's rules decide whether you commit (if it forbids it, don't). In a cloud session (`CLAUDE_CODE_REMOTE=true`) commit on the ticket branch and push it, so the work isn't lost with the VM; never to main / dev
   - a PR title + body: summary, acceptance criteria as a checked list, how it was verified, the ticket link
   - a 3–5 line Linear comment summarizing the change
7. **Ask once:** "Post the Linear comment and move the issue to In Review?" Do it only on yes. The PR is opened by me, or with `gh pr create` if I say so and `gh` is authenticated.
