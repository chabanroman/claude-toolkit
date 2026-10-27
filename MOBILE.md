# Using Claude Code from the iPhone

## A. Remote Control: the laptop does the work, the phone drives

Everything local is available: your files, uncommitted changes, `yarn dev`, Chrome, all MCP servers.

1. On the laptop, in the project: `crc` (= `claude --remote-control`), or `/rc` inside a running session.
   For a ticket in its own worktree: `wt CDP-123` (starts `/pickup CDP-123` with Remote Control on).
2. The first time, accept "Enable Remote Control".
3. On the phone, open the Claude app → **Code**: the session is in the list (named after the host, the branch, or what you passed).
   Or scan the QR code (`/rc` again shows it).
4. Type as usual: `/pickup CDP-123`, `/sentry-sweep`, `/slack-scan today`, `/task …`. Photos you attach go to Claude.
5. The laptop must stay awake (macOS: `caffeinate -dims` in another tab, or keep it on power with the lid open).

## B. Cloud session: no laptop

Runs on a fresh clone in Anthropic's cloud. You get the project's `.claude/` (agents, skills, project commands), the claude.ai connectors (Linear, Slack, Sentry), and this toolkit through the setup script (see README).
You don't get: local `.env` files, Chrome or `browser-verify`, `localhost`, or Remote Control features.

1. One-time setup at claude.ai/code → environment → setup script (README → Cloud sessions). Add the env vars the build needs (`VITE_*`); no secrets there.
2. Phone: Claude app → **Code** → New session → pick the repo and branch.
3. Ask: `/pickup CDP-123` or `/sentry-sweep`. In the cloud Claude commits and pushes to a branch of its own (never `main` / `dev`): the VM is thrown away afterwards. You review the **Changes** card and open the PR from claude.ai or the GitHub app, then merge it yourself.
4. To continue that work on the laptop: `claude --teleport` in the repo (picks the session, checks out its branch).

## Which one?

- Need the running app, local env or the browser check → **A**.
- Laptop off or travelling, and the work is code-only → **B**.
