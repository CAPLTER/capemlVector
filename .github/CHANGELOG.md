# Customizations Changelog

Tracks intentional changes to the engineering operating model: instructions,
agents, prompts, skills, WAF docs, and MCP config. Git history captures *what*;
this file captures *why*. Newest first.

## 2026-06-29
- Update R guidance: treat `renv` as suggested (not required), prefer
  explicit non-base namespacing, and favor `purrr` iteration patterns over
  `for` loops by default.
- Standardize Python guidance on the Astral `uv` workflow (`uv lock`,
  `uv sync`, `uv run`) across base, analysis, and reliability references.
- Add PostgreSQL instruction set (`.github/instructions/postgresql.instructions.md`)
  with MCP-first workflow guidance (context -> query -> modify), safety checks,
  and performance review expectations.
- Update README with a dedicated PostgreSQL section so users discover MCP-first
  DB workflow guidance from the template landing page.
- Add a PostgreSQL MCP quick-start checklist in README for faster onboarding to
  safe DB workflows.

## 2026-06-28
- Add `analysis` instruction — covers analyze-not-just-build projects (research
  question + success metric, `targets`/Snakemake pipelines). Same base applies.
- Add this changelog to version the operating model like code.
- Base instructions now require logging operating-model changes here. Add README.
- Add MCP `context7` (live R-package docs); drop redundant filesystem servers
  for `docs/waf`/`specs` (in-workspace, read natively; read-only enforced via
  agent `tools:`). Add `docs/waf/` pillar checklists + WAF instruction.
- Add worked example `specs/eml-stream-chemistry/` (spec + plan).
- Initial scaffold: base `copilot-instructions.md` (loop + pillars), R/Python
  style instructions, `/spec` + `/plan` prompts, `architect`/`planner` agents,
  `eml-metadata` skill, `specs/` convention, Microsoft Learn MCP.
