# Plan for: EML Data Package — Stream Chemistry Time Series → EDI

> Derived from [spec.md](./spec.md). Steps are small, testable, and reversible.
> The repo stays runnable after each step. If reality diverges from the spec,
> update the spec **first**, then this plan.

- [ ] 1. **Initialize reproducible env** — files: `renv.lock`, `.Rprofile` —
      verify: `renv::status()` clean after `renv::init()`; `EML`,
      `EMLassemblyline`, `EDIutils` recorded in lockfile.
- [ ] 2. **Stage immutable raw data** — files: `data/raw/stream_chem.csv` —
      verify: file present, read-only convention documented; no edits to raw.
- [ ] 3. **Create template directories** — files: `metadata_templates/` —
      verify: `EMLassemblyline::template_directories()` layout exists.
- [ ] 4. **Core metadata templates** — files: `metadata_templates/abstract.md`,
      `methods.md`, `keywords.txt`, `intellectual_rights.txt` —
      verify: `template_core_metadata()` ran; files filled (no placeholders).
- [ ] 5. **Attribute templates** — files:
      `metadata_templates/attributes_stream_chem.txt` —
      verify: every CSV column has definition, class, unit (spec success #4).
- [ ] 6. **Categorical + custom units** — files:
      `metadata_templates/catvars_*.txt`, `custom_units.txt` —
      verify: factor codes defined; non-standard units declared as `customUnit`.
- [ ] 7. **Coverage templates** — files: geographic/taxonomic/temporal templates
      — verify: bounding box + date range present and match the data.
- [ ] 8. **Build EML** — files: `make.R`, `eml/<scope>.<id>.<rev>.xml` —
      verify: `make_eml()` runs clean (spec success #1).
- [ ] 9. **Validate schema** — files: (none new) —
      verify: `EML::eml_validate()` returns `TRUE` (spec success #2).
- [ ] 10. **EDI congruence check** — files: congruence report —
      verify: zero errors via `EDIutils` evaluation; warnings reviewed
      (spec success #3).
- [ ] 11. **End-to-end rebuild test** — files: `make.R`, `README.md` —
      verify: fresh clone + `renv::restore()` + `source("make.R")` reproduces
      the EML (spec success #5).

## Open questions
- Confirm intellectual-rights license (CC-BY vs CC0) with PI.
- Confirm EDI scope/identifier for this package (staging first).

## Definition of done
All success criteria in [spec.md](./spec.md) pass (schema valid, zero congruence
errors, full attribute coverage, reproducible rebuild). Publish to production EDI
is a **manual, human-reviewed** step after sign-off (per spec non-goals).
