---
description: "Use when constructing, validating, or revising ecological metadata in the Ecological Metadata Language (EML) for deposit in the Environmental Data Initiative (EDI) repository. Covers required elements, congruence checks, and the ROpenSci EML R workflow."
---
# EML Metadata Authoring

For full procedures and authoritative references, load the
**`eml-metadata` skill** (`/eml-metadata`). This instruction is the short,
always-discoverable pointer.

## Core rules

- The metadata record is a deliverable, not an afterthought — spec it like code.
- Validate against the **EML schema** and pass EDI's congruence checks
  (`EMLassemblyline` / `EDIutils`) before deposit.
- Prefer the **ROpenSci `EML`** package (and `EMLassemblyline`) to hand-editing
  XML; generate from tabular templates so the process is reproducible.
- Every dataset needs: title, creators with ORCIDs, abstract, keywords,
  temporal/geographic/taxonomic coverage, methods, and per-attribute
  definitions + units for all data tables.
- Record provenance and intellectual rights; never embed sensitive locations of
  protected species without following EDI guidance.
