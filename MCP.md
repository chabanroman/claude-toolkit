# MCP servers

Every server costs context, so only the ones used in most sessions are global. The rest are per project.
**claude.ai connectors** (Settings → Connectors on claude.ai) also work in cloud sessions and on the phone, so they're preferred over `claude mcp add` for anything that has one.

| Server | Where | Auth | Status |
|---|---|---|---|
| Linear | claude.ai connector | OAuth on claude.ai | ✅ connected |
| Slack | claude.ai connector | OAuth on claude.ai | ✅ connected |
| Sentry | claude.ai connector | OAuth: run `/mcp` → "claude.ai Sentry" → Authenticate | ⏳ **needs login**, which `/sentry-sweep` needs |
| Figma | project `.mcp.json` (cdp2-frontend) | OAuth on first use | ✅ connected |
| Context7 — https://github.com/upstash/context7 | user (global), `install.sh` | none (an API key only raises the rate limit) | ✅ after `install.sh` |
| GitHub | `gh` CLI, not MCP | `brew install gh && gh auth login` | ⏳ optional: only needed if Claude should open PRs (`/pickup` hands over the PR text otherwise) |
| Browser | Claude in Chrome (`browser-verify` agent) | Chrome extension | ✅ local only |
| Playwright — https://github.com/microsoft/playwright-mcp | not installed | – | skip for now: Chrome covers local. Add it to a project's `.mcp.json` only if cloud sessions must check UI |

Why `gh` over the GitHub MCP: the CLI costs no context until it's used, has no token to store in config, and Claude already knows it.

Rules: official servers only, never forks. Tokens go in env vars or OAuth, never in a committed `.mcp.json`. Prefer read-only scopes.
