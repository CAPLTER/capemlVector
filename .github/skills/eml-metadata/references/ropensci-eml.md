# R workflow: ROpenSci EML & EMLassemblyline (working notes)

> Authoritative sources (verify function names/args before asserting):
> - ROpenSci EML: https://docs.ropensci.org/EML/
> - EMLassemblyline: https://ediorg.github.io/EMLassemblyline/
> - EDIutils: https://docs.ropensci.org/EDIutils/

## Recommended default: EMLassemblyline (template-driven, reproducible)
Typical flow (confirm current function signatures in the docs):
1. `template_directories()` — set up a project layout.
2. `template_core_metadata()` — abstract, methods, keywords, intellectual rights.
3. `template_table_attributes()` — attribute definitions, classes, units.
4. `template_categorical_variables()` — code definitions for factors.
5. `template_geographic_coverage()` / taxonomic / temporal templates.
6. `make_eml()` — assemble and write validated EML XML.

Edit the generated text templates (Markdown/CSV) under version control; the
EML is a build artifact regenerated from them.

## Programmatic control: ROpenSci `EML`
- Build EML as nested R lists / `emld` objects, then `write_eml()`.
- `eml_validate()` to schema-validate before deposit.
- Use when you need elements EMLassemblyline does not template.

## Deposit: EDIutils
- Authenticate, then stage/evaluate (congruence report) and upload a package to
  the EDI staging or production environment.

## Reproducibility hooks (tie into repo standards)
- Pin these packages with `renv`.
- Keep raw data immutable; write EML to an output dir; make the build script
  runnable end-to-end from a clean checkout.
