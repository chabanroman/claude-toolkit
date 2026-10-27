---
description: Sweep Sentry for this project (default last 24h), fix the urgent and frequent errors, hand over what changed and a commit message (never commits).
argument-hint: [period, e.g. 24h | 7d] [Sentry issue URLs…]
---

Run the `sentry-fix` agent with: $ARGUMENTS (empty = unresolved issues seen in the last 24 hours).

When it returns:
1. Show its report as it is.
2. If a fix touches UI, run `browser-verify` on the affected pages. Run `rules-review` on the diff and fix what it finds.
3. Finish with the files changed and the commit message. Never `git add` / `commit` / `push`, never change anything in Sentry.
