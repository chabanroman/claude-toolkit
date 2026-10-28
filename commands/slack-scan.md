---
description: Scan Slack for a period (default today) for issues this project can fix, show the list, then fix only what you pick (never commits).
argument-hint: [today | yesterday | 3d | this week | YYYY-MM-DD..YYYY-MM-DD] [#channel …]
---

Period and channels: $ARGUMENTS (empty = today, all channels)

1. Run the `slack-scout` agent with the period and channels. Show its list as it is.
2. **Stop and ask** which items to fix ("1, 3" / "all S" / "none"). Change nothing before the answer. For L items, offer a Linear ticket draft instead (create only on yes).
3. Fix each chosen item; the Slack report is the scope. If the project has a `/ticket` command, follow its steps from "pin the scope" on. Independent items (different files) can run in parallel through `sidequest`, one item each.
4. Verify: the project's checks, `browser-verify` for anything visible, `rules-review` on the diff.
5. Hand over: what changed per item (`file:line`), what was verified, ONE commit message (a bullet per item with its Slack permalink). Never post in Slack. In a cloud session (`CLAUDE_CODE_REMOTE=true`) instead commit on a branch named `fix-slack-<slug>` (never a `claude/` prefix; if that push is refused, push the session's own branch and say so) and push it, so the work isn't lost with the VM (never to main / dev); locally, never commit.
