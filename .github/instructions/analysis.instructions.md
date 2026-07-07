---
description: "Use when the deliverable is a data analysis rather than software: exploratory analysis, statistics/modeling, figures, or reports/notebooks. Frames the spec around a research question + success metric, and emphasizes reproducible pipelines."
---
# Analysis (analyze, don't just build)

Same loop and pillars as `copilot-instructions.md`, with data-analysis framing.
The deliverable is a **validated result** (figures, tables, model, report) — not
software. Treat reproducibility as the reliability pillar.

## Spec framing for analysis
- **Problem** = the research question, stated so it can be answered yes/no/by-how-much.
- **Success criteria** = a defensible result + the metric/threshold that judges it
  (e.g. effect estimate with CI, validation score, passing assumption checks).
- **Non-goals** = analyses explicitly out of scope (avoid scope creep / p-hacking).

## Reliability = reproducibility
- Prefer pinned deps (suggest `renv` for R; use Astral `uv` lock/workflow for
  Python); set seeds; raw data immutable; outputs regenerable.
- Prefer a DAG pipeline (`targets` in R, Snakemake/`make` in Python) over ad-hoc
  scripts so only changed steps rerun — also helps Performance & Cost pillars.
- Notebooks for exploration; promote stable steps into scripted pipeline stages.

## Verify
- Re-run end-to-end from a clean checkout; outputs match.
- State assumptions and check them; report uncertainty, not just point estimates.
- If publishing data, hand off to the `eml-metadata` skill for the package.

Consult `docs/waf/pillars/` and cite trade-offs in `specs/<slug>/spec.md`.
