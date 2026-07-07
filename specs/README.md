# specs/ — Specifications as Infrastructure-as-Code

This directory is the **source of truth** for non-trivial work. A spec is
written and reviewed *before* code, the way Terraform/Ansible declare desired
state before anything is provisioned.

## Layout

```
specs/
└── <slug>/
    ├── spec.md     # the contract (goals, options, decision, success criteria)
    └── plan.md     # ordered, checkable steps derived from spec.md
```

## Workflow

1. `/spec <request>` → drafts `specs/<slug>/spec.md`. Review & commit.
2. `/plan specs/<slug>/spec.md` → drafts `specs/<slug>/plan.md`. Review & commit.
3. Implement step by step. If reality diverges, **update the spec first**.
4. Done when every success criterion in `spec.md` passes.

## Why commit specs?

- **Auditability** — reviewers see the reasoning and trade-offs, not just code.
- **Reproducibility** — regenerate intent after the fact; onboard collaborators.
- **Intentionality** — design decisions are explicit and version-controlled,
  not buried in chat history.

Prior art worth borrowing from: GitHub Spec Kit, and the "specs as code" pattern.
