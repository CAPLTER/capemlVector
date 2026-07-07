---
name: eml-metadata
description: 'Author, validate, and revise ecological metadata in the Ecological Metadata Language (EML) for deposit in the Environmental Data Initiative (EDI) repository. Use when building a data package, writing EML XML, choosing required elements, running congruence checks, or using the ROpenSci EML / EMLassemblyline R workflow.'
argument-hint: 'e.g. "build an EML record for this CSV time series"'
---

# EML Metadata Authoring (EDI deposit)

Produce a **valid, congruent, reproducible** EML data package. Generate metadata
from tabular templates with R tooling rather than hand-editing XML.

## When to use
- Creating a new data package for EDI.
- Adding/validating EML elements (coverage, attributes, units, methods).
- Debugging schema-validation or EDI congruence-check failures.

## Procedure
1. **Frame the package**: identify data entities (tables, rasters, others),
   responsible parties (with ORCIDs), and the temporal/geographic/taxonomic
   scope. Capture this in a `specs/` entry first for non-trivial packages.
2. **Choose the workflow**:
   - Reproducible/template-driven → `EMLassemblyline` (recommended default).
   - Programmatic/fine control → ROpenSci `EML` package directly.
   See [ropensci-eml.md](./references/ropensci-eml.md).
3. **Fill required elements** per [eml-schema.md](./references/eml-schema.md):
   title, creators, abstract, keywords, intellectual rights, coverage,
   methods, and per-attribute definitions + units for every data table.
4. **Apply EDI best practices** from
   [edi-best-practices.md](./references/edi-best-practices.md): naming,
   units, missing-value codes, provenance, and sensitive-data handling.
5. **Validate**: schema-validate the EML and run EDI congruence checks; fix all
   errors and warnings before deposit.
6. **Deposit**: stage to the EDI portal (or `EDIutils`), review, then publish.

## Authoritative sources (verify before asserting APIs)
- EML schema — https://github.com/NCEAS/eml and https://eml.ecoinformatics.org/
- EDI best practices — https://ediorg.github.io/data-package-best-practices/
- ROpenSci EML — https://docs.ropensci.org/EML/
- EMLassemblyline — https://ediorg.github.io/EMLassemblyline/
