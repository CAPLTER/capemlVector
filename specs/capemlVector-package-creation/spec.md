# Extract Vector Functionality into `capemlVector` R Package

## Problem

`capemlGIS` was designed to generate EML metadata for both spatial vectors and
rasters, but bundles these concerns together. The `sf` dependency (required only
for vector workflows) is heavy and increasingly difficult to manage alongside
raster dependencies (`raster`, `terra`). Users who need only vector metadata bear
unnecessary dependency costs. A clean extraction of vector functionality into a
dedicated `capemlVector` package removes this coupling and simplifies `capemlGIS`
to a raster-only package. Migrating `create_geographic_coverage()` — currently in
`capeml` — into `capemlVector` enables complete removal of `sf` from `capeml` as
well, reducing the core package's footprint for all users who work only with
tabular data.

---

## Goals / Non-goals

**Goals**

- Create `capemlVector` as a standalone, installable R package containing all
  vector-specific metadata-generation functions.
- Migrate `create_vector()`, `create_vector_shape()`, `package_vector_shape()`,
  `list_crs()`, and `create_geographic_coverage()` to `capemlVector`.
- Preserve full Roxygen documentation and working `@examples` for all migrated
  functions; update `@examples` namespace qualifiers from `capeml::` to
  `capemlVector::` where applicable.
- Add a deprecated stub for `capeml::create_geographic_coverage()` that points
  users to `capemlVector`.
- Author a comprehensive `README.Rmd`/`README.md` describing the package,
  installation (using `pak`), workflow, and function reference.
- Port or create `testthat` tests for all exported functions in `capemlVector`.
- Remove the fully-deprecated `create_spatialVector()` and `get_emlProjection()`
  stubs from `capemlGIS`; update `capemlGIS` README and documentation to reflect
  raster-only scope.
- Remove `sf` entirely from both `capeml` and `capemlGIS` `Imports`.
- Update cross-package documentation so that `capeml`, `capemlGIS`, and
  `capemlVector` each accurately describe their own scope and link to each other
  where appropriate.
- Document installation for all three packages using `pak`.

**Non-goals**

- Adding new functions beyond what currently exists in the existing packages.
- Changing public function signatures or behavior.
- Migrating raster functions (`create_raster()`, `write_raster_factors()`) out
  of `capemlGIS`.
- Publishing any package to CRAN (GitHub/EDI distribution assumed).

---

## Constraints & assumptions

- All three packages are hosted on GitHub under the `CAPLTER` organization;
  installation is via `pak::pak("CAPLTER/<repo>")` (verified against pak docs
  this session).
- `capemlVector` must declare `capeml` in `Imports` and in `Remotes:` (same
  pattern as `capemlGIS`) because `read_attributes()`,
  `read_package_configuration()`, `write_attributes()`, and `write_factors()` are
  consumed from `capeml`.
- `capeml` must declare `capemlVector` in `Suggests` and `Remotes` so the
  deprecated `create_geographic_coverage()` stub can emit a useful error directing
  users to install `capemlVector`.
- The `eml_valid_crs` dataset stays in `capemlGIS` — it is used by
  `create_raster()` only. `list_crs()` queries the NCEAS EML XSD directly and
  requires no internal data copy.
- `zipRelatedFiles()` stays in `capemlGIS` — it is used only by raster workflows;
  `create_vector_shape()` handles its own zip logic internally via `utils::zip`
  and `system()`.
- `emlCoordSystems` dataset and the `get_emlProjection()` stub are both
  exclusively referenced by each other; both are removed from `capemlGIS`.
- `create_spatialVector()` is already halted with `.Deprecated()` + `stop()` and
  carries no live code paths; it is removed from `capemlGIS`.
- No existing `testthat` tests cover vector functions in `capemlGIS` or
  `create_geographic_coverage()` in `capeml`; all tests for `capemlVector` are
  new.
- R version constraint: `>= 4.1.0` (native pipe; align with current
  `capeml`/`capemlGIS` practice).

---

## Options considered

### Option A — Full extraction: new package, clean removal from capemlGIS and capeml *(selected)*

