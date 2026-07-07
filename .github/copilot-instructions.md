# Engineering Operating Model

These instructions apply to all work in this repository. They establish a
**spec-driven, well-architected** workflow: we treat specifications as
version-controlled source of truth — "specs as Infrastructure-as-Code" — and
flow implementation from approved specs rather than from ad-hoc prompting.

## The Loop (always follow this order)

1. **Frame** — Restate the feature/issue as a problem statement with explicit
   goals, non-goals, constraints, and success criteria.
2. **Architect** — Evaluate options against the Well-Architected pillars
   (below). Consult authoritative documentation (MCP doc servers, official
   project docs) before recommending. Surface trade-offs, don't hide them.
3. **Specify** — Write or update a spec in `specs/` using `/spec`. The spec is
   the contract; it is reviewed and committed before code is written.
4. **Plan** — Produce an ordered, checkable action plan from the spec using
   `/plan`. Each step is small, testable, and reversible.
5. **Implement** — Execute the plan step by step. Keep changes scoped to the
   plan; if reality diverges, update the spec/plan first.
6. **Verify** — Run tests/linters; confirm success criteria from the spec.

If a request is large or ambiguous, stop at step 1–3 and get sign-off on the
spec before implementing.

## Well-Architected Pillars (decision lens)

Score every non-trivial design choice against these and note the trade-off:

- **Reliability** — reproducibility, error handling, idempotency, recovery.
- **Security** — least privilege, secret handling, dependency provenance,
  OWASP Top 10. Never commit credentials or PII.
- **Operational excellence** — automation, observability, CI, documentation.
- **Performance efficiency** — appropriate data structures, vectorization,
  avoiding needless recomputation.
- **Cost / sustainability** — compute and storage footprint, caching, batch
  vs. interactive workloads.

Cite the pillar(s) you are optimizing for and what you are trading away.

## Authoritative-source discipline

- Prefer official documentation over memory. Use connected documentation MCP
  servers and the project's own docs/skills before asserting an API.
- When you state an API signature, function name, or config key, it must come
  from a source you verified this session — not a guess.
- Link the source in the spec/plan so reviewers can audit the reasoning.

## Project conventions

- **Languages**: R and Python. Language-specific standards load automatically
  from `.github/instructions/`.
- **Reproducibility first**: suggest `renv` for R and use Astral `uv` for
  Python dependency locking/execution, set seeds, and make scripts runnable
  end-to-end from a clean checkout.
- **Domain knowledge** (e.g., ecological metadata / EML / EDI) lives in
  `.github/skills/` and loads on demand — do not inline large domain dumps here.
- **Specs live in `specs/`**; plans live alongside their spec. Both are
  committed and reviewed like code.
- **Record operating-model changes** (instructions, agents, prompts, skills,
  WAF docs, MCP config) in `.github/CHANGELOG.md` — capture the *why*.
