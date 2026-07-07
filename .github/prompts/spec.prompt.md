---
description: "Generate or update a version-controlled specification in specs/ from a feature request or issue. Spec-as-IaC: the contract reviewed and committed before code."
argument-hint: "<feature or issue to specify>"
tools: [read, search, web]
---
# /spec — Write the contract

You are drafting a **specification**, not code. Treat the spec as
Infrastructure-as-Code: it is the reviewable, version-controlled source of truth
that implementation will flow from.

## Steps

1. **Frame** the request: ${input:request}. Restate as a problem statement.
2. Research with authoritative sources (doc MCP servers, official docs, the
   `eml-metadata` skill if this is metadata work). Cite what you used.
3. Evaluate 2–3 options against the Well-Architected pillars. Recommend one and
   state the trade-offs.
4. Write the spec to `specs/<slug>/spec.md` using the structure below.

## Spec structure

```markdown
# <Title>
## Problem
## Goals / Non-goals
## Constraints & assumptions
## Options considered (with Well-Architected trade-offs)
## Decision
## Success criteria (testable)
## Risks & rollback
## References (links verified this session)
```

Do **not** implement. End by asking the user to review and approve the spec.