All vector R files (`create_vector.R`, `create_vector_shape.R`,
`package_vector_shape.R`, `helper_list_crs.R`) and `create_geographic_coverage.R`
move to `capemlVector`. Dead stubs (`create_spatialVector.R`,
`get_emlProjection.R`, `emlCoordSystems`) are removed from `capemlGIS`.
`capemlGIS` `DESCRIPTION` drops `sf`. `capeml` `DESCRIPTION` drops `sf`
entirely; a deprecated stub remains in `capeml` pointing users to `capemlVector`.

| Pillar | Assessment |
|---|---|
| **Reliability** | Clean boundaries; each package is independently testable. |
| **Security** | No implications. |
| **Operational excellence** | Dependency graph is explicit and auditable. Installation docs use `pak`. |
| **Performance efficiency** | `sf` is not loaded in tabular-only or raster-only workflows. |
| **Cost/sustainability** | Smallest install footprint per use case. |

*Trade-off:* requires a coordinated update across three packages; downstream
projects calling `capeml::create_geographic_coverage()` will receive a
deprecation error with a clear migration message.

### Option B — Soft fork (not selected)
Duplicate code into capemlVector, keep originals deprecated temporarily. Adds
ongoing maintenance burden with no compensating benefit.

### Option C — Monorepo consolidation (not selected)
Merge all three packages. Contradicts stated design intent; re-couples spatial
and tabular concerns.

---

## Decision

**Option A.** The three-package ecosystem (`capeml` → tabular/core, `capemlGIS`
→ rasters, `capemlVector` → vectors + geographic coverage) has clear,
non-overlapping responsibilities. Moving `create_geographic_coverage()` into
`capemlVector` is correct: it is an sf-dependent function that generates EML
coverage metadata from a spatial object — wholly a vector/spatial concern.

---

## Success criteria (testable)

1. `pak::pak("CAPLTER/capemlVector")` installs cleanly on a machine with no
   prior `capemlGIS` installation.
2. `library(capemlVector)` loads without `raster`/`terra`; `library(capemlGIS)`
   loads without `sf`; `library(capeml)` loads without `sf`.
3. All five migrated functions pass `devtools::check()` with 0 errors, 0
   warnings.
4. `devtools::check()` on updated `capemlGIS` returns 0 errors, 0 warnings; `sf`
   not in `DESCRIPTION Imports`.
5. `devtools::check()` on updated `capeml` returns 0 errors, 0 warnings; `sf`
   not in `DESCRIPTION Imports`; calling `capeml::create_geographic_coverage()`
   emits a deprecation error with migration message.
6. `testthat` suite in `capemlVector` covers `list_crs()`,
   `create_geographic_coverage()`, `create_vector()`, `create_vector_shape()`,
   and `package_vector_shape()`.
7. README files for all three packages cross-link and document installation via
   `pak::pak("CAPLTER/<repo>")`.
8. `pkgdown::build_site()` succeeds for all three packages.

---

## Risks & rollback

| Risk | Likelihood | Mitigation |
|---|---|---|
| Downstream projects break on `capeml::create_geographic_coverage()` | Low–Medium | Deprecated stub emits informative error; communicate in NEWS. |
| `capemlVector` missing an undiscovered internal dependency | Low | `devtools::check()` surfaces missing imports before release. |
| `list_crs()` fails if NCEAS GitHub URL changes | Low | Wrap in `tryCatch` with informative error. |

**Rollback:** changes are isolated to three independent git repositories; stage
and test each separately before pushing.

---

## References

- EML spatialReference XSD: `https://raw.githubusercontent.com/NCEAS/eml/main/xsd/eml-spatialReference.xsd`
- pak GitHub source syntax: `https://pak.r-lib.org/reference/pak_package_sources.html`
- R Packages (2e): `https://r-pkgs.org`
- `capeml` DESCRIPTION (verified): `sf` in `Imports` solely for `create_geographic_coverage()`
- `capemlGIS` DESCRIPTION (verified): `sf` and `raster` in `Imports`
