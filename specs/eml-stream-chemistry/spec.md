# EML Data Package: Stream Chemistry Time Series → EDI

> **Status:** Example / template. Replace bracketed values with real ones.
> This worked example shows the Frame → Architect → Specify steps of the loop
> (`copilot-instructions.md`). Run `/plan specs/eml-stream-chemistry/spec.md`
> to regenerate `plan.md`.

## Problem

We have a multi-year stream water-chemistry dataset (one CSV table of weekly
grab-sample measurements) that must be published as a citable, reusable data
package in the **Environmental Data Initiative (EDI)** repository. It currently
has no standardized metadata, so it cannot be deposited or discovered.

## Goals

- Produce a **schema-valid EML** record that passes EDI congruence checks.
- Generate metadata **reproducibly** from the data + a script (no hand-edited XML).
- Document every attribute (definition, unit, missing-value code).
- Make the package re-buildable end-to-end from a clean checkout.

## Non-goals

- Re-deriving or QC-ing the underlying measurements (assumed already cleaned).
- Automating the *publish* step to production EDI (human review before publish).
- Building an MCP server for EML (out of scope; using the `eml-metadata` skill).

## Constraints & assumptions

- Language: **R** (project standard for EML work; see `r-style.instructions.md`).
- Tooling: ROpenSci `EML` / `EMLassemblyline`; deposit via `EDIutils`.
- Data: single table `data/raw/stream_chem.csv`, treated as **immutable**.
- Creators have ORCIDs; intellectual rights = CC-BY (confirm with PI).
- No sensitive/protected-species locations in this dataset.

## Options considered (Well-Architected trade-offs)

See `docs/waf/pillars/` for the checklists referenced below.

### Option A — Hand-author EML XML
- **Reliability** ↓: error-prone, not regenerable; congruence drift likely.
- **Operational excellence** ↓: no automation; hard to review diffs.
- Rejected.

### Option B — ROpenSci `EML` package, programmatic build
- **Performance/flexibility** ↑: full control over every element.
- **Operational excellence** ↓: more bespoke code to maintain for a standard
  tabular package.
- Viable but heavier than needed here.

### Option C — `EMLassemblyline` template-driven build *(recommended)*
- **Reliability** ↑: metadata generated from version-controlled text/CSV
  templates; regenerable from a clean checkout.
- **Operational excellence** ↑: reviewable template diffs; standard workflow EDI
  documents and supports.
- **Trade-away:** less fine-grained control than Option B — acceptable for a
  single standard data table.

## Decision

Adopt **Option C (`EMLassemblyline`)**. Optimizing for **Reliability** and
**Operational excellence**; trading away the fine-grained control of a fully
programmatic `EML` build, which this standard tabular package does not need.

## Success criteria (testable)

1. `EMLassemblyline::make_eml(...)` runs without error and writes EML XML.
2. The EML passes schema validation (`EML::eml_validate()` returns `TRUE`).
3. EDI congruence evaluation reports **zero errors** (warnings reviewed).
4. Every column in `stream_chem.csv` has a definition, unit, and
   missing-value code in the attributes template.
5. `make.R` rebuilds the package end-to-end from a clean checkout with pinned
   `renv` dependencies.

## Risks & rollback

- **Custom units** not in the EML standard → declare `customUnit` in
  `additionalMetadata`; re-validate. (Reliability)
- **Congruence failure** (attribute/data mismatch) → fix templates, never the
  generated XML; rebuild. (Reliability)
- Rollback is trivial: metadata generation produces only derived artifacts;
  delete and rebuild. Raw data is never modified. (Security: immutable raw data)

## References (verify before asserting APIs)

- EML schema — https://github.com/NCEAS/eml · https://eml.ecoinformatics.org/
- EDI best practices — https://ediorg.github.io/data-package-best-practices/
- ROpenSci EML — https://docs.ropensci.org/EML/
- EMLassemblyline — https://ediorg.github.io/EMLassemblyline/
- EDIutils — https://docs.ropensci.org/EDIutils/
- Project skill — `.github/skills/eml-metadata/SKILL.md`
