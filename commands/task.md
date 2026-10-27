---
description: Single entry point — classify a request (inline / agent / skill / parallel / sub-tickets), say the decision in 2–3 lines, then do it.
argument-hint: <what you want done>
---

Request: $ARGUMENTS

1. **Gather what the request points at first.** A ticket id or Linear URL → read the issue, its comments and images. A Sentry link or error → read the issue and latest event. A Figma link → read the frame.

2. **Classify, using the routing table in `~/.claude/CLAUDE.md` and the agents, skills and commands this project has.** Pick exactly one:
   - **inline**: small, one concern
   - **command**: a project command already covers it (e.g. `/ticket`); follow it
   - **agent**: name which one and why
   - **skill**: name it
   - **parallel**: list the independent parts; each must touch different files and must not need another part's output
   - **sub-tickets**: bigger than one PR, or parts that should be reviewed separately

3. **Show the decision** in 2–3 lines: the class, the agent/skill/command, and the one reason. Don't ask for approval unless it's sub-tickets.

4. **Execute.**
   - **parallel**: launch all subagents in ONE message. Give each a self-contained prompt with the files it owns and what to return. When they finish, check for overlapping edits, then summarize.
   - **sub-tickets**: draft each one (title, 2–4 line description, acceptance criteria as a checklist, rough order). Show the drafts and STOP. Create them in Linear under the parent issue only after I confirm.
   - everything else: do it.

5. **Hand over** as `~/.claude/CLAUDE.md` says: what changed, what was verified, what wasn't, and the commit message.
