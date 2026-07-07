---
description: "Turn an approved spec in specs/ into an ordered, checkable action plan of small, testable, reversible steps."
argument-hint: "<path to approved spec>"
tools: [read, search]
---
# /plan — Decompose the approved spec

Read the approved spec (${input:spec}) and produce an implementation plan.

## Rules

- Each step is **small, testable, and reversible**.
- Each step names the files it touches and how it will be verified.
- Order steps so the repo stays runnable after each one.
- Flag any step that diverges from the spec — update the spec first, never the
  plan silently.

## Output

Write to `specs/<slug>/plan.md`:

```markdown
# Plan for <spec title>
- [ ] 1. <action> — files: <...> — verify: <test/command>
- [ ] 2. ...
## Open questions
## Done = all success criteria in spec.md pass
```

Do not implement yet — present the plan for sign-off.
