# EDI data-package best practices (working notes)

> Authoritative source:
> https://ediorg.github.io/data-package-best-practices/ — confirm current
> guidance there; this is a summary checklist.

## File & data structure
- Use stable, descriptive, machine-friendly file names (no spaces).
- One observation per row; tidy, non-merged tables; consistent column names.
- Document and use explicit missing-value codes (avoid blanks/ambiguous `NA`).
- Provide units for all measured columns; use standard units where possible.

## Identity & provenance
- Include ORCIDs for creators; name a long-term contact.
- Describe methods so the dataset is independently interpretable.
- Record provenance for derived data; link source packages where applicable.
- Use a clear `intellectualRights` statement (EDI commonly uses CC0 / CC-BY).

## Versioning & deposit
- Data packages are versioned and immutable once published; revise by
  publishing a new revision, not editing in place.
- Pass EDI congruence checks (metadata ↔ data) before publishing.

## Sensitive data
- Follow EDI guidance for sensitive locations (e.g. protected species);
  generalize coordinates rather than omitting metadata entirely.

## Reproducibility expectation
- Generate metadata from scripts/templates so a reviewer can regenerate the
  EML from the data + code.
