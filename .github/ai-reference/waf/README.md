# Well-Architected Framework — local reference

Version-controlled reference material for design decisions. Agents read these
files on demand (native workspace file access — no MCP server needed) and cite
the relevant pillar in specs and plans.

## Why a local folder instead of an MCP filesystem server?

`.github/ai-reference/waf/` is inside the workspace, so the agent already has
read access via its native file tools. A filesystem MCP server here would add
process overhead and tool-surface clutter without adding capability. Read-only
intent is enforced by restricting the `architect`/`planner` agents' `tools:` to
read/search.

Use an MCP server only to reach docs **outside** the workspace, or a live
external source (that's what `context7` and `microsoft-learn` are for in
`.vscode/mcp.json`).

## Layout

```
.github/ai-reference/waf/
├── README.md          # this file
└── pillars/
    ├── reliability.md
    ├── security.md
    ├── operational-excellence.md
    ├── performance-efficiency.md
    └── cost-sustainability.md
```

## How to use in the loop

1. During **Architect** / `/spec`, open the relevant pillar checklist(s).
2. Score each option; note the trade-off explicitly.
3. Cite the pillar in `specs/<slug>/spec.md` under *Options considered*.

## Sources to ground these checklists (verify before asserting)

- AWS Well-Architected Framework — https://aws.amazon.com/architecture/well-architected/
- Azure Well-Architected Framework — https://learn.microsoft.com/azure/well-architected/
- Google Cloud Architecture Framework — https://cloud.google.com/architecture/framework

Adapt the cloud-centric guidance to a **research-software** context (R/Python,
reproducibility, data packages). The pillar files below are tailored that way.
