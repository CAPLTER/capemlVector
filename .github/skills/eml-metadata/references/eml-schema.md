# EML Schema — required and recommended elements

> Authoritative source: https://github.com/NCEAS/eml and
> https://eml.ecoinformatics.org/ — verify element names/cardinality there
> before asserting them; this file is a working checklist, not the schema.

## Dataset-level (required / strongly recommended)
- `title` — concise, descriptive, includes what/where/when.
- `creator` — one or more; include ORCID `userId` where available.
- `pubDate`
- `abstract` — what, why, how, scope.
- `keywordSet` — prefer controlled vocabularies (e.g. LTER, GCMD).
- `intellectualRights` — typically CC0 or CC-BY for EDI.
- `coverage`:
  - `temporalCoverage` (range of dates)
  - `geographicCoverage` (bounding box + description)
  - `taxonomicCoverage` (ranked taxa, ideally with authority IDs)
- `maintenance` — update frequency / completed.
- `contact` — responsible contact party.
- `methods` — methodStep(s); sampling and processing description.

## Data-entity level (per table / other entity)
- `entityName`, `entityDescription`
- `physical` — data format, field delimiter, encoding, distribution.
- `attributeList` — for **every** column:
  - `attributeName`, `attributeDefinition`
  - measurement scale: `nominal` | `ordinal` | `interval` | `ratio` |
    `dateTime`
  - `unit` (standard EML unit or a documented `customUnit`)
  - `missingValueCode` + `missingValueCodeExplanation`
- `numberOfRecords`

## Common validation pitfalls
- Undefined or non-standard units → declare `customUnit` in `additionalMetadata`.
- Missing `missingValueCode` definitions.
- Attribute count/names not matching the actual data file (congruence error).
- Empty or placeholder `attributeDefinition`.
